# Liquid Galaxy Remote Controller

This repository contains the source code for a Flutter-based mobile application designed to interface with and remotely control a Liquid Galaxy distributed display system. 

## Project Description
The application acts as a central control hub that communicates with a multi-screen Liquid Galaxy rig via secure SSH connections. It handles real-time dynamic KML generation, remote file transfers via SFTP, and distributed command execution to manage data visualization and camera positioning across all connected nodes.

## Core Functionality
* **SSH/SFTP Integration**: Establishes a secure connection to the master node for remote control, script execution, and file management.
* **Dynamic KML Deployment**: Generates and uploads custom 3D geometries (e.g., a 3D pyramid located in Xàtiva) directly to the system's display pipeline.
* **Camera Control**: Implements geospatial "Fly To" logic to synchronize camera angles, coordinates, and altitudes across the distributed screens.
* **Asset Management**: Automates the transfer and rendering of media assets and branding logos using SFTP.

## Tech Stack
* **Framework**: Flutter / Dart
* **Communication**: SSH2 and SFTP protocols for backend interaction and asset synchronization
* **Data Format**: KML (Keyhole Markup Language) for geospatial visualization

## Repository Structure
* `lib/`: Contains the application logic, UI components, and SSH service handlers.
* `assets/`: Includes required static media and KML templates.
* `pubspec.yaml`: Project metadata and dependency management.

## Installation & Setup
1. Clone the repository:
   `git clone https://github.com/aleixrc/Liquid-Galaxy-Remote-Controller.git`
2. Install dependencies:
   `flutter pub get`
3. Build the production APK:
   `flutter build apk --release`

## Author
**Aleix R. Climent**
* **GitHub**: [@aleixrc](https://github.com/aleixrc)
* **LinkedIn**: [Aleix Climent](https://www.linkedin.com/in/aleixcliment/)
* **Email**: aleix.r.climent@gmail.com
