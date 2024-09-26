import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_health_tracker_flutter/addbodyweight.dart';

class DateOfBirth extends StatelessWidget {
  const DateOfBirth({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DateOfBirthForm(),
    );
  }
}

class DateOfBirthForm extends StatefulWidget {
  const DateOfBirthForm({super.key});

  @override
  _DateOfBirthFormState createState() => _DateOfBirthFormState();
}

class _DateOfBirthFormState extends State<DateOfBirthForm> {
  // Variable to hold the selected date
  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();

  // Function to show date picker dialog
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text =
            DateFormat('yyyy-MM-dd').format(picked); // Formatting date
      });
    }
  }

  final _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date Of Birth Selection Form'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Select Date',
                  suffixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                readOnly: true, // Makes the field non-editable
                onTap: () => _selectDate(context), // Opens the DatePicker
              ),
              const SizedBox(height: 10),
              // Display selected date in a Text widget
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_selectedDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Date Of Birth is Required !')),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddBodyWeightSection()),
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
