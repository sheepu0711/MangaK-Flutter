import 'package:flutter/material.dart';

class LabelTitle extends StatelessWidget {
  final String title;
  const LabelTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
