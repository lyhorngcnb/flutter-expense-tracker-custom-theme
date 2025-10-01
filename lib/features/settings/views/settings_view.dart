import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('settings'.tr)),
      body: Column(
        children: [
          ListTile(
            title: Text('language'.tr),
            trailing: DropdownButton<Locale>(
              value: Get.locale,
              items: [
                DropdownMenuItem(value: Locale('en', 'US'), child: Text("English")),
                DropdownMenuItem(value: Locale('km', 'KH'), child: Text("ភាសាខ្មែរ")),
              ],
              onChanged: (locale) {
                if (locale != null) Get.updateLocale(locale);
              },
            ),
          ),
          SwitchListTile(
            title: Text('dark_mode'.tr),
            value: Get.isDarkMode,
            onChanged: (val) => Get.changeThemeMode(val ? ThemeMode.dark : ThemeMode.light),
          ),
        ],
      ),
    );
  }
}
