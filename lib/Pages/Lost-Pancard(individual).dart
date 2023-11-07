import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import 'package:universal_html/html.dart' as html;


class Lost_pancard_individual extends StatefulWidget {
  const Lost_pancard_individual({super.key});

  @override
  State<Lost_pancard_individual> createState() => _Lost_pancard_individualState();
}

class _Lost_pancard_individualState extends State<Lost_pancard_individual> {


  List<String> StuatusList=[];
  String filterName='';
  statusaddfunc()async{
    setState((){
      StuatusList.clear();
      filterName="All";
    });

    var statusdata=await FirebaseFirestore.instance.collection("Status").orderBy('name').get();
    for(int i=0;i<statusdata.docs.length;i++){
      setState(() {
        StuatusList.add(statusdata.docs[i]['name']);
      });
    }
    print(StuatusList);

  }

  @override
  void initState() {
    statusaddfunc();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return  Padding(
      padding:  EdgeInsets.only(left:10),
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
                    "Lost Pan card-Individual List",
                    style: GoogleFonts.poppins(
                        fontSize: width / 57.57,
                        color: const Color(0xff000000)),
                  ),

                ],
              ),
            ),
            SizedBox(height: height/41.143,),
            Padding(
              padding:  EdgeInsets.only(left: width / 100),
              child: SizedBox(
                height:35,
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          filterName="All";
                        });
                      },
                      child: Container(
                        height:height/18.6,
                        width:width/12.418,
                        decoration: BoxDecoration(
                            color:filterName=="All"?Colors.indigo:Colors.green,
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Center(child: Text("All",style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          color:Colors.white,),)),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: StuatusList.length,
                      itemBuilder: (context, index) {


                        return Padding(
                          padding:  EdgeInsets.only(left:width/170.75),
                          child:
                          InkWell(
                            onTap: (){
                              setState(() {
                                filterName=StuatusList[index];
                              });
                            },
                            child: Container(
                              height:height/18.6,
                              width:width/12.418,
                              decoration: BoxDecoration(
                                  color:filterName==StuatusList[index]?Colors.indigo:Colors.green,
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Center(child: Text(StuatusList[index].toString(),style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                color:Colors.white,),)),
                            ),
                          ),
                        );
                      },),
                  ],
                ),
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
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Row(

                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          SizedBox(width: 2,),



                          Container(
                            width: 220,
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
                            width: 220,
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
                            width: 90,
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
                            width: 130,
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
                            width: 140,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,)
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
                            width: 90,
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
                            width: 90,
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
                        stream: FirebaseFirestore.instance.collection("Reprint_document")
                            .orderBy("timestamp").snapshots(),
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

                                if(data['usertype']=='Individual'){

                                  if(filterName==data['updatestatus']){
                                    return Row(

                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 2,),



                                        Container(
                                          width: 220,
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
                                          width: 220,
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
                                          width: 90,
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
                                          width: 130,
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

                                        InkWell(
                                          onTap:(){
                                            statsupdate(data.id);
                                          },
                                          child: Container(
                                            width: 140,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black,)
                                            ),
                                            child: Center(
                                              child: Text(
                                                data["updatestatus"].toString(),
                                                style:
                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                              ),
                                            ),
                                          ),
                                        ),

                                        Container(
                                          width: 90,
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
                                          width: 90,
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
                                                  print("Cilekedddddddddddddddddddddddddddddddd");

                                                  Viewdetailspopup(
                                                    data['name'].toString(),
                                                    data['fathername'].toString(),
                                                    data['gender'].toString(),
                                                    data['dob'].toString(),
                                                    data['phoneno'].toString(),
                                                    data['panno'].toString(),
                                                    data['village_town'].toString(),
                                                    data['postoffice'].toString(),
                                                    data['pincode'].toString(),
                                                    data['district'].toString(),
                                                    data['state'].toString(),
                                                    data['date'].toString(),
                                                    data['time'].toString(),
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
                                  }
                                   if(filterName=="All"){
                                    return Row(

                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 2,),



                                        Container(
                                          width: 220,
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
                                          width: 220,
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
                                          width: 90,
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
                                          width: 130,
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

                                        InkWell(
                                          onTap:(){
                                            statsupdate(data.id);
                                          },
                                          child: Container(
                                            width: 140,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black,)
                                            ),
                                            child: Center(
                                              child: Text(
                                                data["updatestatus"].toString(),
                                                style:
                                                GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                              ),
                                            ),
                                          ),
                                        ),

                                        Container(
                                          width: 90,
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
                                          width: 90,
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
                                                  print("Cilekedddddddddddddddddddddddddddddddd");

                                                  Viewdetailspopup(
                                                    data['name'].toString(),
                                                    data['fathername'].toString(),
                                                    data['gender'].toString(),
                                                    data['dob'].toString(),
                                                    data['phoneno'].toString(),
                                                    data['panno'].toString(),
                                                    data['village_town'].toString(),
                                                    data['postoffice'].toString(),
                                                    data['pincode'].toString(),
                                                    data['district'].toString(),
                                                    data['state'].toString(),
                                                    data['date'].toString(),
                                                    data['time'].toString(),
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
            ),


          ],
        ),
      ),
    );
  }





  Viewdetailspopup(name,fathername,gender,dob,phone,panno,villageandtown,postoffice,pincode,
      district, state,date,time,picture1,picture2,picture3,picture4,picture5){
    return showDialog(context: context, builder:
        (context) {
      return  Padding(
        padding: const EdgeInsets.only(top: 10,bottom: 10,left: 350,right:350),
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: Center(
              child:
              SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height:10),
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
                          child: CustomToolTip(text:"${phone}",),
                        ),
                        CustomToolTip2(text:"${phone}",),


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
                          child: Text("Pin code :",style: GoogleFonts.poppins(
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
                                onTap:(){
                                  _ViewImage(picture1);
                                },
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
                              onTap: (){
                                downloadImage(picture1,"Aadhaar_Image");
                              },
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
                                onTap:(){
                                  _ViewImage(picture2);
                                },
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
                              onTap: (){
                                downloadImage(picture2,"Aadhaar_Image");
                              },
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
                                onTap:(){
                                  _ViewImage(picture3);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xff263645),
                                    ),
                                    height: 100,width: 100,child:Image.network(picture3)),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                downloadImage(picture3,"Photo");
                              },
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
                                onTap:(){
                                  _ViewImage(picture4);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xff263645),
                                    ),
                                    height: 100,width: 100,child:Image.network(picture4)),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                downloadImage(picture4,"Photo");
                              },
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
                                onTap:(){
                                  _ViewImage(picture5);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xff263645),
                                    ),
                                    height: 100,width: 100,child:Image.network(picture5)),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                downloadImage(picture5,"Sign_picture");
                              },
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                        SizedBox(width: 15,),
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
                    ),

                    SizedBox(height: 15,),



                  ],
                ),
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

  statsupdate(docid){
    return showAdaptiveDialog(
      barrierDismissible: true,
      context: context, builder: (context) {
      return Padding(
        padding:  EdgeInsets.only(bottom: 150,top:150,left: 500,right:500),
        child: StatefulBuilder(
            builder: (context,setState) {
              return
                Scaffold(body: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color:Colors. white
                    ),
                    child:ListView.builder(
                      itemCount: StuatusList.length,
                      itemBuilder: (context, index) {
                        return
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                statusUpdatefunctio(docid,StuatusList[index]);
                              },
                              child: Container(
                                  height:50,
                                  width:120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.indigo,
                                  ),
                                  child:Center(child: Text(StuatusList[index].toString(),style: GoogleFonts.poppins(fontWeight: FontWeight.w700,color: Colors.white),))
                              ),
                            ),
                          );
                      },)
                ),);
            }
        ),
      );
    },);
  }
  statusUpdatefunctio(docid,statusname) async {

    var userdocument=await FirebaseFirestore.instance.collection("Users").where("usertype", isEqualTo:"Individual").get();

    for(int i=0;i<userdocument.docs.length;i++){
      FirebaseFirestore.instance.collection("Users").doc(userdocument.docs[i].id).
      collection("Reprint_document").doc(docid).update({
        "updatestatus":statusname
      });
    }

    FirebaseFirestore.instance.collection("Reprint_document").doc(docid).update({
      "updatestatus":statusname,
    });
    Navigator.pop(context);
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


