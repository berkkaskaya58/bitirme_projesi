import 'package:bitirme_projesi/controller/theme_controller/index.dart';
import 'package:bitirme_projesi/size_controller/index.dart';
import 'package:bitirme_projesi/ui/ui_text/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  final themeController = Get.find<ThemeController>();
  final textSizeController = Get.find<TextSizeController>();

   SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text(UIText.settings)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Obx(() => SwitchListTile(
                  title:  Text(UIText.darkMode),
                  value: themeController.isDarkMode.value,
                  onChanged: (_) => themeController.toggleTheme(),
                )),
            const SizedBox(height: 20),
             Text(UIText.fontSize, style: const TextStyle(fontSize: 18)),
            Obx(() => Slider(
                  min: 0.8,
                  max: 1.5,
                  divisions: 7,
                  value: textSizeController.textScale.value,
                  label: textSizeController.textScale.value.toStringAsFixed(2),
                  onChanged: (val) => textSizeController.changeTextSize(val),
                )),
            const SizedBox(height: 30),
          
          ],
        ),
      ),
    );
  }
}