# Liquid Galaxy Flutter Controller - GSoC 2026

This repository contains the source code for Task 2 of the Liquid Galaxy GSoC 2026 selection process. The project is a Flutter-based mobile application designed to interface with a Liquid Galaxy system.

## Project Description
The app functions as a remote controller that communicates with the Liquid Galaxy rig via SSH. It handles KML generation, file transfers via SFTP, and remote command execution to manage the display and camera positioning.

## Core Functionality
* **SSH/SFTP Integration**: Establishes a secure connection to the LG system for remote control and file management.
* **KML Deployment**: Generates and uploads a 3D pyramid KML located in Xàtiva to the master node.
* **Camera Control**: Implements "Fly To" logic to synchronize camera angles and coordinates across the Liquid Galaxy system.
* **Logo Management**: Automates the transfer and visualization of official branding assets, including Liquid Galaxy, GSoC, and Lleida Labs logos.

## Tech Stack
* **Framework**: Flutter / Dart.
* **Communication**: SSH2 and SFTP protocols for backend interaction and asset synchronization.
* **Data Format**: KML (Keyhole Markup Language) for geospatial visualization.

## Repository Structure
* `lib/`: Contains the application logic, UI components, and service handlers.
* `assets/`: Includes required branding logos and KML templates.
* `pubspec.yaml`: Project metadata and dependency management (Internal name: lg_master_web_app).

## Installation
1. Clone the repository:
   `git clone https://github.com/aleixrc/LG-Flutter-Controller-GSoC26.git`
2. Install dependencies:
   `flutter pub get`
3. Build the production APK:
   `flutter build apk --release`

## Author
**Aleix R. Climent** GitHub: [@aleixrc](https://github.com/aleixrc)  
Email: aleix.r.climent@gmail.com
