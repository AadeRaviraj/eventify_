import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventDetailsController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  bool _isNotificationEnabled = false;

  // Function to save event data to Firebase
  Future<void> saveEventToDatabase(String name, String details, String contact, DateTime date, bool notification) async {
    DatabaseReference database = FirebaseDatabase.instance.ref('events');  // Reference to the 'events' node

    // Generate a unique ID for each event using push().key
    String eventId = database.push().key ?? 'event_${DateTime.now().millisecondsSinceEpoch}'; // Generate unique ID
    try {
      // Set event data under the eventId node
      await database.child(eventId).set({
        'contact': contact,
        'date': date.toIso8601String(), // Convert DateTime to ISO 8601 string
        'details': details,
        'name': name,
        'notification': notification,
      });
      // Show success mess
      // age
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Event Added Successfully')));

      // Clear the text fields and reset other values
      _eventNameController.clear();
      _eventDetailsController.clear();
      _contactController.clear();
      _dateController.clear();
      setState(() {
        _selectedDate = DateTime.now(); // Reset selected date to current date
        _isNotificationEnabled = false; // Reset the switch
      });
    } catch (error) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error adding event: $error')));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey, // Form key for validation
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event Name
              TextFormField(
                controller: _eventNameController,
                decoration: InputDecoration(
                  labelText: 'Event Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.event),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the event name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Event Details
              TextFormField(
                controller: _eventDetailsController,
                decoration: InputDecoration(
                  labelText: 'Event Details',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.description),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 16),

              // Contact Number
              TextFormField(
                controller: _contactController,
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a contact number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Event Date Picker
              GestureDetector(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _selectedDate) {
                    setState(() {
                      _selectedDate = picked;
                      _dateController.text = DateFormat.yMd().format(_selectedDate); // Update date controller
                    });
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Select Date',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.calendar_today),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a date';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Notification Switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Enable Notification'),
                  Switch(
                    value: _isNotificationEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        _isNotificationEnabled = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Submit Button
              Center(
                child: SizedBox(
                  width: double.infinity, // Makes the button stretch to full width
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white  // Background color for dark mode
                          : Colors.black,  // Background color for light mode
                      foregroundColor: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black  // Text color for dark mode
                          : Colors.white,  // Text color for light mode
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        String name = _eventNameController.text;
                        String details = _eventDetailsController.text;
                        String contact = _contactController.text;
                        bool notification = _isNotificationEnabled;

                        // Save event data to Firebase
                        saveEventToDatabase(name, details, contact, _selectedDate, notification);
                      }
                    },
                    child: const Text(
                      'Add Event',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
