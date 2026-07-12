import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// {@template formatters}
/// Text input formatters and string helpers for the LEX app.
/// {@endtemplate}
abstract final class Formatters {
  const Formatters._();

  /// Currency formatter for USD with two decimal places.
  static NumberFormat get currency => NumberFormat.currency(
        symbol: '\$',
        decimalDigits: 2,
      );

  /// Compact currency formatter (e.g. \$1.2K).
  static NumberFormat get compactCurrency => NumberFormat.compactCurrency(
        symbol: '\$',
        decimalDigits: 0,
      );

  /// Date formatter for short dates (e.g. Jan 1, 2026).
  static DateFormat get shortDate => DateFormat.yMMMd();

  /// Date formatter for short date and time.
  static DateFormat get shortDateTime => DateFormat.yMMMd().add_jm();

  /// Formats a number to compact views/likes (e.g. 1.2K).
  static String formatCount(int count) {
    return NumberFormat.compact().format(count);
  }

  /// Formats [text] to title case.
  static String toTitleCase(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ')
        .map(
          (String word) => word.isEmpty
              ? word
              : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
        )
        .join(' ');
  }

  /// Capitalizes the first character of [text].
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// Formatter that allows digits and a single decimal point.
  static TextInputFormatter get currencyInputFormatter =>
      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'));

  /// Formatter that only allows digits.
  static TextInputFormatter get digitsOnly =>
      FilteringTextInputFormatter.digitsOnly;

  /// Formatter that limits input to [maxLength] characters.
  static TextInputFormatter maxLength(int maxLength) =>
      LengthLimitingTextInputFormatter(maxLength);
}
