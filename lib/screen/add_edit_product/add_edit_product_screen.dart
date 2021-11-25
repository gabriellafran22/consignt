import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../di.dart';

class AddEditProductScreen extends StatefulWidget {
  const AddEditProductScreen({Key? key}) : super(key: key);

  @override
  _AddEditProductScreenState createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  //TODO: KASIH CEK INI YANG MASUK TU EDIT (EDIT, FIELD" DI ISI SAMA DATA) ATAU ADD PRODUCT (ADD BLANK SEMUA)
  bool isAddProduct = true;
  int productNameChar = 0;
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescController = TextEditingController();
  TextEditingController priceDescController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Product Name'),
                    TextFormField(
                      controller: productNameController,
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
                      controller: productDescController,
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
                      controller: priceDescController,
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
