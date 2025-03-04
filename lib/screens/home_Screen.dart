import 'package:event_managment_2/screens/aboutus_screen.dart';
import 'package:event_managment_2/screens/addEvent_screen.dart';
import 'package:event_managment_2/screens/calender_screen.dart';
import 'package:event_managment_2/screens/profile_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // To track selected index

  // List of screens for navigation
  final List<Widget> _screens = [
    const HomeTabScreen(), // Screens are now widgets without their own Scaffold
    const CalendarScreen(),
    const AddEventScreen(),
    ProfileScreen(),
    const AboutUsScreen(),
  ];

  // Function to handle tab changes
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Change the selected screen
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(_getTitleForSelectedIndex()), // Update title based on selected screen
        backgroundColor: colorScheme.brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        elevation: 0,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        titleSpacing: 20,
      ),
      body: _screens[_selectedIndex], // Show the selected screen
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colorScheme.brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        selectedItemColor: colorScheme.brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
        unselectedItemColor: colorScheme.brightness == Brightness.dark
            ? Colors.white54
            : Colors.black54,
        currentIndex: _selectedIndex, // Update selected index
        onTap: _onItemTapped, // Handle tab click
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Event',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About Us',
          ),
        ],
      ),
    );
  }

  // Helper method to return the title based on selected index
  String _getTitleForSelectedIndex() {
    switch (_selectedIndex) {
      case 0:
        return 'Home';
      case 1:
        return 'Calendar';
      case 2:
        return 'Add Event';
      case 3:
        return 'Profile';
      case 4:
        return 'About Us';
      default:
        return 'Home';
    }
  }
}

// HomeTabScreen now acts as a widget, not a full-screen scaffold
class HomeTabScreen extends StatelessWidget {
  const HomeTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Events',
                filled: true,
                fillColor: colorScheme.brightness == Brightness.dark
                    ? colorScheme.surfaceVariant
                    : colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: colorScheme.brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: colorScheme.brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
          Text(
            'Today\'s Events',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 10),
          EventCard(
            title: 'Tech for the Future: AI and Robotics',
            dateTime: 'Thu, Dec 21 - 3:00 PM',
          ),
          EventCard(
            title: 'Design Thinking in Business',
            dateTime: 'Fri, Dec 22 - 5:00 PM',
          ),
          const SizedBox(height: 20),
          Text(
            'Upcoming Events',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: colorScheme.onBackground,
            ),
          ),
          EventCard(
            title: 'Plan for Retirement with ',
            dateTime: 'Sat, Dec 23 - 2:00 PM',
          ),
          EventCard(
            title: 'Design Sprint with Google',
            dateTime: 'Sun, Dec 24 - 10:00 AM',
          ),
        ],
      ),
    );
  }
}

// EventCard remains the same
class EventCard extends StatelessWidget {
  final String title;
  final String dateTime;

  const EventCard({required this.title, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: colorScheme.brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
          width: 1.5,
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.onBackground,
          ),
        ),
        subtitle: Text(
          dateTime,
          style: TextStyle(color: colorScheme.onBackground),
        ),
        trailing: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Join'),
        ),
      ),
    );
  }
}
