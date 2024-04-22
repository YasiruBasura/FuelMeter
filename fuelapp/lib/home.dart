import 'package:flutter/material.dart';
import 'navBar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(), 
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.count(
                crossAxisCount: 4, // Number of columns
                mainAxisSpacing: 12, // Spacing between tiles vertically
                crossAxisSpacing: 12, // Spacing between tiles horizontally
                children: const [
                  ClickableTile(
                    title: 'Fuel Consumption',
                    value: '50 L',
                  ),
                  ClickableTile(
                    title: 'Total Passed',
                    value: '1000 km',
                  ),
                  ClickableTile(
                    title: 'Total Fuel',
                    value: '200 L',
                  ),
                  ClickableTile(
                    title: 'Total Expenses',
                    value: '\$500',
                  ),
                  ClickableTile(
                    title: 'Refill Cost',
                    value: '\$50',
                  ),
                  ClickableTile(
                    title: 'Next Refill',
                    value: 'Next Week',
                  ),
                  ClickableTile(
                    title: 'Price 1km',
                    value: '\$0.50',
                  ),
                  ClickableTile(
                    title: 'Mileage Per Day',
                    value: '30 km/day',
                  ),
                ],
              ),
            ),
          ),
          Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color.fromARGB(255, 255, 255, 255), width: 3), // Thick border
                ),
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.transparent, // Transparent background
                  child: ClipOval(
                    child: Image.network(
                      'https://cdn.wallpapersafari.com/22/71/8jbM2y.jpg',
                      fit: BoxFit.cover,
                      width: 160,
                      height: 160,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 240.0),
                child: Text(
                  'Aston Martin',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
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

  const ClickableTile({super.key, required this.title, required this.value});

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

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}

   