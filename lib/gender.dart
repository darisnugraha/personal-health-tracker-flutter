import 'package:flutter/material.dart';
import 'package:personal_health_tracker_flutter/dateofbirth.dart';

class GenderSection extends StatelessWidget {
  const GenderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GenderSelectionForm(),
    );
  }
}

class GenderSelectionForm extends StatefulWidget {
  const GenderSelectionForm({super.key});

  @override
  _GenderSelectionFormState createState() => _GenderSelectionFormState();
}

class _GenderSelectionFormState extends State<GenderSelectionForm> {
  String? _gender; // This stores the selected gender

  final _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gender Selection Form'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Please select your gender:',
                style: TextStyle(fontSize: 16),
              ),
              ListTile(
                title: const Text('Wanita'),
                leading: Radio<String>(
                  value: 'Wanita',
                  groupValue: _gender,
                  onChanged: (String? value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Pria'),
                leading: Radio<String>(
                  value: 'Pria',
                  groupValue: _gender,
                  onChanged: (String? value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, proceed with the next action
                    if (_gender == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Gender is Required !')),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DateOfBirth()),
                      );
                    }
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
