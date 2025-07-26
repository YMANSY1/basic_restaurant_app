import 'package:flutter/material.dart';

class SectionRow extends StatelessWidget {
  const SectionRow({
    super.key,
    required this.sectionTitle,
    required this.onPressed,
  });

  final String sectionTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          sectionTitle,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            'See all',
            style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
