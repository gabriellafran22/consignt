import 'package:consignt/common/styles.dart';
import 'package:consignt/common/url_launcher.dart';
import 'package:consignt/common/validation.dart';
import 'package:flutter/material.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController topicController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  Future<bool> sendEmail() async {
    final bool isValid = formKey.currentState!.validate();
    if (isValid) {
      sendAnEmail(topicController.text, bodyController.text);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Us',
          style: titleTextWhite,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Feel free to contact us and fill this form below to address your concerns 😊',
                    style: titleText(18),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Topic',
                  style: titleText(16),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: topicController,
                  validator: (value) => isEmptyFieldValidation(value),
                  decoration: textFormFieldDecoration('Topic'),
                  maxLength: 100,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'How can we help you?',
                  style: titleText(16),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: bodyController,
                  validator: (value) => isEmptyFieldValidation(value),
                  decoration: const InputDecoration(
                    hintText: 'Your problem/feedback about the app',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  style: const TextStyle(fontSize: 14),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: fullyRoundedButton(),
                    child: Text(
                      'Send Email',
                      style: titleTextWhite,
                    ),
                    onPressed: () {
                      sendEmail();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    topicController.dispose();
    bodyController.dispose();
  }
}
