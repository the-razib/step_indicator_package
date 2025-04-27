import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_indicator_package/step_indicator_package.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: StepIndicatorExample(),
    );
  }
}

class StepIndicatorExample extends StatelessWidget {
  StepIndicatorExample({super.key});



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
            // StepIndicator Widget
            StepIndicator(
              // controller: customController, // <- inject custom controller
              steps: const ["Request", "Pending", "Confirmed", "Completed"],
              activeColor: Colors.green,
              activeLineColor: Colors.green,
              inactiveColor: Colors.grey,
              inactiveLineColor: Colors.grey.shade300,
              showNavigationButtons: true, // shows Prev/Next buttons
              showStepsText: true,          // shows step labels
            ),

            const SizedBox(height: 40),

            // You can also control it manually anywhere!
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ElevatedButton(
                //   onPressed: () => customController.setStep(0),
                //   child: const Text('Go to Start'),
                // ),
                // const SizedBox(width: 20),
                // ElevatedButton(
                //   onPressed: () => customController.setStep(3),
                //   child: const Text('Complete'),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
