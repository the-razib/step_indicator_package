import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_indicator_package/step_indicator.dart';

void main() {
  runApp(const StepIndicatorExampleApp());
}

/// A simple example app to demonstrate the usage of StepIndicator widget
class StepIndicatorExampleApp extends StatelessWidget {
  const StepIndicatorExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Step Indicator Example',
      debugShowCheckedModeBanner: false,
      home: const StepIndicatorExamplePage(),
    );
  }
}

/// The main page showing how to use StepIndicator with controller
class StepIndicatorExamplePage extends StatefulWidget {
  const StepIndicatorExamplePage({super.key});

  @override
  State<StepIndicatorExamplePage> createState() => _StepIndicatorExamplePageState();
}

class _StepIndicatorExamplePageState extends State<StepIndicatorExamplePage> {
  // Create a controller to manage the current step
  late StepIndicatorController stepController;

  @override
  void initState() {
    super.initState();
    stepController = StepIndicatorController(
      maxSteps: 3, // (Total steps - 1)
      initialStep: 1, // Start from step 1
      onStepChanged: (step) {
        debugPrint('Step changed to: $step');
      },
    );
  }

  @override
  void dispose() {
    // Always dispose controller if created manually
    Get.delete<StepIndicatorController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step Indicator Demo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StepIndicator(
              steps: const ["Requested", "Processing", "Shipped", "Delivered"],
              controller: stepController,
              allowCircleTap: true,
              initialStep: 1,
              onStepChanged: (index) {
                debugPrint('Current selected step: $index');
              },
              activeColor: Colors.green,
              inactiveColor: Colors.grey,
              activeLineColor: Colors.green,
              inactiveLineColor: Colors.grey,
              showNavigationButtons: true,
              showStepsText: true,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                stepController.setStep(2); // Example: Move to step 2 programmatically
              },
              child: const Text('Move to Step 3'),
            ),
          ],
        ),
      ),
    );
  }
}
