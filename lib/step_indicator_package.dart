import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'step_indicator_controller.dart';

class StepIndicator extends StatelessWidget {
  final List<String> steps;
  final StepIndicatorController? controller;
  final double circleRadius;
  final double lineHeight;
  final double fontSize;
  final double paddingHorizontal;
  final double sideLineLength;
  final Color activeColor;
  final Color inactiveColor;
  final Color activeLineColor;
  final Color inactiveLineColor;
  final IconData activeIcon;
  final IconData leftArrowIcon;
  final IconData rightArrowIcon;
  final double iconSize;
  final TextStyle? labelTextStyle;
  final Duration animationDuration;
  final Widget? previousButton;
  final Widget? nextButton;
  final bool showNavigationButtons;
  final bool showStepsText;

  const StepIndicator({
    super.key,
    this.steps = const ["Request", "Pending", "Confirmed", "Completed"],
    this.controller,
    this.circleRadius = 20.0,
    this.lineHeight = 8.0,
    this.fontSize = 10.0,
    this.paddingHorizontal = 32.0,
    this.sideLineLength = 20.0,
    this.activeColor = const Color(0xff003285),
    this.inactiveColor = const Color(0xFFB0BEC5),
    this.activeLineColor = const Color(0xFF1A237E),
    this.inactiveLineColor = const Color(0xFFE0E0E0),
    this.activeIcon = Icons.check,
    this.leftArrowIcon = Icons.arrow_right_alt,
    this.rightArrowIcon = Icons.arrow_right_alt,
    this.iconSize = 20.0,
    this.labelTextStyle,
    this.animationDuration = const Duration(milliseconds: 300),
    this.previousButton,
    this.nextButton,
    this.showNavigationButtons = true,
    this.showStepsText = true,
  });

  @override
  Widget build(BuildContext context) {
    final StepIndicatorController ctrl = controller ??
        Get.put(StepIndicatorController(maxSteps: steps.length - 1));

    final screenWidth = MediaQuery.of(context).size.width;
    final availableWidth = screenWidth - paddingHorizontal;
    final spacing =
        (availableWidth - (steps.length * (circleRadius * 2))) /
            (steps.length - 1);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showStepsText) _buildStepLabels(ctrl, spacing),
        const SizedBox(height: 8),
        _buildProgressLine(ctrl, availableWidth, spacing),
        if (showNavigationButtons) ...[
          const SizedBox(height: 20),
          _buildNavigationButtons(ctrl),
        ],
      ],
    );
  }

  Widget _buildStepLabels(StepIndicatorController ctrl, double spacing) {
    return Obx(() {
      int current = ctrl.currentStep.value;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(steps.length, (index) {
          bool isActive = index <= current;
          return SizedBox(
            width: circleRadius * 0.1 + spacing,
            child: Text(
              steps[index],
              style: labelTextStyle ??
                  TextStyle(
                    fontSize: fontSize,
                    color: isActive ? activeColor : inactiveColor,
                    fontWeight:
                    index == current ? FontWeight.bold : FontWeight.normal,
                  ),
              textAlign: TextAlign.center,
            ),
          );
        }),
      );
    });
  }

  Widget _buildProgressLine(
      StepIndicatorController ctrl, double availableWidth, double spacing) {
    return SizedBox(
      width: availableWidth,
      height: circleRadius * 2 + 16,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background grey line
          Positioned(
            left: sideLineLength,
            right: sideLineLength,
            child: Container(
              height: lineHeight,
              decoration: BoxDecoration(
                color: inactiveLineColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          // Left active line + arrow
          Positioned(
            left: 0,
            child: Row(
              children: [
                Container(
                  width: sideLineLength,
                  height: lineHeight,
                  color: activeLineColor,
                ),
                Transform.rotate(
                  angle: math.pi,
                  child: Icon(
                    leftArrowIcon,
                    color: activeLineColor,
                    size: iconSize,
                  ),
                ),
              ],
            ),
          ),
          // Right inactive line + arrow
          Positioned(
            right: 0,
            child: Row(
              children: [
                Transform.rotate(
                  angle: 0,
                  child: Icon(
                    rightArrowIcon,
                    color: inactiveLineColor,
                    size: iconSize,
                  ),
                ),
                Container(
                  width: sideLineLength,
                  height: lineHeight,
                  color: inactiveLineColor,
                ),
              ],
            ),
          ),
          // Main progress line
          Positioned(
            left: sideLineLength,
            child: Obx(() {
              int current = ctrl.currentStep.value;
              double progressWidth =
                  (current) * (spacing + circleRadius * 2);

              return ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: AnimatedContainer(
                  duration: animationDuration,
                  height: lineHeight,
                  width: progressWidth,
                  color: activeLineColor,
                ),
              );
            }),
          ),
          // Step circles
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(steps.length, (index) {
                return Obx(() {
                  int current = ctrl.currentStep.value;
                  bool isActive = index <= current;
                  bool isCompleted = index <= current;

                  return GestureDetector(
                    onTap: () => ctrl.setStep(index),
                    child: SizedBox(
                      width: circleRadius * 2,
                      height: circleRadius * 2,
                      child: AnimatedContainer(
                        duration: animationDuration,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive
                              ? activeLineColor
                              : inactiveLineColor,
                        ),
                        child: Center(
                          child: isCompleted
                              ? Icon(
                            activeIcon,
                            color: Colors.white,
                            size: iconSize,
                          )
                              : null,
                        ),
                      ),
                    ),
                  );
                });
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(StepIndicatorController ctrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        previousButton ??
            ElevatedButton(
              onPressed: ctrl.previousStep,
              child: const Text('Previous'),
            ),
        const SizedBox(width: 20),
        nextButton ??
            ElevatedButton(
              onPressed: ctrl.nextStep,
              child: const Text('Next'),
            ),
      ],
    );
  }
}
