import 'dart:io';

import 'package:consignt/common/colors.dart';
import 'package:consignt/core/network/service/firebase/firestore_service.dart';
import 'package:consignt/screen/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';
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
        XFile? file = await getImage();
        String imagePath = await FirestoreService.uploadImage(
          File(file?.path ?? ''),
        );
        widget.provider.setProfilePicture(imagePath);

        setState(() {});
      },
      child: widget.provider.profilePictureUrl != ''
          ? CircleAvatar(
              backgroundImage: NetworkImage(widget.provider.profilePictureUrl),
              radius: 50,
              child: const Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Change',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          : Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: darkGrey,
                    ),
                    child: Center(
                      child: Text(
                        widget.provider.nameTextField.text.substring(0, 1),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 35),
                    child: Text(
                      'Change',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

Future<XFile?> getImage() async {
  final ImagePicker _picker = ImagePicker();
  return await _picker.pickImage(source: ImageSource.gallery);
}
