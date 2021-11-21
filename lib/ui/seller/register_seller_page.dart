import 'package:consignt/common/colors.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/ui/buyer/login_buyer_page.dart';
import 'package:flutter/material.dart';

class RegisterSellerPage extends StatefulWidget{
  static const routeName = '/register_seller_page';

  const RegisterSellerPage({Key? key}) : super(key: key);

  @override
  _RegisterSellerPageState createState() => _RegisterSellerPageState();
}

class _RegisterSellerPageState extends State<RegisterSellerPage>{
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordVerifyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child:  Column(
            children: <Widget>[
              Image.asset('assets/consignt_seller_logo_cropped.png',),
              Text(
                'REGISTER A SELLER ACCOUNT',
                style: loginAndRegisterLargeText,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text('Email', style: loginAndRegisterText,),
                    const SizedBox(height: 10,),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Email address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text('Password', style: loginAndRegisterText,),
                    const SizedBox(height: 10,),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    TextField(
                      controller: _passwordVerifyController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Retype Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
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
                        onPressed: () {
                          if(_passwordVerifyController == _passwordController){
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Account Registered'))
                            );
                            Navigator.pop(context);
                            //TODO: ADD DATA TO BUYER ACCOUNT FIREBASE
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Password does not matched'))
                            );
                          }
                        },
                      ),
                    ),

                  ],
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
                    'Already have a seller account? Login',
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