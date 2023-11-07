import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';

class Form_Page extends StatefulWidget {
  const Form_Page({super.key});

  @override
  State<Form_Page> createState() => _Form_PageState();
}

class _Form_PageState extends State<Form_Page> {



  int viewtab=0;

  TextEditingController fileNamecon=TextEditingController();
  String fileName = const Uuid().v1();
  File? Url;
  var Uploaddocument;
  String imgUrl="";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column (
        children: [
          Padding(
            padding:  EdgeInsets.only(left: width / 75.77,
                top: height/61.43),
            child: Row(
              children: [
                viewtab!=0? GestureDetector(
                    onTap: (){
                      setState(() {
                        viewtab=0;
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
                  "Forms",
                  style: GoogleFonts.poppins(
                      fontSize: width / 57.57,
                      color: const Color(0xff000000)),
                ),
                SizedBox(width: 880,),
                //
                // InkWell(
                //   onTap:(){
                //     setState(() {
                //       viewtab=2;
                //     });
                //   },
                //   child: Material(
                //
                //     borderRadius: BorderRadius.circular(100),
                //     color: Colors.green,
                //     child: Container(
                //       height:40,
                //       width:100,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(100),
                //           color: Colors.green
                //       ),
                //       child: Center(child: Text("View",style: GoogleFonts.poppins(
                //           fontWeight: FontWeight.w700,
                //           color: Colors.white),)),
                //     ),
                //     elevation: 10,
                //   ),
                // ),


              ],
            ),
          ),
          SizedBox(height: height/41.143,),

              SizedBox(
                width:1100,
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Material(
                            elevation: 10,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding:  EdgeInsets.all(20),
                              child: SizedBox(
                                width: 500,
                                child: Center(
                                  child: Column(
                                    children: [

                                      Row(

                                        children: [
                                          SizedBox(
                                            child:
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Text(
                                                "File Name",
                                                style: GoogleFonts.poppins(
                                                    fontSize: width / 97.57,
                                                    color: const Color(0xff000000)),
                                              ),
                                              SizedBox(height: height/41.143,),

                                              Container(
                                                width: width / 4.0,
                                                height: height / 6.42,
                                                //color: Color(0xffDDDEEE),
                                                decoration: BoxDecoration(
                                                    color: const Color(0xffDDDEEE),
                                                    borderRadius: BorderRadius.circular(4)),
                                                child: TextField(
                                                  keyboardType: TextInputType.multiline,
                                                  controller: fileNamecon,
                                                  maxLines: null,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: width / 136.6),
                                                  decoration: InputDecoration(
                                                    hintText: "Type a File Name",
                                                    contentPadding: EdgeInsets.only(
                                                        left: width / 68.3,
                                                        bottom: height / 82.125),
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),),

                                          SizedBox(width: 40,),

                                          SizedBox(
                                            child:
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Text(
                                                "Select File",
                                                style: GoogleFonts.poppins(
                                                    fontSize: width / 97.57,
                                                    color: const Color(0xff000000)),
                                              ),
                                              SizedBox(height: height/41.143,),

                                              InkWell(
                                                onTap: (){
                                                  uploadToStorage();
                                                },
                                                child: Container(
                                                  width: width / 12.5,
                                                  height: height / 6.42,
                                                  //color: Color(0xffDDDEEE),
                                                  decoration: BoxDecoration(
                                                      color: const Color(0xffDDDEEE),
                                                      borderRadius: BorderRadius.circular(4),

                                                  image:  Uploaddocument==null?
                                                  DecorationImage(image:AssetImage("assets/icon_upload_file.png")):
                                                  DecorationImage(
                                                   image: MemoryImage(Uint8List.fromList(base64Decode(Uploaddocument!.split(',').last),),),
                                                  )
                                                  ),

                                                ),
                                              ),
                                            ],
                                          ),),
                                        ],
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                      ),

                                      SizedBox(height: 30,),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap:(){

                                            },
                                            child: Material(

                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.green,
                                              child: Container(
                                                height:50,
                                                width:150,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.green
                                                ),
                                                child: Center(child: Text("Save",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),)),
                                              ),
                                              elevation: 10,
                                            ),
                                          ),
                                        ],
                                      ),


                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          viewtab==1?
                          Material(
                            elevation: 10,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding:  EdgeInsets.all(20),
                              child: SizedBox(
                                width: 500,
                                child: Center(
                                  child: Lottie.asset("assets/PdfFiledoc.json")
                                ),
                              ),
                            ),
                          ):
                          Material(
                            elevation: 10,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding:  EdgeInsets.all(20),
                              child: SizedBox(
                                width: 500,
                                child: Center(
                                  child: Column(
                                    children: [

                                      Row(

                                        children: [
                                          SizedBox(
                                            child:
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Text(
                                                "File Name",
                                                style: GoogleFonts.poppins(
                                                    fontSize: width / 97.57,
                                                    color: const Color(0xff000000)),
                                              ),
                                              SizedBox(height: height/41.143,),

                                              Container(
                                                width: width / 4.0,
                                                height: height / 6.42,
                                                //color: Color(0xffDDDEEE),
                                                decoration: BoxDecoration(
                                                    color: const Color(0xffDDDEEE),
                                                    borderRadius: BorderRadius.circular(4)),
                                                child: TextField(
                                                  keyboardType: TextInputType.multiline,
                                                  controller: fileNamecon,
                                                  maxLines: null,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: width / 136.6),
                                                  decoration: InputDecoration(
                                                    hintText: "Type a File Name",
                                                    contentPadding: EdgeInsets.only(
                                                        left: width / 68.3,
                                                        bottom: height / 82.125),
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),),

                                          SizedBox(width: 40,),

                                          SizedBox(
                                            child:
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Text(
                                                "Select File",
                                                style: GoogleFonts.poppins(
                                                    fontSize: width / 97.57,
                                                    color: const Color(0xff000000)),
                                              ),
                                              SizedBox(height: height/41.143,),

                                              InkWell(
                                                onTap: (){
                                                  uploadToStorage();
                                                },
                                                child: Container(
                                                  width: width / 12.5,
                                                  height: height / 6.42,
                                                  //color: Color(0xffDDDEEE),
                                                  decoration: BoxDecoration(
                                                      color: const Color(0xffDDDEEE),
                                                      borderRadius: BorderRadius.circular(4),

                                                  image:  Uploaddocument==null?
                                                  DecorationImage(image:AssetImage("assets/icon_upload_file.png")):
                                                  DecorationImage(
                                                   image: MemoryImage(Uint8List.fromList(base64Decode(Uploaddocument!.split(',').last),),),
                                                  )
                                                  ),

                                                ),
                                              ),
                                            ],
                                          ),),
                                        ],
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                      ),

                                      SizedBox(height: 30,),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap:(){

                                            },
                                            child: Material(

                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.green,
                                              child: Container(
                                                height:50,
                                                width:150,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.green
                                                ),
                                                child: Center(child: Text("Submit",style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),)),
                                              ),
                                              elevation: 10,
                                            ),
                                          ),
                                        ],
                                      ),


                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height:20),
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
                            physics: const NeverScrollableScrollPhysics(),
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
                                      width: 650,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black)
                                      ),
                                      child: Center(
                                        child: Text(
                                          "File Name",
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
                                          "Actions",
                                          style:
                                          GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance.collection("Forms").orderBy("timestamp").snapshots(),
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

                                        var data=snapshot.data!.docs[index];
                                        return
                                          Row(

                                            crossAxisAlignment: CrossAxisAlignment.center,

                                            children: [


                                              Container(
                                                width: 50,
                                                height: 45,
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
                                                width: 650,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black)
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    data['filename'].toString(),
                                                    style:
                                                    GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                  ),
                                                ),
                                              ),

                                              Container(
                                                width: 200,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black)
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    data['date'].toString(),
                                                    style:
                                                    GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                  ),
                                                ),
                                              ),

                                              Container(
                                                width: 200,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black)
                                                ),
                                                child:
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [

                                                    InkWell(
                                                      onTap:(){
                                                        _deletepopup(data.id);
                                                      },
                                                      child: Material(

                                                        borderRadius: BorderRadius.circular(100),
                                                        color: Colors.white,
                                                        child: Container(
                                                          height:31,
                                                          width:80,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(100),
                                                              color: Colors.white
                                                          ),
                                                          child: Center(child: Icon(Icons.delete)),
                                                        ),
                                                        elevation: 10,
                                                      ),
                                                    ),

                                                    InkWell(
                                                      onTap:(){

                                                        setState(() {
                                                          viewtab=1;
                                                        });
                                                      },
                                                      child: Material(

                                                        borderRadius: BorderRadius.circular(100),
                                                        color: Colors.white,
                                                        child: Container(
                                                          height:31,
                                                          width:80,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(100),
                                                              color: Colors.white
                                                          ),
                                                          child: Center(child: Icon(Icons.edit)),
                                                        ),
                                                        elevation: 10,
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
                      ),
                      SizedBox(height:40),
                    ],
                  ),
                ),
              )
       





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
    FirebaseFirestore.instance.collection("Forms").doc(id).delete();
  }





  ///Image Picke Function

  uploadToStorage() async {
    InputElement input = FileUploadInputElement() as InputElement..accept = 'image/*';
    input.click();
    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        setState(() {
          Uploaddocument=reader.result;
        });
        setState(() {
          Url=file;
        });
      });

      print("Uploaddocumentttttttttttttttttttttttt");
      print(Uploaddocument);

    });

  }

  savedocumentdata() async {
    var snapshot = await FirebaseStorage.instance.ref().child('Images').child(Url!.name).putBlob(Url);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      imgUrl=downloadUrl;
    });

  }

  createDocumentfun(){
    savedocumentdata();
    FirebaseFirestore.instance.collection("Forms").doc().set({
      "date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "Url":imgUrl,
      "timestamp":DateTime.now().microsecondsSinceEpoch,
      "filename":fileNamecon.text,
    });
    clearfun();
  }

  clearfun(){
    setState(() {
      fileNamecon.clear();
      Uploaddocument="";
      Url=null;
      imgUrl="";
    });
  }

}
