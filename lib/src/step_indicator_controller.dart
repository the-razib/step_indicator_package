import 'package:flutter/material.dart';

class StepIndicatorState extends ChangeNotifier {
  int _currentStep;
  final int maxSteps;
  final void Function(int)? onStepChanged;

  StepIndicatorState({
    required this.maxSteps,
    int initialStep = 0,
    this.onStepChanged,
  }) : _currentStep = initialStep;

  int get currentStep => _currentStep;

  void nextStep() {
    if (_currentStep < maxSteps) {
      _currentStep++;
      _notifyStepChanged();
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      _notifyStepChanged();
      notifyListeners();
    }
  }

  void setStep(int step) {
    if (step >= 0 && step <= maxSteps) {
      _currentStep = step;
      _notifyStepChanged();
      notifyListeners();
    }
  }

  void _notifyStepChanged() {
    if (onStepChanged != null) {
      onStepChanged!(_currentStep);
    }
  }
}
