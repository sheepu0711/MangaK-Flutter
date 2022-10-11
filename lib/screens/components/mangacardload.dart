import 'package:flutter/material.dart';
import 'package:mangak/theme/constain.dart';

class MangaCardLoad extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback onTap;
  final String title;
  final String cover;
  final String id;
  final String author;
  const MangaCardLoad(
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
                      height: height * 0.4,
                      width: height * 0.3,
                      decoration: BoxDecoration(
                        color: kPrimaryWhiteColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: kPrimaryBlackColor,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'No Image',
                          style: TextStyle(
                              fontSize: 24, color: kPrimaryBlackColor),
                        ),
                      ),
                    );
                  },
                  height: height * 0.3,
                  width: width * 0.45,
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
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
            width: MediaQuery.of(context).size.width * 0.45,
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
