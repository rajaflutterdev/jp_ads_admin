import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Permissions_Page extends StatefulWidget {
  String?Usertype;
   Permissions_Page({this.Usertype});

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
  bool minor_Tab = false;
  bool Indicidualreports = false;
  String Uservalue="Select";
  String Userdocid="";

  List<String>PermissionLis = [];
  List<String>list = [];

  @override
  void initState() {
    staffpermision();
    // TODO: implement initState
    super.initState();
  }

  staffpermision() async {
    setState(() {
      PermissionLis.clear();
      list.clear();
    });
    setState(() {
      list.add("Select");
    });
    var doc1 = await FirebaseFirestore.instance.collection("AdminUser").get();
    for(int i=0;i<doc1.docs.length;i++){
      setState(() {
        list.add(doc1.docs[i]['username']);
      });
    }
    var document = await FirebaseFirestore.instance.collection("AdminUser").where("username",isEqualTo:widget.Usertype).get();
    for(int j=0;j<document.docs.length;j++){
      setState(() {
        Userdocid=document.docs[j].id;
      });

      for(int i=0;i<document.docs[j]['permission'].length;i++){
        if(document.docs[j]['permission'][i]=="Dashboard"){
          setState(() {
            dashboard=true;
            PermissionLis.add("Dashboard");
          });
        }

        if(document.docs[j]['permission'][i]=="Distributor user"){
          setState(() {
            Distributorisuser=true;
            PermissionLis.add("Distributor user");
          });
        }

        if(document.docs[j]['permission'][i]=="Distributor applied"){
          setState(() {
            Distributorappiled=true;
            PermissionLis.add("Distributor applied");
          });
        }

        if(document.docs[j]['permission'][i]=="Distributor correction"){
          setState(() {
            Distributorcorrection=true;
            PermissionLis.add("Distributor correction");
          });
        }

        if(document.docs[j]['permission'][i]=="Distributor reports"){
          setState(() {
            Distributorreports=true;
            PermissionLis.add("Distributor reports");
          });
        }

        if(document.docs[j]['permission'][i]=="Individual user"){
          setState(() {
            Indicidualuser=true;
            PermissionLis.add("Individual user");
          });
        }

        if(document.docs[j]['permission'][i]=="Individual applied"){
          setState(() {
            Indicidualapplied=true;
            PermissionLis.add("Individual applied");
          });
        }

        if(document.docs[j]['permission'][i]=="Individual correction"){
          setState(() {
            Indicidualcorrection=true;
            PermissionLis.add("Individual correction");
          });
        }

        if(document.docs[j]['permission'][i]=="Individual reports"){
          setState(() {
            Indicidualreports=true;
            PermissionLis.add("Individual reports");
          });
        }

        if(document.docs[j]['permission'][i]=="Notification"){
          setState(() {
            Notification=true;
            PermissionLis.add("Notification");
          });
        }

        if(document.docs[j]['permission'][i]=="Silders"){
          setState(() {
            Slider=true;
            PermissionLis.add("Silders");
          });
        }

        if(document.docs[j]['permission'][i]=="Minor Pancard"){
          setState(() {
            minor_Tab=true;
            PermissionLis.add("Minor Pancard");
          });
        }

      }
    }
  }

    @override
    Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
      return
        Padding(
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

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width:10),
                Text("Select the Role  : ",style: GoogleFonts.poppins(fontWeight: FontWeight.w700),),
                SizedBox(width:10),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xffFFFFFF),
                  child: SizedBox(
                    width:250,
                    height:50,

                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Select',
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: list.map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style:  GoogleFonts.poppins(
                            ),
                          ),
                        ))
                            .toList(),
                        value: Uservalue,
                        onChanged: (String? value) {
                          setState(() {
                            Uservalue = value!;
                          });
                          setthevalue(value);
                        },
                        buttonStyleData:  ButtonStyleData(
                        ),decoration: InputDecoration(
                        border: InputBorder.none
                      ),

                      ),
                    ),
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
                                      PermissionLis.add("Distributor user");
                                    }
                                    else{
                                      PermissionLis.remove("Distributor user");
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
                                    PermissionLis.add("Distributor applied");
                                  }
                                  else{
                                    PermissionLis.remove("Distributor applied");
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
                                    PermissionLis.add("Distributor correction");
                                  }
                                  else{
                                    PermissionLis.remove("Distributor correction");
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
                                value: Distributorreports,
                                onChanged: (val) {
                                  setState(() {
                                    Distributorreports =
                                    !Distributorreports;
                                  });
                                  if (Distributorreports == true) {
                                    PermissionLis.add("Distributor reports");
                                  }
                                  else{
                                    PermissionLis.remove("Distributor reports");
                                  }
                                }),
                            SizedBox(width: 5,),
                            Text("Distributor Reports"),
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
                                    PermissionLis.add("Individual user");
                                  }
                                  else{
                                    PermissionLis.remove("Individual user");
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
                                    PermissionLis.add("Individual applied");
                                  }
                                  else{
                                    PermissionLis.remove("Individual applied");
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
                                    PermissionLis.add("Individual correction");
                                  }
                                  else{
                                    PermissionLis.remove("Individual correction");
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
                                    PermissionLis.add("Individual reports");
                                  }
                                  else{
                                    PermissionLis.remove("Individual reports");
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
                    children: [
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
                      SizedBox(
                        width: 200,
                        child: Row(
                          children: [
                            Checkbox(
                                value: minor_Tab,
                                onChanged: (val) {
                                  setState(() {
                                    minor_Tab =
                                    !minor_Tab;
                                  });
                                  if (minor_Tab == true) {
                                    PermissionLis.add("Minor Pancard");
                                  }
                                  else{
                                    PermissionLis.remove("Minor Pancard");
                                  }
                                }),
                            SizedBox(width: 5,),
                            Text("Minor Pancard"),
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

    updatefunction() async {
      FirebaseFirestore.instance.collection("AdminUser").doc(Userdocid).update({
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


  setthevalue(value) async {
    print("Entereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    setState(() {
      PermissionLis.clear();

       dashboard = false;
       Distributorisuser = false;
       Distributorappiled = false;
       Distributorcorrection = false;
       Distributorreports = false;
       Indicidualuser = false;
       Indicidualapplied = false;
       Indicidualcorrection = false;
       Notification = false;
       Slider = false;
       minor_Tab = false;
       Indicidualreports = false;
    });
    var document = await FirebaseFirestore.instance.collection("AdminUser").where("username",isEqualTo:value).get();
    for(int j=0;j<document.docs.length;j++){
      setState(() {
        Userdocid=document.docs[j].id;
      });
      print(Userdocid);
      print(PermissionLis);
      for(int i=0;i<document.docs[j]['permission'].length;i++){
        if(document.docs[j]['permission'][i]=="Dashboard"){
          setState(() {
            dashboard=true;
            PermissionLis.add("Dashboard");
          });
        }
        if(document.docs[j]['permission'][i]=="Distributor user"){
          setState(() {
            Distributorisuser=true;
            PermissionLis.add("Distributor user");
          });
        }

        if(document.docs[j]['permission'][i]=="Distributor applied"){
          setState(() {
            Distributorappiled=true;
            PermissionLis.add("Distributor applied");
          });
        }

        if(document.docs[j]['permission'][i]=="Distributor correction"){
          setState(() {
            Distributorcorrection=true;
            PermissionLis.add("Distributor correction");
          });
        }

        if(document.docs[j]['permission'][i]=="Distributor reports"){
          setState(() {
            Distributorreports=true;
            PermissionLis.add("Distributor reports");
          });
        }

        if(document.docs[j]['permission'][i]=="Individual user"){
          setState(() {
            Indicidualuser=true;
            PermissionLis.add("Individual user");
          });
        }

        if(document.docs[j]['permission'][i]=="Individual applied"){
          setState(() {
            Indicidualapplied=true;
            PermissionLis.add("Individual applied");
          });
        }

        if(document.docs[j]['permission'][i]=="Individual correction"){
          setState(() {
            Indicidualcorrection=true;
            PermissionLis.add("Individual correction");
          });
        }

        if(document.docs[j]['permission'][i]=="Individual reports"){
          setState(() {
            Indicidualreports=true;
            PermissionLis.add("Individual reports");
          });
        }

        if(document.docs[j]['permission'][i]=="Notification"){
          setState(() {
            Notification=true;
            PermissionLis.add("Notification");
          });
        }

        if(document.docs[j]['permission'][i]=="Silders"){
          setState(() {
            Slider=true;
            PermissionLis.add("Silders");
          });
        }

        if(document.docs[j]['permission'][i]=="Minor Pancard"){
          setState(() {
            minor_Tab=true;
            PermissionLis.add("Minor Pancard");
          });
        }

      }
    }
  }



}