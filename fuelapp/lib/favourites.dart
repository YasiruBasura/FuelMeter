import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
 
  final String? selectedVehicleId;

  const FavoritesScreen({Key? key, this.selectedVehicleId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body:  Center(
        child: Text(
         'Refilling for: $selectedVehicleId' ,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
