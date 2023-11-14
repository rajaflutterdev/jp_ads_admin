import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../DrawerList_Page.dart';
import '../Pages/DashboardLists_page(drawer).dart';


class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {


  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  bool obsecure=true;
  bool _success=false;
  String Usertype="";

  @override
  Widget build(BuildContext context) {

    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor: const Color(0xff263646),
      body:
      Center(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 15,
          color: const Color(0xffE5E5E5),
          child: Container(
            height: height/1.095,
            width: width/3.415,
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                //app logo images
                Container(
                  height:height/4.38,
                  width: width/9.10,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage("assets/Logo.png"))
                  ),
                ),

                //Text 1
                Text("Log in to Admin",style: GoogleFonts.mulish(fontSize: 24,fontWeight: FontWeight.w700),),

                //Text 2
                Text("Dashboard",style: GoogleFonts.mulish(fontSize: 24,fontWeight: FontWeight.w700),),

                const SizedBox(height: 10,),
                //text3 email and password
                //email text and text field
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Username",style: GoogleFonts.mulish(color: const Color(0xff9FA2B4),fontWeight: FontWeight.w400),),
                    ),
                  ],
                ),
                //textfiels email
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "Username",
                        hintStyle: GoogleFonts.mulish(color: const Color(0xff9FA2B4),fontWeight: FontWeight.w400)),

                  ),
                ),

                //password text
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Password",style: GoogleFonts.mulish(color: const Color(0xff9FA2B4),fontWeight: FontWeight.w400),),
                    ),


                  ],
                ),

                //password textfield

                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: TextField(
                    obscureText: obsecure,
                    controller: passwordController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "Password",
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            obsecure=!obsecure;
                          });

                        }, icon:const Icon(Icons.remove_red_eye_outlined,)),
                        hintStyle: GoogleFonts.mulish(color: const Color(0xff9FA2B4),fontWeight: FontWeight.w400)),
                    onSubmitted: (_){
                      _signInWithEmailAndPassword();

                    },
                  ),
                ),

                //log in Button
                GestureDetector(
                  onTap: (){
                    _signInWithEmailAndPassword();
                  },
                  child: Container(
                    height: height/13.14,
                    margin: const EdgeInsets.all(10.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xff3751FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text("Log in",
                        style: GoogleFonts.mulish(
                            color: const Color(0xffFFFFFF),
                            fontWeight: FontWeight.w400,
                            fontSize: 14
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

 _signInWithEmailAndPassword() async {

    bool result = false;
    var auth=FirebaseAuth.instance;
    final User? user = (await auth.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ).catchError((e){
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    })).user;
    if (user != null) {
      setState(() {
        _success = true;
        result = true;
       // _userEmail = user.uid;
        Docuemntcheckfunction();
      });
    } else {
      setState(() {
        _success = false;
        result = false;
      });
    }
    return result;
  }

  final snackBar = SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 3),
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              spreadRadius: 2.0,
              blurRadius: 8.0,
              offset: Offset(2, 4),
            )
          ],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.black),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text('Invalid Credentials !!', style: TextStyle(color: Colors.black)),
            ),
            const Spacer(),
            TextButton(onPressed: () => debugPrint("Undid"), child: Text("Undo"))
          ],
        )
    ),
  );
  
  Docuemntcheckfunction()async{
    var data=await FirebaseFirestore.instance.collection("AdminUser").get();
    for(int i=0;i<data.docs.length;i++){
      if(data.docs[i]['username']==emailController.text && data.docs[i]['password']==passwordController.text){
        print(data.docs[i]['Type']);
        print(data.docs[i]['username']);
        print(data.docs[i]['password']);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeView(Authusertype:data.docs[i]['username']),));
      }
    }

    
  }

}

