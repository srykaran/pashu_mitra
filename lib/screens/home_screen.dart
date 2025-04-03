import 'package:flutter/material.dart';
import '../models/cattle.dart';
import 'add_cattle_screen.dart';
import 'milk_screen.dart';
import 'reports_screen.dart';
import 'events_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cattle Manager'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Pashumitra',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Manage your cattle farm with ease',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildDashboardTile(
                    context,
                    'Cattle',
                    Icons.pets,
                    Colors.green,
                    () => _navigateToCattleScreen(context),
                  ),
                  _buildDashboardTile(
                    context,
                    'Milk',
                    Icons.water_drop,
                    Colors.blue,
                    () => _navigateToMilkScreen(context),
                  ),
                  _buildDashboardTile(
                    context,
                    'Reports',
                    Icons.bar_chart,
                    Colors.orange,
                    () => _navigateToReportsScreen(context),
                  ),
                  _buildDashboardTile(
                    context,
                    'Events',
                    Icons.event,
                    Colors.purple,
                    () => _navigateToEventsScreen(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardTile(
    BuildContext context,
    String title,
    IconData iconData,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconData,
                size: 40,
                color: color,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCattleScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CattleListScreen(),
      ),
    );
  }

  void _navigateToMilkScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MilkScreen(),
      ),
    );
  }

  void _navigateToReportsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ReportsScreen(),
      ),
    );
  }

  void _navigateToEventsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EventsScreen(),
      ),
    );
  }
}

// Cattle List Screen
class CattleListScreen extends StatefulWidget {
  const CattleListScreen({super.key});

  @override
  State<CattleListScreen> createState() => _CattleListScreenState();
}

class _CattleListScreenState extends State<CattleListScreen> {
  final List<Cattle> cattleList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cattle List'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: cattleList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.pets,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No cattle added yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the + button to add your first cattle',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: cattleList.length,
              itemBuilder: (context, index) {
                final cattle = cattleList[index];
                return CattleListItem(cattle: cattle);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newCattle = await Navigator.push<Cattle>(
            context,
            MaterialPageRoute(
              builder: (context) => const AddCattleScreen(),
            ),
          );

          if (newCattle != null) {
            setState(() {
              cattleList.add(newCattle);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CattleListItem extends StatelessWidget {
  final Cattle cattle;

  const CattleListItem({super.key, required this.cattle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cattle.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: cattle.healthStatus == 'Healthy' ? Colors.green : Colors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    cattle.healthStatus,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Breed: ${cattle.breed}'),
            Text('Gender: ${cattle.gender}'),
            Text('Age: ${_calculateAge(cattle.dateOfBirth)}'),
            Text('Weight: ${cattle.weight} kg'),
          ],
        ),
      ),
    );
  }

  String _calculateAge(DateTime dateOfBirth) {
    final now = DateTime.now();
    final age = now.difference(dateOfBirth);
    
    final years = age.inDays ~/ 365;
    final months = (age.inDays % 365) ~/ 30;
    
    if (years > 0) {
      return '$years ${years == 1 ? 'year' : 'years'}${months > 0 ? ', $months ${months == 1 ? 'month' : 'months'}' : ''}';
    } else if (months > 0) {
      return '$months ${months == 1 ? 'month' : 'months'}';
    } else {
      return '${age.inDays} days';
    }
  }
} 