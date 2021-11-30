import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/snackbar.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/di.dart';
import 'package:consignt/preferences/preferences_helper.dart';
import 'package:consignt/screen/profile/provider/profile_provider.dart';
import 'package:consignt/screen/profile/widget_dialog/back_dialog.dart';
import 'package:consignt/screen/profile/widget_dialog/email_dialog.dart';
import 'package:consignt/screen/profile/widget_dialog/name_dialog.dart';
import 'package:consignt/screen/profile/widget_dialog/password_dialog.dart';
import 'package:consignt/screen/profile/widget_dialog/phone_number_dialog.dart';
import 'package:consignt/screen/profile/widget_dialog/province_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileProvider(
        preferencesHelper: PreferencesHelper(
          sharedPreferences: SharedPreferences.getInstance(),
        ),
      ),
      child: Consumer<ProfileProvider>(builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'My Profile',
              style: titleTextWhite,
            ),
            actions: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.check),
                onPressed: () {
                  provider.updateData();
                  showSnackBar(context, 'Data Updated');
                  inject<Navigate>().pop();
                },
              ),
            ],
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (provider.isDataChanged) {
                  backDialog(context, provider);
                } else {
                  inject<Navigate>().pop();
                }
              },
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
                      child: CircleAvatar(
                        backgroundImage: provider.profilePictureUrl == ''
                            ? const AssetImage(
                                'assets/consignt_logo.jpg',
                              )
                            : NetworkImage(provider.profilePictureUrl)
                                as ImageProvider,
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
                    checkPasswordInEmailDialog(context, provider);
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
                    provinceDialog(context, provider);
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
                    checkPasswordInPasswordDialog(context, provider);
                  },
                ),
              ],
            ),
          ),
        );
      }),
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
