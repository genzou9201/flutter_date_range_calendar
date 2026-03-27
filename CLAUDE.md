# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A Flutter package (`date_range_calendar`) that provides a date range picker calendar widget. Published at https://pub.dev/packages/date_range_calendar. SDK constraint: `>=3.0.0 <4.0.0`, Flutter `>=3.10.0`.

## Common Commands

```bash
# Run tests
flutter test

# Run a single test file
flutter test test/date_range_calendar_test.dart

# Generate mock files (required after changing @GenerateNiceMocks annotations)
dart run build_runner build --delete-conflicting-outputs

# Analyze code
flutter analyze

# Get dependencies
flutter pub get
```

## Architecture

The public API is a single widget `DateRangeCalendar` (lib/date_range_calendar.dart) that takes an `onTappedDay` callback and optional `CalendarSetupData` for customization.

### Key layers

- **Data layer** (`lib/src/data/`): Configuration models (`CalendarSetupData`, `DayCellStyle`, `MonthLabelsData`, `DayOfTheWeekLabelsData`) and enums (`CalendarType`, `MonthLayoutType`). `CalendarStore` holds static selected date state.
- **View layer** (`lib/src/view/`): Widget tree rooted at `CalendarOutline` (the only StatefulWidget — manages month navigation and date selection state via `setNewDates`). Renders `MonthTitle`, `DatesOutline`, and individual `CalendarDay` cells.
- **Core** (`lib/src/core/util.dart`): Utility for month name resolution from `CalendarSetupData`.

### Date selection logic

`CalendarOutline._CalendarOutlineState.setNewDates()` handles tap interactions: first tap sets start date, second tap (after start) sets end date, tapping a selected date deselects it, tapping before start date resets start.

### Customization

All visual customization flows through `CalendarSetupData` — day cell colors/radius, month/weekday labels (supports localization e.g. Japanese), month title layout order, and initial month.

## Testing

Tests use `flutter_test` with `mockito` for mocks. Test descriptions are in Japanese. The test helper `TestMyApp` wraps `DateRangeCalendar` in a `MaterialApp` for widget testing.
