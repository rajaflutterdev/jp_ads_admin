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
  TextEditingController editfileNamecon=TextEditingController();
  String fileName = const Uuid().v1();
  File? Url;
  File? Url2;
  var Uploaddocument;
  var Uploaddocument2;
  String imgUrl="";
  String imgUrl2="";
  String documentId="";

  bool Loading=false;


  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      alignment: Alignment.center,
      children: [
        SingleChildScrollView(
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
                    //       width: width/13.66,
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
                    height:580,
                    width:1100,
                    child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Form(
                            key: _formKey,
                            child: Row(
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
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.multiline,
                                                        controller: fileNamecon,
                                                        maxLines: null,
                                                        style: GoogleFonts.poppins(
                                                            fontSize: width /97.571),
                                                        decoration: InputDecoration(
                                                          hintText: "Type a File Name",
                                                          contentPadding: EdgeInsets.only(
                                                              left: width / 68.3,
                                                              bottom: height / 82.125),
                                                          border: InputBorder.none,
                                                        ),
                                                        validator: (value) => value!.isEmpty?"Field is Empty":null,
                                                        onChanged: (val){
                                                          val.isEmpty?"":
                                                          editcontrollerclearfun();
                                                        },
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
                                                        DecorationImage(image:AssetImage("assets/PdfImage.png"))

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
                                                    if(_formKey.currentState!.validate()){
                                                      setState(() {
                                                        Loading=true;
                                                      });
                                                      savedocumentdata();
                                                    }
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

                                viewtab==0?
                                Material(
                                  elevation: 10,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  child: Padding(
                                    padding:  EdgeInsets.all(20),
                                    child: SizedBox(
                                      width: 500,
                                      height:220,
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
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.multiline,
                                                        controller: editfileNamecon,
                                                        maxLines: null,
                                                        style: GoogleFonts.poppins(
                                                            fontSize: width /97.571),
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

                                                        uploadToStorage2();

                                                      },
                                                      child: Container(
                                                        width: width / 12.5,
                                                        height: height / 6.42,
                                                        decoration: BoxDecoration(
                                                            color: const Color(0xffDDDEEE),
                                                            borderRadius: BorderRadius.circular(4),
                                                        image:  imgUrl2==null?
                                                        DecorationImage(image:AssetImage("assets/icon_upload_file.png")):
                                                        DecorationImage(image:AssetImage("assets/PdfImage.png"))

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
                                                    setState((){
                                                      Loading=true;
                                                    });
                                                    editdocumentdata();
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
                          ),

                          SizedBox(height:20),

                          SizedBox(
                            height:436,
                            width:1100,
                            child:
                            SingleChildScrollView(
                              physics: const ScrollPhysics(),
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
                                          width: 50,
                                          height: 40,
                                          child: Center(
                                            child: Text(
                                              "Si.No",
                                              style:
                                              GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          width: 650,
                                          height: 40,
                                          child: Center(
                                            child: Text(
                                              "File Name",
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
                                              "Date",
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
                                    stream: FirebaseFirestore.instance.collection("Forms").orderBy("timestamp",descending: true).snapshots(),
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
                                            Padding(
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
                                                        width: 50,
                                                        height: 45,
                                                        child: Center(
                                                          child: Text(
                                                            (index+1).toString(),
                                                            style:
                                                            GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                          ),
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width: 650,
                                                        height: 45,
                                                        child: Center(
                                                          child: Text(
                                                            data['filename'].toString(),
                                                            style:
                                                            GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                          ),
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width: 200,
                                                        height: 45,
                                                        child: Center(
                                                          child: Text(
                                                            data['date'].toString(),
                                                            style:
                                                            GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                          ),
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width: 200,
                                                        height: 45,
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
                                                                if(viewtab==1){
                                                                  editcontrollerclearfun();
                                                                }else{
                                                                  setState(() {
                                                                    viewtab=1;
                                                                  });
                                                                  editdatafun(data.id);
                                                                }
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
                                                                  child: Center(child:
                                                                  data.id==documentId?Icon(Icons.clear):
                                                                  Icon(Icons.edit)),
                                                                ),
                                                                elevation: 10,
                                                              ),
                                                            ),

                                                          ],
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
                          ),
                          SizedBox(height:20),
                        ],
                      ),
                    ),
                  )
            ],

          ),
        ),
        Loading==true?
        Material(
          elevation: 15,
          shadowColor: Colors.indigo,
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          child: Container(
            height: height / 2.38,
            width: width / 5.106,
           decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.circular(5)
           ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  "assets/FsRGzkbt6x.json",
                  height: height / 3.38,
                  width: width / 6.106,
                ),
                SizedBox(height:height/45.1),
                Text("Please Wait",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600, color: Colors.black))
              ],
            ),
          ),
        )
            :SizedBox()
      ],
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

  uploadToStorage()  {
    InputElement input = FileUploadInputElement() as InputElement..accept ='/*';
    input.click();
    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        print("Enytereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
        setState(() {
          Url=file;
          Uploaddocument=reader.result;
        });
        print("uploaddocumenttttttttttttttttttt$Uploaddocument");
        print("Url filenameeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee$Url");
      });


    });

  }

  savedocumentdata() async {
    var snapshot = await FirebaseStorage.instance.ref().child('Images').child(Url!.name).putBlob(Url);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      imgUrl=downloadUrl;
    });
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
      Uploaddocument=null;
      Url=null;
      imgUrl="";
      Loading=false;
    });
  }



  uploadToStorage2(){
    InputElement input = FileUploadInputElement() as InputElement..accept = '/*';
    input.click();
    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        setState(() {
          Url2=file;
          Uploaddocument2=reader.result;
        });
        print(Uploaddocument2);
        print(Url2);

      });




    });

  }

  editdocumentdata() async {

    var snapshot = await FirebaseStorage.instance.ref().child('Images').child(Url2!.name).putBlob(Url2);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      imgUrl2=downloadUrl;
    });
    FirebaseFirestore.instance.collection("Forms").doc(documentId).update({
      'filename':editfileNamecon.text,
      "Url":imgUrl2,
    });
    editcontrollerclearfun();
  }

  editdatafun(docid)async{
    var data= await FirebaseFirestore.instance.collection("Forms").doc(docid).get();
    Map<String,dynamic>?value=data.data();
    setState((){
      editfileNamecon.text=value!['filename'];
      imgUrl2=value['Url'];
      documentId=docid;
    });
print(imgUrl2);
print(imgUrl2);
print(editfileNamecon.text);
  }


  editcontrollerclearfun(){
    setState(() {
      viewtab=0;
      editfileNamecon.clear();
      imgUrl2="";
      Uploaddocument2=null;
      documentId="";
      Loading=false;
    });
  }

  deleteFireBaseStorageItem(String fileUrl){

    String filePath = 'https://firebasestorage.googleapis.com/v0/b/dial-i-2345.appspot.com/o/default_images%2Fuser.png?alt=media&token=c2ccceec-8d24-42fe-b5c0-c987733ac8ae'.
    replaceAll(new
    RegExp(r'https://console.firebase.google.com/project/jp-ads-526d7/storage/jp-ads-526d7.appspot.com/files'), '');

    FirebaseStorage.instance.ref().child(filePath).delete().then((_) => print('Successfully deleted $filePath storage item' ));

  }

}
