import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quest/constant.dart';
import 'package:quest/login/components/my_textfield_password.dart';
import 'package:quest/login/components/square_tile.dart';
import 'package:quest/login/pages/add_email.dart';
import 'package:quest/login/services/auth_service.dart';
import '../components/my_textfield.dart';
import '../components/my_button.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Text editing controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //sig user in method
  void signinUserIn() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: kTitleTextBlueColor,
            ),
          );
        });
    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      AddEmail(emailController.text, nameController.text);
      //popp the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //popp the loading circle
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: kSecondaryColor,
            title: Center(
              child: Text(message,
                  style: TextStyle(
                      fontFamily: font,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: kTitleTextPurpleColor)),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    //logo
                    Icon(
                      Icons.lock_person_rounded,
                      size: 100.0,
                      color: kTitleTextPurpleColor,
                    ),
                    SizedBox(height: 30.0),
                    //Welcome back
                    Text(
                      'Welcome Back you\'ve been missed',
                      style: TextStyle(
                          color: kTitleTextBlueColor,
                          fontSize: 16,
                          fontFamily: font),
                    ),
                    SizedBox(height: 25.0),
                    MyTextField(
                      controller: nameController,
                      hintText: 'Username',
                      obscureText: false,
                    ),
                    SizedBox(height: 10.0),
                    //username textfield
                    MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                    ),
                    SizedBox(height: 10.0),
                    //passwor textfield
                    MyTextFieldPassword(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                    SizedBox(height: 10.0),
                    //forgot password
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: loginTextStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25.0),
                    //Sign in button
                    MyButton(
                      text: "Sign in",
                      onTap: signinUserIn,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    //or continue with
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: kTitleTextBlueColor,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child:
                                Text('Or continue with', style: loginTextStyle),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: kTitleTextBlueColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25.0),
                    //google and ios buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //google button
                        SquareTile(
                            onTap: () {
                              AuthService().signInWithGoogle();
                            },
                            imagePath: 'lib/login/images/google.png'),
                        SizedBox(width: 10.0),
                        //ios button
                        SquareTile(
                            onTap: () => AuthService().signInWithGoogle(),
                            imagePath: 'lib/login/images/apple.png'),
                      ],
                    ),
                    SizedBox(height: 25.0),
                    //google and ios buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Not a member?', style: loginTextStyle),
                        SizedBox(width: 4.0),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            'Register now',
                            style: TextStyle(
                              fontFamily: font,
                              color: kTitleTextPurpleColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
