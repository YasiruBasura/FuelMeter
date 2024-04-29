import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'navBar.dart';


class HomeScreen extends StatelessWidget {
  final String? selectedVehicleId;

  const HomeScreen({super.key, this.selectedVehicleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(selectedVehicleId: selectedVehicleId), 
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body:Stack(
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
                }
                 else if (index == 0) {
              // Total Filled tile
              return ButtonTile(
                title: 'Refill',
                icon:Icons.playlist_add,
                onPressed: () => {}
              );
            }
             else if (index == 1) {
              // Total Filled tile
              return ButtonTile(
                title: 'Refills',
                icon:Icons.receipt_long,
                onPressed: () => {}
              );
            }
             else if (index == 2) {
              // Total Filled tile
              return ButtonTile(
                title: 'Details',
                icon:Icons.storage,
                 onPressed: () => {}
              );
            }
             else if (index == 3) {
              // Total Filled tile
              return ButtonTile(
                title: 'Stats',
                icon:Icons.stacked_bar_chart,
                 onPressed: () => {}
              );
            }
            else if (index == 4) {
              // Total Filled tile
              return ClickableTile(
                title: 'Total Filled',
                type: TileType.totalFilled,
                selectedVehicleId: selectedVehicleId!,
              );
            } else if (index == 5) {
              // Total Spent tile
              return ClickableTile(
                title: 'Total Spent',
                type: TileType.totalSpent,
                selectedVehicleId: selectedVehicleId!,
              );
            } else if (index == 6) {
              // Last Refill Date tile
              return ClickableTile(
                title: 'Last Refill Date',
                type: TileType.lastRefillDate,
                selectedVehicleId: selectedVehicleId!,
              );
            } else if (index == 7) {
              // Last Refill Amount tile
              return ClickableTile(
                title: 'Last Refill Amount',
                type: TileType.lastRefillAmount,
                selectedVehicleId: selectedVehicleId!,
              );
            } 
            else if (index == 8) {
              // Last Refill Amount tile
              return ClickableTile(
                title: 'Last Refill Amount',
                type: TileType.lastRefillAmount,
                selectedVehicleId: selectedVehicleId!,
              );
            }
            else if (index == 11) {
              // Last Refill Amount tile
              return ClickableTile(
                title: 'Last Refill Amount',
                type: TileType.lastRefillAmount,
                selectedVehicleId: selectedVehicleId!,
              );
            }
            else if (index == 12) {
              // Last Refill Amount tile
              return ClickableTile(
                title: 'Last Refill Amount',
                type: TileType.lastRefillAmount,
                selectedVehicleId: selectedVehicleId!,
              );
            }
            else if (index == 15) {
              // Last Refill Amount tile
              return ClickableTile(
                title: 'Last Refill Amount',
                type: TileType.lastRefillAmount,
                selectedVehicleId: selectedVehicleId!,
              );
            }else {
              // Return an empty container for other tiles
              return Container();
            }
          },
        ),
          ),
   if (selectedVehicleId != null) // Check if a vehicle is selected
            Positioned(
              left: 125, // Adjust left position
              top: 215, // Adjust top position
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
        
        ]


      ),
    );
  }
}


// Define a ButtonTile widget
class ButtonTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const ButtonTile({Key? key, required this.title, required this.icon, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 55, 55, 55), // Tile background color
        borderRadius: BorderRadius.circular(8), // Tile border radius
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color.fromARGB(255, 183, 88, 0),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 183, 88, 0), // Tile text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}


enum TileType { totalFilled, totalSpent, lastRefillDate, lastRefillAmount }

class ClickableTile extends StatelessWidget {
  final String title;
  final TileType type;
  final String selectedVehicleId;

  const ClickableTile({super.key, required this.title, required this.type, required this.selectedVehicleId});

String formatDate(DateTime date) {
  return '${date.year}-${_addLeadingZero(date.month)}-${_addLeadingZero(date.day)}';
}

String _addLeadingZero(int value) {
  return value.toString().padLeft(2, '0');
}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tile tap here
      },
      child: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('Refills').where('vehicleId', isEqualTo: selectedVehicleId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(); // Return an empty container when loading
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Text('No refill data found');
          }

          final refills = snapshot.data!.docs.map((doc) => doc.data()).toList();

          // Calculate total filled, total spent, last refill, and last refill amount
          double totalFilled = 0;
          double totalSpent = 0;
          DateTime? lastRefillDate;
          double lastRefillAmount = 0;

          for (var refill in refills) {
            if (refill != null && refill is Map<String, dynamic>) {
              double? filled = refill['filled'] as double?;
              double? sum = refill['sum'] as double?;
              String? dateStr = refill['date'] as String?;
              
              if (filled != null) {
                totalFilled += filled;
              }
              if (sum != null) {
                totalSpent += sum;
              }
              if (dateStr != null) {
                DateTime? refillDate = DateTime.tryParse(dateStr);
                if (refillDate != null && (lastRefillDate == null || refillDate.isAfter(lastRefillDate))) {
                  lastRefillDate = refillDate;
                  if (sum != null) {
                    lastRefillAmount = sum;
                  }
                }
              }
            }
          }

          // Build tile content based on tile type
          String content;
          switch (type) {
            case TileType.totalFilled:
              content = '$totalFilled L';
              break;
            case TileType.totalSpent:
              content = '$totalSpent USD';
              break;
            case TileType.lastRefillDate:
                content = lastRefillDate != null ? formatDate(lastRefillDate) : 'N/A';
              break;
            case TileType.lastRefillAmount:
              content = '$lastRefillAmount USD';
              break;
          }

  return Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8), // Tile border radius
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(8), // ClipRRect for border radius
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: const Color.fromARGB(255, 55, 55,55), // Top section background color
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8), // Add horizontal padding
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Tile text color
                  ),
                  textAlign: TextAlign.center, // Align text to center
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: const Color.fromARGB(255, 44, 44,44), // Bottom section background color
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8), // Add horizontal padding
              child: Center(
                child: Text(
                  content,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white, // Tile text color
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
);


        },
      ),
    );
  }
}

