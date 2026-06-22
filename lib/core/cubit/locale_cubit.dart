import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebirth/core/helper/shared_prefs_helper.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('ar'));

  Future<void> loadSavedLocale() async {
    final saved = await SharedPrefsHelper.getLocale();
    final locale = saved != null ? Locale(saved) : const Locale('ar');
    emit(locale);
  }

  Future<void> setLocale(Locale locale) async {
    await SharedPrefsHelper.setLocale(locale.languageCode);
    emit(locale);
  }

  void toggle() {
    final next = state.languageCode == 'ar' ? const Locale('en') : const Locale('ar');
    setLocale(next);
  }
}
