import 'dart:io';

import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../di.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameTextField = TextEditingController();
  String temp = '';

  @override
  void initState() {
    super.initState();
    nameTextField.text = "Users Name";
  }

  void nameDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Name'),
          content: TextField(
            controller: nameTextField,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                inject<Navigate>().pop();
              },
              child: const Text('Discard'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  nameTextField.text = nameTextField.text;
                });
                inject<Navigate>().pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: titleTextWhite,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              color: Colors.blueGrey,
              child: Center(
                child: InkWell(
                  onTap: () async {
                    XFile? file = await getImage();
                    //TODO: OPEN GALLERY & CHANGE PROFILE PICTURE
                  },
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('assets/consignt_logo.jpg'),
                    radius: 50,
                  ),
                ),
              ),
            ),
            _listTile('Name', nameTextField.text, nameDialog),
            _listTile('Email', 'Users email', () {}),
            _listTile('Phone Number', '0811524684', () {}),
            const Divider(
              height: 10,
              thickness: 10,
            ),
            _listTile('Province', 'DKI Jakarta', () {}),
            _listTile('City', 'Jakarta Pusat', () {}),
            const Divider(
              height: 10,
              thickness: 10,
            ),
            _listTile('Change Password', '', () {}),
          ],
        ),
      ),
    );
  }
}

Future<XFile?> getImage() async {
  final ImagePicker _picker = ImagePicker();
  return await _picker.pickImage(source: ImageSource.gallery);
}

Widget _listTile(String leading, String title, void Function() ontap) {
  return ListTile(
    leading: Text(leading),
    title: Text(title),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: ontap,
  );
}
