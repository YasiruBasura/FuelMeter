import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'createvehicle.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Vehicles').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot vehicle = snapshot.data!.docs[index];
              return _buildVehicleItem(context, vehicle);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create vehicle screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateVehicleScreen()),
          );
        },
        backgroundColor: Color.fromARGB(255, 183, 88, 0), // Set background color
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildVehicleItem(BuildContext context, DocumentSnapshot vehicle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(vehicle['logoUrl']), // Assuming logoUrl is the URL of the brand logo
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${vehicle['brand']} ${vehicle['model']}',
                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text('Type: ${vehicle['type']}'),
              Text('Year: ${vehicle['make']}'), // Changed to 'make' according to Firestore data
              // Add more details as needed
            ],
          ),
        ],
      ),
    );
  }
}
