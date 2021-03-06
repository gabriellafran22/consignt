import 'dart:io';

import 'package:consignt/core/network/service/firebase/firestore/upload_image.dart';
import 'package:consignt/screen/product/add_product/provider/add_product_provider.dart';
import 'package:consignt/widget/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPicture extends StatefulWidget {
  const AddProductPicture({Key? key, required this.provider}) : super(key: key);

  final AddProductProvider provider;

  @override
  State<AddProductPicture> createState() => _AddProductPictureState();
}

class _AddProductPictureState extends State<AddProductPicture> {
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
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueGrey,
                            width: 2,
                          ),
                        ),
                        child: Stack(
                        children: [
                          Image.network(
                            widget.provider.productPictureUrl,
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress){
                              if(loadingProgress == null){
                                return child;
                              }
                              return loadingPicture(150, 150);
                            },
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              margin: const EdgeInsets.all(5),
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
