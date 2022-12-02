## Features

- Show a calendar to pick range of dates.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

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