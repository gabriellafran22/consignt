import 'package:consignt/common/colors.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/ui/buyer/login_buyer_page.dart';
import 'package:consignt/ui/seller/register_seller_page.dart';
import 'package:flutter/material.dart';

class LoginSellerPage extends StatefulWidget{
  static const routeName = '/login_seller_page';

  const LoginSellerPage({Key? key}) : super(key: key);

  @override
  _LoginSellerPageState createState() => _LoginSellerPageState();
}

class _LoginSellerPageState extends State<LoginSellerPage>{
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset('assets/consignt_seller_logo_cropped.png',),
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
                        onPressed: () {
                          //TODO: HOME PAGE AFTER CHECK EMAIL & PASSWORD IN FIREBASE
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
                    Navigator.pushNamed(context, RegisterSellerPage.routeName);
                  },
                  child: Text(
                    'Don’t have a seller account? Register',
                    style: loginAndRegisterTextWithUnderline,
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Login as a buyer',
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