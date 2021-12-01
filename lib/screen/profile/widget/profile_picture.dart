import 'dart:io';

import 'package:consignt/core/network/service/firebase/firestore/upload_image.dart';
import 'package:consignt/screen/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({Key? key, required this.provider}) : super(key: key);

  final ProfileProvider provider;

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        XFile? file = await getImageFromGallery();
        String imagePath = await uploadImage(
          File(file?.path ?? ''),
        );
        widget.provider.setProfilePicture(imagePath);

        setState(() {});
      },
      child: widget.provider.profilePictureUrl != ''
          ? CircleAvatar(
              backgroundImage: NetworkImage(widget.provider.profilePictureUrl),
              radius: 50,
              child: Align(
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
                    ),
                  ),
                ),
              ),
            )
          : Align(
              alignment: Alignment.center,
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        widget.provider.nameTextField.text.substring(0, 1),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
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
            ),
    );
  }
}
