import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/snackbar.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/core/network/service/firebase/firestore/firestore_product_service.dart';
import 'package:consignt/screen/edit_product/edit_product_provider/edit_product_provider.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';

void showDialogDelete(BuildContext context, EditProductProvider provider) {
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
              FirestoreProductService.deleteProduct(productId: provider.productId);
              inject<Navigate>().pop();
              inject<Navigate>().pop();
              showSnackBar(context, 'Product successfully deleted');
            },
            child: const Text('Delete Product'),
          ),
        ],
      );
    },
  );
}
