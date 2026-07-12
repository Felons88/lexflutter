import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:lex/core/errors/failure.dart';
import 'package:lex/core/utils/currency_utils.dart';
import 'package:lex/core/utils/date_utils.dart';
import 'package:lex/core/utils/formatters.dart';
import 'package:lex/core/utils/platform_utils.dart';
import 'package:lex/core/utils/result.dart';
import 'package:lex/core/utils/validators.dart';

void main() {
  setUpAll(() {
    Intl.defaultLocale = 'en_US';
  });

  group('Result', () {
    const String successValue = 'ok';
    final Failure failure = Failure.unknown();

    test('success result is success and holds value', () {
      final Result<String, Failure> result = Result<String, Failure>.success(
        successValue,
      );
      expect(result.isSuccess, isTrue);
      expect(result.isFailure, isFalse);
      expect(result.valueOrNull, successValue);
      expect(result.failureOrNull, isNull);
    });

    test('failure result is failure and holds failure', () {
      final Result<String, Failure> result = Result<String, Failure>.failure(
        failure,
      );
      expect(result.isSuccess, isFalse);
      expect(result.isFailure, isTrue);
      expect(result.valueOrNull, isNull);
      expect(result.failureOrNull, failure);
    });

    test('when folds success and failure', () {
      final Result<String, Failure> success = Result<String, Failure>.success(
        successValue,
      );
      final Result<String, Failure> fail = Result<String, Failure>.failure(
        failure,
      );

      expect(
        success.when(success: (value) => value, failure: (f) => f.message),
        successValue,
      );
      expect(
        fail.when(success: (value) => value, failure: (f) => f.message),
        failure.message,
      );
    });

    test('map transforms success value', () {
      final Result<String, Failure> result = Result<String, Failure>.success(
        '42',
      );
      final Result<int, Failure> mapped = result.map(int.parse);
      expect(mapped.valueOrNull, 42);
    });

    test('mapFailure transforms failure value', () {
      final Result<String, Failure> result = Result<String, Failure>.failure(
        failure,
      );
      final Result<String, String> mapped = result.mapFailure((f) => f.message);
      expect(mapped.failureOrNull, failure.message);
    });

    test('onSuccess runs side effect and returns this', () {
      String? captured;
      final Result<String, Failure> result = Result<String, Failure>.success(
        successValue,
      );
      expect(result.onSuccess((value) => captured = value), result);
      expect(captured, successValue);
    });

    test('onFailure runs side effect and returns this', () {
      String? captured;
      final Result<String, Failure> result = Result<String, Failure>.failure(
        failure,
      );
      expect(result.onFailure((f) => captured = f.message), result);
      expect(captured, failure.message);
    });
  });

  group('Validators', () {
    test('required returns message for null or empty input', () {
      expect(Validators.required(null), 'This field is required');
      expect(Validators.required('   '), 'This field is required');
      expect(Validators.required('hello'), isNull);
      expect(Validators.required('hello', fieldName: 'Name'), isNull);
    });

    test('required uses custom field name', () {
      expect(Validators.required('', fieldName: 'Email'), 'Email is required');
    });

    test('email validates correctly', () {
      expect(Validators.email('test@example.com'), isNull);
      expect(Validators.email('  test@example.com  '), isNull);
      expect(Validators.email('invalid'), 'Please enter a valid email');
      expect(Validators.email(''), 'Email is required');
    });

    test('password validates length and character requirements', () {
      expect(Validators.password('Password1'), isNull);
      expect(
        Validators.password('short1'),
        'Password must be at least 8 characters with a letter and number',
      );
      expect(
        Validators.password('PasswordNoDigit'),
        'Password must be at least 8 characters with a letter and number',
      );
      expect(Validators.password(''), 'Password is required');
    });

    test('confirmPassword checks match', () {
      expect(Validators.confirmPassword('pass', 'pass'), isNull);
      expect(
        Validators.confirmPassword('pass', 'fail'),
        'Passwords do not match',
      );
      expect(
        Validators.confirmPassword('pass', ''),
        'Please confirm your password',
      );
    });

    test('displayName requires at least two characters', () {
      expect(Validators.displayName('AB'), isNull);
      expect(Validators.displayName('A'), 'Name must be at least 2 characters');
      expect(Validators.displayName(''), 'Name is required');
    });

    test('username restricts length and characters', () {
      expect(Validators.username('user_123'), isNull);
      expect(Validators.username('ab'), 'Username must be 3-30 characters');
      expect(
        Validators.username('user name'),
        'Username can only contain letters, numbers, and underscores',
      );
    });

    test('url validates scheme and host', () {
      expect(Validators.url('https://example.com'), isNull);
      expect(Validators.url('ftp://example.com'), isNull);
      expect(Validators.url('not-a-url'), 'Please enter a valid URL');
    });

    test('price validates positive numbers', () {
      expect(Validators.price('10.99'), isNull);
      expect(Validators.price('\$10.99'), isNull);
      expect(Validators.price('0'), 'Please enter a valid price');
      expect(Validators.price('-5'), 'Please enter a valid price');
      expect(Validators.price('abc'), 'Please enter a valid price');
    });

    test('phone requires at least ten digits', () {
      expect(Validators.phone('1234567890'), isNull);
      expect(Validators.phone('(123) 456-7890'), isNull);
      expect(
        Validators.phone('123456789'),
        'Please enter a valid phone number',
      );
    });

    test('length enforces min and max', () {
      expect(Validators.length('hello', min: 3, max: 10), isNull);
      expect(
        Validators.length('hi', min: 3, max: 10),
        'Field must be between 3 and 10 characters',
      );
      expect(
        Validators.length('hello world', min: 3, max: 10),
        'Field must be between 3 and 10 characters',
      );
    });
  });

  group('Formatters', () {
    test('formatCount returns compact notation', () {
      expect(Formatters.formatCount(1000), '1K');
      expect(Formatters.formatCount(1500), '1.5K');
      expect(Formatters.formatCount(1000000), '1M');
    });

    test('toTitleCase capitalizes each word', () {
      expect(Formatters.toTitleCase('hello world'), 'Hello World');
      expect(Formatters.toTitleCase(''), '');
    });

    test('capitalize capitalizes first letter', () {
      expect(Formatters.capitalize('hello'), 'Hello');
      expect(Formatters.capitalize(''), '');
    });

    test('currency formats with dollar symbol and decimals', () {
      expect(Formatters.currency.format(1234.5), r'$1,234.50');
    });

    test('compactCurrency formats with compact notation', () {
      expect(Formatters.compactCurrency.format(1234), r'$1.23K');
    });

    test('shortDate formats date', () {
      final DateTime date = DateTime(2026);
      expect(Formatters.shortDate.format(date), 'Jan 1, 2026');
    });
  });

  group('DateUtils', () {
    test('timeAgo returns relative labels', () {
      final DateTime now = DateTime(2026, 6, 15, 12);
      expect(
        DateUtils.timeAgo(now.subtract(const Duration(seconds: 30)), now: now),
        'Just now',
      );
      expect(
        DateUtils.timeAgo(now.subtract(const Duration(minutes: 5)), now: now),
        '5m ago',
      );
      expect(
        DateUtils.timeAgo(now.subtract(const Duration(hours: 3)), now: now),
        '3h ago',
      );
      expect(
        DateUtils.timeAgo(now.subtract(const Duration(days: 2)), now: now),
        '2d ago',
      );
      expect(
        DateUtils.timeAgo(now.subtract(const Duration(days: 14)), now: now),
        '2w ago',
      );
      expect(
        DateUtils.timeAgo(now.subtract(const Duration(days: 60)), now: now),
        '2mo ago',
      );
      expect(
        DateUtils.timeAgo(now.subtract(const Duration(days: 400)), now: now),
        '1y ago',
      );
    });

    test('formatDuration produces mm:ss or hh:mm:ss', () {
      expect(DateUtils.formatDuration(const Duration(seconds: 90)), '01:30');
      expect(DateUtils.formatDuration(const Duration(minutes: 75)), '01:15:00');
    });

    test('formatShortDate and formatShortDateTime format dates', () {
      final DateTime date = DateTime(2026, 6, 15, 14, 30);
      expect(DateUtils.formatShortDate(date), 'Jun 15, 2026');
      expect(
        DateUtils.formatShortDateTime(date),
        matches(r'Jun 15, 2026 2:30\sPM'),
      );
    });

    test('tryParseUtc parses ISO strings to UTC', () {
      final DateTime? parsed = DateUtils.tryParseUtc('2024-01-01T00:00:00Z');
      expect(parsed, isNotNull);
      expect(parsed!.isUtc, isTrue);
      expect(DateUtils.tryParseUtc(null), isNull);
      expect(DateUtils.tryParseUtc('invalid'), isNull);
    });

    test('toUtc and toLocal convert timezones', () {
      final DateTime local = DateTime(2026, 6, 15, 12);
      expect(DateUtils.toUtc(local).isUtc, isTrue);
      expect(DateUtils.toLocal(local).isUtc, isFalse);
    });

    test('isToday checks same calendar day', () {
      expect(DateUtils.isToday(DateTime.now()), isTrue);
      expect(
        DateUtils.isToday(DateTime.now().subtract(const Duration(days: 1))),
        isFalse,
      );
    });

    test('isWithinLastDays checks recent dates', () {
      expect(
        DateUtils.isWithinLastDays(
          DateTime.now().subtract(const Duration(days: 3)),
          7,
        ),
        isTrue,
      );
      expect(
        DateUtils.isWithinLastDays(
          DateTime.now().subtract(const Duration(days: 10)),
          7,
        ),
        isFalse,
      );
    });
  });

  group('CurrencyUtils', () {
    test('format uses dollar symbol by default', () {
      expect(CurrencyUtils.format(1234.5), r'$1,234.50');
    });

    test('format accepts custom symbol', () {
      expect(CurrencyUtils.format(1234.5, currencySymbol: '€'), '€1,234.50');
    });

    test('formatCompact returns compact currency', () {
      expect(CurrencyUtils.formatCompact(1234), r'$1.23K');
    });

    test('parse removes symbol and commas', () {
      expect(CurrencyUtils.parse(r'$1,234.50'), 1234.5);
      expect(CurrencyUtils.parse('invalid'), isNull);
    });

    test('fromCents converts cents to currency', () {
      expect(CurrencyUtils.fromCents(12345), r'$123.45');
    });

    test('toCents converts dollars to cents', () {
      expect(CurrencyUtils.toCents(12.34), 1234);
    });

    test('round rounds to two decimals', () {
      expect(CurrencyUtils.round(12.345), 12.35);
      expect(CurrencyUtils.round(12.344), 12.34);
    });
  });

  group('PlatformUtils', () {
    test('isWeb is false in test environment', () {
      expect(PlatformUtils.isWeb, isFalse);
    });

    test('desktop and mobile are mutually exclusive', () {
      expect(PlatformUtils.isDesktop || PlatformUtils.isMobile, isTrue);
      expect(PlatformUtils.isDesktop && PlatformUtils.isMobile, isFalse);
    });

    test('isApple matches iOS or macOS', () {
      expect(
        PlatformUtils.isApple,
        PlatformUtils.isIOS || PlatformUtils.isMacOS,
      );
    });
  });
}
