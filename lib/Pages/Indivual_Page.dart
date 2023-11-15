
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Indivual_Page extends StatefulWidget {
  const Indivual_Page({super.key});

  @override
  State<Indivual_Page> createState() => _Indivual_PageState();
}

class _Indivual_PageState extends State<Indivual_Page> {
  int isviewcollection=0;
  String Userdocuid='';

  int viewhistroy=0;

  int documentcount=0;


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.only(left: width / 25.77,right:  width / 25.77,
                  top: height/61.43),
              child: Row(
                children: [
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
                      )),
                  const SizedBox(width: 10,),

                  Text(
                    isviewcollection==1?"History List":isviewcollection==2?"Wallet List": "Individual List ",
                    style: GoogleFonts.poppins(
                        fontSize: width / 57.57,
                        color: const Color(0xff000000)),
                  ),

                  Text(
                    viewhistroy==1?
                    "- Correction && Applied List ":
                    viewhistroy==2? "-  Applied List":"",
                    style: GoogleFonts.poppins(
                        fontSize: width / 57.57,
                        color: const Color(0xff000000)),
                  ),



                ],
              ),
            ),
            SizedBox(height: height/41.143,),
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
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color:  const Color(0xffd8e6ff),
                        ),
                        child:
                        Row(

                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,

                          children: [

                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Center(
                                child: Text(
                                  "Si.No",
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
                                  "Name",
                                  style:
                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Center(
                                child: Text(
                                 "Phone",
                                  style:
                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Center(
                                child: Text(
                                  "Wallet Amt",
                                  style:
                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Center(
                                child: Text(
                                  "Payment",
                                  style:
                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Center(
                                child: Text(
                                  "Usage count",
                                  style:
                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 300,
                              height: 40,
                              child: Center(
                                child: Text(
                                  "Actions",
                                  style:
                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                ),
                              ),
                            ),






                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height/41.143,),

                    StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("Users").
                      where("usertype",isEqualTo:"Individual").snapshots(),
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

                              return Padding(
                                padding:  const EdgeInsets.only(bottom: 8.0),
                                child: Material( color: const Color(0xffd8e6ff),
                                  elevation: 20,
                                  shadowColor: Colors.black12,
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color:  const Color(0xffd8e6ff),
                                    ),
                                    child:
                                    Row(

                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                                      children: [

                                        SizedBox(
                                          width: 100,
                                          height: 40,

                                          child: Center(
                                            child: Text(
                                              (index+1).toString(),
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
                                              _Userdata["name"].toString(),
                                              style:
                                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          width: 100,
                                          height: 40,

                                          child: Center(
                                            child: Text(
                                              _Userdata["phone"].toString(),
                                              style:
                                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          width: 100,
                                          height: 40,
                                          child: Center(
                                            child: Text(
                                              _Userdata["walletamount"].toString(),
                                              style:
                                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          width: 100,
                                          height: 40,
                                          child: Center(
                                            child: Text(
                                              _Userdata["payment"].toString(),
                                              style:
                                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          width: 100,
                                          height: 40,
                                          child: Center(
                                            child: Text(
                                              _Userdata["usageccount"].toString(),
                                              style:
                                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                            ),
                                          ),
                                        ),

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
                                              child: Center(child: const Text("View Histroy",style: TextStyle(color: Colors.white),))
                                          ),
                                        ),

                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              isviewcollection=2;
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
                                              child: Center(child: const Text("View Wallet",style: TextStyle(color: Colors.white),))
                                          ),
                                        ),

                                        InkWell(
                                          onTap: (){
                                            ///delete popup
                                            _deletepopup(_Userdata.id);
                                          },
                                          child: SizedBox(
                                              width: 60,
                                              height: 40,
                                              child: Center(child: const Icon(Icons.delete))
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                ),
                              );

                            },);
                      },
                    ),


                  ],
                ),
              ),
            ):
            isviewcollection==1?
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
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color:  const Color(0xffd8e6ff),
                        ),
                        child:
                        Row(

                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,

                          children: [

                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Center(
                                child: Text(
                                  "Si.No",
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
                                  "Name",
                                  style:
                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Center(
                                child: Text(
                                  "Fathername\n && Phone",
                                  textAlign: TextAlign.center,
                                  style:
                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Center(
                                child: Text(
                                  "Gender\n && Status",
                                  textAlign: TextAlign.center,
                                  style:
                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Center(
                                child: Text(
                                  "Type",
                                  style:
                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Center(
                                child: Text(
                                  "Date\nTime",
                                  textAlign: TextAlign.center,
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
                                  "Actions",
                                  style:
                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                ),
                              ),
                            ),






                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height/41.143,),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("Users").
                      doc(Userdocuid).collection("Histroy").where("Type",isEqualTo:"Correction").snapshots(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,

                              children: [

                                SizedBox(
                                  width: 100,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      (index+1).toString(),
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
                                      applieddata['Crtname'].toString(),
                                      style:
                                      GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: 100,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      applieddata['crtphonenumber'].toString(),
                                      style:
                                      GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: 100,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      applieddata['crgender'].toString(),
                                      style:
                                      GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: 100,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      applieddata['Type'].toString(),
                                      style:
                                      GoogleFonts.poppins(fontSize: 14, color: Colors.indigo,fontWeight:FontWeight.w700),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: 100,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                     "${ applieddata['date'].toString()}\n${ applieddata['time'].toString()}",
                                      textAlign: TextAlign.center,
                                      style:
                                      GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                    ),
                                  ),
                                ),

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
                                    );
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

                                InkWell(
                                  onTap: (){
                                    ///delete popup
                                    _deleteHistroypopup(applieddata.id);
                                  },
                                  child: SizedBox(
                                      width: 60,
                                      height: 40,
                                      child: Center(child: const Icon(Icons.delete))
                                  ),
                                ),






                              ],
                            );
                          },);
                      },
                    ),

                    StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("Users").doc(Userdocuid).collection("Histroy").where("Type",isEqualTo:"Applied").snapshots(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,

                              children: [

                                SizedBox(
                                  width: 100,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      (documentcount+1).toString(),
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
                                      applieddata['name'].toString(),
                                      style:
                                      GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: 100,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      applieddata['father name'].toString(),
                                      style:
                                      GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: 100,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      applieddata['updatestatus'].toString(),
                                      style:
                                      GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: 100,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      applieddata['Type'].toString(),
                                      style:
                                      GoogleFonts.poppins(fontSize: 14, color:  Colors.green,fontWeight:FontWeight.w700),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: 100,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      "${ applieddata['date'].toString()}\n${ applieddata['time'].toString()}",
                                      textAlign: TextAlign.center,
                                      style:
                                      GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                    ),
                                  ),
                                ),

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

                                    );
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

                                InkWell(
                                  onTap: (){
                                    ///delete popup
                                    _deleteHistroypopup(applieddata.id);
                                  },
                                  child: SizedBox(
                                      width: 60,
                                      height: 40,
                                      child: Center(child: const Icon(Icons.delete))
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
            ):
            isviewcollection==2?
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
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color:  const Color(0xffd8e6ff),
                        ),
                        child:
                        Row(

                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,

                          children: [

                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Center(
                                child: Text(
                                  "Si.No",
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
                                  "Name",
                                  style:
                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Center(
                                child: Text(
                                  "Phone",
                                  style:
                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Center(
                                child: Text(
                                  "Amount",
                                  style:
                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Center(
                                child: Text(
                                  "Date",
                                  style:
                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 100,
                              height: 40,
                              child: Center(
                                child: Text(
                                  "Time",
                                  textAlign: TextAlign.center,
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
                                  "Actions",
                                  style:
                                  GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                ),
                              ),
                            ),






                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height/41.143,),

                    StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("Users").
                      doc(Userdocuid).collection("Wallet_Histroy").snapshots(),
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
                            return GestureDetector(
                              onTap: (){
                                // detailspopup(
                                //   applieddata['Crtname'].toString(),
                                //   applieddata['crtfathername'].toString(),
                                //   applieddata['crtphonenumber'].toString(),
                                //   applieddata['crgender'].toString(),
                                //   applieddata['crtdate_of_birth'].toString(),
                                //   applieddata['pancardno'].toString(),
                                //   applieddata['crtnameandbuildsno'].toString(),
                                //   applieddata['crtnadddress'].toString(),
                                //   applieddata['crtdistrict'].toString(),
                                //   applieddata['crtstate'].toString(),
                                //   applieddata['date'].toString(),
                                //   applieddata['time'].toString(),
                                //   applieddata['updatestatus'].toString(),
                                //   applieddata['correctionupdate'].toString(),
                                //   applieddata['Type'].toString(),
                                //   applieddata['crtpincode'].toString(),
                                // );
                              },
                              child:
                              Row(

                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,

                                children: [

                                  SizedBox(
                                    width: 100,
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        (index+1).toString(),
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
                                        applieddata['name'].toString(),
                                        style:
                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    width: 100,
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        applieddata['Phoneno'].toString(),
                                        style:
                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    width: 100,
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        applieddata['Amount'].toString(),
                                        style:
                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    width: 100,
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        applieddata['date'].toString(),
                                        style:
                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    width: 100,
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        applieddata['time'].toString(),
                                        textAlign: TextAlign.center,
                                        style:
                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                      ),
                                    ),
                                  ),

                                  InkWell(
                                    onTap: (){
                                      ///delete popup
                                      _deleteWalletpopup(applieddata.id);
                                    },
                                    child: SizedBox(
                                        width: 60,
                                        height: 40,
                                        child: Center(child: const Icon(Icons.delete))
                                    ),
                                  ),






                                ],
                              ),
                            );
                          },);
                      },
                    ),
                  ],
                ),
              ),
            ):const SizedBox()

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

  ///delete document()
  deletedocument(id){
    FirebaseFirestore.instance.collection("Users").doc(id).delete();
  }


  ///deleter document histroy
  _deleteHistroypopup(docid){

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
                    deletedocumentHistroy(docid);
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

  deletedocumentHistroy(id){
    FirebaseFirestore.instance.collection("Users").
    doc(Userdocuid).collection("Histroy").doc(id).delete();
  }


  ///deleter document histroy
  _deleteWalletpopup(docid){

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
                    deletedocumentWallet(docid);
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

  deletedocumentWallet(id){
    FirebaseFirestore.instance.collection("Users").doc(Userdocuid).collection("Wallet_Histroy").doc(id).delete();
  }

  detailspopup(name,fathermname,phonenumber,gender,dob,panno,namebuildno,address,district,state,date,time,status,correctionlist,type,pincode)
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
            height: 600,
            width: width/4.2687,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white54.withOpacity(0.9),
            ),
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  Text("Correction Details",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          textStyle: TextStyle(
                              decoration: TextDecoration.underline,
                              overflow: TextOverflow.ellipsis
                          ),
                          color: Colors.black)),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 30,
                          width: 280,
                          child:
                          Text("Name : ${name}",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  textStyle: TextStyle(
                                      overflow: TextOverflow.ellipsis
                                  ),
                                  color: Colors.black))),
                      Container(
                          height: 30,
                          width: 280,
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
                          height: 30,
                          width: 280,
                          child: Text("Phone no: ${phonenumber}",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              textStyle: TextStyle(
                                  overflow: TextOverflow.ellipsis
                              ),
                              color: Colors.black))),
                      Container(
                          height: 30,
                          width: 280,
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
                          height: 30,
                          width: 280,
                          child: Text("DOB: ${dob}",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              textStyle: TextStyle(
                                  overflow: TextOverflow.ellipsis
                              ),
                              color: Colors.black))),
                      Container(
                          height: 30,
                          width: 280,
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
                          height: 30,
                          width: 280,
                          child: Text("Pan No: ${panno}",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              textStyle: TextStyle(
                                  overflow: TextOverflow.ellipsis
                              ),
                              color: Colors.black))),
                      Container(
                          height: 30,
                          width: 280,
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
                          height: 30,
                          width: 280,
                          child: Text("Address: ${address}",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              textStyle: TextStyle(
                                  overflow: TextOverflow.ellipsis
                              ),
                              color: Colors.black))),
                      Container(
                          height: 30,
                          width: 280,
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
                          height: 30,
                          width: 280,
                          child: Text("State: ${state}",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              textStyle: TextStyle(
                                  overflow: TextOverflow.ellipsis
                              ),
                              color: Colors.black))),
                      Container(
                          height: 30,
                          width: 280,
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
                          height: 30,
                          width: 280,
                          child: Text("Date/Time: ${date}-${time}",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              textStyle: TextStyle(
                                  overflow: TextOverflow.ellipsis
                              ),
                              color: Colors.black))),
                      Container(
                          height: 30,
                          width: 280,
                          child: Text("Status: ${status}",style: GoogleFonts.poppins(
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
                  SizedBox(height: 30,),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 100,
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


  Applieddetailspopup(name,fathername,gender,dob,pantype,updatestatus,date,time,type,aadharpicture,signpicture,photo){

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
            width: width/4.2687,
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
                    height: 30,
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
                    height: 30,
                    width: 400,
                    child: Text("Father Name : ${fathername}",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            textStyle: TextStyle(
                                overflow: TextOverflow.ellipsis
                            ),
                            color: Colors.black))),

                Container(
                    height: 30,
                    width: 400,
                    child: Text("Date/Time: ${date}-${time}",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis
                        ),
                        color: Colors.black))),
                Container(
                    height: 30,
                    width: 400,
                    child: Text("Gender: ${gender}",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis
                        ),
                        color: Colors.black))),
                Container(
                    height: 30,
                    width: 400,
                    child: Text("DOB: ${dob}",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis
                        ),
                        color: Colors.black))),
                Container(
                    height: 30,
                    width: 400,
                    child: Text("Pantype: ${pantype}",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis
                        ),
                        color: Colors.black))),
                Container(
                    height: 30,
                    width: 400,
                    child: Text("Status: ${updatestatus}",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis
                        ),
                        color: Colors.black))),
                Container(
                    height: 30,
                    width: 400,
                    child: Text("Date/Time: ${date}-${time}",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis
                        ),
                        color: Colors.black))),
                Container(
                    height: 30,
                    width: 400,
                    child: Text("Type: ${type}",style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        textStyle: TextStyle(
                            overflow: TextOverflow.ellipsis
                        ),
                        color: Colors.black))),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: height/6.51,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(aadharpicture)
                          )
                      ),
                    ),
                    Container(
                      height: height/6.51,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(signpicture)
                          )
                      ),
                    ),
                    Container(
                      height: height/6.51,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(photo)
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(height: 30,
                    width: 100,
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

}
