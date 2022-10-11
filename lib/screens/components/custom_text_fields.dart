import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mangak/theme/constain.dart';

class CustomTextField extends StatelessWidget {
  // final TextEditingController controller;
  final double height;
  final VoidCallback onEnd;
  final Function(String value) onSubmitted;
  const CustomTextField({
    Key? key,
    required this.onSubmitted,
    required this.height,
    required this.onEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: kPrimaryWhiteColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 20,
                color: kSecondaryGrayColor, // changes position of shadow
              ),
            ]),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                onSubmitted: onSubmitted,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Search Manga',
                  hintStyle: TextStyle(fontSize: 16, color: kPrimaryBlackColor),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 32,
                    color: kPrimaryBlackColor,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: onEnd,
              icon: SvgPicture.asset(
                'assets/svg/search_options.svg',
                height: 10,
                color: kPrimaryBlackColor,
              ),
            )
          ],
        ));
  }
}
