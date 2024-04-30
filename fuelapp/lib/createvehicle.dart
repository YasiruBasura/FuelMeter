import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'settings.dart';

class CreateVehicleScreen extends StatefulWidget {
  const CreateVehicleScreen({super.key});

  @override
  _CreateVehicleScreenState createState() => _CreateVehicleScreenState();
}

class _CreateVehicleScreenState extends State<CreateVehicleScreen> {
  String _brand = '';
  String _model = '';
  String _make = '';
  String _type = '';
  String _logoUrl = '';

  final CollectionReference _ref = FirebaseFirestore.instance.collection('Vehicles');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vehicle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputRow(
              label: 'Brand',
              inputField: TextFormField(
                decoration: _buildInputDecoration(),
                onChanged: (value) {
                  setState(() {
                    _brand = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 16.0),
            _buildInputRow(
              label: 'Model',
              inputField: TextFormField(
                decoration: _buildInputDecoration(),
                onChanged: (value) {
                  setState(() {
                    _model = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 16.0),
            _buildInputRow(
              label: 'Make(Year)',
              inputField: TextFormField(
                decoration: _buildInputDecoration(),
                onChanged: (value) {
                  setState(() {
                    _make = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 16.0),
            _buildInputRow(
              label: 'Type',
              inputField: TextFormField(
                decoration: _buildInputDecoration(),
                onChanged: (value) {
                  setState(() {
                    _type = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 16.0),
            _buildInputRow(
              label: 'Logo URL',
              inputField: TextFormField(
                decoration: _buildInputDecoration(),
                onChanged: (value) {
                  setState(() {
                    _logoUrl = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7, // Fill 70% of available width
                child: ElevatedButton(
                  onPressed: _saveVehicleData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 183, 88, 0),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveVehicleData() {
    // Create a map with the vehicle data
    Map<String, dynamic> vehicleData = {
      'brand': _brand,
      'model': _model,
      'make': _make,
      'type': _type,
      'logoUrl': _logoUrl,
    };

    // Add vehicle data to Firestore
    _ref.add(vehicleData).then((_) {
      // Data successfully saved
      _showSnackBar('Vehicle data saved successfully');
      // Redirect to settings screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SettingsScreen()),
      );
    }).catchError((error) {
      // Error occurred while saving data
      _showSnackBar('Failed to save vehicle data');
    });
  }

  Widget _buildInputRow({required String label, required Widget inputField}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16.0),
        ),
        Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 159, 159, 159),
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 150,
                child: inputField,
              ),
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration _buildInputDecoration() {
    return const InputDecoration(
      contentPadding: EdgeInsets.all(8.0), // Padding inside the input field
      border: InputBorder.none, // Hide default border
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
