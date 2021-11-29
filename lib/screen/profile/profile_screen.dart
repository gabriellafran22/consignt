import 'package:consignt/common/styles.dart';
import 'package:consignt/screen/profile/provider/profile_provider.dart';
import 'package:consignt/screen/profile/widget_dialog/email_dialog.dart';
import 'package:consignt/screen/profile/widget_dialog/name_dialog.dart';
import 'package:consignt/screen/profile/widget_dialog/phone_number_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: titleTextWhite,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => ProfileProvider(),
        child: Consumer<ProfileProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
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
                          backgroundImage:
                              AssetImage('assets/consignt_logo.jpg'),
                          radius: 50,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                'Change',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  _listTile(
                    'Name',
                    provider.nameTextField.text,
                    () {
                      nameDialog(context, provider);
                    },
                  ),
                  _listTile(
                    'Email',
                    provider.emailTextField.text,
                    () {
                      emailDialog(context, provider);
                    },
                  ),
                  _listTile(
                    'Phone Number',
                    provider.phoneNumberTextField.text,
                    () {
                      phoneNumberDialog(context, provider);
                    },
                  ),
                  const Divider(
                    height: 10,
                    thickness: 10,
                  ),
                  _listTile(
                    'Province',
                    provider.provinceTextField.text,
                    () {
                      //TODO: MUNCULIN POP UP YG ISINYA PROVINCE DARI API
                    },
                  ),
                  _listTile(
                    'City',
                    provider.cityTextField.text,
                    () {
                      //TODO: MUNCULIN POP UP YG ISINYA CITY DARI API
                    },
                  ),
                  const Divider(
                    height: 10,
                    thickness: 10,
                  ),
                  _listTile(
                    'Change Password',
                    '',
                    () {
                      //TODO: DIALOG TO CHANGE PASSWORD
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

Future<XFile?> getImage() async {
  final ImagePicker _picker = ImagePicker();
  return await _picker.pickImage(source: ImageSource.gallery);
}

Widget _listTile(String leading, String title, void Function() dialog) {
  return ListTile(
    leading: Text(leading),
    title: Text(title),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: dialog,
  );
}
