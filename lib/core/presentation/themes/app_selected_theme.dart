import 'themes.dart';

enum AppSelectedTheme { light }

extension AppSelectedThemeX on AppSelectedTheme {
  ThemeColor get theme {
    switch (this) {
      case AppSelectedTheme.light:
        return AppLightTheme();
    }
  }
}
