import 'package:flutter/material.dart';

/// Example pages below - replace with your real screens ///

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

/// This demonstrates that state (like a counter) is preserved
/// when you switch tabs because of IndexedStack.
class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Home Page', style: TextStyle(fontSize: 24)),

        ],
      ),
    );
  }
}