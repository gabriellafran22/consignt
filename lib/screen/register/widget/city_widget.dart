import 'package:consignt/common/styles.dart';
import 'package:consignt/core/model/city.dart';
import 'package:consignt/screen/register/provider/register_provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CityWidget extends StatelessWidget {
  const CityWidget({Key? key, required this.provider}) : super(key: key);

  final RegisterProvider provider;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<City>(
      dropdownSearchDecoration: textFormFieldDecoration('City'),
      showClearButton: true,
      showSearchBox: true,
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
        await provider.getCity(
          provider.provinceId.toString(),
        );
        return provider.city.data ?? [];
      },
      onChanged: (value) {
        provider.setCity(value);
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
