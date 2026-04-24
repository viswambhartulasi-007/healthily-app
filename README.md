## 🚀 Getting Started

Follow these steps to install and run the project locally.

---

## 📋 Prerequisites

Make sure you have the following installed:

- macOS (required for iOS development)
- Xcode (latest version recommended)
- Git
- Apple ID (for running on a real device)

---

## 📥 Installation

1. Clone the repository
bash git clone https://github.com/your-username/healthily-app.git 

2. Navigate to project folder
bash cd healthily-app 

3. Open project in Xcode
bash open healthily-app.xcodeproj 

---

## ▶️ Running the App

### 🔹 Run on iPhone Simulator

1. Open the project in Xcode  
2. Select a simulator (e.g., iPhone 15) from the top toolbar  
3. Click ▶️ Run button (or press Cmd + R)  

---

### 🔹 Run on Real Device

1. Connect your iPhone via USB  
2. Select your device in Xcode  
3. Go to:
   - Signing & Capabilities
   - Select your Apple ID (Team)  
4. Click ▶️ Run  

> ⚠️ You may need to trust the developer certificate on your iPhone:
> Settings → General → VPN & Device Management → Trust Developer

---

## 🔥 Firebase Setup (Important)

If the app uses Firebase:

1. Go to Firebase Console  
2. Create a project  
3. Register your iOS app (bundle ID must match)  
4. Download GoogleService-Info.plist  
5. Add it to your Xcode project (drag & drop into root)

---

## ⚙️ Build Issues Fix

If the app doesn’t run:

- Clean build:
bash Cmd + Shift + K 

- Delete derived data:
bash rm -rf ~/Library/Developer/Xcode/DerivedData 

- Restart Xcode

---

## ✅ Expected Output

- App launches successfully on simulator/device  
- UI loads without crashes  
- Firebase (if used) connects properly
