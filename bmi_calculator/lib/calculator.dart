import 'dart:math';

class CalculatorBrain {
  final int height;
  final int weight;

  double _bmi = 0;

  Map<double, String> thresholds = {
    40: 'Obese',
    25.0: 'Overweight',
    18.5: 'Normal',
    0: 'Underweight'
  };

  Map<double, String> interpretations = {
    40: 'Obese',
    25.0: 'You have a higher than normal body weight. Try to exercise more.',
    18.5: 'You have a normal body weight. Good job!',
    0: 'You have a lower than normal body weight. You can eat a bit more.'
  };

  CalculatorBrain({required this.height, required this.weight});

  void calculateBMI() {
    _bmi = _bmiCalculator(weight, height);
  }

  String getBMI() {
    calculateBMI();

    return _bmi.toStringAsFixed(1);
  }

  double _bmiCalculator(int weight, int height) {
    double heightInMeters = height / 100.0;
    num heightSquared = pow(heightInMeters, 2);

    double bmi = weight / heightSquared;

    return bmi;
  }

  String getResult() {
    String result = thresholds.entries
        .firstWhere((entry) => _bmi >= entry.key,
            orElse: () => thresholds.entries.last)
        .value;

    return result;
  }

  String getInterpretation() {
    String interpretation = interpretations.entries
        .firstWhere((entry) => _bmi >= entry.key,
            orElse: () => thresholds.entries.last)
        .value;

    return interpretation;
  }
}
