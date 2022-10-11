import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/constain.dart';

class CustomAppBar extends StatelessWidget {
  final List<Widget> more;
  final VoidCallback onBack;
  final String title;
  final double height;
  const CustomAppBar(
      {Key? key,
      required this.onBack,
      required this.title,
      required this.height,
      required this.more})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title.toString(),
          style: const TextStyle(color: kPrimaryBlackColor, fontSize: 16)),
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        onPressed: onBack,
        icon: SvgPicture.asset(
          'assets/svg/back_arrow.svg',
          width: 20,
        ),
      ),
      actions: more,
      elevation: 0,
    );
  }
}

class CustomAppBar2 extends CustomAppBar implements PreferredSizeWidget {
  const CustomAppBar2(
      {super.key,
      required super.onBack,
      required super.title,
      required super.height,
      required super.more});

  @override
  Size get preferredSize => Size.fromHeight(super.height);
}
