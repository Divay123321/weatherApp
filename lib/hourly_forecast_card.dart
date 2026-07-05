import 'package:flutter/material.dart';

class HourlyForecastCard extends StatelessWidget {
  final String time;
  final String value;
  final IconData icon;

  const HourlyForecastCard({
    super.key,
    required this.time,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color.fromARGB(208, 37, 32, 44),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: 90,
          child: Column(
            spacing: 8,
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
              Icon(icon, size: 32),
              Text(value),
            ],
          ),
        ),
      ),
    );
  }
}
