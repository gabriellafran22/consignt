import 'package:consignt/common/navigate.dart';
import 'package:consignt/constant/sort_const.dart';
import 'package:consignt/screen/search/search_result/provider/search_result_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../di.dart';

class SortModalBottomSheet extends StatelessWidget {
  final SearchResultProvider provider;

  const SortModalBottomSheet({Key? key, required this.provider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ActionChip(
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
            builder: (context) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: ListView(
                  children: ListTile.divideTiles(
                    color: Colors.blueGrey,
                    context: context,
                    tiles: [
                      ListTile(
                        title: const Text('Newest'),
                        onTap: () {
                          provider.setSort(SortConst.newest);
                          inject<Navigate>().pop();
                        },
                      ),
                      ListTile(
                        title: const Text('Price: Low to High'),
                        onTap: () {
                          provider.setSort(SortConst.priceLowToHigh);
                          inject<Navigate>().pop();
                        },
                      ),
                      ListTile(
                        title: const Text('Price: High to Low'),
                        onTap: () {
                          provider.setSort(SortConst.priceHighToLow);
                          inject<Navigate>().pop();
                        },
                      ),
                    ],
                  ).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
