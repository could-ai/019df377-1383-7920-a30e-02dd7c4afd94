# ToolVault Pro

ToolVault Pro is a complete, fully functional tool inventory and management app designed specifically for mechanics, contractors, and tradespeople. Built with a rugged, professional diesel mechanic shop aesthetic, it serves as an offline-first service tablet to keep track of valuable tools, batteries, chargers, and equipment.

## Features

- **Tool Inventory Management:** Keep track of all tools including brand, model, serial number, purchase details, and condition.
- **Battery & Charger Tracking:** Dedicated management for power tool batteries and chargers with voltage, capacity, cycle count, and condition tracking.
- **Maintenance Records:** Log maintenance activities for expensive tools, set reminders for servicing, and track costs.
- **Borrow & Lend Tracker:** Never lose a tool again. Track which tools are lent out, to whom, and when they are expected back.
- **Specialty Tools Section:** A categorized area for diagnostic equipment, specialized pullers, precision measuring tools, etc.
- **Search & Filter System:** Quickly find tools by name, brand, category, or status using the powerful search functionality.
- **Data Export & Backup:** Export your entire inventory to CSV/PDF formats for insurance purposes or personal backups. (Pro Feature)
- **Rugged UI/UX:** A matte black and charcoal gray interface with safety orange accents, large tap targets for gloved/greasy hands, and high-contrast typography.

## Tech Stack

- **Framework:** Flutter (Cross-platform compatibility)
- **State Management:** Provider
- **Local Storage:** SQLite (via sqflite plugin) for reliable offline access.
- **Routing:** Standard Flutter Navigator with defined named routes.

## Screenshots & Design

ToolVault Pro uses a custom **Rugged Industrial Theme**:
- **Backgrounds:** Matte Black
- **Cards/Surfaces:** Charcoal Gray
- **Accents:** Safety Orange & Steel Silver
- **Icons:** Garage-style, heavy-duty icons for immediate visual recognition.

## Setup Instructions

1. **Prerequisites:** Ensure you have the Flutter SDK (>=3.7.2) installed and configured on your machine.
2. **Clone the repository:**
   ```bash
   git clone <repository_url>
   cd toolvault-pro
   ```
3. **Install Dependencies:**
   ```bash
   flutter pub get
   ```
4. **Run the App:**
   ```bash
   flutter run
   ```

## Generating Release Builds

For Android deployment to Google Play:
1. Ensure your keystore is configured.
2. Run the build command:
   ```bash
   flutter build appbundle
   ```

---

## CouldAI

This app was generated with [CouldAI](https://could.ai), an AI app builder for cross-platform apps that turns prompts into real native iOS, Android, Web, and Desktop apps with autonomous AI agents that architect, build, test, deploy, and iterate production-ready applications.
