import 'package:flutter/material.dart';

/// Example pages below - replace with your real screens ///

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

/// This demonstrates that state (like a counter) is preserved
/// when you switch tabs because of IndexedStack.
class _HomePageState extends State<HomePage> {
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Home Page', style: TextStyle(fontSize: 24)),
          SizedBox(height: 12),
          Text('Counter: $_counter', style: TextStyle(fontSize: 18)),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => setState(() => _counter++),
            child: Text('Increment'),
          ),
        ],
      ),
    );
  }
}