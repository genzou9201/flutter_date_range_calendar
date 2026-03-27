/// Indicates how many months the calendar displays.
enum CalendarType {
  /// Displays a single month.
  singleMonth,

  /// Displays two consecutive months.
  doubleMonth,
}

/// Indicates the order in which years and months are displayed in the title.
///
/// For example:
/// - [monthYear] shows "December 2023".
/// - [yearMonth] shows "2023 December".
enum MonthLayoutType {
  /// Month is displayed before year (e.g. "December 2023").
  monthYear,

  /// Year is displayed before month (e.g. "2023 December").
  yearMonth,
}