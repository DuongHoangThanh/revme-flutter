import 'package:flutter/material.dart';
class ItemMetric extends StatelessWidget {
  final int value;
  final String title;
  final String unit;
  final IconData icon;
  final Color color;

  final String image;
  const ItemMetric({super.key, required this.value, required this.title, required this.unit, required this.icon, required this.color, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: const Offset(2, 5),

            blurRadius: 5,
          ),
        ],
      ),
      child: Column(

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$title',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 4),

          Row(
            children: [
              Text(
                '$value ',
                style: const TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                unit,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
