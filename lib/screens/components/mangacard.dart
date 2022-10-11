import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangak/theme/constain.dart';
import 'package:shimmer/shimmer.dart';

class MangaCard extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback onTap;
  final String title;
  final String cover;
  final String id;
  final String author;
  const MangaCard(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.author,
      required this.cover,
      required this.id,
      required this.height,
      required this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      color: kPrimaryWhiteColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: kPrimaryBlackColor,
                      ),
                    ),
                    child: Shimmer.fromColors(
                      baseColor: const Color.fromARGB(255, 137, 136, 136),
                      highlightColor: const Color.fromARGB(255, 77, 76, 76),
                      child: Container(
                        height: height * 0.3,
                        width: width * 0.45,
                        decoration: BoxDecoration(
                          color: kPrimaryWhiteColor,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: kPrimaryBlackColor,
                          ),
                        ),
                        child: const Center(child: Text('No Image')),
                      ),
                    ),
                  );
                },
                height: height * 0.3,
                width: width * 0.45,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: Get.width * 0.45,
            child: Text(
              overflow: TextOverflow.ellipsis,
              title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryBlackColor),
            ),
          ),
          SizedBox(
            width: Get.width * 0.45,
            child: Text(
              overflow: TextOverflow.ellipsis,
              author,
              style: const TextStyle(fontSize: 13, color: kSecondaryGrayColor),
            ),
          ),
        ],
      ),
    );
  }
}
