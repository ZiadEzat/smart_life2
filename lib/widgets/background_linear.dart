import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_life/model/ip_model.dart';

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1D1F33), // Dark Blue
                Color(0xFF0D0F1A), // Very Dark Blue
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -180,
                right: -100,
                child: Container(
                  width: 600,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.blue.withOpacity(0.10), // Soft white light
                        Colors.transparent, // Fades out
                      ],
                      stops: const [0.3, 1.0],
                    ),
                  ),
                ),
              ),
              // Light effect at the bottom
              Positioned(
                bottom: -180,
                left: -100,
                child: Container(
                  width: 600,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.blue.withOpacity(0.2), // Soft blue light
                        Colors.transparent, // Fades out
                      ],
                      stops: [0.3, 1.0],
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
