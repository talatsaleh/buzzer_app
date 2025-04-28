import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  const StarRating({super.key, required this.rate});

  final double rate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
          5,
              (index) {
            return Icon(
              Icons.star,
              color: rate - index > 0 ? Colors.yellow.shade700 : Colors.black26,
              size: 15.0,
            );
          },
        )
      ],
    );
  }
}
