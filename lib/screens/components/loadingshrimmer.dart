import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangak/screens/components/shrim.dart';
import 'package:mangak/theme/constain.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShrimmerCard extends StatelessWidget {
  const LoadingShrimmerCard({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 137, 136, 136),
      highlightColor: const Color.fromARGB(255, 77, 76, 76),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Shrim(
          height: height,
          width: width,
        ),
        separatorBuilder: (context, index) => const SizedBox(
          width: 8,
        ),
        itemCount: 10,
      ),
    );
  }
}

class TopReaderShrimmer extends StatelessWidget {
  const TopReaderShrimmer({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 137, 136, 136),
      highlightColor: const Color.fromARGB(255, 77, 76, 76),
      child: SizedBox(
          height: context.orientation == Orientation.portrait
              ? height * 0.1
              : height * 0.2,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Column(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 10,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ],
                  ),
              separatorBuilder: (context, index) => Container(width: 20),
              itemCount: 10)),
    );
  }
}

class ContinuesReading extends StatelessWidget {
  final double height;
  final double width;
  const ContinuesReading(
      {super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 137, 136, 136),
      highlightColor: const Color.fromARGB(255, 77, 76, 76),
      child: Container(
        height: context.orientation == Orientation.portrait
            ? height * 0.1
            : height * 0.2,
        width: width * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          gradient: const LinearGradient(
              colors: kSecondaryGradient,
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        child: Row(children: [
          SizedBox(
            height: context.orientation == Orientation.portrait
                ? height * 0.08
                : height * 0.15,
            width: context.orientation == Orientation.portrait
                ? height * 0.08
                : height * 0.15,
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(60)),
            ),
          ),
          SizedBox(
            height: 70,
            child: Center(
              child: Container(
                width: width * 0.53,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(60)),
              ),
            ),
          ),
          const Spacer(),
          const Icon(Icons.play_arrow)
        ]),
      ),
    );
  }
}
