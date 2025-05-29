# Step Indicator Package

A customizable step indicator widget for Flutter applications. This package provides a beautiful and flexible way to show progress through a series of steps.

## Features

- Multiple design options (Circle, Square, Triangle, Star, Diamond, Hexagon)
- Customizable step indicators with labels
- Animated progress transitions
- Navigation buttons (Previous/Next)
- Customizable colors, sizes, and icons
- Tap to navigate between steps
- Built-in state management
- No external dependencies

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  step_indicator_package: ^1.1.2
```

## Usage

### Basic Usage

```dart
StepIndicator(
  steps: const ["Requested", "Processing", "Shipped", "Delivered"],
  initialStep: 0,
  onStepChanged: (step) {
    print('Current step: $step');
  },
)
```

### With Custom Design

```dart
StepIndicator(
  steps: const ["Step 1", "Step 2", "Step 3", "Step 4"],
  design: StepIndicatorDesign.star, // Choose from: circle, square, triangle, star, diamond, hexagon
  activeColor: Colors.blue,
  inactiveColor: Colors.grey,
)
```

### With Custom State Management

```dart
// Create a state instance
final stepState = StepIndicatorState(
  maxSteps: 3,
  initialStep: 0,
  onStepChanged: (step) {
    print('Step changed to: $step');
  },
);

// Use the widget
StepIndicator(
  steps: const ["Step 1", "Step 2", "Step 3", "Step 4"],
  state: stepState,
  design: StepIndicatorDesign.diamond,
)
```

### Customization Options

```dart
StepIndicator(
  steps: const ["Step 1", "Step 2", "Step 3"],
  design: StepIndicatorDesign.circle, // Default design
  circleRadius: 20.0,
  lineHeight: 8.0,
  fontSize: 12.0,
  activeColor: Colors.blue,
  inactiveColor: Colors.grey,
  activeLineColor: Colors.blue,
  inactiveLineColor: Colors.grey,
  activeIcon: Icons.check,
  showNavigationButtons: true,
  showStepsText: true,
  allowCircleTap: true,
)
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| steps | List<String> | ["Request", "Pending", "Confirmed", "Completed"] | List of step labels |
| design | StepIndicatorDesign | StepIndicatorDesign.circle | Design of the step indicators (circle, square, triangle, star, diamond, hexagon) |
| state | StepIndicatorState? | null | Optional state management instance |
| circleRadius | double | 20.0 | Radius of the step indicators |
| lineHeight | double | 8.0 | Height of the connecting lines |
| fontSize | double | 10.0 | Font size for step labels |
| paddingHorizontal | double | 32.0 | Horizontal padding |
| sideLineLength | double | 20.0 | Length of side lines |
| activeColor | Color | Color(0xff003285) | Color for active step text |
| inactiveColor | Color | Color(0xFFB0BEC5) | Color for inactive step text |
| activeLineColor | Color | Color(0xFF1A237E) | Color for active lines |
| inactiveLineColor | Color | Color(0xFFE0E0E0) | Color for inactive lines |
| activeIcon | IconData | Icons.check | Icon for completed steps |
| leftArrowIcon | IconData | Icons.arrow_right_alt | Icon for left arrow |
| rightArrowIcon | IconData | Icons.arrow_right_alt | Icon for right arrow |
| iconSize | double | 20.0 | Size of icons |
| labelTextStyle | TextStyle? | null | Custom text style for labels |
| animationDuration | Duration | Duration(milliseconds: 300) | Animation duration |
| previousButton | Widget? | null | Custom previous button |
| nextButton | Widget? | null | Custom next button |
| showNavigationButtons | bool | true | Show navigation buttons |
| showStepsText | bool | true | Show step labels |
| allowCircleTap | bool | true | Allow tapping on indicators |
| initialStep | int | 0 | Initial step index |
| onStepChanged | Function(int)? | null | Callback when step changes |

## Available Designs

The package supports the following designs for step indicators:

1. **Circle** (Default) - Classic circular indicators
2. **Square** - Square indicators with rounded corners
3. **Triangle** - Triangular indicators pointing upward
4. **Star** - Five-pointed star indicators
5. **Diamond** - Diamond-shaped indicators
6. **Hexagon** - Six-sided hexagonal indicators

## State Management

The package uses Flutter's built-in state management through `ChangeNotifier`. You can either:

1. Let the widget manage its own state by providing `initialStep` and `onStepChanged`
2. Provide your own `StepIndicatorState` instance for more control

### StepIndicatorState Methods

- `nextStep()`: Move to the next step
- `previousStep()`: Move to the previous step
- `setStep(int step)`: Set a specific step
- `currentStep`: Get the current step index

## Example

Check out the [example](example) directory for a complete implementation.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

