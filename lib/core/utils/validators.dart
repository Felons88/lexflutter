/// {@template validators}
/// Centralized input validation helpers for the LEX app.
///
/// Each validator returns a localized error message or null when valid.
/// {@endtemplate}
abstract final class Validators {
  /// Email regex matching the official HTML5 spec pattern.
  static final RegExp _emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
  );

  /// Password must be at least 8 characters with one letter and one number.
  static final RegExp _passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).{8,}$');

  /// URL regex with scheme and host.
  static final RegExp _urlRegex = RegExp(
    r'^(https?|ftp)://[-a-zA-Z0-9@:%._+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b(?:[-a-zA-Z0-9()@:%_+.~#?&/=]*)$',
  );

  const Validators._();

  /// Validates a non-empty field.
  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validates an email address.
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!_emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email';
    }
    return null;
  }

  /// Validates a password.
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (!_passwordRegex.hasMatch(value)) {
      return 'Password must be at least 8 characters with a letter and number';
    }
    return null;
  }

  /// Validates that [password] and [confirmPassword] match.
  static String? confirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Validates a display name (minimum 2 characters).
  static String? displayName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  /// Validates a username (letters, numbers, underscores, 3-30 chars).
  static String? username(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }
    if (value.length < 3 || value.length > 30) {
      return 'Username must be 3-30 characters';
    }
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores';
    }
    return null;
  }

  /// Validates a URL.
  static String? url(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'URL is required';
    }
    if (!_urlRegex.hasMatch(value.trim())) {
      return 'Please enter a valid URL';
    }
    return null;
  }

  /// Validates a price is a positive number.
  static String? price(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Price is required';
    }
    final double? parsed = double.tryParse(
      value.replaceAll(RegExp(r'[^\d.\-]'), ''),
    );
    if (parsed == null || parsed <= 0) {
      return 'Please enter a valid price';
    }
    return null;
  }

  /// Validates a phone number (minimum 10 digits).
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    final String digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  /// Validates [value] length is within [min] and [max].
  static String? length(
    String? value, {
    required int min,
    required int max,
    String fieldName = 'Field',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    if (value.length < min || value.length > max) {
      return '$fieldName must be between $min and $max characters';
    }
    return null;
  }
}
