import 'package:flutter/material.dart';

/// {@template app_shadows}
/// Elevation and shadow design tokens for LEX cards, sheets, and buttons.
/// {@endtemplate}
@immutable
class AppShadows extends ThemeExtension<AppShadows> {
  /// {@macro app_shadows}
  const AppShadows({
    required this.none,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.glow,
  });

  /// No shadow.
  final List<BoxShadow> none;

  /// Subtle 2dp shadow for small components.
  final List<BoxShadow> xs;

  /// 4dp shadow for cards.
  final List<BoxShadow> sm;

  /// 8dp shadow for elevated cards and menus.
  final List<BoxShadow> md;

  /// 16dp shadow for dialogs and floating elements.
  final List<BoxShadow> lg;

  /// 32dp shadow for modals and large sheets.
  final List<BoxShadow> xl;

  /// Colored glow shadow for premium emphasis.
  final List<BoxShadow> glow;

  /// Dark theme shadows.
  factory AppShadows.dark() => AppShadows(
    none: const <BoxShadow>[],
    xs: <BoxShadow>[
      BoxShadow(
        color: const Color(0xFF000000).withAlpha(20),
        blurRadius: 2,
        offset: const Offset(0, 1),
      ),
    ],
    sm: <BoxShadow>[
      BoxShadow(
        color: const Color(0xFF000000).withAlpha(40),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
    md: <BoxShadow>[
      BoxShadow(
        color: const Color(0xFF000000).withAlpha(60),
        blurRadius: 16,
        offset: const Offset(0, 8),
      ),
    ],
    lg: <BoxShadow>[
      BoxShadow(
        color: const Color(0xFF000000).withAlpha(80),
        blurRadius: 32,
        offset: const Offset(0, 16),
      ),
    ],
    xl: <BoxShadow>[
      BoxShadow(
        color: const Color(0xFF000000).withAlpha(100),
        blurRadius: 64,
        offset: const Offset(0, 24),
      ),
    ],
    glow: <BoxShadow>[
      BoxShadow(
        color: const Color(0xFFFF2E8A).withAlpha(60),
        blurRadius: 24,
        spreadRadius: 2,
      ),
    ],
  );

  /// Light theme shadows.
  factory AppShadows.light() => AppShadows(
    none: const <BoxShadow>[],
    xs: <BoxShadow>[
      BoxShadow(
        color: const Color(0xFF000000).withAlpha(10),
        blurRadius: 2,
        offset: const Offset(0, 1),
      ),
    ],
    sm: <BoxShadow>[
      BoxShadow(
        color: const Color(0xFF000000).withAlpha(20),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
    md: <BoxShadow>[
      BoxShadow(
        color: const Color(0xFF000000).withAlpha(30),
        blurRadius: 16,
        offset: const Offset(0, 8),
      ),
    ],
    lg: <BoxShadow>[
      BoxShadow(
        color: const Color(0xFF000000).withAlpha(40),
        blurRadius: 32,
        offset: const Offset(0, 16),
      ),
    ],
    xl: <BoxShadow>[
      BoxShadow(
        color: const Color(0xFF000000).withAlpha(50),
        blurRadius: 64,
        offset: const Offset(0, 24),
      ),
    ],
    glow: <BoxShadow>[
      BoxShadow(
        color: const Color(0xFFFF2E8A).withAlpha(40),
        blurRadius: 24,
        spreadRadius: 2,
      ),
    ],
  );

  @override
  AppShadows copyWith({
    List<BoxShadow>? none,
    List<BoxShadow>? xs,
    List<BoxShadow>? sm,
    List<BoxShadow>? md,
    List<BoxShadow>? lg,
    List<BoxShadow>? xl,
    List<BoxShadow>? glow,
  }) => AppShadows(
    none: none ?? this.none,
    xs: xs ?? this.xs,
    sm: sm ?? this.sm,
    md: md ?? this.md,
    lg: lg ?? this.lg,
    xl: xl ?? this.xl,
    glow: glow ?? this.glow,
  );

  @override
  AppShadows lerp(AppShadows? other, double t) {
    if (other == null) return this;
    return AppShadows(
      none: BoxShadow.lerpList(none, other.none, t) ?? none,
      xs: BoxShadow.lerpList(xs, other.xs, t) ?? xs,
      sm: BoxShadow.lerpList(sm, other.sm, t) ?? sm,
      md: BoxShadow.lerpList(md, other.md, t) ?? md,
      lg: BoxShadow.lerpList(lg, other.lg, t) ?? lg,
      xl: BoxShadow.lerpList(xl, other.xl, t) ?? xl,
      glow: BoxShadow.lerpList(glow, other.glow, t) ?? glow,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is AppShadows &&
        other.none == none &&
        other.xs == xs &&
        other.sm == sm &&
        other.md == md &&
        other.lg == lg &&
        other.xl == xl &&
        other.glow == glow;
  }

  @override
  int get hashCode => Object.hash(none, xs, sm, md, lg, xl, glow);
}
