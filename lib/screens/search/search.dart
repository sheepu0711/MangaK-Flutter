import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangak/screens/components/appbar.dart';
import 'package:mangak/screens/search/searchcontroller.dart';
import 'package:mangak/theme/constain.dart';

class SearchScreen extends GetView<SearchController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    SearchController searchController = Get.put(SearchController());
    return Scaffold(
      appBar: CustomAppBar2(
          onBack: () => Get.back(),
          title: 'Search Result',
          height: context.orientation == Orientation.portrait
              ? width * 0.1
              : height * 0.15,
          more: const [Icon(null)]),
      body: SafeArea(
        top: true,
        bottom: false,
        child: Obx(
          () => searchController.loading.value
              ? const Center(child: CircularProgressIndicator())
              : searchController.mangars.value.data!.isEmpty
                  ? const Center(
                      child: Text(
                        'No result',
                        style: TextStyle(
                            color: kPrimaryBlackColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: searchController.mangars.value.data!.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () => Get.toNamed("/mangadetail", arguments: {
                          'manga': searchController.mangars.value.data![index],
                          'cover': searchController.coverImageRs[index],
                          'author': searchController.authorNameRs[index],
                        }),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height:
                                  context.orientation == Orientation.portrait
                                      ? height * 0.2
                                      : width * 0.2,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        searchController.coverImageRs[index]),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                searchController.mangaId.title[index]
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                                'Author: ${searchController.authorNameRs[index].toString()}'),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
