
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


class Correction_Infivivual_Page extends StatefulWidget {
  const Correction_Infivivual_Page({super.key});

  @override
  State<Correction_Infivivual_Page> createState() => _Correction_Infivivual_PageState();
}

class _Correction_Infivivual_PageState extends State<Correction_Infivivual_Page> {


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
    return Padding(
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
                    "Correction Individual List",
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
                          SizedBox(width:2),



                          Container(
                            width: 200,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
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
                            width: 200,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
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
                            width: 80,
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
                            width: 150,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
                            ),

                            child: Center(
                              child: Text(
                                "Pan Card No",
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
                            width: 90,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)
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
                            width: 140,
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

                                if(data['usertype']=='Individual'){

                                  if(filterName==data['updatestatus']){
                                    return Row(

                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: [
                                        SizedBox(width: 2,),



                                        Container(
                                          width: 200,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Center(
                                            child: Text(
                                              data["Crtname"].toString(),
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
                                              data["crtfathername"].toString(),
                                              style:
                                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                            ),
                                          ),
                                        ),

                                        Container(
                                          width: 80,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Center(
                                            child: Text(
                                              data["crgender"].toString(),
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
                                              data["pancardno"].toString(),
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
                                            width: 150,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black)
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
                                              border: Border.all(color: Colors.black)
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
                                              border: Border.all(color: Colors.black)
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
                                          width: 140,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  _ViewPop(data.id);
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
                                    );
                                  }
                                   if(filterName=="All"){
                                    return Row(

                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: [
                                        SizedBox(width: 2,),



                                        Container(
                                          width: 200,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Center(
                                            child: Text(
                                              data["Crtname"].toString(),
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
                                              data["crtfathername"].toString(),
                                              style:
                                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                            ),
                                          ),
                                        ),

                                        Container(
                                          width: 80,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Center(
                                            child: Text(
                                              data["crgender"].toString(),
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
                                              data["pancardno"].toString(),
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
                                            width: 150,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black)
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
                                              border: Border.all(color: Colors.black)
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
                                              border: Border.all(color: Colors.black)
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
                                          width: 140,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black)
                                          ),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  _ViewPop(data.id);
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
            SizedBox(height: height/41.143,),


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


  _ViewPop(docid){


    showDialog(context: context, builder:(context) {
      return Padding(
        padding: const EdgeInsets.only(top: 50,bottom: 50,left: 350,right:350),
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
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


                        SizedBox(height: 10,),

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
      collection("Histroy").doc(docid).update({
        "updatestatus":statusname
      });
    }

    FirebaseFirestore.instance.collection("Correction_cards").doc(docid).update({
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


