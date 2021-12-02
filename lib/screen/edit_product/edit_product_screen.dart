
import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/snackbar.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/common/validation.dart';
import 'package:consignt/preferences/preferences_helper.dart';
import 'package:consignt/screen/edit_product/widget/edit_picture_dialog.dart';
import 'package:consignt/screen/edit_product/widget_dialog/edit_category_dialog.dart';
import 'package:consignt/screen/edit_product/widget_dialog/edit_delete_dialog.dart';
import 'package:consignt/screen/edit_product/widget_dialog/edit_product_city_dialog.dart';
import 'package:consignt/screen/edit_product/widget_dialog/edit_product_province_dialog.dart';
import 'package:consignt/widget/back_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di.dart';
import 'edit_product_provider/edit_product_provider.dart';

class EditProductScreen extends StatefulWidget {
  final String productId;

  const EditProductScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProductProvider(
        preferencesHelper: PreferencesHelper(
          sharedPreferences: SharedPreferences.getInstance(),
        ),
        productId: widget.productId,
      ),
      child: Consumer<EditProductProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Edit Product',
                style: titleTextWhite,
              ),
              actions: [
                provider.isChanged
                    ? IconButton(
                        icon: const FaIcon(FontAwesomeIcons.check),
                        onPressed: () async {
                          if (await provider.saveForm()) {
                            inject<Navigate>().pop();
                            showSnackBar(context,
                                'Product Information has been Changed');
                          } else {
                            showSnackBar(context, 'All Fields Must be Filled');
                          }
                        },
                      )
                    : Container(),
              ],
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (provider.isChanged) {
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
                    EditProductPicture(provider: provider),
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
                            onChanged: (value) {
                              provider.isChangedTrue();
                            },
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
                            onChanged: (value) {
                              provider.isChangedTrue();
                            },
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
                            onChanged: (value) {
                              provider.isChangedTrue();
                            },
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
                            onTap: () => editCategoryDialog(context, provider),
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
                                editProductProvinceDialog(context, provider),
                          ),
                          provider.productProvince.isEmpty
                              ? Container()
                              : ListTile(
                                  title: provider.productCity.isEmpty
                                      ? const Text('Choose a City')
                                      : Text(provider.productCity),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () =>
                                      editProductCityDialog(context, provider),
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text(
                                'Delete Product',
                                style: titleTextWhite,
                              ),
                              style: fullyRoundedButton(),
                              onPressed: () =>
                                  showDialogDelete(context, provider),
                            ),
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
