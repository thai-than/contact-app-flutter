# 📱 Contact Manager App

A modern **Flutter mobile app** for managing personal and business contacts.  
Built with **BLoC architecture**, **GoRouter**, **Hive**, and **Firebase** — designed to be fast, secure, and easy to extend.

---

## 🚀 Features

| ID | Feature | Description |
|----|----------|-------------|
| US-1 | **Register & Passcode** | First-time registration with name & phone. Setup 4-digit passcode for quick login. |
| US-2.1 | **Home Screen** | Displays all contacts with search, favorites, and bottom navigation. |
| US-2.2 | **Add Contact** | Add manually or scan another user’s QR code. |
| US-3.1 | **My Profile** | View your own profile and share via QR code. |
| US-3.2 | **Edit Profile** | Update your personal info easily. |
| US-4.1 | **Contact Detail** | View detailed contact info. |
| US-4.2 | **Update Contact** | Edit existing contact data. |
| US-4.3 | **Delete Contact** | Delete contact with confirmation modal. |
| US-5 | **Favorite Contacts** | Add/remove from favorites via star icon. |
| US-6 | **Settings** | Manage appearance (light/dark), language, font size, and app info. |
| US-7 | **Scan QR** | Scan or import QR image to auto-fill contact form. |

---

## 🧠 Architecture

**Pattern:** [BLoC](https://bloclibrary.dev/#/) — for reactive, testable state management  
**Navigation:** [GoRouter](https://pub.dev/packages/go_router) — for structured routes  
**Local Database:** [Hive](https://pub.dev/packages/hive) — lightweight, fast local storage  
**Cloud Services:** [Firebase](https://firebase.google.com/) — auth, analytics, backup, sync (optional)

```

lib/
├── blocs/              # Business logic (BLoC classes)
├── models/             # Hive models, repositories
├── layouts/            # Layouts for screens
├── utils/              # Utility functions
├── screens/            # UI screens
│   ├── auth/
│   ├── home/
│   ├── contact/
│   ├── profile/
│   ├── settings/
├── routes/             # GoRouter setup
├── widgets/            # Reusable components
└── main.dart           # Entry point

````

---

## 🧩 Data Models

### `Contact`
| Field | Type | Description |
|--------|------|-------------|
| firstname | String | Contact name |
| lastname | String | Contact name |
| phone | String | Contact phone |
| email | String? | Optional email |
| address | String? | Optional address |
| groupLabel | String? | Contact group label |
| isFavorite | bool | Mark as favorite |

### `UserProfile`
| Field | Type | Description |
|--------|------|-------------|
| firstname | String | User name |
| lastname | String | User name |
| phone | String | User phone |
| email | String? | Optional email |
| address | String? | Optional address |
| passcode | String | 4-digit numeric passcode |

---

## ⚙️ Setup & Installation

### 1️⃣ Prerequisites
- Flutter SDK (>=3.x)
- Android Studio or VS Code
- Firebase Project (if using backup/auth)

### 2️⃣ Clone Repo
```bash
git clone https://github.com/your-username/contact_manager_app.git
cd contact_manager_app
````

### 3️⃣ Install Dependencies

```bash
flutter pub get
```

### 4️⃣ Setup Hive Adapters

```bash
flutter packages pub run build_runner build
```

### 5️⃣ Run App

```bash
flutter run
```

---


## 🧱 Future Enhancements (Phase 2)

* 🌍 Multi-language support (English, Vietnamese, etc.)
* 🔤 Font size customization (small, medium, large)
* ☁️ Contact sync with Firebase Cloud Firestore
* 📦 Export/import contacts to vCard or CSV

---


## 🪪 License

This project is licensed under the [MIT License](LICENSE).

