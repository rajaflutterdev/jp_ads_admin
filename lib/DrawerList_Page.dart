import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jp_ads_admin/Login_Page/Login_Page.dart';
import 'package:lottie/lottie.dart';

import 'Drawer_Model/Drawer.dart';
import 'Pages/Corection_indiviual_Page.dart';
import 'Pages/Correction_DistributorList_Page.dart';
import 'Pages/Dash_board_Page.dart';
import 'Pages/Distributor_Histroy_page.dart';
import 'Pages/Distributor_User-Page.dart';
import 'Pages/FAQ_Page.dart';
import 'Pages/Forms_Page.dart';
import 'Pages/Individivual_Page.dart';
import 'Pages/Individual_Histroy_Page.dart';
import 'Pages/Lost-Pancard(individual).dart';
import 'Pages/Lost_Pandcard(Distributor).dart';
import 'Pages/Minor_Pancard.dart';
import 'Pages/New_applied_Page.dart';
import 'Pages/New_applied_Page2(Indivivual).dart';
import 'Pages/Notification_Page.dart';
import 'Pages/Permission_Page.dart';
import 'Pages/Slider_Page.dart';
import 'Pages/Support_Page.dart';
import 'const.dart';

class HomeView extends StatefulWidget {
  String ? Authusertype;
    HomeView({this.Authusertype});



@override
State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  int selectedIndex = 100;
  int expandedIndex = 100;
  bool isFetched = false;





  ///distributor variables
  int distrutorCorrectionCount=0;
  int distrutorappliedCount=0;
  int distrutorlostCount=0;

  ///individual variables
  int individualCorrectionCount=0;
  int individualappliedCount=0;
  int individuallostCount=0;

  ///minor variables
  int minorCount=0;


  countfunction()async{
///distributor
    var documentcorrection=await FirebaseFirestore.instance.collection("Correction_cards").where("usertype",isEqualTo:'Distributor').where("updatestatus",isEqualTo:"").get();
    var documentlost=await FirebaseFirestore.instance.collection("Reprint_document").where("usertype",isEqualTo:'Distributor').where("updatestatus",isEqualTo:"").get();
    var documentappliedt=await FirebaseFirestore.instance.collection("New_applied").where("usertype",isEqualTo:'Distributor').where("updatestatus",isEqualTo:"").get();
    setState(() {
       distrutorCorrectionCount=documentcorrection.docs.length;
       distrutorlostCount=documentlost.docs.length;
       distrutorappliedCount=documentappliedt.docs.length;
    });
    ///individual
    var documentcorrection1=await FirebaseFirestore.instance.collection("Correction_cards").where("usertype",isEqualTo:'Individual').where("updatestatus",isEqualTo:"").get();
    var documentlost1=await FirebaseFirestore.instance.collection("Reprint_document").where("usertype",isEqualTo:'Individual').where("updatestatus",isEqualTo:"").get();
    var documentappliedt1=await FirebaseFirestore.instance.collection("New_applied").where("usertype",isEqualTo:'Individual').where("updatestatus",isEqualTo:"").get();
    var minordocument=await FirebaseFirestore.instance.collection("Minor_New_applied").where("updatestatus",isEqualTo:"").get();

    setState(() {
      individualCorrectionCount=documentcorrection1.docs.length;
      individualappliedCount=documentlost1.docs.length;
      individuallostCount=documentappliedt1.docs.length;
      minorCount=minordocument.docs.length;
    });
    print(individualCorrectionCount);
    print(individualappliedCount);
    print(individuallostCount);
    print(minorCount);
    print(distrutorappliedCount);
    print(distrutorlostCount);
    print(distrutorCorrectionCount);
    print("initstate funtion endddddddddddddddddddddddddddddddddddddddddddddddddd");

  }


  
  @override
  void initState() {

    print(widget.Authusertype);
    print("Authendication user email ");
    countfunction();
    // TODO: implement initState
    super.initState();
  }
  



  List<DrawerModel> drawerItems1 = [];



  setDrawerItems(List roles) {
    print("Stream insideeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    print(widget.Authusertype);
    if (drawerItems1.isEmpty) {
      for (int i = 0; i < roles.length; i++) {
        print("printing the rollleeeee forr loppppp----------------");
        print(roles[i]['username'].toString().toLowerCase());
        print(widget.Authusertype!.toLowerCase());
        print("printing the stream function----------------------2");
        if (widget.Authusertype!.toLowerCase()==adminemilId) {
          print("Condition ful fillleeeedddddddddddddddddddd");
          drawerItems1 = drawerItems;
        }
        else  if (roles[i]['username'].toString().toLowerCase()==widget.Authusertype!.toLowerCase()) {

          print("Edlse function entereddddddddddddddddddddddddddddddddddddddd");

          print("000000000000000000000000000000000000000000000");
          print("");
          print("Else if");
          print("UserType");
          print("${roles[i]['Type'].toString().toLowerCase()}---${widget.Authusertype}");
          for (int j = 0; j < roles[i]['permission'].length; j++) {
            print("J-value$j");
            print(roles[i]['permission'][j].toString());
            switch (roles[i]['permission'][j].toString()) {
              case "Dashboard":
                drawerItems1.add( DrawerModel(
                    name: "Dashboard",
                    icon: Icons.dashboard,
                    page: const DashBoard_Page() ,
                    isExpanded: false,
                    children: []
                ),);
                break;
              case "Distributor Users":
                drawerItems1.add(DrawerModel(
                  name: "Distributors",
                  page: Distributor_data_Page() ,
                  icon: Icons.person_pin,
                  isExpanded: false,
                  children: [
                    DrawerChildren(
                        page: Distributor_data_Page(),
                        name: "Distributor Users",
                        icon:Icons.circle ),
                    DrawerChildren(
                        page:     New_Applied_Distributor_Page(),
                        name: "Distributor New Applied",
                        icon:Icons.circle ),
                    DrawerChildren(
                        page: Corretion_List_Page(),
                        name: "Distributor Correction",
                        icon:Icons.circle ),
                    DrawerChildren(
                        page: Distrobutor_Histroe_Page(),
                        name: "Distributor History",
                        icon:Icons.circle ),
                  ],
                ));
                break;
              case "Individual Users":
                drawerItems1.add(
                  DrawerModel(
                    name: "Individual",
                    page: Infividual_Page() ,
                    icon: Icons.person_pin,
                    isExpanded: false,
                    children: [
                      DrawerChildren(
                          page: Infividual_Page(),
                          name: "Individual Users",
                          icon:Icons.circle ),

                      DrawerChildren(
                          page: New_applied_indivivual(),
                          name: "Individual New Applied",
                          icon:Icons.circle ),

                      DrawerChildren(
                          page: Correction_Infivivual_Page(),
                          name: "Individual Correction",
                          icon:Icons.circle ),

                      DrawerChildren(
                          page: Individual_Hostroy_Page(),
                          name: "Individual Reports",
                          icon:Icons.circle ),
                    ],
                  ),
                );
                break;
              case "Notification":
                drawerItems1.add(DrawerModel(
                  name: "Notification",
                  icon: Icons.person_pin_outlined,
                  isExpanded: false,
                  page:  Notification_Page(),
                  children: [],
                ));
                break;
              case "Sliders":
                drawerItems1.add(DrawerModel(
                  name: "Sliders",
                  icon: Icons.person_pin_outlined,
                  isExpanded: false,
                  page:  Slide_Image(),
                  children: [],
                ));
                break;
              case "Permission":
                drawerItems1.add(DrawerModel(
                  name: "Permissions",
                  icon: Icons.person_pin_outlined,
                  isExpanded: false,
                  page:  Permissions_Page(Username: adminemilId),
                  children: [],
                ));
                break;
              case "Support":
                drawerItems1.add(DrawerModel(
                  name: "Support",
                  icon: Icons.person_pin_outlined,
                  isExpanded: false,
                  page:  Support_Page(),
                  children: [],
                ));
                break;
              case "FAQ":
                drawerItems1.add(DrawerModel(
                  name: "FAQ",
                  icon: Icons.question_mark_outlined,
                  isExpanded: false,
                  page:  FAQ_Page(),
                  children: [],
                ));
                break;
            }
          }
        }

      }
    }
    isFetched = true;
  }

  List<DrawerModel> drawerItems = [

    DrawerModel(
        name: "Dashboard",
        icon: Icons.dashboard,
        page: DashBoard_Page() ,
        isExpanded: false,
        children: []
    ),

    DrawerModel(
      name: "Distributors",
      page: Distributor_data_Page() ,
      icon: Icons.person_pin,
      isExpanded: false,
      children: [
        DrawerChildren(
            page: Distributor_data_Page(),
            name: "Distributor Users",
            icon:Icons.circle ),
        DrawerChildren(
            page:     New_Applied_Distributor_Page(),
            name: "Distributor New\nApplied",
            icon:Icons.circle ),
        DrawerChildren(
            page: Corretion_List_Page(),
            name: "Distributor Correction",
            icon:Icons.circle ),
        DrawerChildren(
            page: Lost_Pandcard_distributor(),
            name: "Lost Pan card",
            icon:Icons.circle ),
        DrawerChildren(
            page: Distrobutor_Histroe_Page(),
            name: "Distributor Reports",
            icon:Icons.circle ),

      ],
    ),

    DrawerModel(
      name: "Individual",
      page: Infividual_Page() ,
      icon: Icons.person_pin,
      isExpanded: false,
      children: [
        DrawerChildren(
            page: Infividual_Page(),
            name: "Individual Users",
            icon:Icons.circle ),

        DrawerChildren(
            page: New_applied_indivivual(),
            name: "Individual New Applied",
            icon:Icons.circle ),

        DrawerChildren(
            page: Correction_Infivivual_Page(),
            name: "Individual Correction",
            icon:Icons.circle ),

        DrawerChildren(
            page: Lost_pancard_individual(),
            name: "Lost Pan card",
            icon:Icons.circle ),

        DrawerChildren(
            page: Individual_Hostroy_Page(),
            name: "Individual Reports",
            icon:Icons.circle ),
      ],
    ),

    DrawerModel(
      name: "Minor Pancard",
      icon: Icons.person_pin_outlined,
      isExpanded: false,
      page:  Minor_Pancard(),
      children: [],
    ),

    DrawerModel(
      name: "Forms",
      icon: Icons.document_scanner_sharp,
      isExpanded: false,
      page:  const Form_Page(),
      children: [],
    ),

    DrawerModel(
      name: "Notification",
      icon: Icons.person_pin_outlined,
      isExpanded: false,
      page:  Notification_Page(),
      children: [],
    ),

    DrawerModel(
      name: "Sliders",
      icon: Icons.person_pin_outlined,
      isExpanded: false,
      page:  Slide_Image(),
      children: [],
    ),

    DrawerModel(
      name: "Permissions",
      icon: Icons.person_pin_outlined,
      isExpanded: false,
      page:  Permissions_Page(Username: adminemilId),
      children: [],
    ),

    DrawerModel(
      name: "Support",
      icon: Icons.person_pin_outlined,
      isExpanded: false,
      page:  const Support_Page(),
      children: [],
    ),

    DrawerModel(
      name: "FAQ",
      icon: Icons.question_mark_outlined,
      isExpanded: false,
      page:  const FAQ_Page(),
      children: [],
    ),

  ];



  int Selectpage=0;

  bool isexpanded=false;
  @override
  Widget build(BuildContext context) {
     double  height = MediaQuery.of(context).size.height;
     double  width = MediaQuery.of(context).size.width;

    return Scaffold(
        body:
        Column(
          children: [

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  width: width/5.464,
                  height: height/1.0015,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        end: Alignment.bottomCenter,
                        begin: Alignment.topCenter,
                        colors: [
                      Color(0xff245BCA),
                      Color(0xff245BCA).withOpacity(0.6)
                    ]),
                  ),
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Column(
                      children: [

                        SizedBox(height:height/25.66),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              SizedBox(width:width/91.066),
                              SizedBox(
                                  width:width/9.106,
                                  child: Image.asset("assets/Logo.png")),


                            ],
                          ),
                        ),
                        SizedBox(height:height/21.7),



                        ///DashBoard
                        InkWell(
                          onTap:(){
                            setState((){
                              Selectpage=0;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            height: height/16.275,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Selectpage==0?Colors.white:Colors.transparent,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width:width/91.066),

                                    Icon(Icons.dashboard,color:Selectpage==0?Colors.black:Colors.white,),
                                    SizedBox(width:width/273.2),
                                    Text("Dashboard",style: GoogleFonts.poppins(color:Selectpage==0?Colors.black:Colors.white,fontSize: width/85.88),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                         width:width/5.464,
                          child: ExpansionTile(
                            onExpansionChanged: (value){
                              setState(() {
                                isexpanded=!isexpanded;
                              });
                            },
                            iconColor: Colors.white,
                              collapsedIconColor: Colors.white,
                              title: Row(
                                children: [
                                  Icon(Icons.person,color:Colors.white,   size:width/75.888,),
                                  SizedBox(width:width/273.2),
                                  Text("Distributor",style: GoogleFonts.poppins(color: Colors.white,
                                      fontSize: width/85.88),),
                                ],
                              ),
                          children: [

                            InkWell(
                              onTap:(){
                                setState((){
                                  Selectpage=1;
                                });
                              },
                              child: AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                height: height/16.275,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Selectpage==1?Colors.white:Colors.transparent,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width:width/91.066),
                                    Icon(Icons.circle,color:Selectpage==1?Colors.black:Colors.white,   size:width/75.888,),
                                    SizedBox(width:width/273.2),
                                    Text("Distributor Users",style: GoogleFonts.poppins(color:Selectpage==1?Colors.black:Colors.white,fontSize: width/85.88),),
                                  ],
                                ),
                              ),
                            ),

                            InkWell(
                              onTap:(){
                                setState((){
                                  Selectpage=2;
                                });
                              },
                              child: AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                height: height/16.275,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Selectpage==2?Colors.white:Colors.transparent,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width:width/91.066),
                                    Icon(Icons.circle,color:Selectpage==2?Colors.black:Colors.white,   size:width/75.888,),
                                    SizedBox(width:width/273.2),
                                    Text("Distributor New Applied",style: GoogleFonts.poppins(color: Selectpage==2?Colors.black:Colors.white,fontSize: width/85.88),),

                                  ],
                                ),
                              ),
                            ),

                            InkWell(
                              onTap:(){
                                setState((){
                                  Selectpage=3;
                                });
                              },
                              child: AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                height: height/16.275,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Selectpage==3?Colors.white:Colors.transparent,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width:width/91.066),
                                    Icon(Icons.circle,color:Selectpage==3?Colors.black:Colors.white,   size:width/75.888,),
                                    SizedBox(width:width/273.2),
                                    Text("Distributor Correction",style: GoogleFonts.poppins(color:Selectpage==3?Colors.black:Colors.white,fontSize: width/85.88),),
                                  ],
                                ),
                              ),
                            ),

                            InkWell(
                              onTap:(){
                                setState((){
                                  Selectpage=4;
                                });
                              },
                              child: AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                height: height/16.275,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Selectpage==4?Colors.white:Colors.transparent,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width:width/91.066),
                                    Icon(Icons.circle,color:Selectpage==4?Colors.black:Colors.white,   size:width/75.888,),
                                    SizedBox(width:width/273.2),
                                    Text("Distributor Lost Pan card",style: GoogleFonts.poppins(color:Selectpage==4?Colors.black:Colors.white,fontSize: width/85.88),),
                                  ],
                                ),
                              ),
                            ),

                            InkWell(
                              onTap:(){
                                setState((){
                                  Selectpage=5;
                                });
                              },
                              child: AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                height: height/16.275,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Selectpage==5?Colors.white:Colors.transparent,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width:width/91.066),
                                    Icon(Icons.report,color:Selectpage==5?Colors.black:Colors.white,   size:width/75.888,),
                                    SizedBox(width:width/273.2),
                                    Text("Distributor Reports",style: GoogleFonts.poppins(color: Selectpage==5?Colors.black:Colors.white,fontSize: width/85.88),),

                                  ],
                                ),
                              ),
                            ),

                          ],
                          ),
                        ),

                        SizedBox(
                         width:width/5.464,
                          child: ExpansionTile(
                            onExpansionChanged: (value){
                              setState(() {
                                isexpanded=!isexpanded;
                              });
                            },
                            iconColor: Colors.white,
                            collapsedIconColor: Colors.white,
                              title: Row(
                                children: [
                                  Icon(Icons.person,color:Colors.white,   size:width/75.888,),
                                  SizedBox(width:width/273.2),
                                  Text("Individual",style: GoogleFonts.poppins(color: Colors.white),),
                                ],
                              ),
                          children: [
                            InkWell(
                              onTap:(){
                                setState((){
                                  Selectpage=6;
                                });
                              },
                              child: AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                height: height/16.275,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Selectpage==6?Colors.white:Colors.transparent,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width:width/91.066),
                                    Icon(Icons.circle,color:Selectpage==6?Colors.black:Colors.white,   size:width/75.888,),
                                    SizedBox(width:width/273.2),
                                    Text("Individual Users",style: GoogleFonts.poppins(color: Selectpage==6?Colors.black:Colors.white,fontSize: width/85.88),),

                                  ],
                                ),
                              ),
                            ),

                            InkWell(
                              onTap:(){
                                setState((){
                                  Selectpage=7;
                                });
                              },
                              child: AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                height: height/16.275,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Selectpage==7?Colors.white:Colors.transparent,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width:width/91.066),
                                    Icon(Icons.circle,color:Selectpage==7?Colors.black:Colors.white,   size:width/75.888,),
                                    SizedBox(width:width/273.2),
                                    Text("Individual New Applied",style: GoogleFonts.poppins(color: Selectpage==7?Colors.black:Colors.white,fontSize: width/85.88),),


                                  ],
                                ),
                              ),
                            ),

                            InkWell(
                              onTap:(){
                                setState((){
                                  Selectpage=8;
                                });
                              },
                              child: AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                height: height/16.275,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Selectpage==8?Colors.white:Colors.transparent,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width:width/91.066),
                                    Icon(Icons.circle,color:Selectpage==8?Colors.black:Colors.white,   size:width/75.888,),
                                    SizedBox(width:width/273.2),
                                    Text("Individual Correction",style: GoogleFonts.poppins(color: Selectpage==8?Colors.black:Colors.white,fontSize: width/85.88),),

                                  ],
                                ),
                              ),
                            ),

                            InkWell(
                              onTap:(){
                                setState((){
                                  Selectpage=9;
                                });
                              },
                              child: AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                height: height/16.275,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Selectpage==9?Colors.white:Colors.transparent,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width:width/91.066),
                                    Icon(Icons.circle,color:Selectpage==9?Colors.black:Colors.white,   size:width/75.888,),
                                    SizedBox(width:width/273.2),
                                    Text("Individual Lost Pan card",style: GoogleFonts.poppins(color:Selectpage==9?Colors.black:Colors.white,fontSize: width/85.88),),

                                  ],
                                ),
                              ),
                            ),

                            InkWell(
                              onTap:(){
                                setState((){
                                  Selectpage=10;
                                });
                              },
                              child: AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                height: height/16.275,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Selectpage==10?Colors.white:Colors.transparent,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width:width/91.066),
                                    Icon(Icons.report,color:Selectpage==10?Colors.black:Colors.white,   size:width/75.888,),
                                    SizedBox(width:width/273.2),
                                    Text("Individual Reports",style: GoogleFonts.poppins(color: Selectpage==10?Colors.black:Colors.white,fontSize: width/85.88),),


                                  ],
                                ),
                              ),
                            ),

                          ],
                          ),
                        ),



                        InkWell(
                          onTap:(){
                            setState((){
                              Selectpage=11;
                            });
                          },
                          child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                            height: height/16.275,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Selectpage==11?Colors.white:Colors.transparent,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width:width/91.066),
                                Icon(Icons.document_scanner_rounded,color:Selectpage==11?Colors.black:Colors.white,   size:width/75.888,),
                                SizedBox(width:width/273.2),
                                Text("Minor Pancard",style: GoogleFonts.poppins(color: Selectpage==11?Colors.black:Colors.white,fontSize: width/85.88),),

                              ],
                            ),
                          ),
                        ),


                        InkWell(
                          onTap:(){
                            setState((){
                              Selectpage=12;
                            });
                          },
                          child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                            height: height/16.275,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Selectpage==12?Colors.white:Colors.transparent,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width:width/91.066),
                                Icon(Icons.format_indent_decrease_sharp,color:Selectpage==12?Colors.black:Colors.white,   size:width/75.888,),
                                SizedBox(width:width/273.2),
                                Text("Forms",style: GoogleFonts.poppins(color: Selectpage==12?Colors.black:Colors.white,fontSize: width/85.88),),
                              ],
                            ),
                          ),
                        ),

                        InkWell(
                          onTap:(){
                            setState((){
                              Selectpage=13;
                            });
                          },
                          child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                            height: height/16.275,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Selectpage==13?Colors.white:Colors.transparent,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width:width/91.066),
                                Icon(Icons.notifications,color:Selectpage==13?Colors.black:Colors.white,   size:width/75.888,),
                                SizedBox(width:width/273.2),
                                Text("Notification",style: GoogleFonts.poppins(color:Selectpage==13?Colors.black:Colors.white,fontSize: width/85.88),),

                              ],
                            ),
                          ),
                        ),


                        InkWell(
                          onTap:(){
                            setState((){
                              Selectpage=14;
                            });
                          },
                          child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                            height: height/16.275,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Selectpage==14?Colors.white:Colors.transparent,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width:width/91.066),
                                Icon(Icons.circle,color:Selectpage==14?Colors.black:Colors.white,   size:width/75.888,),
                                SizedBox(width:width/273.2),
                                Text("Permissions",style: GoogleFonts.poppins(color: Selectpage==14?Colors.black:Colors.white,fontSize: width/85.88),),

                              ],
                            ),
                          ),
                        ),

                        InkWell(
                          onTap:(){
                            setState((){
                              Selectpage=15;
                            });
                          },
                          child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                            height: height/16.275,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Selectpage==15?Colors.white:Colors.transparent,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width:width/91.066),
                                Icon(Icons.support,color:Selectpage==15?Colors.black:Colors.white,  size:width/75.888,),
                                SizedBox(width:width/273.2),
                                Text("Support",style: GoogleFonts.poppins(color: Selectpage==15?Colors.black:Colors.white,fontSize: width/85.88),),

                              ],
                            ),
                          ),
                        ),

                        InkWell(
                          onTap:(){
                            setState((){
                              Selectpage=16;
                            });
                          },
                          child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                            height: height/16.275,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Selectpage==16?Colors.white:Colors.transparent,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width:width/91.066),
                                Icon(Icons.question_mark_outlined,
                                  size:width/75.888,
                                  color:Selectpage==16?Colors.black:Colors.white,),
                                SizedBox(width:width/273.2),
                                Text("FAQ",style: GoogleFonts.poppins(color:Selectpage==16?Colors.black:Colors.white,fontSize: width/85.88),),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          height:height/8.1375
                        ),

                        Padding(
                          padding:  EdgeInsets.symmetric(

                            vertical: height/32.55,
                            horizontal: width/68.3
                          ),
                          child: InkWell(
                            onTap: (){LogoutPopup();
                              },
                            child: Material(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                              shadowColor: Colors.white70,
                              child: Container(
                                height:50,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.logout,color: Colors.white,),
                                    SizedBox(width: 8,),
                                    Text("Logout",style: GoogleFonts.poppins(color: Colors.white),)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                Expanded(child:
                Selectpage==0?DashBoard_Page():
                Selectpage==1?Distributor_data_Page():
                Selectpage==2?New_Applied_Distributor_Page():
                Selectpage==3?Corretion_List_Page():
                Selectpage==4?Lost_Pandcard_distributor():
                Selectpage==5?Distrobutor_Histroe_Page():
                Selectpage==6?Infividual_Page():
                Selectpage==7?New_applied_indivivual():
                Selectpage==8?Correction_Infivivual_Page():
                Selectpage==9?Lost_pancard_individual():
                Selectpage==10?Individual_Hostroy_Page():
                Selectpage==11?Minor_Pancard():
                Selectpage==12?Form_Page():
                Selectpage==13?Notification_Page():
                Selectpage==14?Slide_Image():
                Selectpage==15?Permissions_Page():
                Selectpage==16?Support_Page():
                Selectpage==17?FAQ_Page(): SizedBox(),
                )
              ],
            ),
            // StreamBuilder<QuerySnapshot>(
            //   stream:FirebaseFirestore.instance.collection("AdminUser").snapshots() ,
            //   builder: (context, snapshot) {
            //
            //     if(!snapshot.hasData){
            //       return Center(child: Container(),);
            //     }
            //     if(snapshot.hasData==null){
            //       return Center(child: Container(),);
            //     }
            //
            //     setDrawerItems(snapshot.data!.docs);
            //     return
            //       Container(
            //       height: size.height,
            //       width: size.width,
            //       decoration: BoxDecoration(
            //         gradient: LinearGradient(colors: [
            //           Color(0xff245BCA),
            //           Color(0xff245BCA).withOpacity(0.6)
            //         ]),
            //       ),
            //       child: Row(
            //         children: [
            //           Stack(
            //             children: [
            //               SizedBox(
            //                 height: size.height,
            //                 width: size.width * 0.18,
            //                 child: Column(
            //                   children: [
            //                     Container(
            //                       width: double.infinity,
            //                       padding: const EdgeInsets.all(16.0),
            //                       child: Column(
            //                         crossAxisAlignment:
            //                         CrossAxisAlignment.start,
            //                         children: [
            //                           SizedBox(
            //                             width: double.infinity,
            //                             child: Row(
            //                               children: [
            //                                 SizedBox(
            //                                     width:150,
            //                                     child: Image.asset("assets/Logo.png")),
            //
            //                               ],
            //                             ),
            //                           ),
            //
            //                           Text("UserEmail : ${widget.Authusertype}",style: GoogleFonts.poppins(color: Colors.white),),
            //
            //                         ],
            //                       ),
            //                     ),
            //                     Expanded(
            //                       child: Stack(
            //                         children: [
            //                           SizedBox(
            //                               width: double.infinity,
            //                               child: ListView.builder(
            //                                 itemCount: drawerItems.length,
            //                                 itemBuilder: (ctx, i) {
            //                                   return InkWell(
            //                                     onTap: () {
            //                                       setState(() {
            //                                         currentIndex = i;
            //                                         selectedIndex = 0;
            //                                         drawerItems[i].isExpanded =
            //                                         !drawerItems[i].isExpanded!;
            //                                       });
            //                                     },
            //                                     child: Column(
            //                                       children: [
            //                                         Container(
            //                                           height: expandedIndex ==
            //                                               i
            //                                               ? drawerItems[i]
            //                                               .children!
            //                                               .length *
            //                                               60
            //                                               : 50,
            //                                           width:
            //                                           double.infinity,
            //                                           color: currentIndex ==
            //                                               i
            //                                               ? Colors.white
            //                                               : Colors
            //                                               .transparent,
            //                                           child: Padding(
            //                                             padding:
            //                                             const EdgeInsets
            //                                                 .only(
            //                                                 left: 20,
            //                                                 right:
            //                                                 10),
            //                                             child: Column(
            //                                               mainAxisAlignment:
            //                                               MainAxisAlignment
            //                                                   .center,
            //                                               children: [
            //                                                 Row(
            //                                                   children: [
            //                                                     Icon(
            //                                                       drawerItems[i]
            //                                                           .icon,
            //                                                       color: currentIndex ==
            //                                                           i
            //                                                           ? Colors.indigo.withOpacity(0.5)
            //                                                           : Colors.white,
            //                                                     ),
            //                                                     const SizedBox(
            //                                                         width:
            //                                                         20),
            //                                                     Row(
            //                                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                                                       children: [
            //                                                         Container(width:110,
            //                                                           child: Text(
            //                                                             drawerItems[i]
            //                                                                 .name!,
            //                                                             style: currentIndex ==
            //                                                                 i
            //                                                                 ? GoogleFonts.poppins(
            //                                                               fontWeight: FontWeight.w900,
            //                                                               fontSize: 15,
            //                                                               color: Colors.indigo.withOpacity(0.5),)
            //                                                                 : GoogleFonts.poppins(
            //                                                                 fontSize: 13,
            //                                                                 color: Colors.white
            //                                                               //color: const Color(0xff1B1616),
            //                                                             ),
            //                                                           ),
            //                                                         ),
            //
            //                                                         SizedBox(width:15),
            //
            //                                                         (drawerItems[i].name=="Distributors")&&
            //                                                             (distrutorCorrectionCount+distrutorappliedCount+distrutorlostCount)!=0?
            //                                                         Container(
            //                                                           height:18,
            //                                                           width:18,
            //                                                           decoration: BoxDecoration(
            //                                                               color:Colors.white,
            //                                                               borderRadius: BorderRadius.circular(60)
            //                                                           ),
            //                                                           child:
            //                                                           Center(
            //                                                             child:
            //                                                             Text(
            //                                                               "${(distrutorCorrectionCount+distrutorappliedCount+distrutorlostCount).toString()}",
            //                                                               style: GoogleFonts.poppins(color:Colors.black),
            //                                                             ),)) : SizedBox(),
            //
            //                                                         (drawerItems[i].name=="Individual")&&
            //                                                             (individualappliedCount+individualCorrectionCount+individuallostCount)!=0?
            //                                                         Container(
            //                                                           height:18,
            //                                                           width:18,
            //                                                           decoration: BoxDecoration(
            //                                                               color:Colors.white,
            //                                                               borderRadius: BorderRadius.circular(60)
            //                                                           ),
            //                                                           child: Center(
            //                                                             child:
            //                                                             Text(
            //                                                               "${(individualappliedCount+individualCorrectionCount+individuallostCount).toString()}",
            //                                                               style: GoogleFonts.poppins(color:Colors.black),
            //                                                             ),
            //
            //                                                           )) : SizedBox(),
            //
            //                                                         (drawerItems[i].name=="Minor Pancard")&& (minorCount)!=0?
            //                                                         Container(
            //                                                           height:18,
            //                                                           width:18,
            //                                                           decoration: BoxDecoration(
            //                                                               color:Colors.white,
            //                                                               borderRadius: BorderRadius.circular(60)
            //                                                           ),
            //                                                           child: Center(
            //                                                             child:
            //                                                             Text(
            //                                                               "${minorCount.toString()}",
            //                                                               style: GoogleFonts.poppins(color:Colors.black),
            //                                                             ),
            //                                                           )
            //                                                         ) : SizedBox(),
            //
            //                                                       ],
            //                                                     ),
            //                                                     const Expanded(
            //                                                         child:
            //                                                         SizedBox()),
            //                                                     Visibility(
            //                                                       visible: drawerItems[i]
            //                                                           .children!
            //                                                           .isNotEmpty,
            //                                                       child:
            //                                                       InkWell(
            //                                                         onTap:
            //                                                             () {
            //                                                           setState(() {
            //                                                             drawerItems[i].isExpanded = !drawerItems[i].isExpanded!;
            //                                                           });
            //                                                         },
            //                                                         child: drawerItems[i].isExpanded!
            //                                                             ? RotatedBox(
            //                                                             quarterTurns: 2,
            //                                                             child: Icon(
            //                                                               Icons.expand_circle_down_outlined,
            //                                                               color: currentIndex == i ? Colors.indigo.withOpacity(0.5) : Colors.black,
            //                                                             ))
            //                                                             : Icon(
            //                                                           Icons.expand_circle_down_outlined,
            //                                                           color: currentIndex == i ? Colors.indigo.withOpacity(0.5) : Colors.black,
            //                                                         ),
            //                                                       ),
            //                                                     ),
            //                                                   ],
            //                                                 )
            //                                               ],
            //                                             ),
            //                                           ),
            //                                         ),
            //
            //                                         Visibility(
            //                                           visible: (drawerItems[i].children!.isNotEmpty &&
            //                                               drawerItems[i].isExpanded!),
            //                                           child: SizedBox(
            //                                             height: drawerItems[i].children!.length * 50,
            //                                             width: double.infinity,
            //                                             child: ListView
            //                                                 .builder(
            //                                               itemCount: drawerItems[i].children!.length,
            //                                               itemBuilder: (ctx, j) {
            //                                                 return InkWell(
            //                                                   onTap: () {
            //                                                     setState(() {
            //                                                           currentIndex = i;
            //                                                           selectedIndex = j;
            //                                                         });
            //                                                   },
            //                                                   child:
            //                                                   Container(
            //                                                     height:
            //                                                     50,
            //                                                     width: double
            //                                                         .infinity,
            //                                                     color: Colors
            //                                                         .transparent,
            //                                                     child:
            //                                                     Padding(
            //                                                       padding: const EdgeInsets.only(
            //                                                           left:
            //                                                           20,
            //                                                           right:
            //                                                           10),
            //                                                       child:
            //                                                       Column(
            //                                                         mainAxisAlignment:
            //                                                         MainAxisAlignment.center,
            //                                                         children: [
            //                                                           Row(
            //                                                             children: [
            //                                                               const SizedBox(width: 10),
            //                                                               Icon(
            //                                                                 drawerItems[i].children![j].icon,
            //                                                                 color: (currentIndex == i && selectedIndex == j) ? Colors.white : Colors.black,
            //                                                               ),
            //                                                               const SizedBox(width: 20),
            //                                                               Row(
            //                                                                 children: [
            //                                                                   Text(
            //                                                                     drawerItems[i].children![j].name!,
            //                                                                     style: (currentIndex == i && selectedIndex == j) ? GoogleFonts.poppins(fontWeight: FontWeight.w900, fontSize: 13, color: Colors.white) : GoogleFonts.poppins(fontSize: 12, color: const Color(0xff1B1616)),
            //                                                                   ),
            //
            //                                                                   (drawerItems[i].children![j].name=="Distributor New Applied")&&distrutorappliedCount!=0?
            //                                                                   Container(
            //                                                                     height:18,
            //                                                                     width:18,
            //                                                                     decoration: BoxDecoration(
            //                                                                         color:Colors.white,
            //                                                                         borderRadius: BorderRadius.circular(60)
            //                                                                     ),
            //                                                                     child:
            //                                                                     Center(
            //                                                                       child:Text(
            //                                                                         "${distrutorappliedCount.toString()}",
            //                                                                         style: GoogleFonts.poppins(color: Colors.black),
            //                                                                       ),)
            //                                                                   ): SizedBox(),
            //                                                                   (drawerItems[i].children![j].name=="Distributor Correction")&&distrutorCorrectionCount!=0?
            //                                                                   Container(
            //                                                                       height:18,
            //                                                                       width:18,
            //                                                                       decoration: BoxDecoration(
            //                                                                           color:Colors.white,
            //                                                                           borderRadius: BorderRadius.circular(60)
            //                                                                       ),
            //                                                                       child:
            //                                                                       Center(
            //                                                                         child:Text(
            //                                                                           "${distrutorCorrectionCount.toString()}",
            //                                                                           style: GoogleFonts.poppins(color: Colors.black),
            //                                                                         ),)
            //                                                                   ): SizedBox(),
            //                                                                   (drawerItems[i].children![j].name=="Distributor Users"
            //                                                                       && drawerItems[i].children![j].name=="Lost Pan Card")&&distrutorlostCount!=0?
            //                                                                   Container(
            //                                                                       height:18,
            //                                                                       width:18,
            //                                                                       decoration: BoxDecoration(
            //                                                                           color:Colors.white,
            //                                                                           borderRadius: BorderRadius.circular(60)
            //                                                                       ),
            //                                                                       child:
            //                                                                       Center(
            //                                                                         child:Text(
            //                                                                           "${distrutorlostCount.toString()}",
            //                                                                           style: GoogleFonts.poppins(color: Colors.black),
            //                                                                         ),)
            //                                                                   ): SizedBox(),
            //                                                                   (drawerItems[i].children![j].name=="Individual New Applied")&&individualappliedCount!=0?
            //                                                                   Container(
            //                                                                       height:18,
            //                                                                       width:18,
            //                                                                       decoration: BoxDecoration(
            //                                                                           color:Colors.white,
            //                                                                           borderRadius: BorderRadius.circular(60)
            //                                                                       ),
            //                                                                       child:
            //                                                                       Center(
            //                                                                         child:Text(
            //                                                                           "${individualappliedCount.toString()}",
            //                                                                           style: GoogleFonts.poppins(color: Colors.black),
            //                                                                         ),)
            //                                                                   ): SizedBox(),
            //                                                                   (drawerItems[i].children![j].name=="Individual Correction")&&individualCorrectionCount!=0?
            //                                                                   Container(
            //                                                                       height:18,
            //                                                                       width:18,
            //                                                                       decoration: BoxDecoration(
            //                                                                           color:Colors.white,
            //                                                                           borderRadius: BorderRadius.circular(60)
            //                                                                       ),
            //                                                                       child:
            //                                                                       Center(
            //                                                                         child:Text(
            //                                                                           "${individualCorrectionCount.toString()}",
            //                                                                           style: GoogleFonts.poppins(color: Colors.black),
            //                                                                         ),)
            //                                                                   ): SizedBox(),
            //                                                                   (drawerItems[i].children![j].name=="Individual Users"
            //                                                                       && drawerItems[i].children![j].name=="Lost Pan Card")&&individuallostCount!=0?
            //                                                                   Container(
            //                                                                       height:18,
            //                                                                       width:18,
            //                                                                       decoration: BoxDecoration(
            //                                                                           color:Colors.white,
            //                                                                           borderRadius: BorderRadius.circular(60)
            //                                                                       ),
            //                                                                       child:
            //                                                                       Center(
            //                                                                         child:Text(
            //                                                                           "${individuallostCount.toString()}",
            //                                                                           style: GoogleFonts.poppins(color: Colors.black),
            //                                                                         ),)
            //                                                                   ): SizedBox(),
            //
            //
            //                                                                 ],
            //                                                               ),
            //
            //
            //                                                             ],
            //                                                           ),
            //                                                         ],
            //                                                       ),
            //                                                     ),
            //                                                   ),
            //                                                 );
            //                                               },
            //                                             ),
            //                                           ),
            //                                         ),
            //                                       ],
            //                                     ),
            //                                   );
            //                                 },
            //                               )),
            //                         ],
            //                       ),
            //                     ),
            //                     Padding(
            //                       padding: const EdgeInsets.all(20),
            //                       child: InkWell(
            //                         onTap: (){
            //                           LogoutPopup();
            //                         },
            //                         child: Material(
            //                           color: Colors.red,
            //                           borderRadius: BorderRadius.circular(8),
            //                           shadowColor: Colors.white70,
            //                           child: Container(
            //                             height:50,
            //                      decoration: BoxDecoration(
            //                            color: Colors.red,
            //                            borderRadius: BorderRadius.circular(8)
            //                      ),
            //                             child: Row(
            //                               crossAxisAlignment: CrossAxisAlignment.center,
            //                               mainAxisAlignment: MainAxisAlignment.center,
            //                               children: [
            //                                 Icon(Icons.logout,color: Colors.white,),
            //                                 SizedBox(width: 8,),
            //                                 Text("Logout",style: GoogleFonts.poppins(color: Colors.white),)
            //                               ],
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               )
            //             ],
            //           ),
            //           Container(
            //             height: size.height,
            //             width: size.width * 0.82,
            //             color: Colors.white,
            //             child: drawerItems[currentIndex].children!.isNotEmpty
            //                 ? drawerItems[currentIndex]
            //                 .children![selectedIndex]
            //                 .page
            //                 : drawerItems[currentIndex].page,
            //           )
            //         ],
            //       ),
            //     );
            //   },
            // ),
          ],
        )
    );
  }



  LogoutPopup(){

    showDialog(
      barrierColor: Colors.transparent,
      context: context, builder:(context) {
      return Padding(
        padding: const EdgeInsets.only(top: 150.0,bottom: 150,left: 350,right:350),
        child: Material(
         color: Colors.white,
          shadowColor: Color(0xff245BCA),
          borderRadius: BorderRadius.circular(8),
          elevation: 10,
          child: Container(

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Scaffold(
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height:30),
                    Text("Are You Sure Want to LogOut",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize:18
                    ),),

                    const SizedBox(height:20),

                    SizedBox(
                      height:180,
                      width:180,
                      child: Lottie.asset("assets/logout.json"),
                    ),

                    const SizedBox(height:20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          hoverColor:Colors.transparent,
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            height:40,
                            width:180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text("Cancel",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600),),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            _signOut();
                            Navigator.pop(context);
                          },
                          child: Container(
                            height:40,
                            width:180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color:  Colors.red
                            ),
                            child: Center(
                              child: Text("Okay",style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600),),
                            ),
                          ),
                        ),
                      ],
                    )

                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },);
  }

 _signOut()  async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Login_Page(),));

  }

}