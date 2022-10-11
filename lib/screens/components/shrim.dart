import 'package:flutter/material.dart';

class Shrim extends StatelessWidget {
  const Shrim({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            height: height * 0.3,
            width: width * 0.45,
            color: Colors.grey,
          ),
        ),
        Container(
          height: height * 0.025,
          width: height * 0.1,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Container(
          height: height * 0.025,
          width: height * 0.1,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ],
    );
  }
}
