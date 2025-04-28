import 'package:buzzer_app/core/widgets/background_container.dart';
import 'package:flutter/material.dart';

class StackBackground extends StatelessWidget {
  const StackBackground(
      {super.key,
      required this.child,
      this.borderRadiusGeometry,
      required this.height,
      this.backgroundColor = Colors.white});

  final BorderRadiusGeometry? borderRadiusGeometry;
  final double height;
  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Center(
            child: Container(
              color: backgroundColor,
            ),
          ),
          BackgroundContainer(
            height: height,
            borderRadiusGeometry: borderRadiusGeometry,
          ),
          child,
        ],
      ),
    );
  }
}
