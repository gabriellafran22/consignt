import 'package:consignt/common/colors.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/common/validation.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget{
  static const routeName = '/register_screen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>{
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRetypedController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();


  final GlobalKey<FormState> _formKey = GlobalKey();

  void _saveForm() {
    final bool isValid = _formKey.currentState!.validate();
    if(isValid){
      //TODO: ADD DATA TO BUYER ACCOUNT FIREBASE
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account Registered'))
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/consignt_logo_cropped.jpg',),
              Text(
                'REGISTER AN ACCOUNT',
                style: loginAndRegisterLargeText,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text('Name', style: loginAndRegisterText,),
                        const SizedBox(height: 10,),
                        TextFormField(
                          controller: _nameController,
                          validator: (value) {
                            return nameValidation(value);
                          },
                          decoration: textFormFieldDecoration('Name'),
                          style: textFormFieldStyle,
                        ),
                        const SizedBox(height: 10,),
                        Text('Email', style: loginAndRegisterText,),
                        const SizedBox(height: 10,),
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
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
                          validator: (value) {
                            return passwordValidation(value);
                          },
                          decoration: textFormFieldDecoration('Password'),
                          style: textFormFieldStyle,
                        ),
                        const SizedBox(height: 5,),
                        TextFormField(
                          controller: _passwordRetypedController,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            return passwordMatched(_passwordController.text, value);
                          },
                          decoration: textFormFieldDecoration('Retype Password'),
                          style: textFormFieldStyle,
                        ),
                        const SizedBox(height: 10,),
                        Text('Phone Number (+62XXXXXXXXXX)', style: loginAndRegisterText,),
                        const SizedBox(height: 10,),
                        TextFormField(
                          controller: _phoneNumberController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            return phoneNumberValidation(value);
                          },
                          decoration: textFormFieldDecoration('Phone Number'),
                          style: textFormFieldStyle,
                        ),
                        const SizedBox(height: 10,),
                        //TODO: csc_picker gabisa di pakai & belum nemu penggantinya
                        // CSCPicker(
                        //   showCities: true,
                        //   showStates: true,
                        //   defaultCountry: DefaultCountry.Indonesia,
                        //   onStateChanged:(value) {
                        //     setState(() {
                        //       stateValue = value!;
                        //     });
                        //   },
                        //   onCityChanged:(value) {
                        //     setState(() {
                        //       cityValue = value!;
                        //     });
                        //   },
                        // ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedButton(
                            child: const Text('REGISTER'),
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
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Already have an account? Login',
                    style: loginAndRegisterTextWithUnderline,
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
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