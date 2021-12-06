import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/screen/search/search_result/provider/search_result_provider.dart';
import 'package:consignt/screen/search/search_result/widget/dialog/filter_category_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../di.dart';

class FilterModalBottomSheet extends StatefulWidget {
  final SearchResultProvider provider;

  const FilterModalBottomSheet({Key? key, required this.provider})
      : super(key: key);

  @override
  _FilterModalBottomSheetState createState() => _FilterModalBottomSheetState();
}

class _FilterModalBottomSheetState extends State<FilterModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return ActionChip(
      backgroundColor: Colors.white30,
      avatar: const CircleAvatar(
        child: FaIcon(
          FontAwesomeIcons.filter,
          size: 14,
        ),
      ),
      label: const Text('Filter'),
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: titleText(16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: widget.provider.minPriceController,
                          keyboardType: TextInputType.number,
                          decoration:
                              textFormFieldDecorationWithLabel('Min Price'),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          controller: widget.provider.maxPriceController,
                          keyboardType: TextInputType.number,
                          decoration:
                              textFormFieldDecorationWithLabel('Max Price'),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 40,
                    thickness: 5,
                  ),
                  Text(
                    'Location',
                    style: titleText(16),
                  ),
                  const Divider(
                    height: 40,
                    thickness: 5,
                  ),
                  Text(
                    'Category',
                    style: titleText(16),
                  ),
                  //todo: gabisa auto update
                  ListTile(
                    title: widget.provider.category.isEmpty
                        ? const Text(
                            'Choose a Product Category',
                          )
                        : Text(widget.provider.category),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                    onTap: () {
                      setState(() {
                        filterCategoryDialog(context, widget.provider);
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text('Apply Filter'),
                      style: fullyRoundedButton(),
                      onPressed: () {
                        //TODO: APPLY THE FILTER BASED ON DATABASE
                        widget.provider.setPrice();
                        inject<Navigate>().pop();
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
