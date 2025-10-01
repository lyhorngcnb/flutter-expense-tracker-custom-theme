import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TranslationService extends Translations {
  static const fallbackLocale = Locale('en', 'US');
  static final locales = [
    const Locale('en', 'US'),
    const Locale('km', 'KH'),
  ];

  static Future<Map<String, Map<String, String>>> loadTranslations() async {
    final en = await rootBundle.loadString('assets/lang/en.json');
    final km = await rootBundle.loadString('assets/lang/km.json');
    return {
      'en_US': Map<String, String>.from(json.decode(en)),
      'km_KH': Map<String, String>.from(json.decode(km)),
    };
  }

  static Future<TranslationService> init() async {
    final translations = await loadTranslations();
    return TranslationService._(translations);
  }

  final Map<String, Map<String, String>> _translations;
  TranslationService._(this._translations);

  @override
  Map<String, Map<String, String>> get keys => _translations;
}
