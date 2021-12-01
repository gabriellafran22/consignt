import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

Future<String> uploadImage(File imageFile) async {
  String fileName = basename(imageFile.path);

  Reference reference = FirebaseStorage.instance.ref().child(fileName);
  UploadTask task = reference.putFile(imageFile);
  TaskSnapshot snapshot = await task;

  return await snapshot.ref.getDownloadURL();
}

Future<XFile?> getImageFromGallery() async {
  final ImagePicker _picker = ImagePicker();
  return await _picker.pickImage(source: ImageSource.gallery);
}
