# my_finance
Overview:
myFinance is a Flutter-based finance management application designed to help users track their transactions efficiently. 
The app follows the MVVM (Model-View-ViewModel) architecture using the Stacked state management framework. 
Users can create, categorize, and analyze their transactions through various views and statistics.

Features:
Add, edit, and delete transactions.
Categorize transactions for better organization.
View transactions filtered by day, week, month, or all-time.
Visualize financial data with pie charts and statistics.
Manage transaction categories (add, edit, delete).

Tech Stack:
Flutter - Frontend framework.
Stacked - State management using MVVM architecture.
Dart - Programming language.

Installation & Setup:
Prerequisites:
Install Flutter SDK: Flutter Installation Guide
Ensure you have a Flutter-supported IDE (VS Code, Android Studio, or IntelliJ IDEA)
Set up a device emulator or connect a physical device.

Steps to Run the Project:
Clone the repository:
Install dependencies
Run the application
(Use flutter run -d <device> if multiple devices are connected.)

Folder Structure
myFinance/
│── android/             
│── ios/                 
│── assets/              # Assets like images, icons, fonts etc.
│── build/               # Build output (auto-generated)
│── linux/               
│── macos/               
│── test/                # Test files
│   ├── golden/          # Snapshot testing
│   ├── helpers/         # Test helpers
│   ├── services/        # Service-related tests
│── lib/                 # Main application source code
│   ├── main.dart        # Entry point
│   ├── app/             # App-level configurations
│   │   ├── app.dart     # Application setup
│   │   ├── app.locator.dart  # Dependency injection setup
│   │   ├── app.router.dart   # Routing setup
│   ├── models/          # Data models (e.g., category, transaction)
│   ├── services/        # Services like database, etc.
│   ├── ui/              # UI components
│   │   ├── bottom_sheets/  # Bottom sheet UI components
│   │   ├── common/         # Common reusable widgets
│   │   ├── dialogs/        # Custom dialogs
│   │   ├── views/          # Screens/views
│   │   ├── widgets/        # Smaller UI components
│── pubspec.yaml         # Project dependencies
│── README.md            # Project documentation


