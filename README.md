# 🎵 Audio App

**Audio App** is a full-stack audio management and playback application built to demonstrate **Flutter client development** with a **Node.js backend**.  

It allows users to **register, authenticate, upload, manage, and play audio files** seamlessly with a modern UI and advanced audio player features.

---

## 🚀 Live Demo

🔗 **Live Preview (GitHub Pages):**  
👉 [Live Preview Link](https://danial-03-dev.github.io/music_app/)

---

## 🚀 Features
  
### Client (Flutter)

- 🔒 Full **user authentication**
- ☁️ Upload audio files to the cloud
- ✏️ **CRUD operations** on uploaded audio
- 🎧 Audio playback with a **custom audio player**
- 📦 Features include:
  - Mini audio slab
  - Audio player notifications
  - Background audio support
- 🔹 Built with **MVVM architecture** for maintainability
- 🎨 Clean, modular UI with reusable widgets

### Server (Node.js / Express)

- 🗄️ Stores audio in **MongoDB GridFS**
- 🔐 Handles authentication via **JWT**
- ⚡ REST APIs for:
  - User registration/login
  - Audio upload, update, delete
  - Fetching user-specific audio files
- 🗃️ File storage optimized with **multer-gridfs-storage**
- 🌐 Hosted on **Vercel** for instant deployment

---

## 🛠️ Tech Stack

### Client
- **Flutter (MVVM architecture)**
- **Dart**
- **Riverpod** for state management
- **Just Audio / Audio Waveforms** for custom audio playback
- **Shared Preferences**, **File Picker**, **Flex Color Picker** for utility features

### Server
- **Node.js / Express**
- **MongoDB / GridFS** for audio storage
- **JWT** authentication
- **Multer & Multer GridFS Storage**
- **Vercel** hosting for serverless deployment
- **TypeScript** for type-safe backend

---

## 📦 Client Dependencies

```yaml
flutter_riverpod: ^3.0.3
riverpod_annotation: ^3.0.3
shared_preferences: ^2.5.4
file_picker: ^10.3.7
audio_waveforms: ^2.0.1
just_audio: ^0.10.5
just_audio_background: ^0.0.1-beta.17
mime: ^2.0.0
http_parser: ^4.1.2
fpdart: ^1.2.0
