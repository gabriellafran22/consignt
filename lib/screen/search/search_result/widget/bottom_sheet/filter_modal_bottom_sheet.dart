import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/common/validation.dart';
import 'package:consignt/core/model/city.dart';
import 'package:consignt/screen/search/search_result/provider/search_result_provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
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
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'City',
                        style: titleText(16),
                      ),
                      TextButton(
                        onPressed: () {
                          widget.provider.clearAll();
                          inject<Navigate>().pop();
                        },
                        child: Text(
                          'Clear all filter',
                          style: titleText(16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownSearch<City>(
                    clearButtonBuilder: (context) {
                      return IconButton(
                        onPressed: () {
                          widget.provider.cityTextField.text = 'City';
                        },
                        icon: const Icon(Icons.clear),
                      );
                    },
                    dropdownSearchDecoration: textFormFieldDecoration(
                      widget.provider.cityTextField.text.isNotEmpty
                          ? widget.provider.cityTextField.text
                          : 'City',
                    ),
                    showSearchBox: true,
                    validator: (value) => dropdownValidation(value),
                    searchBoxDecoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 25,
                      ),
                      hintText: "City...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onFind: (text) async {
                      return widget.provider.city.data ?? [];
                    },
                    onChanged: (value) {
                      widget.provider.setCity(value!);
                    },
                    popupItemBuilder: (context, item, isSelected) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Text(
                          "${item.type} ${item.cityName}",
                          style: const TextStyle(fontSize: 18),
                        ),
                      );
                    },
                    itemAsString: (item) => "${item.type} ${item.cityName}",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(
                        'Apply Filter',
                        style: titleTextWhite,
                      ),
                      style: fullyRoundedButton(),
                      onPressed: () {
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
