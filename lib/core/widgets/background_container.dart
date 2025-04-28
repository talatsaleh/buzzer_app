import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer(
      {super.key,
      required this.height,
      this.alignment = Alignment.center,
      this.borderRadiusGeometry});

  final double height;
  final AlignmentGeometry alignment;
  final BorderRadiusGeometry? borderRadiusGeometry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadiusGeometry,
        gradient: RadialGradient(
            colors: const [
              Color(0xFF6E0000),
              Color(0xFF170101),
            ],
            // Dark red gradient
            center: alignment,
            radius: 1),
      ),
    );
  }
}
