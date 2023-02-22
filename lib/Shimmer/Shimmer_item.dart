import 'package:flutter/material.dart';

class Shimmer_item extends StatelessWidget {
  Color color;
  double width;
  double height;
  bool width_infinity;

  Shimmer_item({
    required this.color,
    required this.width,
    required this.height,
    this.width_infinity = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width_infinity ? double.infinity : width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: color,
      ),
    );
  }
}
