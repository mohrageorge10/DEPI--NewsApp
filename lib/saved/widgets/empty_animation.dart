import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyAnimation extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/json/empty_ghost.json',
        width: 220,
        height: 220,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.hourglass_empty,
            size: 80,
            color: Colors.grey,
          );
        },
      ),
    );
  }
}
