import 'package:consignt/common/colors.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/ui/buyer/home_buyer_page.dart';
import 'package:consignt/ui/seller/login_seller_page.dart';
import 'package:consignt/ui/buyer/register_buyer_page.dart';
import 'package:flutter/material.dart';

class LoginBuyerPage extends StatefulWidget{
  static const routeName = '/login_buyer_page';

  const LoginBuyerPage({Key? key}) : super(key: key);

  @override
  _LoginBuyerPageState createState() => _LoginBuyerPageState();
}

class _LoginBuyerPageState extends State<LoginBuyerPage>{
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
              Image.asset('assets/consignt_logo_cropped.jpg',),
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
                        child: Text('LOG IN'),
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
                          Navigator.pushNamed(context, HomeBuyerPage.routeName);
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
                    Navigator.pushNamed(context, RegisterBuyerPage.routeName);
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
              Center(
                child: TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, LoginSellerPage.routeName);
                  },
                  child: Text(
                    'Login as a seller',
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