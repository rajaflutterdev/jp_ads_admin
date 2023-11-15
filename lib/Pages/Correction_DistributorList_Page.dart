import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class Corretion_List_Page extends StatefulWidget {
  const Corretion_List_Page({super.key});

  @override
  State<Corretion_List_Page> createState() => _Corretion_List_PageState();
}

class _Corretion_List_PageState extends State<Corretion_List_Page> {


  List<String> StuatusList=[];
  String filterName='';
  int totalApliedcount=0;
  String selectedValue='Select';
  String selectedValue2='Select';

  TextEditingController Serachcontroller=TextEditingController();
  TextEditingController Datecontroller=TextEditingController();

  statusaddfunc()async{
    setState((){
      StuatusList.clear();
      filterName="All";
      totalApliedcount=0;
    });
    setState(() {
      StuatusList.add("Select");
    });

    var statusdata=await FirebaseFirestore.instance.collection("Status").orderBy('name').get();
    for(int i=0;i<statusdata.docs.length;i++){
      setState(() {
        StuatusList.add(statusdata.docs[i]['name']);
      });
    }


    print(StuatusList);

  }

  countfunction()async{
    var data2 =await FirebaseFirestore.instance.collection("Correction_cards").
    where('usertype',isEqualTo:"Distributor").where('count',isEqualTo:true).get();
    setState((){
      totalApliedcount= data2.docs.length;
    });

    print(totalApliedcount);

  }

  @override
  void initState() {
    statusaddfunc();
    countfunction();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding:  EdgeInsets.only(left:width/170.75,right: width/170.75),
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Padding(
              padding:  EdgeInsets.only(left: width / 75.77,right:  width / 25.77,
                  top: height/61.43),
              child: Row(
                children: [
                  Text(
                    "Correction Distributor List",
                    style: GoogleFonts.poppins(
                        fontSize: width / 57.57,
                        color: const Color(0xff000000)),
                  ),
                  SizedBox(width:10),

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
              child: Column(
                children: [
                  Row(
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

                      ///Sorts by status container
                      SizedBox(
                        height:40,
                        width:320,

                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                height:40,
                                child: Center(child: Text("Sort By Status : ",style: GoogleFonts.poppins(fontWeight: FontWeight.w700,color:Colors.white),))),
                            SizedBox(width: 5,),
                            Container(
                              width:200,
                              height:40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child:
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(

                                  isDense: true,
                                  hint: Text(
                                    'Select',
                                    style: GoogleFonts.poppins(
                                      fontSize: width/95.714,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),

                                  items: StuatusList
                                      .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style:  GoogleFonts.poppins(
                                          fontSize: width/95.714,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ))
                                      .toList(),
                                  value: selectedValue,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedValue= value!;
                                      filterName=value;
                                    });
                                  },
                                  buttonStyleData:  ButtonStyleData(
                                    padding: EdgeInsets.symmetric(horizontal: width/22.5),
                                    height:50,
                                    width: width/2.571,
                                  ),
                                  menuItemStyleData:  MenuItemStyleData(
                                    height: 50,
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(width: 15,),

                      ///Sorts by Date
                      SizedBox(
                        height:40,
                        width:300,

                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                height:40,
                                child: Center(child: Text("Sort By Date : ",
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.w700,color:Colors.white),))),
                            SizedBox(width: 5,),
                            Container(
                              width:180,
                              height:40,
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


                      InkWell(
                        onTap:(){
                          setState(() {
                            Serachcontroller.clear();
                            Datecontroller.clear();
                            filterName="All";
                            selectedValue="Select";
                            selectedValue2="Select";
                          });},
                        child: Container(
                            height: height/16.275,
                            width: width/9.76,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child:Center(child: Text("Clear",style: GoogleFonts.poppins(fontWeight: FontWeight.w600),))
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height:10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap:(){
                          createExcel("Distributor");
                        },
                        child:  Container(
                            height: height/16.275,
                            width: width/9.76,
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
                      SizedBox(width:width/1366),
                    ],
                  )
                ],
              ),
            ),

            SizedBox(height: height/41.143,),
            SizedBox(
              height: 436,
              width: 1100,
              child:
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color:  const Color(0xffd8e6ff),
                      ),
                      child: Row(

                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [




                          SizedBox(
                            width: 200,
                            height: 40,
                            child: Center(
                              child: Text(
                                "Full Name",
                                style:
                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),

                          SizedBox(
                            width: 200,
                            height: 40,
                            child: Center(
                              child: Text(
                                "Father Name",
                                style:
                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),

                          SizedBox(
                            width: 80,
                            height: 40,
                            child: Center(
                              child: Text(
                                "Gender",
                                style:
                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),

                          SizedBox(
                            width: 150,
                            height: 40,
                            child: Center(
                              child: Text(
                                "Pan Card No",
                                style:
                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),

                          SizedBox(
                            width: 150,
                            height: 40,
                            child: Center(
                              child: Text(
                                "Status",
                                style:
                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),

                          SizedBox(
                            width: 90,
                            height: 40,
                            child: Center(
                              child: Text(
                                "Date",
                                style:
                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),

                          SizedBox(
                            width: 90,
                            height: 40,
                            child: Center(
                              child: Text(
                                "Time",
                                style:
                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),

                          SizedBox(
                            width: 140,
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

                    SizedBox(height:8),

                    StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("Correction_cards").
                      orderBy("timestamp").snapshots(),
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

                              var data=snapshot.data!.docs[index];

                              if(data['usertype']=='Distributor'){

                                if(filterName==data['updatestatus'] ||
                                    data['Crtname'].toString().toLowerCase().contains(filterName.toString().toLowerCase())
                                    ||filterName==data['date']){
                                  return Padding(
                                    padding:  EdgeInsets.only(bottom:8),
                                    child: Material(
                                      color: Color(0xffFFFFFF),
                                      elevation: 20,
                                      borderRadius: BorderRadius.circular(4),
                                      shadowColor: Colors.black12,
                                      child: SizedBox(
                                        height:50,
                                        child: Row(

                                          crossAxisAlignment: CrossAxisAlignment.center,

                                          children: [

                                            SizedBox(
                                              width: 200,
                                              height: 40,

                                              child: Center(
                                                child: Text(
                                                  data["Crtname"].toString(),
                                                  style:
                                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                ),
                                              ),
                                            ),

                                            SizedBox(
                                              width: 200,
                                              height: 40,
                                              child: Center(
                                                child: Text(
                                                  data["crtfathername"].toString(),
                                                  style:
                                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                ),
                                              ),
                                            ),

                                            SizedBox(
                                              width: 80,
                                              height: 40,

                                              child: Center(
                                                child: Text(
                                                  data["crgender"].toString(),
                                                  style:
                                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                ),
                                              ),
                                            ),

                                            SizedBox(
                                              width: 150,
                                              height: 40,
                                              child: Center(
                                                child: Text(
                                                  data["pancardno"].toString(),
                                                  style:
                                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                ),
                                              ),
                                            ),

                                            SizedBox(
                                              width: 150,
                                              height: 40,

                                              child: Center(
                                                child: Text(
                                                  data["updatestatus"].toString()==""?"-":    data["updatestatus"].toString(),
                                                  style:
                                                  GoogleFonts.poppins(fontSize: 14, color:  Color(0xff245BCA),fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ),

                                            SizedBox(
                                              width: 90,
                                              height: 40,
                                              child: Center(
                                                child: Text(
                                                  data["date"].toString(),
                                                  style:
                                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                ),
                                              ),
                                            ),

                                            SizedBox(
                                              width: 90,
                                              height: 40,
                                              child: Center(
                                                child: Text(
                                                  data["time"].toString(),
                                                  style:
                                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                ),
                                              ),
                                            ),

                                            SizedBox(
                                              width: 140,
                                              height: 40,
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      _ViewPop(data.id,data['updatestatus']);
                                                    },
                                                    child: Container(
                                                        width: 100,
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius: BorderRadius.circular(8)
                                                        ),
                                                        child: Center(child: const Text("View",style: TextStyle(color: Colors.white),))
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //     width: 60,
                                                  //     height: 40,
                                                  //     child: InkWell(
                                                  //         onTap: (){
                                                  //           ///delete popup
                                                  //           _deletepopup(data.id);
                                                  //         },
                                                  //
                                                  //         child: const Icon(Icons.delete))
                                                  // ),
                                                ],
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              ),
                                            ),








                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                if(filterName=="All"){
                                  return Padding(
                                    padding:  EdgeInsets.only(bottom:8),
                                    child: Material(
                                      color: Color(0xffFFFFFF),
                                      elevation: 20,
                                      borderRadius: BorderRadius.circular(4),
                                      shadowColor: Colors.black12,
                                      child: SizedBox(
                                        height:50,
                                        child: Row(

                                          crossAxisAlignment: CrossAxisAlignment.center,

                                          children: [

                                            SizedBox(
                                              width: 200,
                                              height: 40,

                                              child: Center(
                                                child: Text(
                                                  data["Crtname"].toString(),
                                                  style:
                                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                ),
                                              ),
                                            ),

                                            SizedBox(
                                              width: 200,
                                              height: 40,
                                              child: Center(
                                                child: Text(
                                                  data["crtfathername"].toString(),
                                                  style:
                                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                ),
                                              ),
                                            ),

                                            SizedBox(
                                              width: 80,
                                              height: 40,

                                              child: Center(
                                                child: Text(
                                                  data["crgender"].toString(),
                                                  style:
                                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                ),
                                              ),
                                            ),

                                            SizedBox(
                                              width: 150,
                                              height: 40,
                                              child: Center(
                                                child: Text(
                                                  data["pancardno"].toString(),
                                                  style:
                                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                ),
                                              ),
                                            ),

                                            SizedBox(
                                              width: 150,
                                              height: 40,

                                              child: Center(
                                                child: Text(
                                                  data["updatestatus"].toString()==""?"-":    data["updatestatus"].toString(),
                                                  style:
                                                  GoogleFonts.poppins(fontSize: 14, color:  Color(0xff245BCA),fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ),

                                            SizedBox(
                                              width: 90,
                                              height: 40,
                                              child: Center(
                                                child: Text(
                                                  data["date"].toString(),
                                                  style:
                                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                ),
                                              ),
                                            ),

                                            SizedBox(
                                              width: 90,
                                              height: 40,
                                              child: Center(
                                                child: Text(
                                                  data["time"].toString(),
                                                  style:
                                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                ),
                                              ),
                                            ),

                                            SizedBox(
                                              width: 140,
                                              height: 40,
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      _ViewPop(data.id,data['updatestatus']);
                                                    },
                                                    child: Container(
                                                        width: 100,
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius: BorderRadius.circular(8)
                                                        ),
                                                        child: Center(child: const Text("View",style: TextStyle(color: Colors.white),))
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //     width: 60,
                                                  //     height: 40,
                                                  //     child: InkWell(
                                                  //         onTap: (){
                                                  //           ///delete popup
                                                  //           _deletepopup(data.id);
                                                  //         },
                                                  //
                                                  //         child: const Icon(Icons.delete))
                                                  // ),
                                                ],
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              ),
                                            ),








                                          ],
                                        ),
                                      ),
                                    ),
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

            SizedBox(height: height/61.143,),


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

  ///delete document
  deletedocument(id){
    FirebaseFirestore.instance.collection("Correction_cards").doc(id).delete();
  }

  upadtedocument(id){
    FirebaseFirestore.instance.collection("Correction_cards").doc(id).update({
      "updatestatus":selectedValue2,
      "count":true
    });
  }


  _ViewPop(docid,updatestatus){
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(updatestatus==""){
      setState(() {
        selectedValue2="Select";
      });
    }
    else{
      setState(() {
        selectedValue2=updatestatus;
      });
    }

    showDialog(context: context, builder:(context) {
      return
        StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.only(top: 50,bottom: 50,left: 350,right:350),
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                  child:
                  FutureBuilder<dynamic>(
                    future: FirebaseFirestore.instance.collection("Correction_cards").doc(docid).get(),
                    builder: (context, snapshot) {

                      if(snapshot.hasData==null){
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      if(!snapshot.hasData){
                        return const Center(child: CircularProgressIndicator(),);
                      }

                      var userdata=snapshot.data;
                      return SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height:30),
                            Text("Correction Details",style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                fontSize:18
                            ),),
                            SizedBox(height: height/65.1,),


                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: Text("Name :",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize:18
                                  ),),
                                ),
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: CustomToolTip(text:"${userdata['Crtname']}",),
                                ),
                                CustomToolTip2(text:"${userdata['Crtname']}",),


                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: Text("Father Name :",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize:18
                                  ),),
                                ),
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: CustomToolTip(text:"${userdata['crtfathername']}",),
                                ),
                                CustomToolTip2(text:"${userdata['crtfathername']}",),


                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: Text("Gender :",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize:18
                                  ),),
                                ),
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: CustomToolTip(text:"${userdata['crgender']}",),
                                ),
                                CustomToolTip2(text:"${userdata['crgender']}",),


                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: Text("Date of Birth :",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize:18
                                  ),),
                                ),
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: CustomToolTip(text:"${userdata['crtdate_of_birth']}",),
                                ),
                                CustomToolTip2(text:"${userdata['crtdate_of_birth']}",),


                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: Text("Pan Card No :",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize:18
                                  ),),
                                ),
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: CustomToolTip(text:"${userdata['pancardno']}",),
                                ),
                                CustomToolTip2(text:"${userdata['pancardno']}",),


                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: Text("District :",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize:18
                                  ),),
                                ),
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: CustomToolTip(text:"${userdata['crtdistrict']}",),
                                ),
                                CustomToolTip2(text:"${userdata['crtdistrict']}",),


                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: Text("State :",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize:18
                                  ),),
                                ),
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: CustomToolTip(text:"${userdata['crtstate']}",),
                                ),
                                CustomToolTip2(text:"${userdata['crtstate']}",),


                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: Text("Phone Number :",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize:18
                                  ),),
                                ),
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: CustomToolTip(text:"${userdata['crtphonenumber']}",),
                                ),
                                CustomToolTip2(text:"${userdata['crtphonenumber']}",),


                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: Text("Name/village :",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize:18
                                  ),),
                                ),
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: CustomToolTip(text:"${userdata['crtnameandbuildsno']}",),
                                ),
                                CustomToolTip2(text:"${userdata['crtnameandbuildsno']}",),


                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: Text("Address :",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize:18
                                  ),),
                                ),
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: CustomToolTip(text:"${userdata['crtnadddress']}",),
                                ),
                                CustomToolTip2(text:"${userdata['crtnadddress']}",),


                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: Text("Request for update :",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize:18
                                  ),),
                                ),
                                SizedBox(
                                  width: 250,

                                  child: CustomToolTip(text:"${userdata['correctionupdate']}",),
                                ),
                                CustomToolTip2(text:"${userdata['correctionupdate']}",),


                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: Text("Pin code :",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize:18
                                  ),),
                                ),
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: CustomToolTip(text:"${userdata['crtpincode']}",),
                                ),
                                CustomToolTip2(text:"${userdata['crtpincode']}",),


                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: Text("Date :",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize:18
                                  ),),
                                ),
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: CustomToolTip(text:"${userdata['date']}",),
                                ),
                                CustomToolTip2(text:"${userdata['date']}",),

                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: Text("Time :",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize:18
                                  ),),
                                ),
                                SizedBox(
                                  width: 250,
                                  height: 30,
                                  child: CustomToolTip(text:"${userdata['time']}",),
                                ),
                                CustomToolTip2(text:"${userdata['time']}",),


                              ],
                            ),

                            SizedBox(height: height/65.1,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 255,
                                  height: 40,
                                  child: Text("Status :",style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize:18
                                  ),),
                                ),
                                Container(
                                  width: 265,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color:  const Color(0xffd8e6ff),
                                  ),
                                  child:DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      iconStyleData: IconStyleData(
                                        iconEnabledColor: Colors.black,
                                        iconDisabledColor: Colors.black,
                                      ),
                                      isDense: true,
                                      hint: Text(
                                        'Select',
                                        style: GoogleFonts.poppins(
                                            fontSize: width/95.714,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),

                                      items: StuatusList
                                          .map((String item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style:  GoogleFonts.poppins(
                                              fontSize: width/95.714,
                                              color:Colors.black,
                                              fontWeight: FontWeight.w600
                                          ),
                                        ),
                                      ))
                                          .toList(),
                                      value: selectedValue2,
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedValue2= value!;

                                        });
                                        countfunction();
                                      },
                                      buttonStyleData:  ButtonStyleData(
                                        padding: EdgeInsets.symmetric(horizontal: width/22.5),
                                        height:50,
                                        width: width/2.571,
                                      ),
                                      menuItemStyleData:  MenuItemStyleData(
                                        height: 50,
                                      ),
                                    ),
                                  ),
                                ),



                              ],
                            ),
                            SizedBox(height: height/65.1,),

                            InkWell(
                              onTap: (){
                                statusUpdatefunctio(docid);

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
                            ),
                            SizedBox(height: 30,),

                          ],
                        ),
                      );
                    },
                  )
              ),
            ),
          );
        },);
    },);
  }



  statusUpdatefunctio(docid) async {

    var userdocument=await FirebaseFirestore.instance.collection("Users").where("usertype", isEqualTo:"Distributor").get();

    for(int i=0;i<userdocument.docs.length;i++){
      FirebaseFirestore.instance.collection("Users").doc(userdocument.docs[i].id).
      collection("Histroy").doc(docid).update({
        "updatestatus":selectedValue2
      });
    }

    FirebaseFirestore.instance.collection("Correction_cards").doc(docid).update({
      "updatestatus":selectedValue2,
    });
    Navigator.pop(context);
  }


  createExcel(Usertype)async{

    final ex.Workbook workbook = ex.Workbook();
    final ex.Worksheet sheet   = workbook.worksheets[0];


    sheet.getRangeByName("A1").setText("Name");
    sheet.getRangeByName("B1").setText("Father Name");
    sheet.getRangeByName("C1").setText("Gender");
    sheet.getRangeByName("D1").setText("Pan Card No");
    sheet.getRangeByName("E1").setText("Status");
    sheet.getRangeByName("F1").setText("Date");
    sheet.getRangeByName("G1").setText("Time");
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

    var Data=await FirebaseFirestore.instance.collection("Correction_cards").where("usertype",isEqualTo: Usertype).get();

    for(int i=0;i<Data.docs.length;i++){
      sheet.getRangeByName("A${i + 2}").setText(Data.docs[i]['Crtname'].toString());
      sheet.getRangeByName("B${i + 2}").setText(Data.docs[i]['crtfathername'].toString());
      sheet.getRangeByName("C${i + 2}").setText(Data.docs[i]['crgender'].toString());
      sheet.getRangeByName("D${i + 2}").setText(Data.docs[i]['pancardno'].toString());
      sheet.getRangeByName("E${i + 2}").setText(Data.docs[i]['updatestatus'].toString());
      sheet.getRangeByName("F${i + 2}").setText(Data.docs[i]['date'].toString());
      sheet.getRangeByName("G${i + 2}").setText(Data.docs[i]['time'].toString());
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



class CustomToolTip extends StatelessWidget {

  String text;

  CustomToolTip({required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child:
      Tooltip(preferBelow: false,
          message: "Copy", child:  Text(text, style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize:18
          ),)),
      onTap: () {
        print(text);
        Clipboard.setData( ClipboardData(text: text.toString()));
      },
    );
  }
}

class CustomToolTip2 extends StatelessWidget {

  String text;

  CustomToolTip2({required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child:
      Tooltip(preferBelow: false,
          message: "Copy", child:  Icon(Icons.copy,size: 18,)),
      onTap: () {
        print(text);
        Clipboard.setData( ClipboardData(text: text.toString()));
      },
    );
  }
}



