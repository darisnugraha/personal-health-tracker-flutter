import 'package:flutter/material.dart';

class AddBodyWeightSection extends StatelessWidget {
  const AddBodyWeightSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AddBodyWeightForm(),
    );
  }
}

class AddBodyWeightForm extends StatefulWidget {
  const AddBodyWeightForm({super.key});

  @override
  _AddBodyWeightFormState createState() => _AddBodyWeightFormState();
}

class _AddBodyWeightFormState extends State<AddBodyWeightForm> {
  final _formKey = GlobalKey<FormState>();
  final _weightValue = TextEditingController();
  final _heightValue = TextEditingController();
  final _bodyFatValue = TextEditingController();
  final _muscleMassValue = TextEditingController();
  final _visceralFatValue = TextEditingController();
  final _basalMetabolismValue = TextEditingController();

  @override
  void dispose() {
    _weightValue.dispose();
    _heightValue.dispose();
    _bodyFatValue.dispose();
    _muscleMassValue.dispose();
    _visceralFatValue.dispose();
    _basalMetabolismValue.dispose();
    super.dispose();
  }

  String? _validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    final double? number = double.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }
    if (number.toStringAsFixed(2).length > 6) {
      // Up to 3 digits and 1 decimal point
      return 'Maximum of 3 digits allowed';
    }
    return null;
  }

  String? _validateHeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    final double? number = double.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }
    if (number.toStringAsFixed(2).length > 6) {
      // Up to 3 digits and 1 decimal point
      return 'Maximum of 3 digits allowed';
    }
    return null;
  }

  String? _validateBodyFat(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    final double? number = double.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }
    if (number.toStringAsFixed(2).length > 5) {
      // Up to 3 digits and 1 decimal point
      return 'Maximum of 2 digits allowed';
    }
    return null;
  }

  String? _validateVisceralFat(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    final int? number = int.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }
    if (number >= 12) {
      // Up to 3 digits and 1 decimal point
      return 'Maximum Number is 1-12';
    }
    return null;
  }

  String? _validateBasalMetabolism(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (value.length > 5) {
      // Up to 3 digits and 1 decimal point
      return 'Maximum of 4 digits allowed';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Body Weight Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _weightValue,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Weight (Kg)',
                ),
                validator: _validateWeight,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _heightValue,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Height (Cm)',
                ),
                validator: _validateHeight,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _bodyFatValue,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Body Fat (%)',
                ),
                validator: _validateBodyFat,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _muscleMassValue,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Muscle Mass (Kg)',
                ),
                validator: _validateBodyFat,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _visceralFatValue,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Visceral Fat',
                ),
                validator: _validateVisceralFat,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _basalMetabolismValue,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Basal Metabolism (Kcal)',
                ),
                validator: _validateBasalMetabolism,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Form is valid!')),
                    );
                    final double? weight = double.tryParse(_weightValue.text);
                    final double height =
                        double.tryParse(_heightValue.text)! / 100;
                    double bmi = 0;
                    bmi = weight! / (height * height);
                    final String bmifixed = bmi.toStringAsFixed(2);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BMIPage(value: bmifixed),
                      ),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BMIPage extends StatelessWidget {
  final String value;

  BMIPage({required this.value});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Your BMI : ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40), // Spacing between text and button
            Text(value)
          ],
        ),
      ),
    );
  }
}
