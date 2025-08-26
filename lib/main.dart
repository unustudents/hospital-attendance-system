import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import 'routes/app_router.dart';

void main() {
  runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => const Application()));
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    /// Try changing this and hot reloading the application.
    ///
    /// To create a custom theme:
    /// ```shell
    /// dart forui theme create [theme template].
    /// ```
    final theme = FThemes.green.light;

    return MaterialApp.router(
      supportedLocales: FLocalizations.supportedLocales,
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      locale: DevicePreview.locale(context),
      routerConfig: AppRouter.router,
      builder: (context, child) {
        child = DevicePreview.appBuilder(context, child);
        return FTheme(data: theme, child: child);
      },
      theme: theme.toApproximateMaterialTheme(),
    );
  }
}
