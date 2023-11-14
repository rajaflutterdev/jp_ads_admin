import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'DrawerList_Page.dart';
import 'Login_Page/Login_Page.dart';
import 'Pages/DashboardLists_page(drawer).dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBKFLDUMCPW13VPGNsD6zURwHovHTDzflo",
          authDomain: "jp-ads-526d7.firebaseapp.com",
          projectId: "jp-ads-526d7",
          storageBucket: "jp-ads-526d7.appspot.com",
          messagingSenderId: "736534812806",
          appId: "1:736534812806:web:dec5e45a30091e7b3b1907",
          measurementId: "G-8QZP0FPD5N"
      )
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home: //HomeView(Authusertype: "admin",)
       FirebaseAuth.instance.currentUser==null?const Login_Page(): HomeView(Authusertype: FirebaseAuth.instance.currentUser!.email),
    );
  }
}
