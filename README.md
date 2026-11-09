# RememberWell: Wellbeing App for People Living with Dementia

RememberWell is a Flutter mobile app that supports people living with dementia with gentle, everyday activities for the mind and body. It brings exercise, relaxation, memory games, music and daily reminders together in one simple, friendly app.

## Features

- **Secure accounts:** sign up, log in and reset passwords with Firebase Authentication
- **Guided exercises:** walking, stretching and chair exercises with step-by-step images and animations
- **Meditation:** calming nature sounds (forest, ocean, waterfall, wind, night) for relaxation
- **Memory games:**
  - Card-flip game to find matching pairs
  - Timed word game with scoring to keep the mind active
- **Music therapy:** a music player and sing-along karaoke screens
- **To-do list:** add, edit and complete daily tasks, with date and time pickers for reminders

## Tech stack

| Area | Tools |
| --- | --- |
| App | Flutter, Dart |
| Backend | Firebase Authentication, Cloud Firestore |
| Media | video_player, audioplayers, just_audio |
| UI | Material Design, Font Awesome icons |

## Project structure

```
lib/
  main.dart            Login screen
  signup.dart          Sign-up screen
  theapp/
    main.dart          Home screen and navigation
    exercise/          Walking, stretching and chair exercises
    meditation/        Nature-sound meditation
    memory_game/       Card-flip and word games
    music_player/      Music player and karaoke
    todolist/          Tasks and reminders
assets/                Images, animations and icons
meditation_audios/     Nature sounds
meditation_images/     Meditation backgrounds
```

## Running it locally

> Built with Flutter 3.16 (Dart 3.2) in early 2024. On newer Flutter versions you may need to regenerate the Android build files with `flutter create --platforms=android .` and run `flutter pub upgrade --major-versions`.

1. Install [Flutter](https://docs.flutter.dev/get-started/install) and clone this repository:
   ```bash
   git clone https://github.com/Zaidmuckba/rememberwell.git
   cd rememberwell
   flutter pub get
   ```
2. Connect your own Firebase project (Authentication and Firestore enabled). The Firebase config file is not included in this repo for security:
   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```
   This creates `lib/firebase_options.dart`. Copy it to `lib/theapp/firebase_options.dart` as well.
3. Run the app:
   ```bash
   flutter run
   ```

Songs and karaoke videos are protected by copyright and are not included. See `assets/MUSIC_NOT_INCLUDED.md` to add your own.

## Author

**Muhammad Zaid Muckba**, Master of Data Science student at Monash University
[LinkedIn](https://www.linkedin.com/in/muhammad-zaid-muckba-372087252/) · [GitHub](https://github.com/Zaidmuckba)
