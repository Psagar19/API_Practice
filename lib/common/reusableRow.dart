import 'package:flutter/material.dart';

class ReusableRow extends StatelessWidget {
  final String name, value;
  ReusableRow({super.key, required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Text(value),
        ],
      ),
    );
  }
}

