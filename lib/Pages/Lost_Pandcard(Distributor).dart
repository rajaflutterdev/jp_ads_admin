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



class Lost_Pandcard_distributor extends StatefulWidget {
  const Lost_Pandcard_distributor({super.key});

  @override
  State<Lost_Pandcard_distributor> createState() => _Lost_Pandcard_distributorState();
}

class _Lost_Pandcard_distributorState extends State<Lost_Pandcard_distributor> {


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
                    "Lost Pan card-Distributor List",
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
                      SizedBox(width: width/1366,)

                    ],
                  )
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

                                if(data['usertype']=='Distributor'){

                                  if(filterName==data['updatestatus'] ||
                                      data['name'].toString().toLowerCase().contains(filterName.toString().toLowerCase())
                                      ||filterName==data['date']){
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

                                          },
                                          child: Container(
                                            width: 140,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black,)
                                            ),
                                            child:
                                            Center(
                                              child: Text(
                                                data["updatestatus"].toString()==""?"-":    data["updatestatus"].toString(),
                                                style:
                                                GoogleFonts.poppins(fontSize: 14, color:  Color(0xff245BCA),fontWeight: FontWeight.w700),
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
                                                    data.id,
                                                    data['updatestatus'].toString(),
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

                                          },
                                          child: Container(
                                            width: 140,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black,)
                                            ),
                                            child:
                                            Center(
                                              child: Text(
                                                data["updatestatus"].toString()==""?"-":    data["updatestatus"].toString(),
                                                style:
                                                GoogleFonts.poppins(fontSize: 14, color:  Color(0xff245BCA),fontWeight: FontWeight.w700),
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
                                                    data.id,
                                                    data['updatestatus'].toString(),
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
      district, state,date,time,picture1,picture2,picture3,picture4,picture5,docid,updatestatus){
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


    return showDialog(context: context, builder: (context) {
      return
        StatefulBuilder(builder:(context, setState) {

          return Padding(
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


                        SizedBox(height: 15,),
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
                                  color: Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(5)
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
                                statusUpdatefunctio(docid);

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



  statusUpdatefunctio(docid) async {

    var userdocument=await FirebaseFirestore.instance.collection("Users")
        .where("usertype", isEqualTo:"Distributor").get();

    for(int i=0;i<userdocument.docs.length;i++){
      FirebaseFirestore.instance.collection("Users").doc(userdocument.docs[i].id).
      collection("Reprint_document").doc(docid).update({
        "updatestatus":selectedValue2,
        "count":false
      });
    }

    FirebaseFirestore.instance.collection("Reprint_document").doc(docid).update({
      "updatestatus":selectedValue2,
      "count":false
    });

    print("dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
    print(docid);
    print(selectedValue2);
    Navigator.pop(context);
  }
  createExcel(Usertype)async{

    final ex.Workbook workbook = ex.Workbook();
    final ex.Worksheet sheet   = workbook.worksheets[0];


    sheet.getRangeByName("A1").setText("Name");
    sheet.getRangeByName("B1").setText("Father Name");
    sheet.getRangeByName("C1").setText("Gender");
    sheet.getRangeByName("D1").setText("Phone No");
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

    var Data=await FirebaseFirestore.instance.collection("Reprint_document").where("usertype",isEqualTo: Usertype).get();

    for(int i=0;i<Data.docs.length;i++){
      sheet.getRangeByName("A${i + 2}").setText(Data.docs[i]['name'].toString());
      sheet.getRangeByName("B${i + 2}").setText(Data.docs[i]['fathername'].toString());
      sheet.getRangeByName("C${i + 2}").setText(Data.docs[i]['gender'].toString());
      sheet.getRangeByName("D${i + 2}").setText(Data.docs[i]['phoneno'].toString());
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


