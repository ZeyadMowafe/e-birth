# E-Birth 👶💉

E-Birth is a professional Flutter application designed to bridge the gap between parents and healthcare providers (Doctors) for efficient birth and post-natal management. Built with a focus on scalability, performance, and premium user experience.

---

## 🚀 Key Features

### 🔐 Advanced Authentication
- **Dual Identification**: Login and password recovery using either **Email Address** or **14-digit National ID**.
- **Role-Based Workflows**: Tailored experiences for **Parents** and **Doctors**.
- **Secure OTP Verification**: 6-digit OTP verification with a built-in **60-second countdown timer** for resending.
- **Password Recovery**: Robust flow for resetting passwords with server-side validation.

### 👨‍⚕️ Doctor Ecosystem
- **Registration with Credentials**: Specialty-specific forms and document upload (Docs/PDFs) for verification.
- **Verification Workflow**: Pending approval states to ensure only verified medical professionals access the system.

### 🎨 Premium UI/UX
- **Dynamic Splash Screens**: 
  - Native splash (Android 12 support).
  - Animated Flutter splash for a smooth app entry.
- **Bi-Directional Support**: Full Arabic (RTL) and English (LTR) support with specialized fixes for numeric inputs like OTP.
- **Modern Design System**: Consistent branding using a primary blue palette with glassmorphism and smooth transitions.

---

## 🏗 Architecture & Design Patterns

The project follows **Uncle Bob's Clean Architecture**, ensuring highly testable and loosely coupled code.

### Layers:
- **Presentation**: UI Widgets and BLoC (Cubit) for state management. Uses `go_router` for declarative navigation.
- **Domain**: Business logic, Entities, Repositories (Interfaces), and UseCases. The "Source of Truth".
- **Data**: Repository implementations, Data Sources (Remote/Local), and Models (DTOs).

### Design Patterns:
- **BLoC/Cubit**: For predictable state management.
- **Repository Pattern**: To decouple domain logic from data sources.
- **Dependency Injection**: Orchestrated via `get_it` for efficient service location.
- **Functional Programming**: Leverages `dartz` (Either) for explicit error handling.

---

## 🛠 Tech Stack

- **Core**: [Flutter](https://flutter.dev) (v3.x)
- **State management**: `flutter_bloc`
- **Navigation**: `go_router`
- **Networking**: `dio` (with custom interceptors and error handling)
- **Dependency Injection**: `get_it`
- **Local Storage**: `shared_preferences`
- **Functional Tools**: `dartz`, `equatable`
- **Connectivity**: `internet_connection_checker_plus`

---

## 📂 Project Structure

```bash
lib/
├── core/               # Shared constants, widgets, DI, and routing
├── features/
│   ├── auth/          # Authentication, Profile, and Role Selection
│   │   ├── data/      # Models & DataSources
│   │   ├── domain/    # Entities & UseCases
│   │   └── presentation/ # Cubits & UI Pages
│   └── home/          # Main application dashboard
├── l10n/              # Localization files (AR/EN)
└── main.dart          # Entry point
```

---

## 🛠 Getting Started

### Prerequisites:
- Flutter SDK (latest stable version)
- Android Studio / VS Code
- Git

### Installation:
1. **Clone the repository**:
   ```bash
   git clone https://github.com/ZeyadMowafe/e-birth.git
   ```
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Generate localization and mocks**:
   ```bash
   flutter gen-l10n
   ```
4. **Run the application**:
   ```bash
   flutter run
   ```

---

## 📝 License

Distributed under the MIT License. See `LICENSE` for more information.

## 🤝 Contact

Zeyad Mowafe - [LinkedIn](https://www.linkedin.com/in/zeyadmowafe/) - zeyadmowafe17@gmail.com
Project Link: [https://github.com/ZeyadMowafe/e-birth](https://github.com/ZeyadMowafe/e-birth)
