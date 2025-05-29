import 'package:flutter/material.dart';
import 'package:step_indicator_package/step_indicator.dart';

void main() {
  runApp(const StepIndicatorExampleApp());
}

/// A simple example app to demonstrate the usage of StepIndicator widget
class StepIndicatorExampleApp extends StatelessWidget {
  const StepIndicatorExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Step Indicator Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const StepIndicatorExamplePage(),
    );
  }
}

/// The main page showing how to use StepIndicator with controller
class StepIndicatorExamplePage extends StatefulWidget {
  const StepIndicatorExamplePage({super.key});

  @override
  State<StepIndicatorExamplePage> createState() =>
      _StepIndicatorExamplePageState();
}

class _StepIndicatorExamplePageState extends State<StepIndicatorExamplePage> {
  late StepIndicatorState stepState;
  StepIndicatorDesign currentDesign = StepIndicatorDesign.circle;

  @override
  void initState() {
    super.initState();
    stepState = StepIndicatorState(
      maxSteps: 3, // (Total steps - 1)
      initialStep: 0, // Start from step 1
      onStepChanged: (step) {
        debugPrint('Step changed to: $step');
      },
    );
  }

  void _changeDesign(StepIndicatorDesign design) {
    setState(() {
      currentDesign = design;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step Indicator Demo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StepIndicator(
              steps: const ["Requested", "Processing", "Shipped", "Delivered"],
              state: stepState,
              allowCircleTap: true,
              design: currentDesign,
              activeColor: Colors.blue,
              inactiveColor: Colors.grey,
              activeLineColor: Colors.blue,
              inactiveLineColor: Colors.grey,
              showNavigationButtons: true,
              showStepsText: true,
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildDesignButton(StepIndicatorDesign.circle, 'Circle'),
                _buildDesignButton(StepIndicatorDesign.square, 'Square'),
                _buildDesignButton(StepIndicatorDesign.triangle, 'Triangle'),
                _buildDesignButton(StepIndicatorDesign.star, 'Star'),
                _buildDesignButton(StepIndicatorDesign.diamond, 'Diamond'),
                _buildDesignButton(StepIndicatorDesign.hexagon, 'Hexagon'),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                stepState.setStep(2);
              },
              child: const Text('Move to Step 3'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesignButton(StepIndicatorDesign design, String label) {
    final isSelected = currentDesign == design;
    return ElevatedButton(
      onPressed: () => _changeDesign(design),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey[200],
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      child: Text(label),
    );
  }
}
