import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart'as http;

class Notification_Page extends StatefulWidget {
  const Notification_Page({super.key});

  @override
  State<Notification_Page> createState() => _Notification_PageState();
}

class _Notification_PageState extends State<Notification_Page> {

  bool dataview=false;
  TextEditingController _Messagecontroller=TextEditingController();
  TextEditingController _Titlecontroller=TextEditingController();
  String userType="All";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
      Padding(
        padding: EdgeInsets.only(left:10),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.only(left: width / 75.77,right:  width / 25.77,
                top: height/61.43),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Notification",
                      style: GoogleFonts.poppins(
                          fontSize: width / 57.57,
                          color: const Color(0xff000000)),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          dataview=!dataview;
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(child:  Text(

                              dataview==false?"View Previous Notification":"Back",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),)),
                          )
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),
          SizedBox(height: height/16.143,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
              color: Color(0xffFFFFFF),
                elevation: 5,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height:60,
                  width:700,
                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Select to Send Notification :",style: GoogleFonts.poppins(fontWeight: FontWeight.w700),),
                      SizedBox(width: 30,),
                      SizedBox(
                        width:120,
                        child: RadioListTile(
                          title: const Text("All"),
                          value: "All",
                          groupValue: userType,
                          onChanged: (value){
                            setState(() {
                              userType = value.toString();
                            });
                          },
                        ),
                      ),

                      SizedBox(
                        width:160,
                        child: RadioListTile(
                          title: const Text("Individual"),
                          value: "Individual",
                          groupValue: userType,
                          onChanged: (value){
                            setState(() {
                              userType = value.toString();
                            });
                          },
                        ),
                      ),

                      SizedBox(
                        width:160,
                        child: RadioListTile(
                          title: const Text("Distributor"),
                          value: "Distributor",
                          groupValue: userType,
                          onChanged: (value){
                            setState(() {
                              userType = value.toString();
                            });
                          },
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: height/41.143,),
          dataview==true?
          SizedBox(
            width: 1100,
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [


                Material(
                  color: const Color(0xffd8e6ff),
                  elevation: 20,
                  shadowColor: Colors.black12,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color:  const Color(0xffd8e6ff),
                    ),
                    child: Row(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        SizedBox(
                          width: 100,
                          height: 40,

                          child: Center(
                            child: Text(
                              "Si.No",
                              style:
                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),

                        SizedBox(
                          width: 300,
                          height: 40,

                          child: Center(
                            child: Text(
                              "Title",
                              style:
                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),

                        SizedBox(
                          width: 500,
                          height: 40,
                          child: Center(
                            child: Text(
                              "Content",
                              style:
                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),

                        SizedBox(
                          width: 100,
                          height: 40,
                          child: Center(
                            child: Text(
                              "date",
                              style:
                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),

                        SizedBox(
                          width: 100,
                          height: 40,
                          child: Center(
                            child: Text(
                              "Actions",
                              style:
                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                SizedBox(height:8),
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("Notification").orderBy("timestamp").snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData==null){
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    if(!snapshot.hasData){
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    return
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {

                          var _Userdata=snapshot.data!.docs[index];

                          if(userType=="All"){
                            return
                              Padding(
                                padding:  EdgeInsets.only(bottom: 8),
                                child: Material(
                                  color: Color(0xffFFFFFF),
                                  elevation: 20,
                                  borderRadius: BorderRadius.circular(4),
                                  shadowColor: Colors.black12,
                                  child: SizedBox(
                                    height: 50,
                                    child: Row(

                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [

                                        SizedBox(
                                          width: 100,
                                          height: 40,
                                          child: Center(
                                            child: Text(
                                              (index+1).toString(),
                                              style:
                                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          width: 300,
                                          height: 40,
                                          child: Center(
                                            child: Text(
                                              _Userdata["title"].toString(),
                                              style:
                                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          width: 500,
                                          height: 40,
                                          child: Center(
                                            child: Text(
                                              _Userdata["content"].toString(),
                                              style:
                                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          width: 100,
                                          height: 40,
                                          child: Center(
                                            child: Text(
                                              _Userdata["date"].toString(),
                                              style:
                                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                            width: 100,
                                            height: 40,
                                            child: Center(
                                              child: InkWell(
                                                  onTap: (){
                                                    ///delete popup
                                                    _deletepopup(_Userdata.id);
                                                  },

                                                  child: const Icon(Icons.delete)),
                                            )
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              );
                          }
                          if(_Userdata['notifytype']==userType){
                            return
                              Padding(
                                padding:  EdgeInsets.only(bottom: 8),
                                child: Material(
                                  color: Color(0xffFFFFFF),
                                  elevation: 20,
                                  borderRadius: BorderRadius.circular(4),
                                  shadowColor: Colors.black12,
                                  child: SizedBox(
                                    height: 50,
                                    child: Row(

                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [

                                        SizedBox(
                                          width: 100,
                                          height: 40,
                                          child: Center(
                                            child: Text(
                                              (index+1).toString(),
                                              style:
                                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          width: 300,
                                          height: 40,
                                          child: Center(
                                            child: Text(
                                              _Userdata["title"].toString(),
                                              style:
                                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          width: 500,
                                          height: 40,
                                          child: Center(
                                            child: Text(
                                              _Userdata["content"].toString(),
                                              style:
                                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          width: 100,
                                          height: 40,
                                          child: Center(
                                            child: Text(
                                              _Userdata["date"].toString(),
                                              style:
                                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                            width: 100,
                                            height: 40,
                                            child: Center(
                                              child: InkWell(
                                                  onTap: (){
                                                    ///delete popup
                                                    _deletepopup(_Userdata.id);
                                                  },

                                                  child: const Icon(Icons.delete)),
                                            )
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              );
                          }
                          return const SizedBox();


                        },);
                  },
                ),
              ],
            ),
          ),
        ):

          Padding(
            padding:  EdgeInsets.only(top:80),
            child: Stack(

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width:550,
                    height:380,
                    decoration: BoxDecoration(
                     gradient: LinearGradient(
                       begin: Alignment.topLeft,
                       end: Alignment.bottomRight,
                       colors: [
                         Color(0xff8E8FFA),
                         Color(0xff89CFF3),
                       ]
                     ),
                      borderRadius: BorderRadius.circular(15)
                    ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height/6.51,
                            child: Column(
                              crossAxisAlignment:CrossAxisAlignment.start ,
                              children: [
                                Text(
                                  "Title",
                                  style: GoogleFonts.poppins(
                                      fontSize: width / 77.57,
                                      fontWeight: FontWeight.w700,
                                      color:  Colors.white),
                                ),
                                SizedBox(height:height/65.1),
                                Container(
                                  height: 40,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFF9F9F9),
                                      borderRadius: BorderRadius.circular(5),),
                                  child: TextField(
                                    maxLines: null,controller: _Titlecontroller,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 20),
                                      border: InputBorder.none,

                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),


                          Row(

                            children: [
                              SizedBox(
                                height: 200,
                                child: Column(
                                  crossAxisAlignment:CrossAxisAlignment.start ,
                                  children: [
                                    Text(
                                      "Content",
                                      style: GoogleFonts.poppins(
                                          fontSize: width / 77.57,
                                          fontWeight: FontWeight.w700,
                                          color:  Colors.white),
                                    ),
                                    SizedBox(height:height/65.1),
                                    Container(height: height/6.51,width: 450,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF9F9F9),
                                        borderRadius: BorderRadius.circular(10),),
                                      child: TextField(
                                        controller: _Messagecontroller,
                                        maxLines: null,

                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(left: 20)

                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Userdata();
                                },
                                child: Container(
                                  height: height / 18.425,
                                  width: width / 10.537,
                                  decoration: BoxDecoration(
                                    color:  Colors.indigo.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(5),),
                                  child: const Center(
                                    child: Text(
                                      "Send Now",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),



                        ],
                      ),
                    ),
                    SizedBox(width: 10,)
                  ],
                ),

                SizedBox(
                    height:400,
                    width:500,
                    child: SvgPicture.asset("assets/undraw_my_notifications_re_ehmk.svg")),

              ],
            ),
          )

        ],

    ),
      );
  }

  ///delete popup
  String deletefile="https://assets5.lottiefiles.com/packages/lf20_tqsLQJ3Q73.json";

  _deletepopup(docid){

    showDialog(context: context, builder:(context) {
      return Padding(
        padding: const EdgeInsets.only(top: 150.0,bottom: 150,left: 350,right:350),
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height:30),
                Text("Are You Sure Want to Delete",style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize:18
                ),),

                const SizedBox(height:20),

                SizedBox(
                  height:180,
                  width:180,
                  child: Lottie.network(deletefile),
                ),

                const SizedBox(height:20),

                InkWell(
                  onTap: (){
                    deletedocument(docid);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height:40,
                    width:180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: const Color(0xff263646)
                    ),
                    child: Center(
                      child: Text("Okay",style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600),),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      );
    },);
  }

  ///delete document
  deletedocument(id){
    FirebaseFirestore.instance.collection("Notification").doc(id).delete();
  }



  Userdata() async {
    if(userType=="All"){
      var data=await FirebaseFirestore.instance.collection("Users").get();

      for(int i=0;i<data.docs.length;i++){
        sendPushMessagefirebase(data.docs[i]['fcmtoken'],_Messagecontroller.text,_Titlecontroller.text);
        FirebaseFirestore.instance.collection("Users").doc(data.docs[i].id).collection("Notification").doc().set({
          "title":_Titlecontroller.text,
          "time":DateFormat('hh:mm a').format(DateTime.now()),
          "date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          "content":_Messagecontroller.text,
          "timestamp":DateTime.now().millisecondsSinceEpoch,
          "isviewed":false,
          "notifytype":""
        });
      }
      FirebaseFirestore.instance.collection("Notification").doc().set({
        "title":_Titlecontroller.text,
        "time":DateFormat('hh:mm a').format(DateTime.now()),
        "date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "content":_Messagecontroller.text,
        "timestamp":DateTime.now().millisecondsSinceEpoch,
        "isviewed":false,
        "notifytype":"",
      });
      controllerclear();
      sendnowpopuop();
    }
    else  if(userType=="Individual"){
      var data=await FirebaseFirestore.instance.collection("Users").where("usertype",isEqualTo:"Individual").get();

      for(int i=0;i<data.docs.length;i++){
        sendPushMessagefirebase(data.docs[i]['fcmtoken'],_Messagecontroller.text,_Titlecontroller.text);
        FirebaseFirestore.instance.collection("Users").doc(data.docs[i].id).collection("Notification").doc().set({
          "title":_Titlecontroller.text,
          "time":DateFormat('hh:mm a').format(DateTime.now()),
          "date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          "content":_Messagecontroller.text,
          "timestamp":DateTime.now().millisecondsSinceEpoch,
          "isviewed":false,
          "notifytype":"Individual"
        });
      }
      FirebaseFirestore.instance.collection("Notification").doc().set({
        "title":_Titlecontroller.text,
        "time":DateFormat('hh:mm a').format(DateTime.now()),
        "date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "content":_Messagecontroller.text,
        "timestamp":DateTime.now().millisecondsSinceEpoch,
        "isviewed":false,
        "notifytype":"Individual"
      });
      controllerclear();
      sendnowpopuop();
    }
     else if(userType=="Distributor"){
      var data=await FirebaseFirestore.instance.collection("Users").where("usertype",isEqualTo:"Distributor").get();

      for(int i=0;i<data.docs.length;i++){
        sendPushMessagefirebase(data.docs[i]['fcmtoken'],_Messagecontroller.text,_Titlecontroller.text);
        FirebaseFirestore.instance.collection("Users").doc(data.docs[i].id).collection("Notification").doc().set({
          "title":_Titlecontroller.text,
          "time":DateFormat('hh:mm a').format(DateTime.now()),
          "date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          "content":_Messagecontroller.text,
          "timestamp":DateTime.now().millisecondsSinceEpoch,
          "isviewed":false,
          "notifytype":"Distributor"
        });
      }
      FirebaseFirestore.instance.collection("Notification").doc().set({
        "title":_Titlecontroller.text,
        "time":DateFormat('hh:mm a').format(DateTime.now()),
        "date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        "content":_Messagecontroller.text,
        "timestamp":DateTime.now().millisecondsSinceEpoch,
        "isviewed":false,
        "notifytype":"Distributor"
      });
      controllerclear();
      sendnowpopuop();
    }

  }


  Future<bool> sendPushMessagefirebase(String token, String body, String title) async {
    bool isSended = false;
    try {
      var response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
          'key=AAAAq3zlWIY:APA91bH9tz5y88MvJqqGI2FPCW_VQM5wL5ipvNdRMF7xHPGTZC5hEUXnbXSULjQLoD6M5I00TtwyNo7tXa69XMjTJNKAL6FlHwgn4LbP_NTfJS3yfA8PCNU9hY_3MRM3d-Tsdb8htpks',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': body, 'title': title},
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        isSended = true;
      } else {
        isSended = false;
      }
    } catch (e) {
    }
    return isSended;
  }

  ///popup message
  sendnowpopuop() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    showDialog(
      context: context,
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(
              left: width / 4.268,
              right: width / 2.845,
              top: height / 4.106,
              bottom: height / 4.106),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xffF3E8FF),
          ),
          child: Column(
            children: [
              SizedBox(
                height: height / 16.425,
              ),
              SizedBox(
                height: height / 3.750,
                width: width / 11.383,
                child: Lottie.network(
                    "https://assets8.lottiefiles.com/private_files/lf30_nsqfzxxx.json"),
              ),
              SizedBox(
                height: height / 54.75,
              ),
              Text(
                "Message Send Successfully....",
                style: GoogleFonts.poppins(
                    fontSize: width / 77.613,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              SizedBox(
                height: height / 82.1250,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //cancel button
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: height / 18.464,
                      width: width / 11.383,
                      decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: width / 106.718),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: width / 34.15,
                  ),

                  //okay button
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: height / 18.464,
                      width: width / 11.383,
                      decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                          child: Text(
                            "Okay",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: width / 106.718),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: width / 34.15,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  controllerclear(){
    setState(() {
      _Messagecontroller.clear();
      _Titlecontroller.clear();

    });
  }

}
