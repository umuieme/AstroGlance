# NASA APOD Viewer (SwiftUI)

A SwiftUI app that showcases NASA's Astronomy Picture of the Day (APOD) in a vertical, paginated page view. Browse through daily APOD entries, view detailed explanations, and download images for offline enjoyment.

---

## 🚀 Features

* **Vertical Page View**: Swipe up/down to navigate through APOD entries by date, with the latest at the top.
* **Pagination**: Efficient loading of entries in batches for smooth scrolling and reduced memory usage.
* **Detail View**: Tap on an short description to read the full explanation provided by NASA.
* **Clear View**: Toggle the clear image view by tapping the image.
* **Image Download**: Save APOD images directly to your device.
* **Configurable API Key**: Store your NASA API key securely in `Secrets.xcconfig`.

> **Note**: Video playback for APOD entries with video media is not supported yet.

---

## 📋 Requirements

* iOS 17.0 or later
* Xcode
* Swift

---

## 🔧 Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/umuieme/AstroGlance.git
   cd AstroGlance
   ```

2. **Open in Xcode**

   * Double-click `AstroGlance.xcodeproj` or open via Xcode’s **File ▶ Open**.

3. **Configure API Key**

   * Duplicate `Secrets.xcconfig.example` and rename it to `Secrets.xcconfig`.
   * Add your NASA API key:

     ```xcconfig
     API_KEY = YOUR_NASA_API_KEY_HERE
     ```
   * Ensure `Secrets.xcconfig` is added to the project and included in your build settings.

4. **Build & Run**

   * Select the target device or simulator.
   * Click **Run** (▶) in Xcode.

---

## 📖 Usage

1. Launch the app to see the latest APOD entry.
2. Swipe up/down to navigate through previous dates.
3. Tap the info button or image to view the detailed explanation.
4. Tap the download button to save the current image to your photo library.

---

## ⚙️ Configuration

* **Secrets.xcconfig**: Stores sensitive keys (e.g., `API_KEY`). Do **not** commit this file to version control.

---

## 🛠 Architecture

* **MVVM**: ViewModels handle data fetching and business logic.
* **SwiftUI Views**: Declarative UI components with smooth animations.

---

## 🎥 Demo / GIF Preview

![App Demo](Demo.gif)