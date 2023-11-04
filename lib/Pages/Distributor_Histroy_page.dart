
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart'as http;
import 'package:universal_html/html.dart' as html;

class Distrobutor_Histroe_Page extends StatefulWidget {
  const Distrobutor_Histroe_Page({super.key});

  @override
  State<Distrobutor_Histroe_Page> createState() => _Distrobutor_Histroe_PageState();
}

class _Distrobutor_Histroe_PageState extends State<Distrobutor_Histroe_Page> with SingleTickerProviderStateMixin{

  int isviewcollection=0;
  String Userdocuid='';

  int viewhistroy=0;
  int documentcount=0;

  TabController?tabController;
  int selectTabIndex=0;
  var indexvalue=0;

  ///status update varibales
  String Statusvaue="";
  String Statusvaue2="";


  @override
  void initState() {
    tabController=TabController(length: 4, vsync: this)  ;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
      Padding(
        padding:  EdgeInsets.only(left:10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.only(left: width / 75.77,right:  width / 25.77,
                    top: height/61.43),
                child: Row(
                  children: [
                    isviewcollection==1?
                    GestureDetector(
                        onTap: (){
                          setState(() {
                            isviewcollection=0;
                            viewhistroy=0;
                          });
                        },
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(100),
                          shadowColor: Colors.indigo,
                          color: Colors.grey.shade400,
                          child: const SizedBox(
                              height: 30,
                              width: 30,
                              child: Icon(Icons.arrow_back,color: Colors.white,)),
                        )):SizedBox(),
                    const SizedBox(width: 10,),

                    Text(
                      "Distributor Reports ",
                      style: GoogleFonts.poppins(
                          fontSize: width / 57.57,
                          color: const Color(0xff000000)),
                    ),




                  ],
                ),
              ),
              SizedBox(height: height/41.143,),

              isviewcollection==0?
              SizedBox(
                height: 500,
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material( color: const Color(0xffd8e6ff),
                        elevation: 20,
                        shadowColor: Colors.black12,
                        child: Container(
                            width: 1090,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color:  const Color(0xffd8e6ff),
                          ),
                          child:
                          Column(
                            children: [
                              Row(

                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  Container(
                                    width: 50,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Si.No",
                                        style:
                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),

                                  Container(
                                    width: 250,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Name",
                                        style:
                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),

                                  Container(
                                    width: 150,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Phone",
                                        style:
                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),

                                  Container(
                                    width: 150,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Wallet Amt",
                                        style:
                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),

                                  Container(
                                    width: 150,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Payment",
                                        style:
                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),

                                  Container(
                                    width: 150,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Applied count",
                                        style:
                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),

                                  Container(
                                    width: 190,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)
                                    ),
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
                              StreamBuilder(
                                stream: FirebaseFirestore.instance.collection("Users").where("usertype",isEqualTo:"Distributor").snapshots(),
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
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {

                                        var _Userdata=snapshot.data!.docs[index];

                                        return Row(

                                          crossAxisAlignment: CrossAxisAlignment.center,


                                          children: [

                                            Container(
                                              width: 50,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black)
                                              ),
                                              child: Center(
                                                child: Text(
                                                  (index+1).toString(),
                                                  style:
                                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                ),
                                              ),
                                            ),

                                            Container(
                                              width: 250,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black)
                                              ),
                                              child: Center(
                                                child: Text(
                                                  _Userdata["name"].toString(),
                                                  style:
                                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                ),
                                              ),
                                            ),

                                            Container(
                                              width: 150,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black)
                                              ),
                                              child: Center(
                                                child: Text(
                                                  _Userdata["phone"].toString(),
                                                  style:
                                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                ),
                                              ),
                                            ),

                                            Container(
                                              width: 150,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black)
                                              ),
                                              child: Center(
                                                child: Text(
                                                  _Userdata["walletamount"].toString(),
                                                  style:
                                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                ),
                                              ),
                                            ),

                                            Container(
                                              width: 150,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black)
                                              ),
                                              child: Center(
                                                child: Text(
                                                  _Userdata["payment"].toString(),
                                                  style:
                                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                ),
                                              ),
                                            ),

                                            Container(
                                              width: 150,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black)
                                              ),
                                              child: Center(
                                                child: Text(
                                                  _Userdata["usageccount"].toString(),
                                                  style:
                                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                ),
                                              ),
                                            ),

                                            Container(
                                              width: 190,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black)
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      setState(() {
                                                        isviewcollection=1;
                                                        viewhistroy=1;
                                                        Userdocuid=_Userdata.id.toString();
                                                      });

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
                                                  InkWell(
                                                    onTap: (){
                                                      ///delete popup
                                                      _deletepopup(_Userdata.id);
                                                    },
                                                    child: SizedBox(
                                                        width: 40,
                                                        height: 40,
                                                        child: Center(child: const Icon(Icons.delete))
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),






                                          ],
                                        );

                                      },);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: height/41.143,),




                    ],
                  ),
                ),
              ):
              isviewcollection==1?
              SizedBox(
                  height: 500,
                  child:
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height:100,
                          margin: EdgeInsets.only(left: 8,right: 8),
                          padding:   EdgeInsets.only(top:10),
                          decoration: BoxDecoration(
                              color:Color(0xffd8e6ff),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              )
                          ),
                          child: Center(
                            child: FutureBuilder(
                              future: FirebaseFirestore.instance.collection("Users").doc(Userdocuid).get(),
                              builder: (context, snapshot) {
                                if(!snapshot.hasData){
                                  return Center(child: CircularProgressIndicator());
                                }
                                if(snapshot.hasData==null){
                                  return Center(child: CircularProgressIndicator());
                                }
                                var data=snapshot.data;

                                return
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 500,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 230,
                                                  height: 40,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Name",
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 230,
                                                  height: 40,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        data!['name'].toString(),
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color:  Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 230,
                                                  height: 40,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Type",
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 230,
                                                  height: 40,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        data['usertype'].toString(),
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        width: 500,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 230,
                                                  height: 40,

                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Phone No",
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 230,
                                                  height: 40,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        data['phone'].toString(),
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 230,
                                                  height: 40,

                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Wallet Amount",
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 230,
                                                  height: 40,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        data['walletamount'].toString(),
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                              },
                            ),
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(left: 8,right: 8),
                          child: Center(
                            child: Container(
                              height: 50,
                              width:double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TabBar(
                                controller: tabController,
                                labelColor: Colors.indigo,
                                dividerColor: Colors.transparent,
                                indicatorSize: TabBarIndicatorSize.label,
                                indicatorColor: Colors.red,
                                indicatorPadding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                labelPadding: const EdgeInsets.all(0),
                                splashBorderRadius: BorderRadius.zero,
                                splashFactory: NoSplash.splashFactory,
                                labelStyle: GoogleFonts.openSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                                unselectedLabelStyle: GoogleFonts.openSans(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                ),
                                onTap: (index){
                                  setState(() {
                                    selectTabIndex = index;
                                  });
                                },
                                tabs: [
                                  Tab(
                                    child:  const Text("Approved"),
                                  ),
                                  Tab(
                                    child: const Text("Pending"),
                                  ),
                                  Tab(
                                    child: const Text("Rejected"),
                                  ),
                                  Tab(
                                    child: const Text("Wallet"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: [


                              SizedBox(
                               height:500,

                                child: Column(
                                  children: [
                                    Material( color: const Color(0xffd8e6ff),
                                      elevation: 20,
                                      shadowColor: Colors.black12,
                                      child: Container(
                                        width:1100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          color:  const Color(0xffd8e6ff),
                                        ),
                                        child:
                                        SingleChildScrollView(
                                          physics: ScrollPhysics(),
                                          child: Column(
                                            children: [
                                              Row(

                                                crossAxisAlignment: CrossAxisAlignment.center,

                                                children: [

                                                  Container(
                                                    width: 50,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Si.No",
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: 250,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Name",
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: 200,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Gender",
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: 200,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Type",
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: 200,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Status",
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: 200,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Date/Time",
                                                        textAlign: TextAlign.center,
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),








                                                ],
                                              ),
                                              FutureBuilder(
                                                future: FirebaseFirestore.instance.collection("Users").
                                                doc(Userdocuid).collection("Histroy").where("Type",isEqualTo:"Correction").where("updatestatus",isEqualTo:"Approved").get(),
                                                builder: (context, snapshot) {

                                                  if(snapshot.hasData==null){
                                                    return const Center(child: CircularProgressIndicator(),);
                                                  }
                                                  if(!snapshot.hasData){
                                                    return const Center(child: CircularProgressIndicator(),);
                                                  }

                                                  return ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: snapshot.data!.docs.length,
                                                    itemBuilder: (context, index) {

                                                      documentcount=snapshot.data!.docs.length;
                                                      var applieddata=snapshot.data!.docs[index];
                                                      return Row(

                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                            width: 50,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                (index+1).toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 250,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                applieddata['Crtname'].toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 200,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                applieddata['crgender'].toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 200,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                applieddata['Type'].toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: Colors.indigo,fontWeight:FontWeight.w700),
                                                              ),
                                                            ),
                                                          ),

                                                          InkWell(
                                                            onTap:(){
                                                              statsupdate(applieddata.id);
                                                            },
                                                            child: Container(
                                                              width: 200,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(color: Colors.black)
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  applieddata['updatestatus'].toString(),
                                                                  style:
                                                                  GoogleFonts.poppins(fontSize: 14, color: Colors.indigo,fontWeight:FontWeight.w700),
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 200,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "${ applieddata['date'].toString()}\n${ applieddata['time'].toString()}",
                                                                textAlign: TextAlign.center,
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),










                                                        ],
                                                      );
                                                    },);
                                                },
                                              ),

                                              FutureBuilder(
                                                future: FirebaseFirestore.instance.collection("Users").
                                                doc(Userdocuid).collection("Histroy").where("Type",isEqualTo:"Applied").where("updatestatus",isEqualTo:"Approved").get(),
                                                builder: (context, snapshot) {

                                                  if(snapshot.hasData==null){
                                                    return const Center(child: CircularProgressIndicator(),);
                                                  }
                                                  if(!snapshot.hasData){
                                                    return const Center(child: CircularProgressIndicator(),);
                                                  }

                                                  return ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: snapshot.data!.docs.length,
                                                    itemBuilder: (context, index) {

                                                      var applieddata=snapshot.data!.docs[index];
                                                      return Row(

                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [

                                                          Container(
                                                            width: 50,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                (documentcount+1).toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 250,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                applieddata['name'].toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 200,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                applieddata['gender'].toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 200,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                applieddata['Type'].toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: Colors.indigo,fontWeight:FontWeight.w700),
                                                              ),
                                                            ),
                                                          ),

                                                          InkWell(
                                                            onTap:(){
                                                              statsupdate(applieddata.id);
                                                            },
                                                            child: Container(
                                                              width: 200,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(color: Colors.black)
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  applieddata['updatestatus'].toString(),
                                                                  style:
                                                                  GoogleFonts.poppins(fontSize: 14, color: Colors.indigo,fontWeight:FontWeight.w700),
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 200,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "${ applieddata['date'].toString()}\n${ applieddata['time'].toString()}",
                                                                textAlign: TextAlign.center,
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),










                                                        ],
                                                      );
                                                    },);
                                                },
                                              ),


                                            ],
                                          ),
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                              ),

                              SizedBox(
                                height:500,

                                child: Column(
                                  children: [
                                    Material( color: const Color(0xffd8e6ff),
                                      elevation: 20,
                                      shadowColor: Colors.black12,
                                      child: Container(
                                        width:1100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          color:  const Color(0xffd8e6ff),
                                        ),
                                        child:
                                        SingleChildScrollView(
                                          physics: ScrollPhysics(),
                                          child: Column(
                                            children: [
                                              Row(

                                                crossAxisAlignment: CrossAxisAlignment.center,

                                                children: [


                                                  Container(
                                                    width: 50,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Si.No",
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: 250,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Name",
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: 200,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Gender",
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: 200,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Type",
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: 200,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Status",
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: 200,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Date/Time",
                                                        textAlign: TextAlign.center,
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),








                                                ],
                                              ),
                                              FutureBuilder(
                                                future: FirebaseFirestore.instance.collection("Users").
                                                doc(Userdocuid).collection("Histroy").where("Type",isEqualTo:"Correction").where("updatestatus",isEqualTo:"Pending").get(),
                                                builder: (context, snapshot) {

                                                  if(snapshot.hasData==null){
                                                    return const Center(child: CircularProgressIndicator(),);
                                                  }
                                                  if(!snapshot.hasData){
                                                    return const Center(child: CircularProgressIndicator(),);
                                                  }

                                                  return ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: snapshot.data!.docs.length,
                                                    itemBuilder: (context, index) {

                                                      documentcount=snapshot.data!.docs.length;
                                                      var applieddata=snapshot.data!.docs[index];
                                                      return Row(

                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                            width: 50,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                (index+1).toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 250,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                applieddata['Crtname'].toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 200,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                applieddata['crgender'].toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 200,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                applieddata['Type'].toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: Colors.indigo,fontWeight:FontWeight.w700),
                                                              ),
                                                            ),
                                                          ),

                                                          InkWell(
                                                            onTap:(){
                                                              statsupdate(applieddata.id);
                                                            },
                                                            child: Container(
                                                              width: 200,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(color: Colors.black)
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  applieddata['updatestatus'].toString(),
                                                                  style:
                                                                  GoogleFonts.poppins(fontSize: 14, color: Colors.indigo,fontWeight:FontWeight.w700),
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 200,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "${ applieddata['date'].toString()}\n${ applieddata['time'].toString()}",
                                                                textAlign: TextAlign.center,
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),










                                                        ],
                                                      );
                                                    },);
                                                },
                                              ),

                                              FutureBuilder(
                                                future: FirebaseFirestore.instance.collection("Users").
                                                doc(Userdocuid).collection("Histroy").where("Type",isEqualTo:"Applied").where("updatestatus",isEqualTo:"Pending").get(),
                                                builder: (context, snapshot) {

                                                  if(snapshot.hasData==null){
                                                    return const Center(child: CircularProgressIndicator(),);
                                                  }
                                                  if(!snapshot.hasData){
                                                    return const Center(child: CircularProgressIndicator(),);
                                                  }

                                                  return ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: snapshot.data!.docs.length,
                                                    itemBuilder: (context, index) {

                                                      var applieddata=snapshot.data!.docs[index];
                                                      return Row(

                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [

                                                          Container(
                                                            width: 50,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                (documentcount+1).toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 250,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                applieddata['name'].toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 200,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                applieddata['gender'].toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 200,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                applieddata['Type'].toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: Colors.indigo,fontWeight:FontWeight.w700),
                                                              ),
                                                            ),
                                                          ),

                                                          InkWell(
                                                            onTap:(){
                                                              statsupdate(applieddata.id);
                                                            },
                                                            child: Container(
                                                              width: 200,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(color: Colors.black)
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  applieddata['updatestatus'].toString(),
                                                                  style:
                                                                  GoogleFonts.poppins(fontSize: 14, color: Colors.indigo,fontWeight:FontWeight.w700),
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 200,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "${ applieddata['date'].toString()}\n${ applieddata['time'].toString()}",
                                                                textAlign: TextAlign.center,
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),










                                                        ],
                                                      );
                                                    },);
                                                },
                                              ),


                                            ],
                                          ),
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                              ),

                              SizedBox(
                                height:500,
                                child: Column(
                                  children: [
                                    Material( color: const Color(0xffd8e6ff),
                                      elevation: 20,
                                      shadowColor: Colors.black12,
                                      child: Container(
                                        width:1100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          color:  const Color(0xffd8e6ff),
                                        ),
                                        child:
                                        SingleChildScrollView(
                                          physics: ScrollPhysics(),
                                          child: Column(
                                            children: [
                                              Row(

                                                crossAxisAlignment: CrossAxisAlignment.center,

                                                children: [


                                                  Container(
                                                    width: 50,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Si.No",
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: 250,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Name",
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: 200,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Gender",
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: 200,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Type",
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: 200,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Status",
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: 200,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Date/Time",
                                                        textAlign: TextAlign.center,
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),








                                                ],
                                              ),
                                              FutureBuilder(
                                                future: FirebaseFirestore.instance.collection("Users").
                                                doc(Userdocuid).collection("Histroy").where("Type",isEqualTo:"Correction").where("updatestatus",isEqualTo:"Rejected").get(),
                                                builder: (context, snapshot) {

                                                  if(snapshot.hasData==null){
                                                    return const Center(child: CircularProgressIndicator(),);
                                                  }
                                                  if(!snapshot.hasData){
                                                    return const Center(child: CircularProgressIndicator(),);
                                                  }

                                                  return ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: snapshot.data!.docs.length,
                                                    itemBuilder: (context, index) {

                                                      documentcount=snapshot.data!.docs.length;
                                                      var applieddata=snapshot.data!.docs[index];
                                                      return Row(

                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [

                                                          Container(
                                                            width: 50,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                (index+1).toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 250,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                applieddata['Crtname'].toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 200,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                applieddata['crgender'].toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 200,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                applieddata['Type'].toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: Colors.indigo,fontWeight:FontWeight.w700),
                                                              ),
                                                            ),
                                                          ),

                                                          InkWell(
                                                            onTap:(){
                                                              statsupdate(applieddata.id);
                                                            },
                                                            child: Container(
                                                              width: 200,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(color: Colors.black)
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  applieddata['updatestatus'].toString(),
                                                                  style:
                                                                  GoogleFonts.poppins(fontSize: 14, color: Colors.indigo,fontWeight:FontWeight.w700),
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 200,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "${ applieddata['date'].toString()}\n${ applieddata['time'].toString()}",
                                                                textAlign: TextAlign.center,
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),










                                                        ],
                                                      );
                                                    },);
                                                },
                                              ),

                                              FutureBuilder(
                                                future: FirebaseFirestore.instance.collection("Users").
                                                doc(Userdocuid).collection("Histroy").where("Type",isEqualTo:"Applied").where("updatestatus",isEqualTo:"Rejected").get(),
                                                builder: (context, snapshot) {

                                                  if(snapshot.hasData==null){
                                                    return const Center(child: CircularProgressIndicator(),);
                                                  }
                                                  if(!snapshot.hasData){
                                                    return const Center(child: CircularProgressIndicator(),);
                                                  }

                                                  return ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: snapshot.data!.docs.length,
                                                    itemBuilder: (context, index) {

                                                      var applieddata=snapshot.data!.docs[index];
                                                      return Row(

                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [

                                                          Container(
                                                            width: 50,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                (documentcount+1).toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 250,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                applieddata['name'].toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 200,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                applieddata['gender'].toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 200,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                applieddata['Type'].toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: Colors.indigo,fontWeight:FontWeight.w700),
                                                              ),
                                                            ),
                                                          ),

                                                          InkWell(
                                                            onTap:(){
                                                              statsupdate(applieddata.id);
                                                            },
                                                            child: Container(
                                                              width: 200,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(color: Colors.black)
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  applieddata['updatestatus'].toString(),
                                                                  style:
                                                                  GoogleFonts.poppins(fontSize: 14, color: Colors.indigo,fontWeight:FontWeight.w700),
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 200,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "${ applieddata['date'].toString()}\n${ applieddata['time'].toString()}",
                                                                textAlign: TextAlign.center,
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),










                                                        ],
                                                      );
                                                    },);
                                                },
                                              ),


                                            ],
                                          ),
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                              ),

                              ///wallet

                              SizedBox(
                                height:500,
                                child: Column(
                                  children: [
                                    Material( color: const Color(0xffd8e6ff),
                                      elevation: 20,
                                      shadowColor: Colors.black12,
                                      child: Container(
                                        width:1100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          color:  const Color(0xffd8e6ff),
                                        ),
                                        child:
                                        SingleChildScrollView(
                                          physics: ScrollPhysics(),
                                          child: Column(
                                            children: [
                                              Row(

                                                crossAxisAlignment: CrossAxisAlignment.center,

                                                children: [


                                                  Container(
                                                    width: 50,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Si.No",
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: 250,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Name",
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: 200,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Phone",
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: 200,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Amount",
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: 200,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Date",
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: 200,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Time",
                                                        textAlign: TextAlign.center,
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),








                                                ],
                                              ),
                                              FutureBuilder(
                                                future: FirebaseFirestore.instance.collection("Users").
                                                doc(Userdocuid).collection("Wallet_Histroy").get(),
                                                builder: (context, snapshot) {

                                                  if(snapshot.hasData==null){
                                                    return const Center(child: CircularProgressIndicator(),);
                                                  }
                                                  if(!snapshot.hasData){
                                                    return const Center(child: CircularProgressIndicator(),);
                                                  }

                                                  return ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: snapshot.data!.docs.length,
                                                    itemBuilder: (context, index) {

                                                      var applieddata=snapshot.data!.docs[index];
                                                      return Row(

                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [

                                                          Container(
                                                            width: 50,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                (index+1).toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),



                                                          Container(
                                                            width: 250,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                applieddata['name'].toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 200,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                applieddata['Phoneno'].toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: Colors.indigo,fontWeight:FontWeight.w700),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 200,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                applieddata['Amount'].toString(),
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: Colors.indigo,fontWeight:FontWeight.w700),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 200,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "${ applieddata['date'].toString()}",
                                                                textAlign: TextAlign.center,
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),

                                                          Container(
                                                            width: 200,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.black)
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                   applieddata['time'].toString(),
                                                                textAlign: TextAlign.center,
                                                                style:
                                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                              ),
                                                            ),
                                                          ),










                                                        ],
                                                      );
                                                    },);
                                                },
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                              ),



                            ],
                          ),
                        ),

                      ],
                    ),
                  )
              ):
              const SizedBox(),



            ],
          ),
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

  ///delete document()
  deletedocument(id){
    FirebaseFirestore.instance.collection("Users").doc(id).delete();
  }


  statsupdate(docid){
    return showAdaptiveDialog(
      barrierDismissible: true,
      context: context, builder: (context) {
      return Padding(
        padding:  EdgeInsets.only(bottom: 200,top:200,left: 500,right:500),
        child: StatefulBuilder(
            builder: (context,setState) {
              return
                Container(
                  height:100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color:Colors. white
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState((){
                            Statusvaue="Approved";
                          });
                          Updatecorrectiondocumenr(docid);
                          Navigator.pop(context);
                        },
                        child: Container(
                            height:50,
                            width: double.infinity,
                            decoration:  BoxDecoration(
                                color: Colors.indigo.shade300,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Center(child: Text("Approved",style: GoogleFonts.poppins(fontWeight: FontWeight.w700,color: Colors.white),))),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState((){
                            Statusvaue="Pending";
                          });
                          Updatecorrectiondocumenr(docid);
                          Navigator.pop(context);
                        },
                        child: Container(
                            height:50,
                            width: double.infinity,
                            decoration:  BoxDecoration(
                                color: Colors.indigo.shade300,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Center(child: Text("Pending",style: GoogleFonts.poppins(fontWeight: FontWeight.w700,color: Colors.white),))),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState((){
                            Statusvaue="Rejected";
                          });
                          Updatecorrectiondocumenr(docid);
                          Navigator.pop(context);
                        },
                        child: Container(
                            height:50,
                            width: double.infinity,
                            decoration:  BoxDecoration(
                                color: Colors.indigo.shade300,
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Center(child: Text("Rejected",style: GoogleFonts.poppins(fontWeight: FontWeight.w700,color: Colors.white),))),
                      ),

                    ],
                  ),
                );
            }
        ),
      );
    },);
  }

  Updatecorrectiondocumenr(docid){
    FirebaseFirestore.instance.collection("Users").doc(Userdocuid).collection("Histroy").doc(docid).update({
      "updatestatus":Statusvaue,
    });
    setState((){});
  }

  // Appliedstatsupdate(docid){
  //   return showAdaptiveDialog(
  //     barrierDismissible: true,
  //     context: context, builder: (context) {
  //     return Padding(
  //       padding:  EdgeInsets.only(bottom: 200,top:200,left: 500,right:500),
  //       child: StatefulBuilder(
  //           builder: (context,setState) {
  //             return
  //               Container(
  //                 height:100,
  //                 width: double.infinity,
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(8),
  //                     color:Colors. white
  //                 ),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                   children: [
  //                     GestureDetector(
  //                       onTap: (){
  //                         setState((){
  //                           Statusvaue2="Approved";
  //                         });
  //                         _applieddocumentupdate(docid);
  //                         Navigator.pop(context);
  //                       },
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: Container(
  //                             height:50,
  //                             width: double.infinity,
  //                             decoration:  BoxDecoration(
  //                                 color: Colors.indigo.shade300,
  //                                 borderRadius: BorderRadius.circular(8)
  //                             ),
  //                             child: Center(child: Text("Approved",style: GoogleFonts.poppins(fontWeight: FontWeight.w700,color: Colors.white),))),
  //                       ),
  //                     ),
  //                     GestureDetector(
  //                       onTap: (){
  //                         setState((){
  //                           Statusvaue2="Pending";
  //                         });
  //                         _applieddocumentupdate(docid);
  //                         Navigator.pop(context);
  //                       },
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: Container(
  //                             height:50,
  //                             width: double.infinity,
  //                             decoration:  BoxDecoration(
  //                                 color: Colors.indigo.shade300,
  //                                 borderRadius: BorderRadius.circular(8)
  //                             ),
  //                             child: Center(child: Text("Pending",style: GoogleFonts.poppins(fontWeight: FontWeight.w700,color: Colors.white),))),
  //                       ),
  //                     ),
  //                     GestureDetector(
  //                       onTap: (){
  //                         setState((){
  //                           Statusvaue2="Rejected";
  //                         });
  //                         _applieddocumentupdate(docid);
  //                         Navigator.pop(context);
  //                       },
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: Container(
  //                             height:50,
  //                             width: double.infinity,
  //                             decoration:  BoxDecoration(
  //                                 color: Colors.indigo.shade300,
  //                                 borderRadius: BorderRadius.circular(8)
  //                             ),
  //                             child: Center(child: Text("Rejected",style: GoogleFonts.poppins(fontWeight: FontWeight.w700,color: Colors.white),))),
  //                       ),
  //                     ),
  //
  //                   ],
  //                 ),
  //               );
  //           }
  //       ),
  //     );
  //   },);
  // }
  //
  // _applieddocumentupdate(docid){
  //   FirebaseFirestore.instance.collection("Users").doc(Userdocuid).collection("Histroy").doc(docid).update({
  //     "updatestatus":Statusvaue2,
  //   });
  //   setState((){});
  // }
  //



}
