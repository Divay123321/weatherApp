# Weather App

A Flutter app that displays real-time weather information for any city using the OpenWeatherMap API.

## Features
- Current temperature and weather condition
- Hourly forecast for the next 5 time slots
- Additional weather metrics — humidity, wind speed, atmospheric pressure
- Dynamic weather icons based on current conditions
- Pull-to-refresh to fetch latest data
- Loading indicator while fetching data
- Error handling for failed API calls

## Tech Stack
- Flutter
- Dart
- OpenWeatherMap API
- http package for API calls
- intl package for date formatting

## What I Learned
- Making real HTTP API calls in Flutter
- Parsing JSON responses
- FutureBuilder for async UI updates
- StatefulWidget lifecycle with initState
- Storing futures in variables to prevent unnecessary API calls
- Handling loading and error states properly



## Getting Started
1. Clone the repo
2. Run `flutter pub get`
3. Create a `lib/secrets.dart` file with your API key:
```dart
const apiweatherkey = 'YOUR_API_KEY_HERE';
```
4. Run `flutter run`

## Note
Never commit your API key. `secrets.dart` is excluded via `.gitignore`.# weather_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
