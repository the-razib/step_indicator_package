import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'step_indicator_controller.dart';

class StepIndicator extends StatefulWidget {
  final List<String> steps;
  final StepIndicatorState? state;
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
  final bool allowCircleTap;
  final int initialStep;
  final void Function(int)? onStepChanged;

  const StepIndicator({
    super.key,
    this.steps = const ["Request", "Pending", "Confirmed", "Completed"],
    this.state,
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
    this.allowCircleTap = true,
    this.initialStep = 0,
    this.onStepChanged,
  });

  @override
  State<StepIndicator> createState() => _StepIndicatorState();
}

class _StepIndicatorState extends State<StepIndicator> {
  late StepIndicatorState _state;

  @override
  void initState() {
    super.initState();
    _state =
        widget.state ??
        StepIndicatorState(
          maxSteps: widget.steps.length - 1,
          initialStep: widget.initialStep,
          onStepChanged: widget.onStepChanged,
        );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final availableWidth = screenWidth - widget.paddingHorizontal;
    final spacing =
        (availableWidth - (widget.steps.length * (widget.circleRadius * 2))) /
        (widget.steps.length - 1);

    return ListenableBuilder(
      listenable: _state,
      builder: (context, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.showStepsText) _buildStepLabels(spacing),
            const SizedBox(height: 8),
            _buildProgressLine(availableWidth, spacing),
            if (widget.showNavigationButtons) ...[
              const SizedBox(height: 20),
              _buildNavigationButtons(),
            ],
          ],
        );
      },
    );
  }

  Widget _buildStepLabels(double spacing) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.steps.length, (index) {
        bool isActive = index <= _state.currentStep;
        return SizedBox(
          width: widget.circleRadius * 0.1 + spacing,
          child: Text(
            widget.steps[index],
            style:
                widget.labelTextStyle ??
                TextStyle(
                  fontSize: widget.fontSize,
                  color: isActive ? widget.activeColor : widget.inactiveColor,
                  fontWeight:
                      index == _state.currentStep
                          ? FontWeight.bold
                          : FontWeight.normal,
                ),
            textAlign: TextAlign.center,
          ),
        );
      }),
    );
  }

  Widget _buildProgressLine(double availableWidth, double spacing) {
    return SizedBox(
      width: availableWidth,
      height: widget.circleRadius * 2 + 16,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: widget.sideLineLength,
            right: widget.sideLineLength,
            child: Container(
              height: widget.lineHeight,
              decoration: BoxDecoration(
                color: widget.inactiveLineColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Positioned(
            left: 0,
            child: Row(
              children: [
                Container(
                  width: widget.sideLineLength,
                  height: widget.lineHeight,
                  color: widget.activeLineColor,
                ),
                Transform.rotate(
                  angle: math.pi,
                  child: Icon(
                    widget.leftArrowIcon,
                    color: widget.activeLineColor,
                    size: widget.iconSize,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            child: Row(
              children: [
                Transform.rotate(
                  angle: 0,
                  child: Icon(
                    widget.rightArrowIcon,
                    color: widget.inactiveLineColor,
                    size: widget.iconSize,
                  ),
                ),
                Container(
                  width: widget.sideLineLength,
                  height: widget.lineHeight,
                  color: widget.inactiveLineColor,
                ),
              ],
            ),
          ),
          Positioned(
            left: widget.sideLineLength,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: AnimatedContainer(
                duration: widget.animationDuration,
                height: widget.lineHeight,
                width: _state.currentStep * (spacing + widget.circleRadius * 2),
                color: widget.activeLineColor,
              ),
            ),
          ),
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(widget.steps.length, (index) {
                bool isActive = index <= _state.currentStep;
                bool isCompleted = index <= _state.currentStep;

                return GestureDetector(
                  onTap:
                      widget.allowCircleTap
                          ? () => _state.setStep(index)
                          : null,
                  child: SizedBox(
                    width: widget.circleRadius * 2,
                    height: widget.circleRadius * 2,
                    child: AnimatedContainer(
                      duration: widget.animationDuration,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            isActive
                                ? widget.activeLineColor
                                : widget.inactiveLineColor,
                      ),
                      child: Center(
                        child:
                            isCompleted
                                ? Icon(
                                  widget.activeIcon,
                                  color: Colors.white,
                                  size: widget.iconSize,
                                )
                                : null,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.previousButton ??
            ElevatedButton(
              onPressed: _state.previousStep,
              child: const Text('Previous'),
            ),
        const SizedBox(width: 20),
        widget.nextButton ??
            ElevatedButton(
              onPressed: _state.nextStep,
              child: const Text('Next'),
            ),
      ],
    );
  }
}
