# Smart Ambulance App 🚑

The **Smart Ambulance System** is a cutting-edge mobile application designed to bridge the gap between emergency medical needs and rapid response. Built with a modular architecture and real-time tracking capabilities, it ensures that help is always just a few taps away.

---

## 🛠️ Setup & Configuration (Important)

To get this project running, you need to set up two external services for mapping and routing:

### 1. Google Maps Platform
The app uses Google Maps for the map interface.
- Go to the [Google Cloud Console](https://console.cloud.google.com/).
- Create a new project.
- Enable the **Maps SDK for Android** and **Maps SDK for iOS**.
- Create an **API Key** under Credentials.
- **Android**: Place your API key in `android/app/src/main/AndroidManifest.xml`.
- **iOS**: Place your API key in `ios/Runner/AppDelegate.swift`.

### 2. Open Route Service (ORS)
The app uses Open Route Service to calculate and draw routes on the map (instead of the paid Google Directions API).
- Create a free account at [Open Route Service](https://openrouteservice.org/).
- Generate a new **API Key** (Token).
- Place your ORS Token in the `lib/core/networking/api_constants.dart` file (or your specific directions service config).

---

## 🌟 Key Features

- **Live Tracking**: Real-time GPS synchronization for ambulance movement.
- **User/Driver Dual Interface**: Context-aware UI based on the account type.
- **SOS Logic**: Intelligent assignment of the nearest ambulance to emergency requests.
- **Smart Scheduling**: Pre-book medical transport for non-critical cases.
- **Interactive Rating**: A post-trip feedback system for service quality improvement.
- **Dynamic Routing**: Automatic path generation from the driver to the pickup point.

---

## 🚀 Technology Stack

- **Flutter**: Cross-platform mobile development (SDK ^3.10.7).
- **BLoC/Cubit**: Advanced state management for real-time data handling.
- **Retrofit & Dio**: Type-safe REST API client.
- **GetIT**: Dependency injection for clean, decoupled code.
- **Google Maps & ORS**: Integrated mapping and routing services.
- **Clean Architecture**: Organized by feature to ensure scalability and testability.

---

## 🏗️ Installation Guide

### 1. Clone the repository
```bash
git clone https://github.com/Khaled-elnabawy/smart-ambulance-api.git
cd smart-ambulance-api/mobile
```

### 2. Install Packages
```bash
flutter pub get
```

### 3. Generate Code Structures
The project relies on code generation for JSON and State models:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Run the Application
Ensure an emulator is running or a device is connected:
```bash
flutter run
```

---

## 🤝 Credits & Contribution

Developed with passion to save lives and improve medical accessibility.

## 👥 Authors

- **Amr Saleh** - [GitHub Profile](https://github.com/amr-khalid-saleh)
---

Developed using **Flutter** & **Laravel Backend**.
