import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1; // Default to "Work" tab (index 1)

  // List of pages for each tab
  static const List<Widget> _pages = <Widget>[
    Center(child: Text('Home Page')), // Placeholder for Home page
    WorkPage(), // Work page
    Center(child: Text('Study Page')), // Placeholder for Study page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Work')),
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Work'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Study'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal, // Color for the selected item
        onTap: _onItemTapped,
      ),
    );
  }
}

class WorkPage extends StatelessWidget {
  const WorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.work, color: Colors.brown, size: 40),
          SizedBox(height: 8),
          Text(
            'Work Page',
            style: TextStyle(color: Colors.brown, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
