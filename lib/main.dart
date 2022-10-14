import 'package:flutter/material.dart';
import 'package:messageme_firebase/pages/chat_screen.dart';
import 'package:messageme_firebase/pages/registration_screen.dart';
import 'package:messageme_firebase/pages/sign_in_screen.dart';
import 'package:messageme_firebase/pages/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MessageMe App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme:const TextTheme(
          headline1: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold,color: Color(0xff6AABC7)),
          headline2: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline3: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),

        )
      ),

     // home: const ChatScreen(),

      initialRoute: WelcomeScreen.screenRout,
      routes: {
        WelcomeScreen.screenRout:(context)=>const WelcomeScreen(),
        SignInScreen.screenRout:(context)=>const SignInScreen(),
        RegistrationScreen.screenRout:(context)=>const RegistrationScreen(),
        ChatScreen.screenRout:(context)=>const ChatScreen(),
      },
    );
  }
}

