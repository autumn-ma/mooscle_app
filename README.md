# 🚀 Mooscle

A minimal, self‑hosted productivity and fitness companion that keeps you honest about skipped reps and visualizes your progress over time.

---

## ✨ Features

| Category                                      | What you get                                                                                                                                                                                                           |
| --------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Adaptive task quantities – “Mooscle ⚡”**   | When you mark a workout task as **skipped**, the app gently “punishes” you by bumping its target by a configurable percentage (default **+20 %**).<br/>*Example*: `Push‑ups ×10` → skipped → next day becomes **×12**. |
| **Workout tracker with graphs & video demos** | Log any exercise (reps, distance, duration, weight, etc.), view line/bar charts, **and watch static embedded YouTube videos for form guidance**.                                                                       |
| **Weight tracker**                            | Record body‑weight entries; view trend‑lines, 7‑day moving averages, and BMI classification zones.                                                                                                                     |
| **Cross‑platform**                            | Runs in any modern browser, installable as a PWA on mobile/desktop.                                                                                                                                                    |
| **Offline‑first**                             | All data saved securely on‑device using a local SQLite store—no account, no internet required.                                                                                                                         |

---

## 🚀 Quick Start

### 1 · Clone & install

```bash
git clone https://github.com/your‑handle/simplefit‑todo.git
cd simplefit‑todo
flutter pub get           # install dependencies
```

### 2 · Run the app

Choose one of the targets:

```bash
# Web
flutter run -d chrome

# Android emulator / device
flutter run -d android

# iOS simulator / device
flutter run -d ios
```

> 📱 Make sure you have Flutter SDK ≥ 3.22 and the appropriate platform SDKs installed (Android Studio, Xcode, etc.).

---

## 🔍 How “Mooscle” Works

```text
new_quantity = ceil(old_quantity * (1 + penalty_rate))
```

* **penalty\_rate** defaults to `0.2` (20 %).
* The multiplier is applied only when you mark a task as **Skipped** for the day.
* You can set per‑task or global rates (see *Settings* → *Motivation*).

Example sequence for *Push‑ups* (rate 20 %):

| Day | Action    | Target |
| --- | --------- | ------ |
| 1   | Add       | 10     |
| 2   | Skipped   | 12     |
| 3   | Completed | 12     |
| 4   | Skipped   | 15     |

---

## 📊 Data Visualization

| Dashboard          | Details                                            |
| ------------------ | -------------------------------------------------- |
| **Workout Volume** | Stacked bar chart of total reps/sets per day/week. |
| **Best Sets**      | Scatter plot of PRs by date.                       |
| **Weight Trend**   | Line chart with 7‑day moving average & BMI bands.  |

Charts are powered by **fl\_chart** with responsive layouts and dark‑mode support.

---

## 🛤️ Roadmap

* [ ] Habit streak badges & leaderboards
* [ ] Apple/Google Health import
* [ ] Social workout challenges
* [ ] Wearable auto‑logging (BLE)

---

## 🤝 Contributing

1. Fork the repo 🚀
2. Create a feature branch (`git checkout -b feat/my‑idea`)
3. Commit your changes (`git commit -m 'feat: add super‑feature'`)
4. Push (`git push origin feat/my‑idea`)
5. Open a Pull Request 🙌

Please follow Conventional Commits and ensure the test suite passes.

---

## 📜 License

[MIT](LICENSE) © 2025 autumn

