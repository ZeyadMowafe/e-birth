import 'package:ebirth/core/di/injection_container.dart';
import 'package:ebirth/core/router/app_router.dart';
import 'package:ebirth/core/theme/app_theme.dart';
import 'package:ebirth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const EBirthApp());
}

class EBirthApp extends StatelessWidget {
  const EBirthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'E-Birth',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ar')],
      locale: const Locale('ar'),
    );
  }
}

