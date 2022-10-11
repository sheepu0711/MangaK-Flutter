import 'package:flutter/material.dart';
import 'package:mangak/theme/constain.dart';

class Avatar extends StatelessWidget {
  final VoidCallback onTap;
  final String avatar;

  const Avatar({Key? key, required this.avatar, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 60,
        padding: const EdgeInsets.all(3), // Border width
        decoration: BoxDecoration(
          color: kPrimaryWhiteColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: kSecondaryGrayColor.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: CircleAvatar(
          backgroundColor: kPrimaryWhiteColor,
          backgroundImage: NetworkImage(avatar),
        ),
      ),
    );
  }
}
