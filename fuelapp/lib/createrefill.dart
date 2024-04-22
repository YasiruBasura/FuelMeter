import 'package:flutter/material.dart';


class CreateRefillScreen extends StatefulWidget {
  const CreateRefillScreen({super.key});

  @override
  _CreateRefillScreenState createState() => _CreateRefillScreenState();
}

class _CreateRefillScreenState extends State<CreateRefillScreen> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _selectedFuelType = '95'; // Initial selection
  double _price = 0.0;
  double _filled = 0.0;
  double _sumUSD = 0.0;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Refill'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputRow(
              label: 'Odometer (km)',
              inputField: TextFormField(
                keyboardType: TextInputType.number,
                decoration: _buildInputDecoration(),
              ),
            ),
            const SizedBox(height: 16.0),
            _buildInputRow(
              label: 'Filled (L)',
              inputField: TextFormField(
                keyboardType: TextInputType.number,
                decoration: _buildInputDecoration(),
                onChanged: (value) {
                  setState(() {
                    _filled = double.tryParse(value) ?? 0.0;
                    _updateSumUSD();
                  });
                },
              ),
            ),
            const SizedBox(height: 16.0),
            _buildInputRow(
              label: 'Price (USD/L)',
              inputField: TextFormField(
                keyboardType: TextInputType.number,
                decoration: _buildInputDecoration(),
                onChanged: (value) {
                  setState(() {
                    _price = double.tryParse(value) ?? 0.0;
                    _updateSumUSD();
                  });
                },
              ),
            ),
            const SizedBox(height: 16.0),
            _buildInputRow(
              label: 'Sum (USD)',
              inputField: Text(
                _sumUSD.toStringAsFixed(2),
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            const SizedBox(height: 16.0),
            _buildDateRow(),
            const SizedBox(height: 16.0),
            _buildInputRow(
              label: 'Fuel Type',
              inputField: ElevatedButton(
                onPressed: () {
                  _showFuelTypeDialog(context);
                },
                child: Text(_selectedFuelType),
              ),
            ),
            const SizedBox(height: 16.0),
            _buildInputRow(
              label: 'Comment',
              inputField: TextFormField(
                maxLines: null,
                decoration: _buildInputDecoration(),
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              alignment: Alignment.center,
               child: SizedBox(
    width: MediaQuery.of(context).size.width * 0.7, // Fill 70% of available width
    child: ElevatedButton(
      onPressed: () {
        // Add logic to save refill data
      },
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

  void _updateSumUSD() {
    setState(() {
      _sumUSD = _price * _filled;
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


  Widget _buildDateRow() {
    return Row(
      children: [
        const Text(
          'Date',
          style: TextStyle(fontSize: 16.0),
        ),
        const SizedBox(width: 16.0),
        ElevatedButton(
          onPressed: () => _selectDate(context),
          child: Text('${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
        ),
        const SizedBox(width: 8.0),
        ElevatedButton(
          onPressed: () => _selectTime(context),
          child: Text('${_selectedTime.hour}:${_selectedTime.minute}'),
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

  Future<void> _showFuelTypeDialog(BuildContext context) async {
    final String? selectedFuelType = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Fuel Type'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5, // Set width to 50% of screen width
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  value: _selectedFuelType,
                  onChanged: (String? newValue) {
                    Navigator.of(context).pop(newValue);
                  },
                  items: <String>['95', '98', 'Diesel', 'Gas']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16.0), // Add some spacing below the dropdown
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );

    if (selectedFuelType != null) {
      setState(() {
        _selectedFuelType = selectedFuelType;
      });
    }
  }
}


