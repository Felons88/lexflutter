import 'package:flutter_test/flutter_test.dart';
import 'package:lex/core/errors/failure.dart';

void main() {
  group('Failure', () {
    test('unknown factory creates a failure with unknown type', () {
      final Failure failure = Failure.unknown();
      expect(failure.type, FailureType.unknown);
      expect(
        failure.message,
        'An unexpected error occurred. Please try again.',
      );
      expect(failure.code, isNull);
    });

    test('typed factories create the correct type', () {
      expect(Failure.network().type, FailureType.network);
      expect(Failure.server().type, FailureType.server);
      expect(Failure.auth().type, FailureType.auth);
      expect(Failure.validation('Invalid').type, FailureType.validation);
      expect(Failure.storage().type, FailureType.storage);
      expect(Failure.permission().type, FailureType.permission);
      expect(Failure.cancelled().type, FailureType.cancelled);
    });

    test('equality depends on message, type, and code', () {
      const Failure a = Failure(
        message: 'Error',
        type: FailureType.server,
        code: '500',
      );
      const Failure b = Failure(
        message: 'Error',
        type: FailureType.server,
        code: '500',
      );
      const Failure c = Failure(
        message: 'Error',
        type: FailureType.server,
        code: '404',
      );

      expect(a, b);
      expect(a, isNot(c));
      expect(a.hashCode, b.hashCode);
    });

    test('toString includes type, message, and code', () {
      const Failure failure = Failure(
        message: 'Oops',
        type: FailureType.network,
        code: '503',
      );
      expect(
        failure.toString(),
        'Failure(type: FailureType.network, message: Oops, code: 503)',
      );
    });

    test('can carry an optional exception', () {
      final Exception exception = Exception('boom');
      final Failure failure = Failure(message: 'Error', exception: exception);
      expect(failure.exception, exception);
    });
  });
}
