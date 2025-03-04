import 'package:event_managment_2/screens/login_Screen2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
try {
  await Firebase.initializeApp();
  testFirebaseWrite();

} catch (error) {
  print('Error initializing Firebase: $error');
}
  print('Firebase Initialized Successfully');
  runApp(MyApp());
}

Future<void> testFirebaseWrite() async {
  try {
    // Initialize the reference to the Firebase database node
    var ref = FirebaseDatabase.instance.ref('test');

    // Write data to the reference
    await ref.set({
      'testKey': 'testValue',
    });

    print('Test data written to Firebase successfully');
  } catch (error) {
    print('Error writing to Firebase: $error');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Management App',
      themeMode: ThemeMode.system, // Automatically adapts to system theme
      theme: ThemeData.light(),    // Light theme
      darkTheme: ThemeData.dark(), // Dark theme
      home: LoginScreen2(),
    );
  }
}
