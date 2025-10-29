import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample_project/layouts/main_layout.dart';
import 'package:sample_project/models/contact.dart';
import 'package:sample_project/screens/add_contact.dart';
import 'package:sample_project/screens/home.dart';
import 'package:sample_project/screens/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ContactAdapter());
  await Hive.openBox<Contact>('contacts');
  
  runApp(const ContactManagerApp());
}

class ContactManagerApp extends StatefulWidget {
  const ContactManagerApp({super.key});

  @override
  State<ContactManagerApp> createState() => _ContactManagerAppState();
}

class _ContactManagerAppState extends State<ContactManagerApp> {
  int _currentIndex = 1;

  final List<Widget> _screens = const [
    AddContactScreen(),
    HomeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Manager',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: MainLayout(
        body: _screens[_currentIndex],
        onTabSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
