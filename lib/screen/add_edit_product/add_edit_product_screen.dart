import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/snackbar.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/preferences/preferences_helper.dart';
import 'package:consignt/screen/add_edit_product/provider/add_edit_product_provider.dart';
import 'package:consignt/screen/add_edit_product/widget/product_picture.dart';
import 'package:consignt/screen/add_edit_product/widget_dialog/category_dialog.dart';
import 'package:consignt/screen/add_edit_product/widget_dialog/city_product_dialog.dart';
import 'package:consignt/screen/add_edit_product/widget_dialog/city_province_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di.dart';

class AddEditProductScreen extends StatefulWidget {
  const AddEditProductScreen({Key? key}) : super(key: key);

  @override
  _AddEditProductScreenState createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  //TODO: KASIH CEK INI YANG MASUK TU EDIT (EDIT, FIELD" DI ISI SAMA DATA) ATAU ADD PRODUCT (ADD BLANK SEMUA)
  bool isAddProduct = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddEditProductProvider(
        preferencesHelper: PreferencesHelper(
          sharedPreferences: SharedPreferences.getInstance(),
        ),
      ),
      child: Consumer<AddEditProductProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                isAddProduct ? 'Add Product' : 'Edit Product',
                style: titleTextWhite,
              ),
              actions: [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.check),
                  onPressed: () {
                    //TODO: KALAU ADD PRODUCT BRARTI ADD, KALAU EDIT BRARTI EDIT
                    provider.addOrUpdateProduct();
                    inject<Navigate>().pop();
                    showSnackBar(context, 'Your Product is added');
                  },
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Form(
                key: provider.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //TODO: CHECK DLU INI ADD APA EDIT, KALO ADD KLUARNYA INI, KALO EDIT YG KLUAR MIRIP YG D PROFILE PICTURE
                    ProductPicture(provider: provider),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Product Name'),
                          TextFormField(
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
                            onTap: () => categoryDialog(context, provider),
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
                                productProvinceDialog(context, provider),
                          ),
                          provider.productProvince.isEmpty
                              ? Container()
                              : ListTile(
                                  title: provider.productCity.isEmpty
                                      ? const Text('Choose a City')
                                      : Text(provider.productCity),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () =>
                                      productCityDialog(context, provider),
                                ),
                        ],
                      ),
                    ),
                    isAddProduct
                        ? Container()
                        : Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text(
                                'Delete Product',
                                style: titleTextWhite,
                              ),
                              onPressed: () => _showDialogDelete(context),
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

void _showDialogDelete(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Delete Product',
          style: titleText16,
        ),
        content: const Text(
          'Are you sure, you want to delete this product?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              inject<Navigate>().pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              //TODO: DELETE PRODUCT
              inject<Navigate>().pop();
              inject<Navigate>().pop();
            },
            child: const Text('Delete Product'),
          ),
        ],
      );
    },
  );
}


