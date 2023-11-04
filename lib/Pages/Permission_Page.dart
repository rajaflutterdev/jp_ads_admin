import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Permissions_Page extends StatefulWidget {
  const Permissions_Page({super.key});

  @override
  State<Permissions_Page> createState() => _Permissions_PageState();
}

class _Permissions_PageState extends State<Permissions_Page> {

  bool dashboard = false;
  bool Distributorisuser = false;
  bool Distributorappiled = false;
  bool Distributorcorrection = false;
  bool Distributorreports = false;
  bool Indicidualuser = false;
  bool Indicidualapplied = false;
  bool Indicidualcorrection = false;
  bool Notification = false;
  bool Slider = false;
  bool Indicidualreports = false;

  List<String>PermissionLis = [];

  @override
  void initState() {
    setState(() {
      PermissionLis.clear();
    });
    staffpermision();
    // TODO: implement initState
    super.initState();
  }

  staffpermision() async {
    var document = await FirebaseFirestore.instance.collection("AdminUser").doc("XygWbdHioeNoVhSamVxh").get();
    Map<String, dynamic>?value = document.data();

    for(int i=0;i<value!['permission'].length;i++){

      print(value!['permission'][i].toString());

      if(value!['permission'][i]=="Dashboard"){
        setState(() {
          dashboard=true;
          PermissionLis.add("Dashboard");
        });
      }

      if(value!['permission'][i]=="Distributor Users"){
        setState(() {
          Distributorisuser=true;
          PermissionLis.add("Distributor Users");
        });
      }

      if(value!['permission'][i]=="Distributor Applied"){
        setState(() {
          Distributorappiled=true;
          PermissionLis.add("Distributor Applied");
        });
      }

      if(value!['permission'][i]=="Distributor Correction"){
        setState(() {
          Distributorcorrection=true;
          PermissionLis.add("Distributor Correction");
        });
      }

      if(value!['permission'][i]=="Distributor Reports"){
        setState(() {
          Distributorreports=true;
          PermissionLis.add("Distributor Reports");
        });
      }


      if(value!['permission'][i]=="Individual Users"){
        setState(() {
          Indicidualuser=true;
          PermissionLis.add("Individual Users");
        });
      }

      if(value!['permission'][i]=="Individual Applied"){
        setState(() {
          Indicidualapplied=true;
          PermissionLis.add("Individual Applied");
        });
      }

      if(value!['permission'][i]=="Individual Correction"){
        setState(() {
          Indicidualcorrection=true;
          PermissionLis.add("Individual Correction");
        });
      }

      if(value!['permission'][i]=="Individual Reports"){
        setState(() {
          Indicidualreports=true;
          PermissionLis.add("Individual Reports");
        });
      }

      if(value!['permission'][i]=="Notification"){
        setState(() {
          Notification=true;
          PermissionLis.add("Notification");
        });
      }

      if(value!['permission'][i]=="Slider"){
        setState(() {
          Slider=true;
          PermissionLis.add("Slider");
        });
      }

    }

  }

    @override
    Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
      return Padding(
        padding:  EdgeInsets.only(left:10),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: width / 75.77,top: height/61.43),
                  child: Text(
                    " Permissions",
                    style: GoogleFonts.poppins(
                        fontSize: width / 57.57,
                        color: const Color(0xff000000)),
                  ),
                ),
              ],
            ),
            SizedBox(height: height/41.143,),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(

                children: [

                  SizedBox(height: 30,),

                  Row(
                    children: [
                      SizedBox(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: dashboard,
                                onChanged: (val) {
                                  setState(() {
                                    dashboard = !dashboard;
                                  });
                                  if (dashboard == true) {
                                    PermissionLis.add("Dashboard");
                                  }
                                  else{
                                    PermissionLis.remove("Dashboard");
                                  }
                                }),
                            SizedBox(width: 5,),
                            Text("DashBoard"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: Distributorisuser,
                                onChanged: (val) {
                                  setState(() {
                                    Distributorisuser =
                                    !Distributorisuser;
                                    if (Distributorisuser == true) {
                                      PermissionLis.add("Distributor Users");
                                    }
                                    else{
                                      PermissionLis.remove("Distributor Users");
                                    }
                                  });
                                }),
                            SizedBox(width: 5,),
                            Text("Distributor Users"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: Distributorappiled,
                                onChanged: (val) {
                                  setState(() {
                                    Distributorappiled =
                                    !Distributorappiled;
                                  });
                                  if (Distributorappiled == true) {
                                    PermissionLis.add("Distributor Applied");
                                  }
                                  else{
                                    PermissionLis.remove("Distributor Applied");
                                  }
                                }),
                            SizedBox(width: 5,),
                            Text("Distributor Applied"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: Distributorcorrection,
                                onChanged: (val) {
                                  setState(() {
                                    Distributorcorrection =
                                    !Distributorcorrection;
                                  });
                                  if (Distributorcorrection == true) {
                                    PermissionLis.add("Distributor Correction");
                                  }
                                  else{
                                    PermissionLis.remove("Distributor Correction");
                                  }

                                }),
                            SizedBox(width: 5,),
                            Text("Distributor Correction"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: Notification,
                                onChanged: (val) {
                                  setState(() {
                                    Notification =
                                    !Notification;
                                  });
                                  if (Notification == true) {
                                    PermissionLis.add("Notification");
                                  }
                                  else{
                                    PermissionLis.remove("Notification");
                                  }
                                }),
                            SizedBox(width: 5,),
                            Text("Notification"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),

                  Row(
                    children: [
                      SizedBox(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: Indicidualuser,
                                onChanged: (val) {
                                  setState(() {
                                    Indicidualuser =
                                    !Indicidualuser;
                                  });
                                  if (Indicidualuser == true) {
                                    PermissionLis.add("Individual Users");
                                  }
                                  else{
                                    PermissionLis.remove("Individual Users");
                                  }
                                }),
                            SizedBox(width: 5,),
                            Text("Indicidual users"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: Indicidualapplied,
                                onChanged: (val) {
                                  setState(() {
                                    Indicidualapplied =
                                    !Indicidualapplied;
                                  });
                                  if (Indicidualapplied == true) {
                                    PermissionLis.add("Individual Applied");
                                  }
                                  else{
                                    PermissionLis.remove("Individual Applied");
                                  }
                                }),
                            SizedBox(width: 5,),
                            Text("Individual Applied"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: Indicidualcorrection,
                                onChanged: (val) {
                                  setState(() {
                                    Indicidualcorrection =
                                    !Indicidualcorrection;
                                  });
                                  if (Indicidualcorrection == true) {
                                    PermissionLis.add("Individual Correction");
                                  }
                                  else{
                                    PermissionLis.remove("Individual Correction");
                                  }
                                }),
                            SizedBox(width: 5,),
                            Text("Individual Correction"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: Indicidualreports,
                                onChanged: (val) {
                                  setState(() {
                                    Indicidualreports =
                                    !Indicidualreports;
                                  });
                                  if (Indicidualreports == true) {
                                    PermissionLis.add("Individual Reports");
                                  }
                                  else{
                                    PermissionLis.remove("Individual Reports");
                                  }
                                }),
                            SizedBox(width: 5,),
                            Text("Individual Reports"),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: Slider,
                                onChanged: (val) {
                                  setState(() {
                                    Slider = !Slider;
                                  });
                                  if (Slider == true) {
                                    PermissionLis.add("Slider");
                                  }
                                  else{
                                    PermissionLis.remove("Slider");
                                  }
                                }),
                            SizedBox(width: 5,),
                            Text("Slider"),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30,),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){
                          updatefunction();
                          sendnowpopuop();
                        },
                        child: Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Center(child: const Text("View User",style: TextStyle(color: Colors.white),))
                        ),
                      ),
                      SizedBox(width: 50,),
                    ],
                  )

                ],
              ),
            ),

          ],
        ),
      );
    }


    updatefunction(){
      FirebaseFirestore.instance.collection("AdminUser").doc("XygWbdHioeNoVhSamVxh").update({
        "permission":PermissionLis
      });
    }

  //showdialogbox..
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
                "Permission Add Successfully....",
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



}