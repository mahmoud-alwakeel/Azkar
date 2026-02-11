# Azkar App - Usage Guide

## 🎯 App Features

### Main Features
1. **Display Morning Azkar** (أذكار الصباح)
2. **Counter System** - Track your progress for each Azkar
3. **Progress Tracking** - See overall completion percentage
4. **Reset Options** - Reset individual or all counters

## 📱 How to Use

### 1. View Azkar List
When you open the app, you'll see:
- **Header**: Shows "أذكار الصباح" (Morning Azkar)
- **Progress Bar**: Overall completion progress
- **Azkar Cards**: List of all morning Azkar

### 2. Complete an Azkar
- **Tap** on an Azkar card to increment the counter
- The counter shows: `Current Count / Required Repetitions`
- Example: `1 / 3` means you've completed it 1 out of 3 times
- The progress bar fills up as you progress
- When complete, the card turns green with a checkmark

### 3. Reset Individual Azkar
- **Long-press** on any Azkar card
- A dialog will appear asking for confirmation
- Tap "إعادة تعيين" to reset that specific Azkar counter to 0

### 4. Reset All Counters
- Tap the **refresh icon** in the top-right corner
- A dialog will appear asking for confirmation
- Tap "إعادة تعيين" to reset all counters to 0

## 📊 Visual Indicators

### Azkar Card States

#### Incomplete Azkar
- Border: Gray
- Counter Badge: Blue
- Progress Bar: Blue
- Can be tapped to increment

#### Completed Azkar
- Border: Green (thicker)
- Counter Badge: Green
- Progress Bar: Green (full)
- Shows "مكتمل" (Completed) text with checkmark
- Cannot be tapped (completed)

## 🎨 UI Elements

### Header Section
```
┌─────────────────────────────────┐
│        أذكار الصباح              │
│    تم إنجاز 5 من 24             │
│    [Progress Bar ███░░░]         │
└─────────────────────────────────┘
```

### Azkar Card Layout
```
┌─────────────────────────────────┐
│ آية الكرسي            [1 / 1]   │
│                                  │
│ اللّهُ لاَ إِلَـهَ إِلاَّ هُوَ... │
│                                  │
│ [Progress ███████████████]       │
│         ✓ مكتمل                 │
└─────────────────────────────────┘
```

## ⚙️ Technical Details

### Counter Logic
- Each Azkar has a `repeat` value (how many times to recite)
- Each tap increments the `counter` by 1
- Counter cannot exceed the `repeat` value
- Reset returns counter to 0

### Data Persistence
Currently, counters **do not persist** when you close the app. They reset to 0 each time you restart.

To add persistence, you would need to:
1. Add `shared_preferences` package
2. Save counter state when changed
3. Load saved state on app start

## 🔮 Future Enhancements

Potential features to add:
- [ ] Evening Azkar (أذكار المساء)
- [ ] After-Prayer Azkar (أذكار بعد الصلاة)
- [ ] Favorites system
- [ ] Counter persistence (save progress)
- [ ] Notifications/Reminders
- [ ] Dark mode
- [ ] Audio recitation
- [ ] Search functionality
- [ ] Customize font size
- [ ] Share Azkar

## 🛠️ For Developers

### Adding New Azkar Category

1. **Create JSON file**: `assets/data/evening_azkar.json`
2. **Add to pubspec.yaml**: Already covered by `assets/data/`
3. **Update Datasource**:
```dart
Future<AzkarCategoryModel> loadEveningAzkar() async {
  final String jsonString = await rootBundle.loadString('assets/data/evening_azkar.json');
  final Map<String, dynamic> jsonData = json.decode(jsonString);
  return AzkarCategoryModel.fromJson(jsonData);
}
```
4. **Update Repository**:
```dart
Future<AzkarCategoryModel> getEveningAzkar() async {
  return await datasource.loadEveningAzkar();
}
```
5. **Create new screen** or add category selector

### Customizing UI
- Colors: Change in [azkar_screen.dart](lib/features/azkar/presentation/screens/azkar_screen.dart)
- Card design: Modify [azkar_card.dart](lib/features/azkar/presentation/widgets/azkar_card.dart)
- Theme: Update [main.dart](lib/main.dart) ThemeData

### Testing
Run tests with:
```bash
flutter test
```

## 📝 Notes

- The app is RTL (Right-to-Left) friendly for Arabic text
- All Azkar text is in Arabic
- UI labels and messages are in Arabic
- The app uses Material 3 design
