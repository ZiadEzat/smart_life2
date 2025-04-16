import 'package:flutter/material.dart';
import 'package:smart_life/views/car_count.dart'; // Import the CarCount widget

class Garage extends StatelessWidget {
  const Garage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Garage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text("data"), // Add the CarCount widget here
      ),
    );
  }
}
