import 'package:flutter/material.dart';
import 'package:mangak/theme/constain.dart';

class CustomButton extends StatelessWidget {
  final String textlabel;
  final VoidCallback onTap;
  const CustomButton({
    Key? key,
    required this.width,
    required this.height,
    required this.textlabel,
    required this.onTap,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width * 0.65,
        height: height * 0.05,
        decoration: BoxDecoration(
          color: kSecondaryGrayColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            textlabel,
            style: const TextStyle(fontSize: 16, color: kPrimaryWhiteColor),
          ),
        ),
      ),
    );
  }
}
