import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Map<String, String>? _localizedStrings;

  Future<void> load() async {
    String jsonString =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  String? translate(String key) {
    return _localizedStrings?[key];
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  final Locale overriddenLocale;

  const AppLocalizationsDelegate({required this.overriddenLocale});

  @override
  bool isSupported(Locale locale) {
    return ['en', 'tr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(overriddenLocale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
