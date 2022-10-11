import 'package:flutter/material.dart';

import '../../theme/constain.dart';

class InfoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final double width;
  const InfoAppBar({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicator: BoxDecoration(
          color: kPrimaryWhiteColor,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(118, 0, 0, 15),
                blurRadius: 7,
                offset: Offset(0, 5))
          ]),
      labelColor: kPrimaryBlackColor,
      unselectedLabelColor: kSecondaryGrayColor,
      tabs: [
        SizedBox(
          // constraints: BoxConstraints(minWidth: 400),
          height: height * 0.035,
          // width: height * 0.8,
          child: const Center(child: Text('Manga')),
        ),
        SizedBox(
          // constraints: BoxConstraints(minWidth: 300),
          height: height * 0.035,
          // width: width * 0.8,
          child: const Center(child: Text('Chapter')),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(1);
}
