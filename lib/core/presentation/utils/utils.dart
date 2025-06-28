class Utils {
  Utils._();
  int daysBetween(DateTime from, DateTime to) {
    return (to.difference(from).inHours / 24).round();
  }

  static String calculateTimeDifferenceBetween({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    if (startDate.isAfter(endDate)) {
      return 'expired';
    }
    final seconds = endDate.difference(startDate).inSeconds;
    if (seconds < 60) {
      return '$seconds ${seconds > 1 ? 'seconds' : 'second'}';
    } else if (seconds >= 60 && seconds < 3600) {
      final minute = endDate.difference(startDate).inMinutes.abs();
      return '$minute ${minute > 1 ? 'minutes' : 'minute'}';
    } else if (seconds >= 3600 && seconds < 86400) {
      final hour = endDate.difference(startDate).inHours;
      return '$hour ${hour > 1 ? 'hours' : 'hour'}';
    } else {
      final day = endDate.difference(startDate).inDays;
      return '$day ${day > 1 ? 'days' : 'day'}';
    }
  }
}
