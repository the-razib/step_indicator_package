import 'package:get/get.dart';

class StepIndicatorController extends GetxController {
  final RxInt currentStep = 0.obs;
  final int maxSteps;
  final int initialStep;
  final void Function(int)? onStepChanged;

  StepIndicatorController({
    required this.maxSteps,
    this.initialStep = 0,
    this.onStepChanged,
  });

  @override
  void onInit() {
    super.onInit();
    currentStep.value = initialStep;
  }

  void nextStep() {
    if (currentStep.value < maxSteps) {
      currentStep.value++;
      _notifyStepChanged();
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
      _notifyStepChanged();
    }
  }

  void setStep(int step) {
    if (step >= 0 && step <= maxSteps) {
      currentStep.value = step;
      _notifyStepChanged();
    }
  }

  void _notifyStepChanged() {
    if (onStepChanged != null) {
      onStepChanged!(currentStep.value);
    }
  }
}
