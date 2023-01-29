/// [CalendarType] indicates how many month will be displayed.
enum CalendarType {
  singleMonth,
  doubleMonth,
}

/// [MonthLayoutType] indicates the order in which years and months
/// are displayed.
/// For example,
/// [MonthLayoutType.monthYear] shows "December 2023".
/// [MonthLayoutType.yearMonth] shows "2023 February".
enum MonthLayoutType {
  monthYear,
  yearMonth,
}