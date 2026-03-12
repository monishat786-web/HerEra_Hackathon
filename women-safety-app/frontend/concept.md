# herERA - Advanced Women's Safety Ecosystem 🛡️✨

## 🌟 Vision
**herERA** is more than just a safety app; it is a comprehensive digital ecosystem designed to empower women through technology. Built with a "Privacy First, Safety Always" philosophy, the app combines real-time risk assessment, community-driven alerts, and advanced emergency triggers in a premium, user-friendly interface.

---

## 🎨 Design Philosophy
The UI is inspired by modern **Glassmorphism** and a **Professional Play Store** aesthetic.
- **Color Palette**: 
  - `Soft Purple (#8B5CF6)` & `Warm Pink (#EC4899)` for core brand elements.
  - `Mint Green (#10B981)` for safety and verification.
  - `Deep Blue/Lavender Gradient` for a premium, calming background.
- **Visual Elements**: Subtle shadows, 4k-quality renders, pulsating animations, and high-quality iconography.
- **Typography**: Uses `Quicksand` for a friendly touch and `Inter` for clarity and professional readability.

---

## 📂 Project Structure (Frontend)

The codebase is organized following a **Feature-First Clean Architecture**:

- `lib/core/`: Foundation of the app.
  - `constants/`: Global variables like `app_colors.dart`, `app_themes.dart`, and `app_constants.dart`.
  - `widgets/`: Shared UI components like `main_navigation.dart` (Glassmorphism Bottom Bar).
- `lib/features/`: Modularized business logic and UI for each feature.
  - `home/`: The central hub (SOS, Detection, Night Mode).
  - `map/`: Real-time tracking and heatmaps.
  - `community/`: Peer-to-peer safety alerts.
  - `legal/`: Rights and legal education.
  - `profile/`: User settings and emergency contacts.
  - `onboarding/`: Initial setup and permissions.
  - `evidence_locker/`: Secure storage for safety-related documentation.

---

## 🚀 Key Features & UI Components

### 1. 🏠 Home Screen (The Pulse)
- **Detection Center**: A pulsating microphone icon with "Active Scream Detection."
- **SOS Button**: A large, central circular button with a radial gradient. Triggers on 3 taps; features a subtle glow effect.
- **Quick Actions**: 
  - `Safe Route`: Directs to the safest path home.
  - `Fake Call`: Triggers a realistic simulated incoming call.
  - `Evidence`: Quick access to the Evidence Locker.
  - `AI Assist`: On-demand safety guidance.
- **Night Safety Mode**: A "Frosted Glass" card that changes the theme to a sleek dark mode with purple glows when activated.
- **Risk Level Gauge**: Real-time safety status score based on environmental factors.

### 2. 🗺️ Map Screen (Safe Mobility)
- **Simulated Map Grid**: Clean, high-performance map interface.
- **Real-time Heatmaps**: Visualizes High-Risk (Red), Medium-Risk (Yellow), and Safe (Green) zones.
- **POI Markers**: Emoji-based markers for Hospitals, Police Stations, and Safe Houses.
- **Route Comparison**: A bottom sheet that compares the "Shortest Route" vs. "Safe Route" (showing well-lit roads and police presence).
- **Voice Commands**: Mic icon for hands-free navigation.

### 3. 👥 Community Screen (Unity)
- **Live SOS Alerts**: Shows active SOS triggers from other users nearby (Distance & Time).
- **Unsafe Location Reporting**: A dedicated portal to report suspicious activity or poor lighting.
- **Mutual Assistance**: "Provide Assistance" button for nearby verified volunteers.

### 4. ⚖️ Legal Screen (Empowerment)
- **Know Your Rights**: Detailed breakdown of Indian Legal Acts (POSH Act, Criminal Law Amendment 2013, Domestic Violence Act, etc.).
- **Right to Consent**: Clear educational cards explaining legal protection.

### 5. 👤 Profile & Settings
- **Emergency Contacts**: One-tap calling to parents/guardians and emergency services.
- **SOS Preferences**: Customizable SOS messages and auto-call settings.
- **Safety Activity History**: A log of previous safety events and reports.
- **Biometric Security**: Protects app access via fingerprint or face ID.

---

## 🛠️ Tech Stack
- **Framework**: Flutter (Dart)
- **Theming**: Custom Material 3 with extensive Glassmorphism layers.
- **Animations**: `flutter_staggered_animations`, `Lottie`, and explicit `AnimationController` for pulsating effects.
- **Typography/Icons**: Google Fonts, Font Awesome, and custom SVG icons.
- **State Management**: Provider / GetIt (Service Locator pattern).

---

## 🛡️ Privacy & Security
- **No Idle Tracking**: Location is only used when the app is active or when an SOS is triggered.
- **Microphone Consent**: Secure audio processing specifically for scream/distress patterns.
- **Evidence Protection**: End-to-end encryption for the Evidence Locker.

---
Created with ❤️ for **HerEra Hackathon**
