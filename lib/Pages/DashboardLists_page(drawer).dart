import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sidebarx/sidebarx.dart';

import '../Drawer_Model/Drawer.dart';
import 'Corection_indiviual_Page.dart';
import 'Correction_DistributorList_Page.dart';
import 'Dash_board_Page.dart';

import 'Distributor_Histroy_page.dart';
import 'Individivual_Page.dart';
import 'Individual_Histroy_Page.dart';
import 'New_applied_Page.dart';
import 'New_applied_Page2(Indivivual).dart';
import 'Notification_Page.dart';
import 'Slider_Page.dart';
import 'Distributor_User-Page.dart';

class LandinG_Screen extends StatefulWidget {
  String ? Authusertype;
   LandinG_Screen({this.Authusertype});

  @override
  State<LandinG_Screen> createState() => _LandinG_ScreenState();
}

class _LandinG_ScreenState extends State<LandinG_Screen> {

int selectedtile=0;




   List Pages=[];

   List<Widget> ViewPages=[
       DashBoard_Page(),///dash bOard Page
       Distributor_data_Page(),///distributor user Page
       New_Applied_Distributor_Page(),///distributor Applied Page
       Corretion_List_Page(),///distributor Correction Page
       Distrobutor_Histroe_Page(),///Distributor Reports Page
       Infividual_Page(),///Individual User Page
       New_applied_indivivual(),///Individual Applied Page
       Correction_Infivivual_Page(),///Individual Correction Page
       Individual_Hostroy_Page(),
       Notification_Page(),
       Slide_Image(),///Slider Image Page
   ];

   upadteFunction()async{
     var doc=await FirebaseFirestore.instance.collection("AdminUser").where("Type",isEqualTo: widget.Authusertype).get();
      if(doc.docs[0]['Type']=="admin"){
        setState(() {
          Pages=ViewPages;
        });
      }
      print(Pages);

   }

   @override
  void initState() {
     upadteFunction();
     // TODO: implement initState
    super.initState();
  }



  int pageselctindex = 0;


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff263646),
        title: Row(
          children: [

            const SizedBox(width: 10,),
            Text("JP Ads",style: GoogleFonts.montserrat(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w700),),
          ],
        ),
        toolbarHeight: 40,
      ),

      body: Row(
        children: [

          Container(
            height: double.infinity,
            width: 200,
            decoration: BoxDecoration(
              color: Color(0xff263646)

            ),
            child:
            ListView.builder(
              itemCount: Pages.length,
              itemBuilder: (context, intx) {
              return GestureDetector(
                  onTap: (){
                    setState(() {
                      pageselctindex=intx;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: pageselctindex==intx?Colors.white:Color(0xff263646)
                      ),
                      child: Center(child: Text(Pages[intx].toString(),style: TextStyle( color: pageselctindex==intx?Colors.black:Colors.white),))));
            },)
          ),


          Flexible(
            child: Material(
              shadowColor: Colors.black12,
              child: ListView.builder(
                itemCount:Pages.length ,
                itemBuilder: (context, index) {
                    return Pages[pageselctindex];
              },)
            ),
          ),



        ],
      ),
    );

  }
}

class Permission{
    String ?pagename;
    bool?pageselect;
    Widget?page;
   Permission({this.pagename,this.pageselect,this.page});
}




