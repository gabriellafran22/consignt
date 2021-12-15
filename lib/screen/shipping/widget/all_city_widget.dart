import 'package:consignt/common/styles.dart';
import 'package:consignt/common/validation.dart';
import 'package:consignt/core/model/city.dart';
import 'package:consignt/screen/shipping/provider/shipping_provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class AllCityWidget extends StatelessWidget {
  const AllCityWidget(
      {Key? key, required this.provider, required this.dropdownSearchType})
      : super(key: key);

  final ShippingProvider provider;
  final String dropdownSearchType;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<City>(
      dropdownSearchDecoration: textFormFieldDecoration('City'),
      showClearButton: true,
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
        return provider.city.data ?? [];
      },
      onChanged: (value) {
        if (dropdownSearchType == provider.typeFrom) {
          provider.setCityFrom(value);
        } else {
          provider.setCityTo(value);
        }
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
    );
  }
}
