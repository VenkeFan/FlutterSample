import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'l10n/messages_all.dart';

class FQLocalizations {
  static Future<FQLocalizations> load(Locale locale) {
    final String name = locale.countryCode == null || locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return FQLocalizations();
    });
  }

  static FQLocalizations of(BuildContext context) {
    return Localizations.of<FQLocalizations>(context, FQLocalizations);
  }

  String get title {
    return Intl.message(
      '这个message_str有啥用',
      name: 'title',
    );
  }

  String localizedString(String localeName) {
    return Intl.message(
      '这个message_str有啥用',
      name: localeName,
    );
  }
}

class FQLocalizationsDelegate extends LocalizationsDelegate<FQLocalizations> {
  const FQLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<FQLocalizations> load(Locale locale) => FQLocalizations.load(locale);

  @override
  bool shouldReload(FQLocalizationsDelegate old) => false;
}

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FQLocalizations.of(context).title),
      ),
      body: Center(
        child: Text(FQLocalizations.of(context).title),
      ),
    );
  }
}