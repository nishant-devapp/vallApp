# VALL Assignment - Event Booking App (Flutter + Firebase)

A mobile app built with **Flutter** that allows users to **sign up, log in**, view a list of **events**, and **RSVP (book/unbook)** for events. It uses **Firebase Authentication**, **Cloud Firestore**, and **Firebase REST API** for backend functionality. **BLoC** is used for state management and the app follows a **clean architecture** approach.

---

## 🚀 Features

- Firebase Email/Password **signup and login** (via REST API)
- View list of **upcoming events**
- **RSVP (book/unbook)** for events
- Session **persistence** using Shared Preferences
- Works on **Android** not on **iOS** because Firebase iOS set up has not been initialized

---

## 📦 Setup Instructions

### 🔧 Prerequisites

- Flutter (latest stable version recommended)
- Android Studio or VS Code
- Firebase project (configured for Android)

### 🔌 Firebase Configuration

1. Create a Firebase project at [https://console.firebase.google.com](https://console.firebase.google.com)

2. Enable:
   - **Authentication > Email/Password**
   - **Cloud Firestore**

3. Add Android App:
   - Provide your Android package name (e.g., `com.example.vallassignment`)
   - Download `google-services.json`
   - Place it in: `android/app/google-services.json`

4. Add your Firebase project ID in your repository file where needed:
   ```
   const projectId = "your_project_id";
   ```

---

## 🧠 Architecture & State Management

This project follows **Clean Architecture** principles:

### Layers:
- **Presentation Layer**: UI + BLoC (Business Logic Components)
- **Domain Layer**: Models
- **Data Layer**: Repositories, Firebase REST API calls

### 🔄 State Management:
- Uses **flutter_bloc** for managing states across login, signup, and event RSVP workflows
- States and events are clearly defined for each use case (authentication, events)

---

## ✅ Testing the App

### 🔐 1. Testing Signup & Login

- Launch the app
- Tap **Sign Up**
- Enter name, email and password → Click **Sign Up**
- You'll be redirected to **Login screen** on successful signup
- Enter the same credentials(email, password) and tap **Sign In**
- On successful login, you’ll reach the **Events Screen**

### 📅 2. Testing RSVP (Book / Cancel)

- On Events screen, you will get a list of events tap **Book Slot** on any event
- Your user ID will be added to that event’s `bookedUsers` array
- `totalBookedCount` will increase
- If you tap **Cancel Slot**, your ID will be removed and count decreased

### 🔁 3. Testing Session Persistence

- Close and reopen the app
- You will stay logged in (session maintained via SharedPreferences)
- You’ll be automatically taken to the Events screen without re-login

---

## 💡 Tech Stack

- **Flutter** (cross-platform app framework)
- **Firebase** (auth, firestore - via REST API)
- **BLoC** (state management)
- **Shared Preferences** (local session storage)
- **HTTP** (for Firebase REST API calls)

---

## 🧪 Folder Structure (Clean Architecture)

```
lib/
├── utils/
├── auth/
│   ├── bloc/
│   ├── models/
│   ├── repository/
│   └── screens/
├── events/
│   ├── bloc/
│   ├── models/
│   ├── repository/
│   └── screens/
└── main.dart
```

---

## 📲 Platform Support

- ✅ Android

---

## 📄 License

This project is licensed under the MIT License.
