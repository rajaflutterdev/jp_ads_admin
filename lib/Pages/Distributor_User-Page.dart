
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart'as http;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as ex;
import 'package:universal_html/html.dart' as html;
import 'package:universal_html/html.dart'  show AnchorElement;
import 'package:flutter/foundation.dart'  show kIsWeb;
import 'package:open_file/open_file.dart';


class Distributor_data_Page extends StatefulWidget {


  @override
  State<Distributor_data_Page> createState() => _Distributor_data_PageState();
}

class _Distributor_data_PageState extends State<Distributor_data_Page> with SingleTickerProviderStateMixin {
  int isviewcollection=0;
  String Userdocuid='';

  int viewhistroy=0;
  int documentcount=0;

  TabController?tabController;
  int selectTabIndex=0;

  @override
  void initState() {
    tabController=TabController(length: 3, vsync: this)  ;
    usertyprfunc();
    // TODO: implement initState
    super.initState();
  }



  int totalApliedcount=0;
  usertyprfunc()async{
    setState((){
      totalApliedcount=0;
    });
    var data =await FirebaseFirestore.instance.collection("Users").
    where('usertype',isEqualTo:'Distributor').get();

    for(int i=0;i<data.docs.length;i++){
      var data2 =await FirebaseFirestore.instance.collection("Users").doc(data.docs[i].id).
      collection("Histroy").where('count',isEqualTo:true).get();
      setState((){
        totalApliedcount= data2.docs.length;
      });

    }
    print(totalApliedcount);


  }

  TextEditingController Serachcontroller=TextEditingController();
  TextEditingController Datecontroller=TextEditingController();
  String filterName="All";


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
      Padding(
        padding:  EdgeInsets.only(left:width/136.6),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.only(left: width / 75.77,right:  width / 25.77,
                    top: height/61.43),
                child: Row(
                  children: [
                    isviewcollection==1?  GestureDetector(
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
                          child:  SizedBox(
                              height: height/21.7,
                              width: 30,
                              child: Icon(Icons.arrow_back,color: Colors.white,)),
                        )):SizedBox(),
                    const SizedBox(width: 10,),

                    Text(
                      "Distributor List ",
                      style: GoogleFonts.poppins(
                          fontSize: width / 57.57,
                          color: const Color(0xff000000)),
                    ),
                    const SizedBox(width:10),

                    totalApliedcount==0?const SizedBox():
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.green
                        ),
                        padding: EdgeInsets.all(2),
                        child: Text(" New  -${totalApliedcount.toString()} ",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w700,color:Colors.white),)),




                  ],
                ),
              ),
              SizedBox(height: height/41.143,),
              Container(
                width:1100,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color:Colors.blue,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Row(
                  children: [
                    Container(
                      width: width / 4.902,
                      height: height / 16.42,
                      //color: Color(0xff00A99D),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color:  Colors.white,
                      ),
                      child:
                      Padding(
                        padding:  EdgeInsets.only(left:8),
                        child: TextField(
                          controller: Serachcontroller,
                          style: GoogleFonts.poppins(fontSize: width / 88.3,fontWeight: FontWeight.w600,color: Colors.black),
                          decoration: InputDecoration(
                              hintText: "Search here",
                              helperStyle:GoogleFonts.poppins(fontSize: width / 88.3,fontWeight: FontWeight.w600,color: Colors.black),
                              border: InputBorder.none,
                              suffixIcon: const Icon(
                                Icons.search_outlined,
                                color: Colors.black,
                              )
                          ),
                          onChanged: (value){
                            if(value.isNotEmpty){
                              setState(() {
                                filterName=value;
                              });
                            }
                            else{
                              setState(() {
                                filterName="All";
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 15,),



                    ///Sorts by Date
                    SizedBox(
                      height: height/16.275,
                      width:300,

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: height/16.275,
                              child: Center(child: Text("Sort By Date : ",
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w700,color:Colors.white),))),
                          SizedBox(width: 5,),
                          Container(
                            width: width/7.5888,
                            height: height/16.275,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: TextField(
                              controller: Datecontroller,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    bottom: width / 90.6, left: width / 91.06),
                                hintText: "d/mm/yyyy",
                                hintStyle:  GoogleFonts.openSans(color: Color(0xff00A99D)),
                                border: InputBorder.none,
                              ),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime.now());

                                if (pickedDate != null) {
                                  //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                  DateFormat('d/M/yyyy').format(pickedDate);
                                  setState(() {
                                    Datecontroller.text=formattedDate;
                                    filterName=formattedDate;
                                  });
                                  //formatted date output using intl package =>  2021-03-16
                                }
                              },
                            ),

                          ),

                        ],
                      ),
                    ),
                    SizedBox(width: 10,),

                    InkWell(
                      onTap:(){
                        setState(() {
                          Serachcontroller.clear();
                          Datecontroller.clear();
                          filterName="All";

                        });},
                      child: Container(
                          height: height/16.275,
                          width: width/9.66,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child:Center(child: Text("Clear",style: GoogleFonts.poppins(fontWeight: FontWeight.w600),))
                      ),
                    ),

                    SizedBox(width:30),

                    InkWell(
                      onTap:(){
                        createExcel("Distributor");
                      },
                      child:
                      Container(
                          height: height/16.275,
                          width: width/9.66,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.document_scanner_rounded,color:Colors.white,   size:width/55.888,),
                              SizedBox(width:width/273.2),
                              Text("Print Excel",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color:Colors.white),),
                            ],
                          )
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: height/41.143,),

              isviewcollection==0?
              SizedBox(
                height: height/1.085,
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          Column(
                            children: [

                              Row(

                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [


                                  Container(
                                    width: 300,
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
                                    width: 200,
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
                                stream: FirebaseFirestore.instance.collection("Users").orderBy('timestamp').snapshots(),
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

                                        if(_Userdata['usertype']=='Distributor'){

                                          if((_Userdata['name'].toString().toLowerCase().contains(filterName.toString().toLowerCase()))||(_Userdata['date']==filterName)){
                                            return Row(

                                              crossAxisAlignment: CrossAxisAlignment.center,


                                              children: [



                                                Container(
                                                  width: 300,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: Colors.black)
                                                  ),
                                                  child: Center(
                                                    child:
                                                    Text(
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
                                                  width: 200,
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
                                                            width: width/13.66,
                                                            height: height/21.7,
                                                            decoration: BoxDecoration(
                                                                color: Colors.green,
                                                                borderRadius: BorderRadius.circular(8)
                                                            ),
                                                            child: Center(child: const Text("View User",style: TextStyle(color: Colors.white),))
                                                        ),
                                                      ),
                                                      // InkWell(
                                                      //   onTap: (){
                                                      //     ///delete popup
                                                      //     _deletepopup(_Userdata.id);
                                                      //   },
                                                      //   child: SizedBox(
                                                      //       width: 40,
                                                      //       height: 40,
                                                      //       child: Center(child: const Icon(Icons.delete))
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                ),






                                              ],
                                            );
                                          }
                                          if(filterName=="All"){
                                            return Row(

                                              crossAxisAlignment: CrossAxisAlignment.center,


                                              children: [



                                                Container(
                                                  width: 300,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: Colors.black)
                                                  ),
                                                  child: Center(
                                                    child:
                                                    Text(
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
                                                  width: 200,
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
                                                            width: width/13.66,
                                                            height: height/21.7,
                                                            decoration: BoxDecoration(
                                                                color: Colors.green,
                                                                borderRadius: BorderRadius.circular(8)
                                                            ),
                                                            child: Center(child: const Text("View User",style: TextStyle(color: Colors.white),))
                                                        ),
                                                      ),
                                                      // InkWell(
                                                      //   onTap: (){
                                                      //     ///delete popup
                                                      //     _deletepopup(_Userdata.id);
                                                      //   },
                                                      //   child: SizedBox(
                                                      //       width: 40,
                                                      //       height: 40,
                                                      //       child: Center(child: const Icon(Icons.delete))
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                ),






                                              ],
                                            );
                                          }
                                        }
                                        return const SizedBox();

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
                  height: height/1.085,
                  child:
                  SingleChildScrollView(
                    physics:const  ScrollPhysics(),
                    child: Column(
                      children: [

                        Container(
                          height:100,
                          width:1100,
                          margin: EdgeInsets.only(left: 8,right: 8),
                          padding: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color:Color(0xffd8e6ff),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              )
                          ),
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
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              child:
                              TabBar(
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
                                    child:  const Text("Wallet"),
                                  ),
                                  Tab(
                                    child: const Text("Correction"),
                                  ),
                                  Tab(
                                    child: const Text("Applied"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 430,
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              SizedBox(
                                height: 580,
                                width:1100,
                                child: SingleChildScrollView(
                                  physics: const ScrollPhysics(),
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
                                            width: 190,
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
                                            width: 190,
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

                                          // Container(
                                          //   width: 200,
                                          //   height: 40,
                                          //   decoration: BoxDecoration(
                                          //       border: Border.all(color: Colors.black)
                                          //   ),
                                          //   child: Center(
                                          //     child: Text(
                                          //       "Actions",
                                          //       style:
                                          //       GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                          //     ),
                                          //   ),
                                          // ),






                                        ],
                                      ),
                                      StreamBuilder(
                                        stream: FirebaseFirestore.instance.collection("Users").
                                        doc(Userdocuid).collection("Wallet_Histroy").orderBy('timestamp').snapshots(),
                                        builder: (context, snapshot) {

                                          if(snapshot.hasData==null){
                                            return const Center(child: CircularProgressIndicator(),);
                                          }
                                          if(!snapshot.hasData){
                                            return const Center(child: CircularProgressIndicator(),);
                                          }

                                          return ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: snapshot.data!.docs.length,
                                            itemBuilder: (context, index) {

                                              var applieddata=snapshot.data!.docs[index];
                                              return
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
                                                          applieddata['Amount'].toString(),
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
                                                      child: Center(
                                                        child: Text(
                                                          applieddata['date'].toString(),
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
                                                      child: Center(
                                                        child: Text(
                                                          applieddata['time'].toString(),
                                                          textAlign: TextAlign.center,
                                                          style:
                                                          GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                        ),
                                                      ),
                                                    ),

                                                    // Container(
                                                    //   width: 200,
                                                    //   height: 40,
                                                    //   decoration: BoxDecoration(
                                                    //       border: Border.all(color: Colors.black)
                                                    //   ),
                                                    //   child: InkWell(
                                                    //     onTap: (){
                                                    //       ///delete popup
                                                    //       _deleteWalletpopup(applieddata.id);
                                                    //     },
                                                    //     child: SizedBox(
                                                    //         width: 60,
                                                    //         height: 40,
                                                    //         child: Center(child: const Icon(Icons.delete))
                                                    //     ),
                                                    //   ),
                                                    // ),






                                                  ],
                                                );
                                            },);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 580,
                                width:1100,
                                child: SingleChildScrollView(
                                  physics: const ScrollPhysics(),
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
                                                "Gender",
                                                style:
                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                          ),

                                          Container(
                                            width: width/13.66,
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
                                            width: width/13.66,
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
                                            width: width/13.66,
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

                                          Container(
                                            width: 200,
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
                                      FutureBuilder(
                                        future: FirebaseFirestore.instance.collection("Users").
                                        doc(Userdocuid).collection("Histroy").where("Type",isEqualTo:"Correction").get(),
                                        builder: (context, snapshot) {

                                          if(snapshot.hasData==null){
                                            return const Center(child: CircularProgressIndicator(),);
                                          }
                                          if(!snapshot.hasData){
                                            return const Center(child: CircularProgressIndicator(),);
                                          }

                                          return ListView.builder(
                                            shrinkWrap: true,
                                            physics:const  NeverScrollableScrollPhysics(),
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
                                                    width: 150,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        applieddata['crtphonenumber'].toString(),
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
                                                        applieddata['crgender'].toString(),
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: width/13.66,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        applieddata['updatestatus'].toString()==""?"-":   applieddata['updatestatus'].toString(),
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: Colors.indigo,fontWeight:FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: width/13.66,
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

                                                  Container(
                                                    width: width/13.66,
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

                                                  Container(
                                                    width: 200,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        InkWell(
                                                          onTap: (){
                                                            detailspopup(
                                                              applieddata['Crtname'].toString(),
                                                              applieddata['crtfathername'].toString(),
                                                              applieddata['crtphonenumber'].toString(),
                                                              applieddata['crgender'].toString(),
                                                              applieddata['crtdate_of_birth'].toString(),
                                                              applieddata['pancardno'].toString(),
                                                              applieddata['crtnameandbuildsno'].toString(),
                                                              applieddata['crtnadddress'].toString(),
                                                              applieddata['crtdistrict'].toString(),
                                                              applieddata['crtstate'].toString(),
                                                              applieddata['date'].toString(),
                                                              applieddata['time'].toString(),
                                                              applieddata['updatestatus'].toString(),
                                                              applieddata['correctionupdate'].toString(),
                                                              applieddata['Type'].toString(),
                                                              applieddata['crtpincode'].toString(),
                                                              applieddata.id.toString(),
                                                            );
                                                          },
                                                          child: Container(
                                                              width: width/13.66,
                                                              height: height/21.7,
                                                              decoration: BoxDecoration(
                                                                  color: Colors.green,
                                                                  borderRadius: BorderRadius.circular(8)
                                                              ),
                                                              child: Center(child: const Text("View",style: TextStyle(color: Colors.white),))
                                                          ),
                                                        ),
                                                        // InkWell(
                                                        //   onTap: (){
                                                        //     ///delete popup
                                                        //     _deleteHistroypopup(applieddata.id);
                                                        //   },
                                                        //   child: SizedBox(
                                                        //       width: 40,
                                                        //       height: 40,
                                                        //       child: Center(child: const Icon(Icons.delete))
                                                        //   ),
                                                        // ),
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

                              SizedBox(
                                height: 580,
                                width:1100,
                                child: SingleChildScrollView(
                                  physics: const ScrollPhysics(),
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
                                            width: width/13.66,
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
                                            width: width/13.66,
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
                                            width: width/13.66,
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
                                            width: 150,
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

                                          Container(
                                            width: 200,
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
                                      FutureBuilder(
                                        future: FirebaseFirestore.instance.collection("Users").doc(Userdocuid).collection("Histroy").where("Type",isEqualTo:"Applied").get(),
                                        builder: (context, snapshot) {

                                          if(snapshot.hasData==null){
                                            return const Center(child: CircularProgressIndicator(),);
                                          }
                                          if(!snapshot.hasData){
                                            return const Center(child: CircularProgressIndicator(),);
                                          }

                                          return ListView.builder(
                                            shrinkWrap: true,
                                            physics: const ScrollPhysics(),
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
                                                    width: 150,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        applieddata['father name'].toString(),
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: width/13.66,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        applieddata['updatestatus'].toString()==""?"-":   applieddata['updatestatus'].toString(),
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color:  Colors.green,fontWeight:FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: width/13.66,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        applieddata['Type'].toString(),
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color:  Colors.green,fontWeight:FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    width: width/13.66,
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
                                                    width: 150,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.black)
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "${ applieddata['time'].toString()}",
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
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        InkWell(
                                                          onTap: (){
                                                            Applieddetailspopup(
                                                              applieddata['name'].toString(),
                                                              applieddata['father name'].toString(),
                                                              applieddata['gender'].toString(),
                                                              applieddata['dob'].toString(),
                                                              applieddata['pantype'].toString(),
                                                              applieddata['updatestatus'].toString(),
                                                              applieddata['date'].toString(),
                                                              applieddata['time'].toString(),
                                                              applieddata['Type'].toString(),
                                                              applieddata['aadharpicture'].toString(),
                                                              applieddata['signpicture'].toString(),
                                                              applieddata['photo'].toString(),
                                                              applieddata['photo2'].toString(),
                                                              applieddata['aadharpicture2'].toString(),
                                                            );
                                                          },
                                                          child: Container(
                                                              width: width/13.66,
                                                              height: height/21.7,
                                                              decoration: BoxDecoration(
                                                                  color: Colors.green,
                                                                  borderRadius: BorderRadius.circular(8)
                                                              ),
                                                              child: Center(child: const Text("View",style: TextStyle(color: Colors.white),))
                                                          ),
                                                        ),
                                                        // InkWell(
                                                        //   onTap: (){
                                                        //     ///delete popup
                                                        //     _deleteHistroypopup(applieddata.id);
                                                        //   },
                                                        //   child: SizedBox(
                                                        //       width: 60,
                                                        //       height: 40,
                                                        //       child: Center(child: const Icon(Icons.delete))
                                                        //   ),
                                                        // ),
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

    double height =MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;

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
                  width: width/7.5888,
                  child: Lottie.network(deletefile),
                ),

                const SizedBox(height:20),

                InkWell(
                  onTap: (){
                    deletedocument(docid);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: height/16.275,
                    width: width/7.5888,
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


  ///deleter document histroy
  _deleteHistroypopup(docid){
    double height =MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;
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
                  width: width/7.5888,
                  child: Lottie.network(deletefile),
                ),

                const SizedBox(height:20),

                InkWell(
                  onTap: (){
                    deletedocumentHistroy(docid);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: height/16.275,
                    width: width/7.5888,
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

  deletedocumentHistroy(id){
    FirebaseFirestore.instance.collection("Users").
    doc(Userdocuid).collection("Histroy").doc(id).delete();
  }


  ///deleter document histroy
  _deleteWalletpopup(docid){

    double height =MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;
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
                  width: width/7.5888,
                  child: Lottie.network(deletefile),
                ),

                const SizedBox(height:20),

                InkWell(
                  onTap: (){
                    deletedocumentWallet(docid);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: height/16.275,
                    width: width/7.5888,
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

  deletedocumentWallet(id){
    FirebaseFirestore.instance.collection("Users").doc(Userdocuid).collection("Wallet_Histroy").doc(id).delete();
  }

  detailspopup(name,fathermname,phonenumber,gender,dob,panno,namebuildno,address,district,state,date,time,status,correctionlist,type,pincode,docid)
  {
    double height = MediaQuery.of(context).size.height;
    double  width = MediaQuery.of(context).size.width;

    return showDialog(context: context, builder: (context) {
      return  Padding(
        padding:  EdgeInsets.only(left: 300,right: 300,top: 40,bottom: 40),
        child: Material(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white54.withOpacity(0.9),
          elevation: 10,
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.easeIn,
            height: height/1.085,
            width: width/4.268,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white54.withOpacity(0.9),
            ),
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height/43.4,),
                  Text("Correction Details",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          textStyle: TextStyle(
                              decoration: TextDecoration.underline,
                              overflow: TextOverflow.ellipsis
                          ),
                          color: Colors.black)),
                  SizedBox(height: height/43.4,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: height/21.7,
                          width: width/4.878,
                          child:
                          Text("Name : ${name}",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  textStyle: TextStyle(
                                      overflow: TextOverflow.ellipsis
                                  ),
                                  color: Colors.black))),
                      Container(
                          height: height/21.7,
                          width: width/4.878,
                          child: Text("Father Name : ${fathermname}",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  textStyle: TextStyle(
                                      overflow: TextOverflow.ellipsis
                                  ),
                                  color: Colors.black))),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: height/21.7,
                          width: width/4.878,
                          child: Text("Phone no: ${phonenumber}",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              textStyle: TextStyle(
                                  overflow: TextOverflow.ellipsis
                              ),
                              color: Colors.black))),
                      Container(
                          height: height/21.7,
                          width: width/4.878,
                          child: Text("Gender: ${gender}",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              textStyle: TextStyle(
                                  overflow: TextOverflow.ellipsis
                              ),
                              color: Colors.black))),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: height/21.7,
                          width: width/4.878,
                          child: Text("DOB: ${dob}",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              textStyle: TextStyle(
                                  overflow: TextOverflow.ellipsis
                              ),
                              color: Colors.black))),
                      Container(
                          height: height/21.7,
                          width: width/4.878,
                          child: Text("Type: ${type}",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              textStyle: TextStyle(
                                  overflow: TextOverflow.ellipsis
                              ),
                              color: Colors.black))),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: height/21.7,
                          width: width/4.878,
                          child: Text("Pan No: ${panno}",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              textStyle: TextStyle(
                                  overflow: TextOverflow.ellipsis
                              ),
                              color: Colors.black))),
                      Container(
                          height: height/21.7,
                          width: width/4.878,
                          child: Text("Name/Building No: ${namebuildno}",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              textStyle: TextStyle(
                                  overflow: TextOverflow.ellipsis
                              ),
                              color: Colors.black))),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: height/21.7,
                          width: width/4.878,
                          child: Text("Address: ${address}",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              textStyle: TextStyle(
                                  overflow: TextOverflow.ellipsis
                              ),
                              color: Colors.black))),
                      Container(
                          height: height/21.7,
                          width: width/4.878,
                          child: Text("District: ${district}",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              textStyle: TextStyle(
                                  overflow: TextOverflow.ellipsis
                              ),
                              color: Colors.black))),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: height/21.7,
                          width: width/4.878,
                          child: Text("State: ${state}",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              textStyle: TextStyle(
                                  overflow: TextOverflow.ellipsis
                              ),
                              color: Colors.black))),
                      Container(
                          height: height/21.7,
                          width: width/4.878,
                          child: Text("Pin Code: ${pincode}",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              textStyle: TextStyle(
                                  overflow: TextOverflow.ellipsis
                              ),
                              color: Colors.black))),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: height/21.7,
                          width: width/4.878,
                          child: Text("Date/Time: ${date}-${time}",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              textStyle: TextStyle(
                                  overflow: TextOverflow.ellipsis
                              ),
                              color: Colors.black))),
                      Container(
                          height: height/21.7,
                          width: width/4.878,
                          child: Text("Status: ${status==""?"-":status}",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              textStyle: TextStyle(
                                  overflow: TextOverflow.ellipsis
                              ),
                              color: Colors.black))),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 560,

                          child: Text("Correction List:  ${correctionlist.toString()}",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,

                                  color: Colors.black))),
                    ],
                  ),
                  SizedBox(height: height/21.7,),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: width/13.66,
                      decoration: BoxDecoration(
                          color: Color(0xff263646),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child:Center(
                        child: Text("Okay",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500,
                              fontSize:width/82,
                              color: Colors.white),),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },);
  }


  Applieddetailspopup(name,fathername,gender,dob,pantype,updatestatus,date,time,type,aadharpicture,signpicture,photo,photo2,aadharpicture2){

    double height = MediaQuery.of(context).size.height;
    double  width = MediaQuery.of(context).size.width;

    return showDialog(context: context, builder: (context) {
      return  Padding(
        padding:  EdgeInsets.only(left: 300,right: 300,top: 50,bottom: 50),
        child: Material(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white54.withOpacity(0.9),
          elevation: 10,
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.easeIn,
            height: 400,
            width: width/4.268,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white54.withOpacity(0.9),
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 5,),
                Text("Applied Details",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        textStyle: TextStyle(
                            decoration: TextDecoration.underline,
                            overflow: TextOverflow.ellipsis
                        ),
                        color: Colors.black)),
                SizedBox(height: 5,),
                Container(
                    height: height/21.7,
                    width: 400,
                    child:
                    Text("Name : ${name}",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            textStyle: TextStyle(
                                overflow: TextOverflow.ellipsis
                            ),
                            color: Colors.black))),
                Container(
                    height: height/21.7,
                    width: 400,
                    child: Text("Father Name : ${fathername}",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            textStyle: TextStyle(
                                overflow: TextOverflow.ellipsis
                            ),
                            color: Colors.black))),

                Container(
                    height: height/21.7,
                    width: 400,
                    child: Text("Date/Time: ${date}-${time}",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis
                        ),
                        color: Colors.black))),
                Container(
                    height: height/21.7,
                    width: 400,
                    child: Text("Gender: ${gender}",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis
                        ),
                        color: Colors.black))),
                Container(
                    height: height/21.7,
                    width: 400,
                    child: Text("DOB: ${dob}",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis
                        ),
                        color: Colors.black))),
                Container(
                    height: height/21.7,
                    width: 400,
                    child: Text("Pantype: ${pantype}",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis
                        ),
                        color: Colors.black))),
                Container(
                    height: height/21.7,
                    width: 400,
                    child: Text("Status: ${updatestatus==""?"-":updatestatus}",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis
                        ),
                        color: Colors.black))),
                Container(
                    height: height/21.7,
                    width: 400,
                    child: Text("Date/Time: ${date}-${time}",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis
                        ),
                        color: Colors.black))),
                Container(
                    height: height/21.7,
                    width: 400,
                    child: Text("Type: ${type}",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis
                        ),
                        color: Colors.black))),
                SizedBox(height: height/21.7,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: (){
                        _ViewImage(aadharpicture);
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            height: height/6.51,
                            width: width/13.66,
                            decoration: BoxDecoration(
                                color: Color(0xff263646),
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: NetworkImage(aadharpicture)
                                )
                            ),
                          ),
                          InkWell(
                            onTap: ()=>downloadImage(aadharpicture),
                            child: Material(
                              elevation: 10,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              child: SizedBox(
                                  height:30,
                                  width: 30,
                                  child: Icon(Icons.download,color: Colors.black,)),
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        _ViewImage(aadharpicture2);
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            height: height/6.51,
                            width: width/13.66,
                            decoration: BoxDecoration(
                                color: Color(0xff263646),
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: NetworkImage(aadharpicture2)
                                )
                            ),
                          ),
                          InkWell(
                            onTap: ()=>downloadImage(aadharpicture2),
                            child: Material(
                              elevation: 10,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              child: SizedBox(
                                  height:30,
                                  width: 30,
                                  child: Icon(Icons.download,color: Colors.black,)),
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        _ViewImage(signpicture);
                      },
                      child: Stack(
                        alignment:Alignment.bottomRight ,
                        children: [
                          Container(
                            height: height/6.51,
                            width: width/13.66,
                            decoration: BoxDecoration(
                                color: Color(0xff263646),
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: NetworkImage(signpicture)
                                )
                            ),
                          ),
                          InkWell(
                            onTap: ()=>downloadImage(signpicture),
                            child: Material(
                              elevation: 10,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              child: SizedBox(
                                  height:30,
                                  width: 30,
                                  child: Icon(Icons.download,color: Colors.black,)),
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        _ViewImage(photo);
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            height: height/6.51,
                            width: width/13.66,
                            decoration: BoxDecoration(
                                color: Color(0xff263646),
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: NetworkImage(photo)
                                )
                            ),
                          ),
                          InkWell(
                            onTap: ()=>downloadImage(photo),
                            child: Material(
                              elevation: 10,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              child: SizedBox(
                                  height:30,
                                  width: 30,
                                  child: Icon(Icons.download,color: Colors.black,)),
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        _ViewImage(photo2);
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            height: height/6.51,
                            width: width/13.66,
                            decoration: BoxDecoration(
                                color: Color(0xff263646),
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: NetworkImage(photo2)
                                )
                            ),
                          ),
                          InkWell(
                            onTap: ()=>downloadImage(photo2),
                            child: Material(
                              elevation: 10,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              child: SizedBox(
                                  height:30,
                                  width: 30,
                                  child: Icon(Icons.download,color: Colors.black,)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height/21.7,),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(height: height/21.7,
                    width: width/13.66,
                    decoration: BoxDecoration(
                        color: Color(0xff263646),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child:Center(
                      child: Text("Okay",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500,
                            fontSize:width/82,
                            color: Colors.white),),
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


  _ViewImage(ImageLink){
    double height =MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;

    showDialog(context: context, builder:(context) {
      return Padding(
        padding: const EdgeInsets.only(top: 60,bottom: 60,left: 350,right:350),
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: Center(
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height:20),
                  Text("View Image",style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize:18
                  ),),
                  SizedBox(height: 20,),

                  SizedBox(
                    height:380,
                    width: 400,
                    child: Image.network(ImageLink,fit: BoxFit.contain,),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: height/16.275,
                      width: width/7.5888,
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
              )
          ),
        ),
      );
    },);
  }

  downloadImage(String imageUrl) async {

    try {
      // first we make a request to the url like you did
      // in the android and ios version
      final http.Response r = await http.get(
        Uri.parse(imageUrl),
      );

      // we get the bytes from the body
      final data = r.bodyBytes;
      // and encode them to base64
      final base64data = base64Encode(data);

      // then we create and AnchorElement with the html package
      final a = html.AnchorElement(href: 'data:image/jpeg;base64,$base64data');

      // set the name of the file we want the image to get
      // downloaded to
      a.download = 'download.jpg';

      // and we click the AnchorElement which downloads the image
      a.click();
      // finally we remove the AnchorElement
      a.remove();
    } catch (e) {
      print(e);
    }
  }

  createExcel(Usertype)async{

    final ex.Workbook workbook = ex.Workbook();
    final ex.Worksheet sheet   = workbook.worksheets[0];


    sheet.getRangeByName("A1").setText("Name");
    sheet.getRangeByName("B1").setText("Phone");
    sheet.getRangeByName("C1").setText("Wallet Amount");
    sheet.getRangeByName("D1").setText("Payment");
    sheet.getRangeByName("E1").setText("Applied count");
    // sheet.getRangeByName("F1").setText("Academic Year");
    // sheet.getRangeByName("G1").setText("Blood Group");
    // sheet.getRangeByName("H1").setText("Date of Birth");
    // sheet.getRangeByName("I1").setText("Gender");
    // sheet.getRangeByName("J1").setText("Address");
    // sheet.getRangeByName("K1").setText("Community");
    // sheet.getRangeByName("L1").setText("House");
    // sheet.getRangeByName("M1").setText("Religion");
    // sheet.getRangeByName("N1").setText("Mobile");
    // sheet.getRangeByName("O1").setText("Email");
    // sheet.getRangeByName("P1").setText("Aadhaar No");
    // sheet.getRangeByName("Q1").setText("Height (CMS)");
    // sheet.getRangeByName("R1").setText("Weight (KG)");
    // sheet.getRangeByName("S1").setText("EMIS");
    // sheet.getRangeByName("T1").setText("Transport");
    // sheet.getRangeByName("U1").setText("Father Name");
    // sheet.getRangeByName("V1").setText("Father Occupation");
    // sheet.getRangeByName("W1").setText("Father Office");
    // sheet.getRangeByName("X1").setText("Father Mobile");
    // sheet.getRangeByName("Y1").setText("Father Email");
    // sheet.getRangeByName("Z1").setText("Father Aadhaar");
    //
    // sheet.getRangeByName("AA1").setText("Mother Name");
    // sheet.getRangeByName("AB1").setText("Mother Occupation");
    // sheet.getRangeByName("AC1").setText("Mother Office");
    // sheet.getRangeByName("AD1").setText("Mother Mobile");
    // sheet.getRangeByName("AE1").setText("Mother Email");
    // sheet.getRangeByName("AF1").setText("Mother Aadhaar");
    //
    // sheet.getRangeByName("AG1").setText("Guardian Name");
    // sheet.getRangeByName("AH1").setText("Guardian Occupation");
    // sheet.getRangeByName("AI1").setText("Guardian Mobile");
    // sheet.getRangeByName("AJ1").setText("Guardian Email");
    // sheet.getRangeByName("AK1").setText("Guardian Aadhaar");
    // sheet.getRangeByName("AL1").setText("Brother Studying Here");
    // sheet.getRangeByName("AM1").setText("Brother Name");

    var Data=await FirebaseFirestore.instance.collection("Users").where("usertype",isEqualTo: Usertype).get();

    for(int i=0;i<Data.docs.length;i++){
      sheet.getRangeByName("A${i + 2}").setText(Data.docs[i]['name'].toString());
      sheet.getRangeByName("B${i + 2}").setText(Data.docs[i]['phone'].toString());
      sheet.getRangeByName("C${i + 2}").setText(Data.docs[i]['walletamount'].toString());
      sheet.getRangeByName("D${i + 2}").setText(Data.docs[i]['payment'].toString());
      sheet.getRangeByName("E${i + 2}").setText(Data.docs[i]['usageccount'].toString());
      // sheet.getRangeByName("F${i + 2}").setText(widget.studentData[i].academicYear);
      // sheet.getRangeByName("G${i + 2}").setText(widget.studentData[i].bloodGroup);
      // sheet.getRangeByName("H${i + 2}").setText(widget.studentData[i].dob);
      // sheet.getRangeByName("I${i + 2}").setText(widget.studentData[i].gender);
      // sheet.getRangeByName("J${i + 2}").setText(widget.studentData[i].address);
      // sheet.getRangeByName("K${i + 2}").setText(widget.studentData[i].community);
      // sheet.getRangeByName("L${i + 2}").setText(widget.studentData[i].house);
      // sheet.getRangeByName("M${i + 2}").setText(widget.studentData[i].religion);
      // sheet.getRangeByName("N${i + 2}").setText(widget.studentData[i].phone);
      // sheet.getRangeByName("O${i + 2}").setText(widget.studentData[i].email);
      // sheet.getRangeByName("P${i + 2}").setText(widget.studentData[i].aadhaarNumber);
      // sheet.getRangeByName("Q${i + 2}").setText(widget.studentData[i].height);
      // sheet.getRangeByName("R${i + 2}").setText(widget.studentData[i].weight);
      // sheet.getRangeByName("S${i + 2}").setText(widget.studentData[i].emiNo);
      // sheet.getRangeByName("T${i + 2}").setText(widget.studentData[i].modeOfTransport);
      // sheet.getRangeByName("U${i + 2}").setText(widget.studentData[i].fatherName);
      // sheet.getRangeByName("V${i + 2}").setText(widget.studentData[i].fatherOccupation);
      // sheet.getRangeByName("W${i + 2}").setText(widget.studentData[i].fatherOfficeAddress);
      // sheet.getRangeByName("X${i + 2}").setText(widget.studentData[i].fatherPhone);
      // sheet.getRangeByName("Y${i + 2}").setText(widget.studentData[i].fatherEmail);
      // sheet.getRangeByName("Z${i + 2}").setText(widget.studentData[i].fatherAadhaar);
      //
      // sheet.getRangeByName("AA${i + 2}").setText(widget.studentData[i].motherName);
      // sheet.getRangeByName("AB${i + 2}").setText(widget.studentData[i].motherOccupation);
      // sheet.getRangeByName("AC${i + 2}").setText(widget.studentData[i].motherOffice);
      // sheet.getRangeByName("AD${i + 2}").setText(widget.studentData[i].motherPhone);
      // sheet.getRangeByName("AE${i + 2}").setText(widget.studentData[i].motherEmail);
      // sheet.getRangeByName("AF${i + 2}").setText(widget.studentData[i].motherAadhaar);
      // sheet.getRangeByName("AG${i + 2}").setText(widget.studentData[i].guardianName);
      // sheet.getRangeByName("AH${i + 2}").setText(widget.studentData[i].guardianOccupation);
      // sheet.getRangeByName("AI${i + 2}").setText(widget.studentData[i].guardianPhone);
      // sheet.getRangeByName("AJ${i + 2}").setText(widget.studentData[i].guardianEmail);
      // sheet.getRangeByName("AK${i + 2}").setText(widget.studentData[i].guardianAadhaar);
      // sheet.getRangeByName("AL${i + 2}").setText(widget.studentData[i].brotherStudyingHere);
      // sheet.getRangeByName("AM${i + 2}").setText(widget.studentData[i].brotherName);
    }


    final List<int>bytes = workbook.saveAsStream();
    workbook.dispose();

    if(kIsWeb){
      AnchorElement(href: 'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
        ..setAttribute('download', 'Output.xlsx')
        ..click();
    }else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName = Platform.isWindows?'$path\\Student Data.xlsx':"$path/Student Data.xlsx";
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
  }



}
