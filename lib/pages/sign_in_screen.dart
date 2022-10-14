import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messageme_firebase/pages/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widget/button_widget.dart';
import '../widget/text_field_widget.dart';

class SignInScreen extends StatefulWidget {
  static const String screenRout = "signIn_screen";

  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late String email, password;
  bool isLoading=false;

  signIn(context) async {
    setState(() {
      isLoading=true;
    });
    try {
      Navigator.pushNamed(context, ChatScreen.screenRout);
    setState(() {
      isLoading=false;
    });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                  height: 150,
                  child: Image.asset(
                    "images/logo.png",
                  )),
              const SizedBox(
                height: 50,
              ),
              TextFieldWidget(
                hintText: "Enter Your Email",
                password: false,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                hintText: "Enter Your password",
                password: true,
                keyboardType: TextInputType.visiblePassword,
                onChanged: (value) {
                  password = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget(
                title: "Sign In",
                onPressed: () async{
                  await signIn(context);
              },
                color: Colors.yellow[800]!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
