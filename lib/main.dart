import 'package:ebirth/core/cubit/locale_cubit.dart';
import 'package:ebirth/core/di/injection_container.dart';
import 'package:ebirth/core/router/app_router.dart';
import 'package:ebirth/core/theme/app_theme.dart';
import 'package:ebirth/core/helper/shared_prefs_helper.dart';
import 'package:ebirth/core/helper/auth_token_holder.dart';
import 'package:ebirth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  final savedToken = await SharedPrefsHelper.getToken();
  if (savedToken != null && savedToken.isNotEmpty) {
    AuthTokenHolder.setToken(savedToken);
  }

  final localeCubit = LocaleCubit();
  await localeCubit.loadSavedLocale();

  runApp(EBirthApp(localeCubit: localeCubit));
}

class EBirthApp extends StatelessWidget {
  final LocaleCubit localeCubit;

  const EBirthApp({super.key, required this.localeCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: localeCubit,
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
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
            supportedLocales: AppLocalizations.supportedLocales,
            locale: locale,
          );
        },
      ),
    );
  }
}

