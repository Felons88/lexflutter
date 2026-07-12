import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

/// {@template currency_utils}
/// Currency formatting and parsing helpers for the LEX marketplace.
/// {@endtemplate}
abstract final class CurrencyUtils {
  const CurrencyUtils._();

  static final NumberFormat _currencyFormatter = NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 2,
  );

  static final NumberFormat _compactFormatter = NumberFormat.compactCurrency(
    symbol: '\$',
    decimalDigits: 0,
  );

  /// Formats a value as currency (e.g. \$1,234.56).
  static String format(double value, {String? currencySymbol}) {
    if (currencySymbol != null && currencySymbol.isNotEmpty) {
      return NumberFormat.currency(
        symbol: currencySymbol,
        decimalDigits: 2,
      ).format(value);
    }
    return _currencyFormatter.format(value);
  }

  /// Formats a value as compact currency (e.g. \$1.2K).
  static String formatCompact(double value) => _compactFormatter.format(value);

  /// Parses a currency string into a double.
  ///
  /// Returns null if the string cannot be parsed.
  static double? parse(String value, {String? symbol}) {
    final String normalized = value
        .replaceAll(symbol ?? '\$', '')
        .replaceAll(',', '')
        .trim();
    return double.tryParse(normalized);
  }

  /// Formats cents to a dollar display string.
  static String fromCents(int cents, {String? symbol}) {
    return format(cents / 100.0, currencySymbol: symbol);
  }

  /// Converts a dollar amount to cents.
  static int toCents(double value) => (value * 100).round();

  /// Rounds [value] to two decimal places for storage.
  static double round(double value) => (value * 100).roundToDouble() / 100.0;

  @visibleForTesting
  static NumberFormat get currencyFormatter => _currencyFormatter;
}
