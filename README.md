
# Step Indicator Package

A customizable and interactive step indicator widget for Flutter applications. This package allows you to visually represent the progress of a multi-step process, such as a form wizard or a task tracker, with navigation controls and dynamic updates.

## Features

- **Customizable Design**: Adjust colors, sizes, icons, and text styles to match your app's theme.
- **Interactive Steps**: Users can tap on steps to navigate directly.
- **Navigation Buttons**: Built-in "Next" and "Previous" buttons for easy navigation.
- **Dynamic Updates**: Automatically updates the progress line and step indicators based on user interaction.
- **Reactive State Management**: Powered by the `GetX` package for efficient state management.

## Getting Started

### Prerequisites

Ensure you have the following dependencies in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.5
```

### Installation

Add the package to your project by running:

```bash
flutter pub add step_indicator_package
```

Then, import it in your Dart file:

```dart
import 'package:step_indicator_package/step_indicator_package.dart';
```

## Usage

### Basic Example

Here is a simple example of how to use the `StepIndicator` widget:

```dart
import 'package:flutter/material.dart';
import 'package:step_indicator_package/step_indicator_package.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Step Indicator Example')),
        body: Center(
          child: StepIndicator(
            steps: ["Step 1", "Step 2", "Step 3", "Step 4"],
            activeColor: Colors.blue,
            inactiveColor: Colors.grey,
            activeLineColor: Colors.blueAccent,
            inactiveLineColor: Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}
```

### Advanced Example

For more control, you can pass a custom `StepIndicatorController` to manage the state programmatically:

```dart
final controller = StepIndicatorController(maxSteps: 3);

StepIndicator(
  steps: ["Request", "Pending", "Confirmed", "Completed"],
  controller: controller,
  showNavigationButtons: true,
  previousButton: ElevatedButton(
    onPressed: controller.previousStep,
    child: const Text('Back'),
  ),
  nextButton: ElevatedButton(
    onPressed: controller.nextStep,
    child: const Text('Next'),
  ),
);
```

## Customization

The `StepIndicator` widget provides several properties for customization:

- **Steps**: Define the labels for each step.
- **Colors**: Customize active/inactive colors for steps and lines.
- **Icons**: Use custom icons for active steps and navigation arrows.
- **Dimensions**: Adjust circle radius, line height, and spacing.
- **Text Styles**: Customize the font size and style of step labels.
- **Animation**: Control the animation duration for progress updates.

## Contributing

Contributions are welcome! If you encounter any issues or have feature requests, please file them in the [issue tracker](https://github.com/the-razib/step_indicator_package/issues).

## License

This package is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Additional Information

For more details, visit the [official documentation](https://pub.dev/packages/step_indicator_package) or contact the package authors.


