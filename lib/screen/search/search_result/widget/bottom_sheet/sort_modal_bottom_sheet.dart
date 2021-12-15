import 'dart:ui';

import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/constant/sort_const.dart';
import 'package:consignt/screen/search/search_result/provider/search_result_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../di.dart';

class SortModalBottomSheet extends StatelessWidget {
  final SearchResultProvider provider;

  const SortModalBottomSheet({Key? key, required this.provider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionChip(
        backgroundColor: Colors.white30,
        avatar: const CircleAvatar(
          child: FaIcon(
            FontAwesomeIcons.sort,
            size: 14,
          ),
        ),
        label: Text(provider.sort),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTile(
                        provider: provider,
                        sort: SortConst.newest,
                        text: 'Newest Product',
                      ),
                      const Divider(height: 40, thickness: 5),
                      CustomTile(
                        provider: provider,
                        sort: SortConst.latest,
                        text: 'Latest Product',
                      ),
                      const Divider(height: 40, thickness: 5),
                      CustomTile(
                        provider: provider,
                        sort: SortConst.priceLowToHigh,
                        text: 'Price: Low to High',
                      ),
                      const Divider(height: 40, thickness: 5),
                      CustomTile(
                        provider: provider,
                        sort: SortConst.priceHighToLow,
                        text: 'Price: High to Low',
                      ),
                      const Divider(height: 40, thickness: 5),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: const Text('Reset Sort'),
                          style: fullyRoundedButton(),
                          onPressed: () {
                            provider.setSort("Sort");
                            inject<Navigate>().pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },

    );
  }
}

class CustomTile extends StatelessWidget {
  const CustomTile({
    Key? key,
    required this.provider,
    required this.sort,
    required this.text,
  }) : super(key: key);

  final SearchResultProvider provider;
  final String sort;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: () {
          provider.setSort(sort);
          inject<Navigate>().pop();
        },
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
