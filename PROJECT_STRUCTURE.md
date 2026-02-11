# Azkar App - Project Structure

This is an Azkar (Islamic remembrance) Flutter app built using Domain-Driven Design (DDD) architecture.

## 📁 Project Structure

```
lib/
└── features/
    └── azkar/
        ├── data/                           # Data Layer
        │   ├── models/
        │   │   ├── azkar_model.dart        # Single Azkar model
        │   │   └── azkar_category_model.dart # Category model (e.g., Morning Azkar)
        │   ├── datasource/
        │   │   └── azkar_local_datasource.dart # Loads JSON from assets
        │   └── repository/
        │       └── azkar_repository.dart    # Repository implementation
        ├── presentation/                    # Presentation Layer
        │   ├── screens/
        │   │   └── azkar_screen.dart       # Main Azkar screen
        │   └── widgets/
        │       └── azkar_card.dart         # Individual Azkar card widget
        └── logic/                          # Business Logic Layer
            ├── azkar_cubit.dart            # State management (Cubit)
            └── azkar_state.dart            # State definitions

assets/
└── data/
    └── morning_azkar.json                  # Morning Azkar data
```

## 🏗️ Architecture - DDD (Domain-Driven Design)

The app follows a clean architecture pattern with three main layers:

### 1. Data Layer
- **Models**: Define the data structure (AzkarModel, AzkarCategoryModel)
- **Datasource**: Handles data loading from JSON files
- **Repository**: Abstracts data operations

### 2. Logic Layer (Business Logic)
- **Cubit**: Manages state and business logic using flutter_bloc
- **States**: Defines different states (Initial, Loading, Loaded, Error)

### 3. Presentation Layer
- **Screens**: Full-page widgets (AzkarScreen)
- **Widgets**: Reusable components (AzkarCard)

## 📊 Data Structure

Each Azkar has:
- `id`: Unique identifier
- `title`: Title of the Azkar
- `text`: The actual Azkar text in Arabic
- `repeat`: How many times it should be repeated
- `counter`: Current count (how many times completed)

## 🎯 Features

- ✅ Display morning Azkar (أذكار الصباح)
- ✅ Tap to increment counter
- ✅ Progress indicator for each Azkar
- ✅ Long-press to reset individual Azkar
- ✅ Reset all counters at once
- ✅ Visual feedback when Azkar is completed
- ✅ Overall progress tracking

## 🚀 How to Run

1. Make sure Flutter is installed
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## 📝 Adding More Azkar Categories

To add more categories (e.g., Evening Azkar):

1. Create a new JSON file in `assets/data/`
2. Add it to `pubspec.yaml` under assets
3. Add a method in `azkar_local_datasource.dart` to load it
4. Update `azkar_repository.dart` to expose it

## 🔧 Technologies Used

- **Flutter**: UI framework
- **flutter_bloc**: State management
- **Material 3**: Design system
