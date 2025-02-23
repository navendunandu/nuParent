# NuParent - Children's Dental Care App

## Overview
**NuParent** is a dental care Android application designed for children to encourage good oral hygiene habits in an engaging and informative way. The app consists of two main modules:
- **User Module** (for children and parents) - Built with Flutter
- **Admin Module** (for managing content and users) - Built with React

Firebase was integrated for real-time data synchronization, ensuring instant updates and seamless communication between users and administrators.

## Features
### User Module (Flutter)
- **Interactive Learning** - Engaging content to educate children about dental care.
- **Brushing Reminders** - Personalized notifications to remind children to brush their teeth.
- **Progress Tracking** - Users can monitor their dental hygiene progress over time.

### Admin Module (React)
- **User Management** - Admins can manage user accounts and monitor engagement.
- **Content Management** - Update and maintain educational resources.
- **Real-Time Monitoring** - Track app activity and ensure users receive timely updates.

## Development Stack
- **Frontend:**
  - User Module: Flutter (Dart)
  - Admin Module: React (JavaScript/TypeScript)
- **Backend & Database:** Firebase (Realtime Database, Authentication, Cloud Messaging)

## Installation & Setup
### User Module (Flutter)
1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo/nuparent-user.git
   cd nuparent-user
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

### Admin Module (React)
1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo/nuparent-admin.git
   cd nuparent-admin
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Start the development server:
   ```bash
   npm start
   ```

## Firebase Configuration
To set up Firebase for both modules:
1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/).
2. Enable Authentication, Firestore Database, and Cloud Messaging.
3. Download the `google-services.json` (for Flutter) and `firebase-config.js` (for React) files and place them in the respective project directories.

## Contribution
If you want to contribute:
1. Fork the repository.
2. Create a feature branch (`git checkout -b feature-branch`).
3. Commit changes (`git commit -m 'Added new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Open a Pull Request.

## License
This project is licensed under the MIT License.

## Contact
For any questions or issues, please reach out to [Your Contact Email].

