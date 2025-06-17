import 'package:flutter/material.dart';
import 'todo_database.dart';

void main() {
  runApp(const MyApp());
}

class Todo {
  Todo({this.id, required this.title, DateTime? dueDate, this.isDone = false})
      : dueDate = dueDate ?? DateTime.now();

  int? id;
  final String title;
  bool isDone;
  DateTime dueDate;

  Todo.fromMap(Map<String, dynamic> map)
      : id = map['id'] as int?,
        title = map['title'] as String,
        isDone = map['is_done'] == 1,
        dueDate = DateTime.parse(map['due_date'] as String);

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'is_done': isDone ? 1 : 0,
        'due_date': dueDate.toIso8601String(),
      };

  void toggle() => isDone = !isDone;

  void carryOverIfPastDue(DateTime today) {
    while (!isDone && dueDate.isBefore(today)) {
      dueDate = DateTime(dueDate.year, dueDate.month, dueDate.day + 1);
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mooscle Todo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Todo> _todos = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _carryOver() async {
    final today = DateTime.now();
    for (final todo in _todos) {
      final before = todo.dueDate;
      todo.carryOverIfPastDue(DateTime(today.year, today.month, today.day));
      if (before != todo.dueDate) {
        await TodoDatabase.instance.updateTodo(todo);
      }
    }
  }

  Future<void> _loadTodos() async {
    final todos = await TodoDatabase.instance.getTodos();
    setState(() {
      _todos
        ..clear()
        ..addAll(todos);
    });
    await _carryOver();
  }

  Future<void> _addTodo(String title) async {
    final todo = Todo(title: title);
    final id = await TodoDatabase.instance.insertTodo(todo);
    setState(() {
      _todos.add(todo..id = id);
    });
  }

  Future<void> _toggleTodo(Todo todo) async {
    setState(() {
      todo.toggle();
    });
    await TodoDatabase.instance.updateTodo(todo);
  }

  Future<void> _showAddDialog() async {
    _controller.clear();
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Todo'),
        content: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'What to do?'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final text = _controller.text.trim();
              if (text.isNotEmpty) {
                _addTodo(text);
              }
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          final todo = _todos[index];
          return CheckboxListTile(
            title: Text(todo.title),
            subtitle: Text('Due: ${todo.dueDate.toLocal().toIso8601String().split('T').first}'),
            value: todo.isDone,
            onChanged: (_) => _toggleTodo(todo),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
