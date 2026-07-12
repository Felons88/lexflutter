import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

/// {@template date_utils}
/// Date/time helpers for the LEX app.
/// {@endtemplate}
abstract final class DateUtils {
  const DateUtils._();

  /// Short date format (e.g. Jan 1, 2026).
  static final DateFormat _shortDate = DateFormat.yMMMd();

  /// Short date/time format.
  static final DateFormat _shortDateTime = DateFormat.yMMMd().add_jm();

  /// Relative time format (e.g. 2 hours ago).
  static String timeAgo(DateTime date, {DateTime? now}) {
    final DateTime reference = now ?? DateTime.now();
    final Duration difference = reference.difference(date);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()}w ago';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()}mo ago';
    } else {
      return '${(difference.inDays / 365).floor()}y ago';
    }
  }

  /// Formats a date to short form.
  static String formatShortDate(DateTime date) {
    return _shortDate.format(date);
  }

  /// Formats a date to short date + time.
  static String formatShortDateTime(DateTime date) {
    return _shortDateTime.format(date);
  }

  /// Formats a duration to mm:ss or hh:mm:ss.
  static String formatDuration(Duration duration) {
    final String hours = duration.inHours > 0
        ? '${duration.inHours.toString().padLeft(2, '0')}:'
        : '';
    final String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$hours$minutes:$seconds';
  }

  /// Returns true if [date] is today.
  static bool isToday(DateTime date) {
    final DateTime now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Returns true if [date] is within the last [days] days.
  static bool isWithinLastDays(DateTime date, int days) {
    final DateTime now = DateTime.now();
    return now.difference(date).inDays <= days;
  }

  /// Parses an ISO-8601 string into UTC DateTime.
  static DateTime? tryParseUtc(String? value) {
    if (value == null || value.isEmpty) return null;
    try {
      return DateTime.parse(value).toUtc();
    } on FormatException {
      return null;
    }
  }

  /// Converts [date] to UTC for storage.
  static DateTime toUtc(DateTime date) => date.toUtc();

  /// Converts [date] to local time.
  static DateTime toLocal(DateTime date) => date.toLocal();

  @visibleForTesting
  static DateFormat get shortDateFormat => _shortDate;
}
