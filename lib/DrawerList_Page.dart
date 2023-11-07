import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'Drawer_Model/Drawer.dart';
import 'Pages/Corection_indiviual_Page.dart';
import 'Pages/Correction_DistributorList_Page.dart';
import 'Pages/Dash_board_Page.dart';
import 'Pages/Distributor_Histroy_page.dart';
import 'Pages/Distributor_User-Page.dart';
import 'Pages/Forms_Page.dart';
import 'Pages/Individivual_Page.dart';
import 'Pages/Individual_Histroy_Page.dart';
import 'Pages/Lost_Pandcard(Distributor).dart';
import 'Pages/Minor_Pancard.dart';
import 'Pages/New_applied_Page.dart';
import 'Pages/New_applied_Page2(Indivivual).dart';
import 'Pages/Notification_Page.dart';
import 'Pages/Permission_Page.dart';
import 'Pages/Slider_Page.dart';
import 'Pages/Support_Page.dart';

class HomeView extends StatefulWidget {
  String?Authusertype;
    HomeView({this.Authusertype});



@override
State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  int selectedIndex = 100;
  int expandedIndex = 100;
  bool isFetched = false;

  List<DrawerModel> drawerItems1 = [];

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
            name: "Distributor History",
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
      page:  Permissions_Page(Usertype:"admin@gmail.com"),
      children: [],
    ),



    DrawerModel(
      name: "Support",
      icon: Icons.person_pin_outlined,
      isExpanded: false,
      page:  Support_Page(),
      children: [],
    ),

    // DrawerModel(
    //   name: "Logout",
    //   icon: Icons.logout,
    //   isExpanded: false,
    //   page:  Support_Page(),
    //   children: [],
    // ),

  ];

  setDrawerItems(List roles) {
    print(widget.Authusertype);
    if (drawerItems1.isEmpty) {
      for (int i = 0; i < roles.length; i++) {

        if (widget.Authusertype!.toLowerCase()=='admin'.toLowerCase()) {

          drawerItems1 = drawerItems;
        }
        else  if (widget.Authusertype.toString().toLowerCase()=="staff".toLowerCase()) {
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
              case "Distributor":
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
              case "Individual":
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
            }
          }
        }
      }
    }
    isFetched = true;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body:
        StreamBuilder<QuerySnapshot>(
          stream:FirebaseFirestore.instance.collection("AdminUser").snapshots() ,
          builder: (context, snapshot) {

            if(!snapshot.hasData){
              return Center(child: Container(),);
            }
            if(snapshot.hasData==null){
              return Center(child: Container(),);
            }

            setDrawerItems(snapshot.data!.docs);
            return Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xff245BCA),
                  Color(0xff245BCA).withOpacity(0.6)
                ]),
              ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: size.height,
                        width: size.width * 0.18,
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            width:150,
                                            child: Image.asset("assets/Logo.png")),

                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Expanded(
                              child: Stack(
                                children: [
                                  SizedBox(
                                      width: double.infinity,
                                      child: ListView.builder(
                                        itemCount: drawerItems.length,
                                        itemBuilder: (ctx, i) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                currentIndex = i;
                                                selectedIndex = 0;
                                                drawerItems[i].isExpanded =
                                                !drawerItems[i].isExpanded!;
                                              });



                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: expandedIndex ==
                                                      i
                                                      ? drawerItems[i]
                                                      .children!
                                                      .length *
                                                      60
                                                      : 50,
                                                  width:
                                                  double.infinity,
                                                  color: currentIndex ==
                                                      i
                                                      ? Colors.white
                                                      : Colors
                                                      .transparent,
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        left: 20,
                                                        right:
                                                        10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              drawerItems[i]
                                                                  .icon,
                                                              color: currentIndex ==
                                                                  i
                                                                  ? Colors.indigo.withOpacity(0.5)
                                                                  : Colors.white,
                                                            ),
                                                            const SizedBox(
                                                                width:
                                                                20),
                                                            Text(
                                                              drawerItems[i]
                                                                  .name!,
                                                              style: currentIndex ==
                                                                  i
                                                                  ? GoogleFonts.poppins(
                                                                fontWeight: FontWeight.w900,
                                                                fontSize: 15,
                                                                color: Colors.indigo.withOpacity(0.5),
                                                              )
                                                                  : GoogleFonts.poppins(
                                                                  fontSize: 13,
                                                                  color: Colors.white
                                                                //color: const Color(0xff1B1616),
                                                              ),
                                                            ),
                                                            const Expanded(
                                                                child:
                                                                SizedBox()),
                                                            Visibility(
                                                              visible: drawerItems[i]
                                                                  .children!
                                                                  .isNotEmpty,
                                                              child:
                                                              InkWell(
                                                                onTap:
                                                                    () {
                                                                  setState(() {
                                                                    drawerItems[i].isExpanded = !drawerItems[i].isExpanded!;
                                                                  });
                                                                },
                                                                child: drawerItems[i].isExpanded!
                                                                    ? RotatedBox(
                                                                    quarterTurns: 2,
                                                                    child: Icon(
                                                                      Icons.expand_circle_down_outlined,
                                                                      color: currentIndex == i ? Colors.indigo.withOpacity(0.5) : Colors.black,
                                                                    ))
                                                                    : Icon(
                                                                  Icons.expand_circle_down_outlined,
                                                                  color: currentIndex == i ? Colors.indigo.withOpacity(0.5) : Colors.black,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: (drawerItems[
                                                  i]
                                                      .children!
                                                      .isNotEmpty &&
                                                      drawerItems[i]
                                                          .isExpanded!),
                                                  child: SizedBox(
                                                    height: drawerItems[
                                                    i]
                                                        .children!
                                                        .length *
                                                        50,
                                                    width: double
                                                        .infinity,
                                                    child: ListView
                                                        .builder(
                                                      itemCount:
                                                      drawerItems[
                                                      i]
                                                          .children!
                                                          .length,
                                                      itemBuilder:
                                                          (ctx, j) {
                                                        return InkWell(
                                                          onTap: () {
                                                            setState(
                                                                    () {
                                                                  currentIndex =
                                                                      i;
                                                                  selectedIndex =
                                                                      j;
                                                                });
                                                          },
                                                          child:
                                                          Container(
                                                            height:
                                                            50,
                                                            width: double
                                                                .infinity,
                                                            color: Colors
                                                                .transparent,
                                                            child:
                                                            Padding(
                                                              padding: const EdgeInsets.only(
                                                                  left:
                                                                  20,
                                                                  right:
                                                                  10),
                                                              child:
                                                              Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.center,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      const SizedBox(width: 10),
                                                                      Icon(
                                                                        drawerItems[i].children![j].icon,
                                                                        color: (currentIndex == i && selectedIndex == j) ? Colors.white : Colors.black,
                                                                      ),
                                                                      const SizedBox(width: 20),
                                                                      Text(
                                                                        drawerItems[i].children![j].name!,
                                                                        style: (currentIndex == i && selectedIndex == j) ? GoogleFonts.poppins(fontWeight: FontWeight.w900, fontSize: 13, color: Colors.white) : GoogleFonts.poppins(fontSize: 12, color: const Color(0xff1B1616)),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: InkWell(
                                onTap: (){
                                  LogoutPopup();
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
                      )
                    ],
                  ),
                  Container(
                    height: size.height,
                    width: size.width * 0.82,
                    color: Colors.white,
                    child: drawerItems[currentIndex].children!.isNotEmpty
                        ? drawerItems[currentIndex]
                        .children![selectedIndex]
                        .page
                        : drawerItems[currentIndex].page,
                  )
                ],
              ),
            );
          },
        ));
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

  }

}