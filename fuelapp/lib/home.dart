import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'navBar.dart';

class HomeScreen extends StatelessWidget {
  final String? selectedVehicleId;

  const HomeScreen({Key? key, this.selectedVehicleId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(selectedVehicleId: selectedVehicleId), 
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: 16,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                if (index == 9 || index == 10 || index == 13 || index == 14) {
                  // Return an empty container for the bottom middle 2x2 tiles
                  return Container();
                } else {
                  // Display clickable tile for other tiles
                  return ClickableTile(
                    title: 'Tile $index',
                    value: 'Value $index',
                  );
                }
              },
            ),
          ),
          if (selectedVehicleId != null) // Check if a vehicle is selected
            Positioned(
              left: 125, // Adjust left position
              top: 225, // Adjust top position
              child: FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('Vehicles').doc(selectedVehicleId).get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(); // Return an empty container when loading
                  }
                  if (!snapshot.hasData) {
                    return const Text('Vehicle not found');
                  }
                  final data = snapshot.data!.data() as Map<String, dynamic>;
                  final logoUrl = data['logoUrl'];

                  return CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(logoUrl),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class ClickableTile extends StatelessWidget {
  final String title;
  final String value;

  const ClickableTile({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tile tap here
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 183, 88, 0), // Tile background color
          borderRadius: BorderRadius.circular(8), // Tile border radius
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Tile text color
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white, // Tile text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
