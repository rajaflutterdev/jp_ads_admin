import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart'as http;
import 'package:universal_html/html.dart' as html;


class Lost_Pandcard_distributor extends StatefulWidget {
  const Lost_Pandcard_distributor({super.key});

  @override
  State<Lost_Pandcard_distributor> createState() => _Lost_Pandcard_distributorState();
}

class _Lost_Pandcard_distributorState extends State<Lost_Pandcard_distributor> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return  Padding(
      padding:  EdgeInsets.only(left:10),
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
                  "Applied Distributor List",
                  style: GoogleFonts.poppins(
                      fontSize: width / 57.57,
                      color: const Color(0xff000000)),
                ),

              ],
            ),
          ),
          SizedBox(height: height/41.143,),

          Material( color: const Color(0xffd8e6ff),
            elevation: 20,
            shadowColor: Colors.black12,
            child: Container(
              height:532,
              width: 1102,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color:  const Color(0xffd8e6ff),
              ),
              child:
              SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  children: [
                    Row(

                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        SizedBox(width: 2,),

                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,)
                          ),
                          child: Center(
                            child: Text(
                              "Si.No",
                              textAlign: TextAlign.start,
                              style:
                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),

                        Container(
                          width: 240,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,)
                          ),

                          child: Center(
                            child: Text(
                              "Full Name",
                              style:
                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),

                        Container(
                          width: 250,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,)
                          ),
                          child: Center(
                            child: Text(
                              "Father Name",
                              style:
                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),

                        Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,)
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
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,)
                          ),
                          child: Center(
                            child: Text(
                              "Phone No",
                              style:
                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),

                        Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,)
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
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,)
                          ),
                          child: Center(
                            child: Text(
                              "Time",
                              style:
                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),

                        Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,)
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
                      stream: FirebaseFirestore.instance.collection("Reprint_document").where("usertype",isEqualTo: "Distributor").snapshots(),
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

                              return Row(

                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: 2,),

                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,)
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
                                    width: 240,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,)
                                    ),
                                    child: Center(
                                      child: Text(
                                        data["name"].toString(),
                                        style:
                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                      ),
                                    ),
                                  ),

                                  Container(
                                    width: 250,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,)
                                    ),
                                    child: Center(
                                      child: Text(
                                        data["fathername"].toString(),
                                        style:
                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                      ),
                                    ),
                                  ),

                                  Container(
                                    width: 100,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,)
                                    ),
                                    child: Center(
                                      child: Text(
                                        data["gender"].toString(),
                                        style:
                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                      ),
                                    ),
                                  ),

                                  Container(
                                    width: 150,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,)
                                    ),
                                    child: Center(
                                      child: Text(
                                        data["phoneno"].toString(),
                                        style:
                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                      ),
                                    ),
                                  ),

                                  Container(
                                    width: 100,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,)
                                    ),
                                    child: Center(
                                      child: Text(
                                        data["date"].toString(),
                                        style:
                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                      ),
                                    ),
                                  ),

                                  Container(
                                    width: 100,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,)
                                    ),
                                    child: Center(
                                      child: Text(
                                        data["time"].toString(),
                                        style:
                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                      ),
                                    ),
                                  ),

                                  Container(
                                    width: 120,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black,)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            //name,fathername,gender,dob,pantype,date,time
                                            _ViewPop(
                                              data['name'].toString(),
                                              data['fathername'].toString(),
                                              data['gender'].toString(),
                                              data['dob'].toString(),
                                              data['date'].toString(),
                                              data['time'].toString(),
                                              data['district'].toString(),
                                              data['panno'].toString(),
                                              data['phoneno'].toString(),
                                              data['pincode'].toString(),
                                              data['postoffice'].toString(),
                                              data['state'].toString(),
                                              data['village/town'].toString(),
                                              data['aadharpicture'].toString(),
                                              data['aadharpicture2'].toString(),
                                              data['photo'].toString(),
                                              data['photo2'].toString(),
                                              data['signpicture'].toString(),
                                            );
                                          },
                                          child: Container(
                                              width: 60,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius: BorderRadius.circular(8)
                                              ),
                                              child: Center(child: const Text("View",style: TextStyle(color: Colors.white),))
                                          ),
                                        ),
                                        // SizedBox(
                                        //     width: 30,
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
    FirebaseFirestore.instance.collection("New_applied").doc(id).delete();
  }



  _ViewPop(
      name,fathername,gender,dob,date,time,district,panno,phoneno,pincode,
      postoffice, state, villageandtown, picture1,picture2,picture3,picture4,picture5){

    final key = new GlobalKey<ScaffoldState>();
    showDialog(context: context, builder:(context) {
      return Padding(
        padding: const EdgeInsets.only(top: 60,bottom: 60,left: 350,right:350),
        child: Scaffold(
          key:key ,
          backgroundColor: Colors.grey.shade200,
          body: Center(
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height:20),
                  Text("Application Details",style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize:18
                  ),),
                  SizedBox(height: 10,),


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
                        child: CustomToolTip(text:"${name}",),
                      ),
                      CustomToolTip2(text:"${name}",),


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
                        child: CustomToolTip(text:"${fathername}",),
                      ),
                      CustomToolTip2(text:"${fathername}",),


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
                        child: CustomToolTip(text:"${gender}",),
                      ),
                      CustomToolTip2(text:"${gender}",),


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
                        child: CustomToolTip(text:"${dob}",),
                      ),
                      CustomToolTip2(text:"${dob}",),


                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        height: 30,
                        child: Text("Phone No :",style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize:18
                        ),),
                      ),
                      SizedBox(
                        width: 250,
                        height: 30,
                        child: CustomToolTip(text:"${phoneno}",),
                      ),
                      CustomToolTip2(text:"${phoneno}",),


                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        height: 30,
                        child: Text("Pan No :",style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize:18
                        ),),
                      ),
                      SizedBox(
                        width: 250,
                        height: 30,
                        child: CustomToolTip(text:"${panno}",),
                      ),
                      CustomToolTip2(text:"${panno}",),


                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        height: 30,
                        child: Text("Village/Town :",style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize:18
                        ),),
                      ),
                      SizedBox(
                        width: 250,
                        height: 30,
                        child: CustomToolTip(text:"$villageandtown",),
                      ),
                      CustomToolTip2(text:"${villageandtown}",),


                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        height: 30,
                        child: Text("Post Office :",style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize:18
                        ),),
                      ),
                      SizedBox(
                        width: 250,
                        height: 30,
                        child: CustomToolTip(text:"$postoffice",),
                      ),
                      CustomToolTip2(text:"${postoffice}",),


                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        height: 30,
                        child: Text("Pincode :",style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize:18
                        ),),
                      ),
                      SizedBox(
                        width: 250,
                        height: 30,
                        child: CustomToolTip(text:"$pincode",),
                      ),
                      CustomToolTip2(text:"${pincode}",),


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
                        child: CustomToolTip(text:"$district",),
                      ),
                      CustomToolTip2(text:"${district}",),


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
                        child: CustomToolTip(text:"$state",),
                      ),
                      CustomToolTip2(text:"${state}",),


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
                        child: CustomToolTip(text:"$date",),
                      ),
                      CustomToolTip2(text:"${date}",),


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
                        child: CustomToolTip(text:"${time}",),
                      ),
                      CustomToolTip2(text:"${time}",),


                    ],
                  ),


                  SizedBox(height: 30,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Tooltip(
                            message: "View Image",
                            child: InkWell(
                              onTap:()=>_ViewImage(picture1),
                              //message: "View Image",
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xff263645),
                                  ),
                                  height: 100,width: 100,child:Image.network(picture1)),
                            ),
                          ),
                          InkWell(
                            onTap: ()=>downloadImage(picture1,"Aadhaar_Image"),
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
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Tooltip(
                            message: "View Image",
                            child: InkWell(
                              onTap:()=>_ViewImage(picture2),
                              //message: "View Image",
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xff263645),
                                  ),
                                  height: 100,width: 100,child:Image.network(picture2)),
                            ),
                          ),
                          InkWell(
                            onTap: ()=>downloadImage(picture2,"Aadhaar_Image"),
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
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Tooltip(
                            message: "View Image",
                            child: InkWell(
                              onTap:()=>_ViewImage(picture3),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xff263645),
                                  ),
                                  height: 100,width: 100,child:Image.network(picture3)),
                            ),
                          ),
                          InkWell(
                            onTap: ()=>downloadImage(picture3,"Photo"),
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
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Tooltip(
                            message: "View Image",
                            child: InkWell(
                              onTap:()=>_ViewImage(picture4),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xff263645),
                                  ),
                                  height: 100,width: 100,child:Image.network(picture4)),
                            ),
                          ),
                          InkWell(
                            onTap: ()=>downloadImage(picture4,"Photo"),
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
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Tooltip(
                            message: "View Image",
                            child: InkWell(
                              onTap:()=>_ViewImage(picture5),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xff263645),
                                  ),
                                  height: 100,width: 100,child:Image.network(picture5)),
                            ),
                          ),
                          InkWell(
                            onTap: ()=>downloadImage(picture5,"Sign_picture"),
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


                    ],
                  ),

                  SizedBox(height: 15,),

                  InkWell(
                    onTap: (){

                      for(int i=0;i<5;i++){
                        if(i==0){
                          downloadImage(picture1,"Aadhaar_Image");
                        }
                        if(i==1){
                          downloadImage(picture1,"Photo");
                        }
                        if(i==2){
                          downloadImage(picture1,"Sign_picture");
                        }
                        if(i==3){
                          downloadImage(picture1,"Sign_picture");
                        }
                        if(i==4){
                          downloadImage(picture1,"Sign_picture");
                        }

                      }


                    },
                    child: Container(
                      height:40,
                      width:180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xff263646)
                      ),
                      child: Center(
                        child: Text("Download All",style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w600),),
                      ),
                    ),
                  ),

                  SizedBox(height: 15,),

                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height:40,
                      width:100,
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

  _ViewImage(ImageLink){


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
              )
          ),
        ),
      );
    },);
  }

  downloadImage(String imageUrl,String Imagetitle) async {
    var title= imageUrl.split("-",);
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
      a.download =
      Imagetitle=="Aadhaar_Image"?"Aadhaar_Image.jpg":
      Imagetitle=="Photo"?"Photo.jpg":
      Imagetitle=="Sign_picture"?"Sign_picture.jpg": 'download.jpg';

      // and we click the AnchorElement which downloads the image
      a.click();
      // finally we remove the AnchorElement
      a.remove();
    } catch (e) {
      print(e);
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


