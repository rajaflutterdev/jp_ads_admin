import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../Login_Page/Login_Page.dart';

class Logout_Page extends StatefulWidget {
  const Logout_Page({super.key});

  @override
  State<Logout_Page> createState() => _Logout_PageState();
}

class _Logout_PageState extends State<Logout_Page> {


  @override
  void initState() {
    _signOut();
    // TODO: implement initState
    super.initState();
  }

  Future <Login_Page> _signOut()  async{
    await FirebaseAuth.instance.signOut();

    return  const Login_Page();
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
