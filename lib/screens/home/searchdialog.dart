import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mangak/screens/home/homecontroller.dart';
import 'package:mangak/theme/constain.dart';

class SearchAlertDialog extends GetView<HomeController> {
  const SearchAlertDialog({
    Key? key,
    required this.height,
    required this.width,
    required this.homeController,
  }) : super(key: key);

  final double height;
  final double width;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Obx(() => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          backgroundColor: kPrimaryWhiteColor,
          content: SizedBox(
            height: height * 0.45,
            width: width * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Search filter',
                  style: TextStyle(fontSize: 18),
                ),
                Table(
                  children: [
                    TableRow(
                      children: [
                        const TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Text(
                              'Language',
                              style: TextStyle(color: kSecondaryGrayColor),
                            )),
                        Obx(
                          () => TableCell(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              elevation: 16,
                              items: const [
                                DropdownMenuItem(
                                  value: 'en',
                                  child: Text('English'),
                                ),
                                DropdownMenuItem(
                                  value: 'vi',
                                  child: Text('Vietnamese'),
                                ),
                              ],
                              value:
                                  homeController.searchFilter.value.lang!.value,
                              onChanged: (value) => homeController
                                  .searchFilter.value.lang!.value = value!,
                            ),
                          ),
                        )
                      ],
                    ),
                    TableRow(
                      children: [
                        const TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Text(
                              'Status',
                              style: TextStyle(color: kSecondaryGrayColor),
                            )),
                        Obx(
                          () => TableCell(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              elevation: 16,
                              items: const [
                                DropdownMenuItem(
                                  value: 'ongoing',
                                  child: Text('OnGoing'),
                                ),
                                DropdownMenuItem(
                                  value: 'completed',
                                  child: Text('Completed'),
                                ),
                              ],
                              value: homeController
                                  .searchFilter.value.status!.value,
                              onChanged: (value) => homeController
                                  .searchFilter.value.status!.value = value!,
                            ),
                          ),
                        )
                      ],
                    ),
                    TableRow(
                      children: [
                        const TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Text(
                              'Year',
                              style: TextStyle(color: kSecondaryGrayColor),
                            )),
                        TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          controller: homeController.yearcontroller.value,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                const Text(
                  'Gerne',
                  style: TextStyle(fontSize: 18, color: kSecondaryGrayColor),
                ),
                SizedBox(
                  width: width * 0.6,
                  child: Wrap(
                    children: [
                      ...homeController.tagMap.keys
                          .map((e) => Obx(
                                () => InkWell(
                                  onTap: () => homeController.checkTag(e),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: homeController
                                            .searchFilter.value.genres
                                            .contains(e)
                                        ? BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: kSecondaryGradient,
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          )
                                        : null,
                                    child: Text(
                                      e,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ))
                          .toList()
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          homeController.searchFilter.value.clearAll();
                          homeController.yearcontroller.value.text = '';
                        },
                        child: const Text(
                          'Clear',
                          style: TextStyle(
                              color: kSecondaryGrayColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // print(homeController.searchFilter.value.lang.value);
                          // print(homeController.searchFilter.value.status.value);
                          // print(homeController.searchFilter.value.year);
                          // print(homeController.searchFilter.value.genres);
                          Get.back();
                          Get.toNamed('/search',
                              arguments: homeController.searchFilter.value);
                          // homeController.clearTag();
                        },
                        child: const Text(
                          'Apply',
                          style: TextStyle(
                              color: kPrimaryBlackColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
