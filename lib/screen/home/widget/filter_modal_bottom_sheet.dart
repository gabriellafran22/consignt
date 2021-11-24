import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../di.dart';

class FilterModalBottomSheet extends StatefulWidget {
  const FilterModalBottomSheet({Key? key}) : super(key: key);

  @override
  _FilterModalBottomSheetState createState() => _FilterModalBottomSheetState();
}

class _FilterModalBottomSheetState extends State<FilterModalBottomSheet> {
  String sort = 'Newest';
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();


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
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location',
                    style: titleText16,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 5,
                    thickness: 5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Price',
                    style: titleText16,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: minPriceController,
                          decoration:
                              textFormFieldDecorationWithLabel('Min Price'),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          controller: maxPriceController,
                          decoration:
                              textFormFieldDecorationWithLabel('Max Price'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text('Apply Filter'),
                      onPressed: () {
                        //TODO: APPLY THE FILTER BASED ON DATABASE
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
