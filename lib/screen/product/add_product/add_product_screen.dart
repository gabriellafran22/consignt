import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/snackbar.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/common/validation.dart';
import 'package:consignt/preferences/preferences_helper.dart';
import 'package:consignt/screen/product/add_product/provider/add_product_provider.dart';
import 'package:consignt/screen/product/add_product/widget/add_product_picture.dart';
import 'package:consignt/screen/product/add_product/widget_dialog/add_category_dialog.dart';
import 'package:consignt/screen/product/add_product/widget_dialog/add_product_city_dialog.dart';
import 'package:consignt/screen/product/add_product/widget_dialog/add_product_province_dialog.dart';
import 'package:consignt/widget/back_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../di.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddProductProvider(
        preferencesHelper: PreferencesHelper(
          sharedPreferences: SharedPreferences.getInstance(),
        ),
      ),
      child: Consumer<AddProductProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Add Product',
                style: titleTextWhite,
              ),
              actions: [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.check),
                  onPressed: () async {
                    if (await provider.saveForm()) {
                      inject<Navigate>().pop();
                      showSnackBar(context, 'Your Product has been Published');
                    } else {
                      showSnackBar(context, 'All Fields Must be Filled');
                    }
                  },
                )
              ],
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (provider.isChanged ||
                      provider.productNameController.text.isNotEmpty ||
                      provider.productDescController.text.isNotEmpty ||
                      provider.productPriceController.text.isNotEmpty) {
                    backDialog(context);
                  } else {
                    inject<Navigate>().pop();
                  }
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: provider.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddProductPicture(provider: provider),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Product Name'),
                          TextFormField(
                            validator: (value) => isEmptyFieldValidation(value),
                            controller: provider.productNameController,
                            maxLength: 100,
                            decoration: const InputDecoration(
                              hintText: 'Product Name',
                              border: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 10,
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Product Description'),
                          TextFormField(
                            validator: (value) => isEmptyFieldValidation(value),
                            controller: provider.productDescController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                              hintText: 'Product Description',
                              border: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 10,
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Price'),
                          TextFormField(
                            validator: (value) => isEmptyFieldValidation(value),
                            controller: provider.productPriceController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefix: Text('Rp. '),
                              hintText: 'Price',
                              border: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 10,
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Category'),
                          ListTile(
                            title: provider.productCategory.isEmpty
                                ? const Text(
                                    'Choose a Product Category',
                                  )
                                : Text(provider.productCategory),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                            ),
                            onTap: () => addCategoryDialog(context, provider),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                      height: 2,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Product Location'),
                          ListTile(
                            title: provider.productProvince.isEmpty
                                ? const Text('Choose a Province')
                                : Text(provider.productProvince),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () =>
                                addProductProvinceDialog(context, provider),
                          ),
                          provider.productProvince.isEmpty
                              ? Container()
                              : ListTile(
                                  title: provider.productCity.isEmpty
                                      ? const Text('Choose a City')
                                      : Text(provider.productCity),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () =>
                                      addProductCityDialog(context, provider),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
