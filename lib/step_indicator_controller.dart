import 'package:get/get.dart';

class StepIndicatorController extends GetxController {
  final RxInt currentStep = 0.obs;
  final int maxSteps;

  StepIndicatorController({required this.maxSteps});

  @override
  void onInit() {
    super.onInit();
    currentStep.value = 0;
  }

  void nextStep() {
    if (currentStep.value < maxSteps) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void setStep(int step) {
    if (step >= 0 && step <= maxSteps) {
      currentStep.value = step;
    }
  }
}
