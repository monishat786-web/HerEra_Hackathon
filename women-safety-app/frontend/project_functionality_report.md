# herERA project Functional Breakdown

This document provides a comprehensive overview of the interactive elements and features implemented within the herERA application.

---

## 🏠 Home Screen (`HomeScreen`)
The central safety hub of the app.

| Button / UI Element | Action | Status | Functional Detail |
| :--- | :--- | :--- | :--- |
| **Profile Icon** (Top-Right) | Navigation | ✅ Working | Opens the `ProfileScreen`. |
| **Activities Link** (Top-Left) | Navigation | ✅ Working | Opens the `SOSHistoryScreen`. |
| **Location Status Indicator** | Toggle / Modal | ✅ Working | Mock toggle. Tapping switches between "ON" and "OFF". If OFF, SOS is locked. |
| **SOS Button (Tapping)** | Emergency | ✅ Working | Triggers `SOSActiveScreen`. |
| **SOS Button (Triple Tap)** | Speed Trigger | ✅ Working | Instantly triggers SOS (overrides recording). |
| **SOS Button (Long Press + Drag)** | Scream Mode | ✅ Working | Starts "Scream Detection" & Audio Recording. |
| **SOS Button (Tap while Rec.)** | Manual Stop | ✅ Working | Stops recording and triggers SOS alert. |
| **Shake Device (3x)** | Motion Trigger | ✅ Working | Starts a 60s recording then auto-sends SOS alert. |
| **Area Safety Gauge Card** | Information | ✅ Working | Interactive SfRadialGauge showing local safety score (85 - Safe). |
| **Map Preview Card** | Navigation | ✅ Working | Tapping the card opens the full `MapScreen`. |
| **Quick Action: Fake Call** | Navigation | ✅ Working | Opens the `GuardianCallScreen` (Simulated). |
| **Quick Action: Safe Route** | Navigation | ✅ Working | Redirects to `MapScreen` with route overlay. |
| **Quick Action: Share Live** | Feedback | ✅ Working | Shows a SnackBar: "Live location sharing activated." |
| **Quick Action: Evidence** | Navigation | ✅ Working | Opens the `EvidenceLockerScreen`. |

---

## 🗺️ Safety Map (`MapScreen`)
Geospatial safety intelligence.

| Button / UI Element | Action | Status | Functional Detail |
| :--- | :--- | :--- | :--- |
| **District Markers** | Modal | ✅ Working | Tapping a city/district dot shows a detailed safety stats popup. |
| **AI Summary Button** | Information | ⚡ Dynamic | Tapping shows an AI-generated briefing of local safety trends. |
| **Report Unsafe Area** | Feedback | ✅ Working | Shows a SnackBar confirming the report for community review. |
| **Search Bar** | Navigation | 🚧 Searchable | Visual search bar for specific locations. |

---

## 🕵️ Evidence Vault (`EvidenceLockerScreen`)
Secure repository for incident media.

| Button / UI Element | Action | Status | Functional Detail |
| :--- | :--- | :--- | :--- |
| **Filter Tabs (All/Audio/Video/...)** | UI Toggle | ✅ Working | Dynamically filters based on stored evidence types. |
| **Media Cards (Play Icon)** | Interaction | ✅ Working | Real playback of recorded audio files using `audioplayers`. |
| **Evidence Cards** | Details | ✅ Working | Dynamically displays recorded SOS data, timestamps, and locations from persistence. |
| **Refresh Button** (Top-Right) | State Update | ✅ Working | Reloads the evidence list from local storage. |

---

## 📍 Activities (`ActivitiesScreen`)
Daily location and safety timeline.

| Button / UI Element | Action | Status | Functional Detail |
| :--- | :--- | :--- | :--- |
| **Horizontal Date Strip** | Data Select | ✅ Working | Allows switching between different days; highlights the selection. |
| **Calendar Icon** (Top-Right) | Feedback | ✅ Working | Placeholder for full date picking logic. |
| **Timeline Entry (Office/Park)** | Details | ✅ Working | Shows addresses, duration, and safety risk status. |
| **Export Daily Report** | Feedback | ✅ Working | Confirmation SnackBar for report generation. |

---

## 👥 Community (`CommunityScreen`)
Social safety network.

| Button / UI Element | Action | Status | Functional Detail |
| :--- | :--- | :--- | :--- |
| **Floating Action Button (+)** | Action | 🚧 Placeholder | Intent: Report new neighborhood issue. |
| **Help Button** (on SOS cards) | Assistance | 🚧 Placeholder | Intent: Respond to nearby helper request. |
| **Verify Button** (on reports) | Validation | ✅ Working | Upvotes community reports for better visibility. |
| **Responder Cards** | Selection | 🚧 Placeholder | Shows available trusted helpers nearby. |

---

## 👤 Profile (`ProfileScreen`)
Personal identity and security settings.

| Button / UI Element | Action | Status | Functional Detail |
| :--- | :--- | :--- | :--- |
| **Secure Evidence Locker** | Navigation | ✅ Working | Direct link to the `EvidenceLockerScreen`. |
| **Location Activities** | Navigation | ✅ Working | Direct link to the `ActivitiesScreen`. |
| **Emergency Contact Icon** | Interaction | ✅ Working | Tapping the phone icon triggers a mock emergency call. |
| **Identifications (Aadhaar)** | Information | ✅ Working | Displays "Verified" status for digital ID. |
| **Guardian Sentinel Settings** | Selection | ✅ Working | High-fidelity cards for controlling AI sentinel levels. |

---

## 🚨 Navigation Management (`MainNavigation`)
Bottom bar logic.

| Button / UI Element | Action | Status | Functional Detail |
| :--- | :--- | :--- | :--- |
| **Home Tap** | App State | ✅ Working | Switches to Index 0. |
| **Safety Map Tap** | App State | ✅ Working | Switches to Index 1. |
| **Community Tap** | App State | ✅ Working | Switches to Index 2 (includes active SOS badge). |
| **Vault Tap** | App State | ✅ Working | Switches to Index 3. |

---

**Glossary of Icons Used:**
- ✅ **Working**: Feature is fully implemented and interactive.
- 🚧 **Placeholder**: UI exists but currently performs no state-change or heavy logic.
- ⚡ **Dynamic**: Mocked with interactive feedback (SnackBars/Modal popups).
