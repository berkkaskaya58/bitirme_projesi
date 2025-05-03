import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextSizeController extends GetxController {
  var textScale = 1.0.obs;

  @override
  void onInit() {
    loadTextSize();
    super.onInit();
  }

  void changeTextSize(double newSize) {
    textScale.value = newSize;
    saveTextSize(newSize);
  }

  Future<void> loadTextSize() async {
    final prefs = await SharedPreferences.getInstance();
    textScale.value = prefs.getDouble("textSize") ?? 1.0;
  }

  Future<void> saveTextSize(double size) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble("textSize", size);
  }
}