import 'dart:io';

import 'package:consignt/core/network/service/firebase/firestore/upload_image.dart';
import 'package:consignt/screen/edit_product/edit_product_provider/edit_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class EditProductPicture extends StatefulWidget {
  const EditProductPicture({Key? key, required this.provider})
      : super(key: key);

  final EditProductProvider provider;

  @override
  State<EditProductPicture> createState() => _EditProductPictureState();
}

class _EditProductPictureState extends State<EditProductPicture> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: InkWell(
            onTap: () async {
              XFile? file = await getImageFromGallery();
              String imagePath = await uploadImage(
                File(file?.path ?? ''),
              );
              widget.provider.setProductPicture(imagePath);

              setState(() {});
            },
            child: widget.provider.productPictureUrl != ''
                ? SizedBox(
                    height: 150,
                    width: 150,
                    child: Center(
                      child: Stack(
                        children: [
                          Image.network(widget.provider.productPictureUrl),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.indigo,
                              ),
                              child: const Center(
                                child: FaIcon(
                                  FontAwesomeIcons.camera,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      border: Border.all(
                        color: Colors.blueGrey,
                        width: 2,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '+',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
