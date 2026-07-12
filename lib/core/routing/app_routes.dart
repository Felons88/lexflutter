/// {@template app_routes}
/// Route path and name constants for the LEX app.
///
/// Using typed constants prevents hardcoded route strings across the app.
/// {@endtemplate}
abstract final class AppRoutes {
  const AppRoutes._();

  /// Splash screen.
  static const String splash = '/splash';

  /// Onboarding flow.
  static const String onboarding = '/onboarding';

  /// Authentication screens.
  static const String auth = '/auth';

  /// Home feed.
  static const String home = '/home';

  /// Discover / explore.
  static const String discover = '/discover';

  /// Marketplace.
  static const String marketplace = '/marketplace';

  /// Live commerce.
  static const String live = '/live';

  /// Messages.
  static const String messages = '/messages';

  /// User profile.
  static const String profile = '/profile';

  /// Settings.
  static const String settings = '/settings';

  /// Wallet.
  static const String wallet = '/wallet';

  /// Orders.
  static const String orders = '/orders';

  /// Cart.
  static const String cart = '/cart';

  /// Seller dashboard.
  static const String seller = '/seller';

  /// Admin dashboard.
  static const String admin = '/admin';

  /// Search.
  static const String search = '/search';

  /// Product listing detail.
  static const String listing = '/listing';

  /// Reviews.
  static const String reviews = '/reviews';

  /// Root path for deep linking.
  static const String root = home;

  /// All top-level routes that require authentication.
  static const List<String> protectedRoutes = <String>[
    home,
    discover,
    marketplace,
    live,
    messages,
    profile,
    settings,
    wallet,
    orders,
    cart,
    seller,
    admin,
    search,
    listing,
    reviews,
  ];

  /// All public routes that do not require authentication.
  static const List<String> publicRoutes = <String>[
    splash,
    onboarding,
    auth,
  ];
}
