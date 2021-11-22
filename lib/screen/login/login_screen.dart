import 'package:consignt/common/colors.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/common/validation.dart';
import 'package:consignt/screen/home/home_screen.dart';
import 'package:consignt/screen/register/register_screen.dart';

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget{
  static const routeName = '/login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  void _saveForm() {
    final bool isValid = _formKey.currentState!.validate();
    if(isValid){
      //TODO: HOME PAGE AFTER CHECK EMAIL & PASSWORD IN FIREBASE
      Navigator.pushNamed(context, HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset('assets/consignt_logo_cropped.jpg',),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text('Email', style: loginAndRegisterText,),
                        const SizedBox(height: 10,),
                        TextFormField(
                          controller: _emailController,
                          validator: (value){
                            return emailValidation(value);
                          },
                          decoration: textFormFieldDecoration('Email Address'),
                          style: textFormFieldStyle,
                        ),
                        const SizedBox(height: 10,),
                        Text('Password', style: loginAndRegisterText,),
                        const SizedBox(height: 10,),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value){
                            return passwordValidation(value);
                          },
                          decoration: textFormFieldDecoration('Password'),
                          style: textFormFieldStyle,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedButton(
                            child: const Text('LOG IN'),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    )
                                )
                            ),
                            onPressed: () => _saveForm(),
                          ),
                        ),
                      ],
                    ),
                ),

              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, RegisterScreen.routeName);
                  },
                  child: Text(
                    'Don’t have an account? Register',
                    style: loginAndRegisterTextWithUnderline,
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

}