import 'package:flutter/material.dart';

class AdditionalItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const AdditionalItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6,
      children: [
        Icon(icon, size: 32),
        Text(label),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
