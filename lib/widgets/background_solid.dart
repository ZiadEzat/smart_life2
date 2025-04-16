import 'package:flutter/material.dart';

class BackgroundSolid extends StatelessWidget {
  const BackgroundSolid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: const SizedBox.expand(),
    );
  }
}
