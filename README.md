# Flutter Anime App

A Flutter application built using the Jikan Anime API that allows users to browse top anime, search anime by title, and view detailed anime information.

## Features

- Top Anime Listing
- Infinite Scroll Pagination
- Anime Search
- Anime Details Screen
- Riverpod State Management
- Repository Pattern
- Clean Folder Structure

## Tech Stack

- Flutter
- Dart
- Riverpod
- HTTP
- Jikan API
## Screenshots

### Home Screen

Browse the highest-rated anime fetched from the Jikan API. The home screen supports infinite scrolling and pagination for a smooth browsing experience.

![Home Screen](assets/screenshots/home.png)

### Search Functionality

Search anime by title and retrieve real-time results from the Jikan API. Results are fetched dynamically using Riverpod-powered state management.

![Search Screen](assets/screenshots/search.png)

### Anime Details

View detailed information about a selected anime, including score, rank, episode count, cover artwork, and synopsis.

![Details Screen](assets/screenshots/details.png)

## Folder Structure

text
lib/
│
├── models/
├── providers/
├── repository/
├── screens/
├── widgets/
└── main.dart


## Architecture

The project follows a simple and scalable architecture using:

- Repository Pattern
- AsyncNotifierProvider
- FutureProvider.family
- StateProvider

## Learning Outcomes

Through this project, I practiced:

- API Integration
- Pagination
- Riverpod State Management
- Search Architecture
- Navigation
- Async Programming
- Clean Code Organization

## API Used

Jikan API

https://api.jikan.moe/

## Future Improvements

- Favorites Feature
- Offline Caching
- Better Animations
- Search Suggestions
- Theme Switching

## Author

Yug Patel

Computer Science Student | Flutter Developer
