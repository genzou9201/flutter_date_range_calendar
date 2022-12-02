## Features

- Show a calendar to pick range of dates.

## Usage

### Basic

Just import this package in your file you want to use.
Then, place `DateRangeCalendar` widget wherever you want to declare.

```dart
  void onTappedDay(DateTime? s, DateTime? e) {
    print('$s, $e');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DateRangeCalendar(
          onTappedDay: onTappedDay,
        ),
      ),
    );
  }
```