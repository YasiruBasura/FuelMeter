import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'settings.dart';

class CreateVehicleScreen extends StatefulWidget {
  const CreateVehicleScreen({Key? key}) : super(key: key);

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

  final _brandFocusNode = FocusNode();
  final _modelFocusNode = FocusNode();
  final _makeFocusNode = FocusNode();
  final _typeFocusNode = FocusNode();
  final _logoUrlFocusNode = FocusNode();

  @override
  void dispose() {
    _brandFocusNode.dispose();
    _modelFocusNode.dispose();
    _makeFocusNode.dispose();
    _typeFocusNode.dispose();
    _logoUrlFocusNode.dispose();
    super.dispose();
  }

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
                focusNode: _brandFocusNode, // Assign focus node
                decoration: _buildInputDecoration(focused: _brandFocusNode.hasFocus),
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
                focusNode: _modelFocusNode, // Assign focus node
                decoration: _buildInputDecoration(focused: _modelFocusNode.hasFocus),
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
                focusNode: _makeFocusNode, // Assign focus node
                decoration: _buildInputDecoration(focused: _makeFocusNode.hasFocus),
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
                focusNode: _typeFocusNode, // Assign focus node
                decoration: _buildInputDecoration(focused: _typeFocusNode.hasFocus),
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
                focusNode: _logoUrlFocusNode, // Assign focus node
                decoration: _buildInputDecoration(focused: _logoUrlFocusNode.hasFocus),
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

InputDecoration _buildInputDecoration({required bool focused}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.all(8.0), // Padding inside the input field
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: focused ? const Color.fromARGB(255, 183, 88, 0) : const Color.fromARGB(255, 159, 159, 159),
        width: focused ? 3.0 : 1.0, // Set border width based on focus state
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
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
          child: inputField,
        ),
      ],
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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
