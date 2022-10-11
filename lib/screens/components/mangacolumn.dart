import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/constain.dart';

class MangaColumn extends StatelessWidget {
  const MangaColumn({
    Key? key,
    required this.height,
    required this.width,
    required this.author,
    required this.year,
    required this.description,
  }) : super(key: key);

  final double height;
  final double width;
  final String author;
  final String year;
  final String description;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(height: height * 0.02),
        //divied container to 3 equal part
        Container(
          height: context.orientation == Orientation.portrait
              ? height * 0.1
              : height * 0.2,
          decoration: BoxDecoration(
            color: kPrimaryWhiteColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: kPrimaryBlackColor,
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: width * 0.25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(author,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 24, color: kPrimaryBlackColor)),
                    const Text('Author',
                        style: TextStyle(
                            fontSize: 16, color: kSecondaryGrayColor)),
                  ],
                ),
              ),
              // const Spacer(),
              const VerticalDivider(
                color: kSecondaryGrayColor,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(
                width: width * 0.25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(year,
                        style: const TextStyle(
                            fontSize: 24, color: kPrimaryBlackColor)),
                    const Text('Year',
                        style: TextStyle(
                            fontSize: 16, color: kSecondaryGrayColor)),
                  ],
                ),
              ),
              const VerticalDivider(
                color: kSecondaryGrayColor,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(
                width: width * 0.25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Action',
                        style:
                            TextStyle(fontSize: 24, color: kPrimaryBlackColor)),
                    Text('Genre',
                        style: TextStyle(
                            fontSize: 16, color: kSecondaryGrayColor)),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: height * 0.02),
        Text(description,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 18, color: kPrimaryBlackColor)),
        SizedBox(height: height * 0.13),
      ],
    ));
  }
}
