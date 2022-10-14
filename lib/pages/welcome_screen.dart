import 'package:flutter/material.dart';
import 'package:messageme_firebase/pages/registration_screen.dart';
import 'package:messageme_firebase/pages/sign_in_screen.dart';

import '../widget/button_widget.dart';
class WelcomeScreen extends StatefulWidget {
  static const String screenRout="welcome_screen";
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                SizedBox(
                    height: 150,
                    child: Image.asset("images/logo.png",)),
                Text("MessageMe",style: Theme.of(context).textTheme.headline1,)
              ],
            ),
            const SizedBox(height: 30,),
            ButtonWidget(title: "SignIn",onPressed: (){
              Navigator.pushNamed(context, SignInScreen.screenRout);
            },color: Colors.yellow[900]!),
            ButtonWidget(title: "Register",onPressed: (){
              Navigator.pushNamed(context, RegistrationScreen.screenRout);

            },color: Colors.blue[800]!,),
          ],
        ),
      ),
    );
  }
}


