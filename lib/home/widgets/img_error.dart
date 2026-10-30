import 'package:flutter/material.dart';

class ImgError extends StatelessWidget {
  const ImgError({super.key, this.w, this.h});
  final double? w;
  final double? h;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w ?? double.infinity,
      height: h ?? 194,
      color: Colors.grey[200],
      child: const Center(
        child: Icon(Icons.broken_image, color: Colors.grey, size: 40),
      ),
    );
  }
}
