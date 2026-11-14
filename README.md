🚨 SOS Emergency App

A Pattern-Based Emergency Alert Application with Android Lock-Screen Overlay

📖 About the Project

SOS Emergency App is a Flutter-based Android application designed to provide quick access to emergency alerts through a pattern-based activation system.

The application introduces a lock-screen overlay concept that displays an SOS pattern interface when the phone screen is turned on while the device is locked.

Users can activate the emergency alert by drawing a predefined pattern. If the pattern matches, an emergency SMS is automatically sent to the saved emergency contacts, and a fake calculator interface appears.

If the user does not want to activate the SOS feature, they can simply swipe up to return to the normal lock screen.

The main idea is to make emergency activation accessible while keeping the normal phone experience available.

✨ Key Features

- Lock-Screen Overlay: Displays the SOS interface over the lock screen when the phone screen turns on.
- Pattern-Based Activation: Uses a predefined pattern to trigger the emergency function.
- Automatic Emergency SMS: Sends an emergency message to saved contacts when the correct pattern is detected.
- Multiple Emergency Contacts: Allows users to add and save multiple emergency contact numbers.
- Contact Management: Provides the option to remove saved emergency contacts.
- Fake Calculator Interface: Displays a calculator-style interface after successful SOS pattern activation.
- Normal Lock-Screen Access: Users can swipe up to return to the normal lock screen without activating the SOS feature.

🔄 How the Application Works

1. The user turns on the phone screen while the device is locked.
2. The SOS lock-screen overlay appears.
3. The user can choose to draw the predefined emergency pattern.
4. If the pattern matches, the application automatically sends an emergency SMS to the saved contacts.
5. A fake calculator interface appears after successful activation.
6. If the user does not want to activate SOS, they can swipe up to return to the normal lock screen.

🛠️ Technologies Used

Technology| Purpose
Flutter| Mobile application development
Dart| Programming language
Android Studio| Development environment
Pattern Lock| Pattern-based activation
Telephony| SMS functionality
Permission Handler| Android permission management
Kotlin| Android platform integration

⚙️ Installation and Setup

Prerequisites

- Flutter SDK
- Dart SDK
- Android Studio
- Android device

1. Clone the Repository

git clone https://github.com/kamalvaradeva/SOS_APP.git

2. Navigate to the Project

cd SOS_APP

3. Install Dependencies

flutter pub get

4. Run the Application

Connect an Android device and execute:

flutter run

5. Build APK

flutter build apk --release

The generated APK will be available at:

build/app/outputs/flutter-apk/app-release.apk

🔐 Permissions and Safety

The application requires appropriate Android permissions for SMS functionality and lock-screen interaction.

- SMS permission must be granted where required.
- SMS delivery depends on device compatibility and network availability.
- Carrier charges may apply.

Disclaimer: This application is an educational mini-project prototype and is not a replacement for official emergency services. SMS delivery is not guaranteed.

🎯 Project Objective

To develop an Android-based emergency alert application that combines lock-screen overlay interaction, pattern-based activation and SMS communication to provide a simple emergency alert mechanism.


Built with Flutter ❤️ | Technology for Personal Safety
