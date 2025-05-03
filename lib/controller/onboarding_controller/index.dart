// lib/controller/onboarding_controller.dart
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingController extends GetxController {
  var isFirstTime = true.obs;

  @override
  void onInit() {
    checkIfFirstTime();
    super.onInit();
  }

  void checkIfFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    isFirstTime.value = prefs.getBool("isFirstTime") ?? true;
  }

  void completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isFirstTime", false);
    isFirstTime.value = false;
  }
}