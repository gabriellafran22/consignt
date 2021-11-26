import 'package:consignt/common/styles.dart';
import 'package:consignt/common/validation.dart';
import 'package:consignt/core/model/province.dart';
import 'package:consignt/screen/register/provider/register_provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class ProvinceWidget extends StatelessWidget {
  const ProvinceWidget({Key? key, required this.provider}) : super(key: key);

  final RegisterProvider provider;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Province>(
      dropdownSearchDecoration: textFormFieldDecoration('Province'),
      showClearButton: true,
      showSearchBox: true,
      validator: (value) => dropdownValidation(value),
      searchBoxDecoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 25,
        ),
        hintText: "Province...",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onFind: (text) async {
        await provider.getProvince();
        return provider.province.data ?? [];
      },
      onChanged: (value) {
        provider.setProvince(value);
      },
      popupItemBuilder: (context, item, isSelected) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Text(
            "${item.province}",
            style: const TextStyle(fontSize: 18),
          ),
        );
      },
      itemAsString: (item) => item.province as String,
    );
  }
}
