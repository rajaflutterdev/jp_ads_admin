import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Permissions_Page extends StatefulWidget {
  String Usertype;
   Permissions_Page({ required this.Usertype});

  @override
  State<Permissions_Page> createState() => _Permissions_PageState();
}

class _Permissions_PageState extends State<Permissions_Page> {

  bool dashboard = false;
  bool Distributorisuser = false;
  bool Distributorappiled = false;
  bool Distributorcorrection = false;
  bool Distributorreports = false;
  bool Indicidualuser = false;
  bool Indicidualapplied = false;
  bool Indicidualcorrection = false;
  bool Notification = false;
  bool Slider = false;
  bool minor_Tab = false;
  bool Indicidualreports = false;
  bool forms = false;
  bool supports = false;
  bool faq = false;
  String Uservalue="Select";
  String Userdocid="";
  String Authusertype="admin";

  final  _formKey=GlobalKey<FormState>();

  List<String>PermissionLis = [];
  List<String>list = [];


  TextEditingController userName=TextEditingController();
  TextEditingController passWord=TextEditingController();


  @override
  void initState() {
    staffpermision();
    // TODO: implement initState
    super.initState();
  }

  staffpermision() async {
    setState(() {
      PermissionLis.clear();
      list.clear();
    });
    setState(() {
      list.add("Select");
    });
    var doc1 = await FirebaseFirestore.instance.collection("AdminUser").get();
    for(int i=0;i<doc1.docs.length;i++){
      setState(() {
        list.add(doc1.docs[i]['username']);
      });
    }

    var document = await FirebaseFirestore.instance.collection("AdminUser").where("username",isEqualTo:widget.Usertype).get();
    for(int j=0;j<document.docs.length;j++){
      setState(() {
        Userdocid=document.docs[j].id;
      });

      for(int i=0;i<document.docs[j]['permission'].length;i++){
        if(document.docs[j]['permission'][i]=="Dashboard"){
          setState(() {
            dashboard=true;
            PermissionLis.add("Dashboard");
          });
        }

        if(document.docs[j]['permission'][i]=="Distributor user"){
          setState(() {
            Distributorisuser=true;
            PermissionLis.add("Distributor user");
          });
        }

        if(document.docs[j]['permission'][i]=="Distributor applied"){
          setState(() {
            Distributorappiled=true;
            PermissionLis.add("Distributor applied");
          });
        }

        if(document.docs[j]['permission'][i]=="Distributor correction"){
          setState(() {
            Distributorcorrection=true;
            PermissionLis.add("Distributor correction");
          });
        }

        if(document.docs[j]['permission'][i]=="Distributor reports"){
          setState(() {
            Distributorreports=true;
            PermissionLis.add("Distributor reports");
          });
        }

        if(document.docs[j]['permission'][i]=="Individual user"){
          setState(() {
            Indicidualuser=true;
            PermissionLis.add("Individual user");
          });
        }

        if(document.docs[j]['permission'][i]=="Individual applied"){
          setState(() {
            Indicidualapplied=true;
            PermissionLis.add("Individual applied");
          });
        }

        if(document.docs[j]['permission'][i]=="Individual correction"){
          setState(() {
            Indicidualcorrection=true;
            PermissionLis.add("Individual correction");
          });
        }

        if(document.docs[j]['permission'][i]=="Individual reports"){
          setState(() {
            Indicidualreports=true;
            PermissionLis.add("Individual reports");
          });
        }

        if(document.docs[j]['permission'][i]=="Notification"){
          setState(() {
            Notification=true;
            PermissionLis.add("Notification");
          });
        }

        if(document.docs[j]['permission'][i]=="Slider"){
          setState(() {
            Slider=true;
            PermissionLis.add("Slider");
          });
        }
        if(document.docs[j]['permission'][i]=="Minor Pancard"){
          setState(() {
            minor_Tab=true;
            PermissionLis.add("Minor Pancard");
          });
        }

        if(document.docs[j]['permission'][i]=="Forms"){
          setState(() {
            forms=true;
            PermissionLis.add("Forms");
          });
        }

        if(document.docs[j]['permission'][i]=="Support"){
          setState(() {
            supports=true;
            PermissionLis.add("Support");
          });
        }
        if(document.docs[j]['permission'][i]=="FAQ"){
          setState(() {
            faq=true;
            PermissionLis.add("FAQ");
          });
        }



      }
    }
    setState(() {
      Uservalue=widget.Usertype!;
    });

  }

    @override
    Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
      return
        Padding(
        padding:  EdgeInsets.only(left:10),
        child: SingleChildScrollView(
          physics:const  ScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: width / 75.77,top: height/61.43),
                    child: Text(
                      " Permissions",
                      style: GoogleFonts.poppins(
                          fontSize: width / 57.57,
                          color: const Color(0xff000000)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height/41.143,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width:40),
                  SizedBox(

                      child: Row(
                    children: [
                      Text("Select the Role  : ",style: GoogleFonts.poppins(fontWeight: FontWeight.w700),),
                      SizedBox(width:10),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffFFFFFF),
                        child: SizedBox(
                          width:250,
                          height:50,

                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2<String>(
                              isExpanded: true,
                              hint: Text(
                                'Select',
                                style: GoogleFonts.poppins(
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: list.map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style:  GoogleFonts.poppins(
                                  ),
                                ),
                              ))
                                  .toList(),
                              value: Uservalue,
                              onChanged: (String? value) {
                                setState(() {
                                  Uservalue = value!;
                                });
                                setthevalue(value);
                              },
                              buttonStyleData:  ButtonStyleData(
                              ),decoration: InputDecoration(
                                border: InputBorder.none
                            ),

                            ),
                          ),
                        ),
                      ),
                    ],
                  )),

                  SizedBox(width:50),

                  InkWell(
                    onTap: (){
                      adduserdialogBox();
                    },
                    child: Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: const Center(child:  Text("Add User",style: TextStyle(color: Colors.white),))
                    ),
                  ),
                ],
              ),

              SizedBox(height: height/41.143,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(

                  children: [

                    SizedBox(height: 30,),

                    Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              Checkbox(
                                  value: dashboard,
                                  onChanged: (val) {
                                    setState(() {
                                      dashboard = !dashboard;
                                    });
                                    if (dashboard == true) {
                                      PermissionLis.add("Dashboard");
                                    }
                                    else{
                                      PermissionLis.remove("Dashboard");
                                    }
                                  }),
                              SizedBox(width: 5,),
                              Text("DashBoard"),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              Checkbox(
                                  value: Distributorisuser,
                                  onChanged: (val) {
                                    setState(() {
                                      Distributorisuser =
                                      !Distributorisuser;
                                      if (Distributorisuser == true) {
                                        PermissionLis.add("Distributor user");
                                      }
                                      else{
                                        PermissionLis.remove("Distributor user");
                                      }
                                    });
                                  }),
                              SizedBox(width: 5,),
                              Text("Distributor Users"),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              Checkbox(
                                  value: Distributorappiled,
                                  onChanged: (val) {
                                    setState(() {
                                      Distributorappiled =
                                      !Distributorappiled;
                                    });
                                    if (Distributorappiled == true) {
                                      PermissionLis.add("Distributor applied");
                                    }
                                    else{
                                      PermissionLis.remove("Distributor applied");
                                    }
                                  }),
                              SizedBox(width: 5,),
                              Text("Distributor Applied"),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              Checkbox(
                                  value: Distributorcorrection,
                                  onChanged: (val) {
                                    setState(() {
                                      Distributorcorrection =
                                      !Distributorcorrection;
                                    });
                                    if (Distributorcorrection == true) {
                                      PermissionLis.add("Distributor correction");
                                    }
                                    else{
                                      PermissionLis.remove("Distributor correction");
                                    }

                                  }),
                              SizedBox(width: 5,),
                              Text("Distributor Correction"),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              Checkbox(
                                  value: Distributorreports,
                                  onChanged: (val) {
                                    setState(() {
                                      Distributorreports =
                                      !Distributorreports;
                                    });
                                    if (Distributorreports == true) {
                                      PermissionLis.add("Distributor reports");
                                    }
                                    else{
                                      PermissionLis.remove("Distributor reports");
                                    }
                                  }),
                              SizedBox(width: 5,),
                              Text("Distributor Reports"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),

                    Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              Checkbox(
                                  value: Indicidualuser,
                                  onChanged: (val) {
                                    setState(() {
                                      Indicidualuser =
                                      !Indicidualuser;
                                    });
                                    if (Indicidualuser == true) {
                                      PermissionLis.add("Individual user");
                                    }
                                    else{
                                      PermissionLis.remove("Individual user");
                                    }
                                  }),
                              SizedBox(width: 5,),
                              Text("Indicidual users"),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              Checkbox(
                                  value: Indicidualapplied,
                                  onChanged: (val) {
                                    setState(() {
                                      Indicidualapplied =
                                      !Indicidualapplied;
                                    });
                                    if (Indicidualapplied == true) {
                                      PermissionLis.add("Individual applied");
                                    }
                                    else{
                                      PermissionLis.remove("Individual applied");
                                    }
                                  }),
                              SizedBox(width: 5,),
                              Text("Individual Applied"),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              Checkbox(
                                  value: Indicidualcorrection,
                                  onChanged: (val) {
                                    setState(() {
                                      Indicidualcorrection =
                                      !Indicidualcorrection;
                                    });
                                    if (Indicidualcorrection == true) {
                                      PermissionLis.add("Individual correction");
                                    }
                                    else{
                                      PermissionLis.remove("Individual correction");
                                    }
                                  }),
                              SizedBox(width: 5,),
                              Text("Individual Correction"),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              Checkbox(
                                  value: Indicidualreports,
                                  onChanged: (val) {
                                    setState(() {
                                      Indicidualreports =
                                      !Indicidualreports;
                                    });
                                    if (Indicidualreports == true) {
                                      PermissionLis.add("Individual reports");
                                    }
                                    else{
                                      PermissionLis.remove("Individual reports");
                                    }
                                  }),
                              SizedBox(width: 5,),
                              Text("Individual Reports"),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              Checkbox(
                                  value: Slider,
                                  onChanged: (val) {
                                    setState(() {
                                      Slider = !Slider;
                                    });
                                    if (Slider == true) {
                                      PermissionLis.add("Slider");
                                    }
                                    else{
                                      PermissionLis.remove("Slider");
                                    }
                                  }),
                              SizedBox(width: 5,),
                              Text("Slider"),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 30,),
                    Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              Checkbox(
                                  value: Notification,
                                  onChanged: (val) {
                                    setState(() {
                                      Notification =
                                      !Notification;
                                    });
                                    if (Notification == true) {
                                      PermissionLis.add("Notification");
                                    }
                                    else{
                                      PermissionLis.remove("Notification");
                                    }
                                  }),
                              SizedBox(width: 5,),
                              Text("Notification"),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              Checkbox(
                                  value: minor_Tab,
                                  onChanged: (val) {
                                    setState(() {
                                      minor_Tab =
                                      !minor_Tab;
                                    });
                                    if (minor_Tab == true) {
                                      PermissionLis.add("Minor Pancard");
                                    }
                                    else{
                                      PermissionLis.remove("Minor Pancard");
                                    }
                                  }),
                              SizedBox(width: 5,),
                              Text("Minor Pancard"),
                            ],
                          ),
                        ),

                        SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              Checkbox(
                                  value: forms,
                                  onChanged: (val) {
                                    setState(() {
                                      forms =
                                      !forms;
                                    });
                                    if (forms == true) {
                                      PermissionLis.add("Forms");
                                    }
                                    else{
                                      PermissionLis.remove("Forms");
                                    }
                                  }),
                              SizedBox(width: 5,),
                              Text("Minor Pancard"),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              Checkbox(
                                  value: supports,
                                  onChanged: (val) {
                                    setState(() {
                                      supports =
                                      !supports;
                                    });
                                    if (supports == true) {
                                      PermissionLis.add("Support");
                                    }
                                    else{
                                      PermissionLis.remove("Support");
                                    }
                                  }),
                              SizedBox(width: 5,),
                              Text("Support"),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              Checkbox(
                                  value: faq,
                                  onChanged: (val) {
                                    setState(() {
                                      faq =
                                      !faq;
                                    });
                                    if (faq == true) {
                                      PermissionLis.add("FAQ");
                                    }
                                    else{
                                      PermissionLis.remove("FAQ");
                                    }
                                  }),
                              SizedBox(width: 5,),
                              Text("FAQ"),
                            ],
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 30,),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){
                            updatefunction();
                            successpopuop("Permission Add Successfully....");
                          },
                          child: Container(
                              width: 150,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: const Center(child:  Text("Add Permission",style: TextStyle(color: Colors.white),))
                          ),
                        ),
                        SizedBox(width: 50,),
                      ],
                    )

                  ],
                ),
              ),

              SizedBox(height: height/41.143,),
              SizedBox(height:20),
              Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: width / 75.77,top: height/61.43),
                    child: Text(
                      "Users Lists",
                      style: GoogleFonts.poppins(
                          fontSize: width / 57.57,
                          color: const Color(0xff000000)),
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
                                  "User Name",
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
                                  "Password",
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
                          stream: FirebaseFirestore.instance.collection("AdminUser").orderBy("timestamp").snapshots(),
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
                                            data['username'].toString(),
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
                                            data['password'].toString(),
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
                                        Center(
                                          child: InkWell(
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
      );
    }

    ///Permission update function
    updatefunction() async {
      FirebaseFirestore.instance.collection("AdminUser").doc(Userdocid).update({
        "permission":PermissionLis
      });

    }

    successpopuop(name) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    showDialog(
      context: context,
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(
              left: width / 4.268,
              right: width / 2.845,
              top: height / 4.106,
              bottom: height / 4.106),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xffF3E8FF),
          ),
          child: Column(
            children: [
              SizedBox(
                height: height / 16.425,
              ),
              SizedBox(
                height: height / 3.750,
                width: width / 11.383,
                child: Lottie.network(
                    "https://assets8.lottiefiles.com/private_files/lf30_nsqfzxxx.json"),
              ),
              SizedBox(
                height: height / 54.75,
              ),
              Text(name,
                style: GoogleFonts.poppins(
                    fontSize: width / 77.613,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              SizedBox(
                height: height / 82.1250,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //cancel button
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: height / 18.464,
                      width: width / 11.383,
                      decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: width / 106.718),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: width / 34.15,
                  ),

                  //okay button
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: height / 18.464,
                      width: width / 11.383,
                      decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                          child: Text(
                            "Okay",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: width / 106.718),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: width / 34.15,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

    setthevalue(value) async {
    print("Entereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    setState(() {
      PermissionLis.clear();

       dashboard = false;
       Distributorisuser = false;
       Distributorappiled = false;
       Distributorcorrection = false;
       Distributorreports = false;
       Indicidualuser = false;
       Indicidualapplied = false;
       Indicidualcorrection = false;
       Notification = false;
       Slider = false;
       minor_Tab = false;
       Indicidualreports = false;
    });
    var document = await FirebaseFirestore.instance.collection("AdminUser").where("username",isEqualTo:value).get();
    for(int j=0;j<document.docs.length;j++){
      setState(() {
        Userdocid=document.docs[j].id;
      });
      print(Userdocid);
      print(PermissionLis);
      for(int i=0;i<document.docs[j]['permission'].length;i++){
        if(document.docs[j]['permission'][i]=="Dashboard"){
          setState(() {
            dashboard=true;
            PermissionLis.add("Dashboard");
          });
        }
        if(document.docs[j]['permission'][i]=="Distributor user"){
          setState(() {
            Distributorisuser=true;
            PermissionLis.add("Distributor user");
          });
        }

        if(document.docs[j]['permission'][i]=="Distributor applied"){
          setState(() {
            Distributorappiled=true;
            PermissionLis.add("Distributor applied");
          });
        }

        if(document.docs[j]['permission'][i]=="Distributor correction"){
          setState(() {
            Distributorcorrection=true;
            PermissionLis.add("Distributor correction");
          });
        }

        if(document.docs[j]['permission'][i]=="Distributor reports"){
          setState(() {
            Distributorreports=true;
            PermissionLis.add("Distributor reports");
          });
        }

        if(document.docs[j]['permission'][i]=="Individual user"){
          setState(() {
            Indicidualuser=true;
            PermissionLis.add("Individual user");
          });
        }

        if(document.docs[j]['permission'][i]=="Individual applied"){
          setState(() {
            Indicidualapplied=true;
            PermissionLis.add("Individual applied");
          });
        }

        if(document.docs[j]['permission'][i]=="Individual correction"){
          setState(() {
            Indicidualcorrection=true;
            PermissionLis.add("Individual correction");
          });
        }

        if(document.docs[j]['permission'][i]=="Individual reports"){
          setState(() {
            Indicidualreports=true;
            PermissionLis.add("Individual reports");
          });
        }

        if(document.docs[j]['permission'][i]=="Notification"){
          setState(() {
            Notification=true;
            PermissionLis.add("Notification");
          });
        }

        if(document.docs[j]['permission'][i]=="Silders"){
          setState(() {
            Slider=true;
            PermissionLis.add("Silders");
          });
        }

        if(document.docs[j]['permission'][i]=="Minor Pancard"){
          setState(() {
            minor_Tab=true;
            PermissionLis.add("Minor Pancard");
          });
        }

      }
    }
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
    FirebaseFirestore.instance.collection("AdminUser").doc(id).delete();
    staffpermision();
  }

///create document function
  documentcreatfunc(){
    FirebaseFirestore.instance.collection("AdminUser").doc().set({
      "Type":Authusertype,
      "password":passWord.text,
      "permission":[],
      "username":userName.text,
      "timestamp":DateTime.now().millisecondsSinceEpoch
    });
    setState(() {
      Authusertype="";
      passWord.clear();
      userName.clear();
    });
    staffpermision();
    Navigator.pop(context);
    successpopuop("New User Add Successfully....");

  }


  adduserdialogBox(){
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      context: context, builder:(context) {
      return
        StatefulBuilder(builder: (context, setState) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 100,bottom: 100,left: 350,right:350),
              child: Material(
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
                          Text("Add New User",style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: width/68.3),),

                          SizedBox(
                            child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  "User Name",
                                  style: GoogleFonts.poppins(
                                      fontSize: width / 97.57,
                                      color: const Color(0xff000000)),
                                ),
                                SizedBox(height: height/41.143,),

                                Container(
                                  width: width / 3.0,
                                  height: height / 14.42,
                                  //color: Color(0xffDDDEEE),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffDDDEEE),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: TextFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp("[a-z]")),
                                    ],
                                    controller: userName,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    style: GoogleFonts.poppins(
                                        fontSize: width / 106.6),
                                    decoration: InputDecoration(
                                      hintText: "Type a User Name",
                                      contentPadding: EdgeInsets.only(
                                          left: width / 68.3,
                                          bottom: height / 82.125),
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) => value!.isEmpty?"Field is Empty":null,
                                  ),
                                ),
                              ],
                            ),),
                          SizedBox(height:height/45.5),

                          SizedBox(
                            child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  "Password",
                                  style: GoogleFonts.poppins(
                                      fontSize: width / 97.57,
                                      color: const Color(0xff000000)),
                                ),
                                SizedBox(height: height/41.143,),

                                Container(
                                  width: width / 3.0,
                                  height: height / 14.42,
                                  //color: Color(0xffDDDEEE),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffDDDEEE),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: TextFormField(
                                    controller: passWord,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    style: GoogleFonts.poppins(
                                        fontSize: width / 106.6),
                                    decoration: InputDecoration(
                                      hintText: "Type a Password",
                                      contentPadding: EdgeInsets.only(
                                          left: width / 68.3,
                                          bottom: height / 82.125),
                                      border: InputBorder.none,
                                    ),
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return  "Field is Empty";
                                        }
                                         if(value!.isNotEmpty){
                                          if(value.length!=6){
                                            return  "Please fill the Password";
                                          }
                                        }
                                      }

                                  ),
                                ),
                              ],
                            ),),
                          SizedBox(height:height/45.5),
                          Text(
                            "( Hint : User Name Allows Only Email Address and Password is 6 Characters )",
                            style: GoogleFonts.poppins(
                                fontSize: width / 97.57,
                                color: const Color(0xff000000)),
                          ),
                          SizedBox(height:height/45.5),
                          Row(
                            children: [
                              SizedBox(width:85),
                              Text("Select the User Type",style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: width/68.3),),
                            ],
                          ),

                          SizedBox(
                            height:60,
                            width:600,

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width:150,
                                  child: RadioListTile(
                                    title: const Text("Admin"),
                                    value: "admin",
                                    groupValue: Authusertype,
                                    onChanged: (value){
                                      setState(() {
                                        Authusertype = value.toString();
                                      });
                                    },
                                  ),
                                ),

                                SizedBox(
                                  width:160,
                                  child: RadioListTile(
                                    title: const Text("Staff"),
                                    value: "staff",
                                    groupValue: Authusertype,
                                    onChanged: (value){
                                      setState(() {
                                        Authusertype = value.toString();
                                      });
                                    },
                                  ),
                                ),

                                SizedBox(
                                  width:160,
                                  child: RadioListTile(
                                    title: const Text("Others"),
                                    value: "others",
                                    groupValue: Authusertype,
                                    onChanged: (value){
                                      setState(() {
                                        Authusertype = value.toString();
                                      });
                                    },
                                  ),
                                ),


                              ],
                            ),
                          ),
                          SizedBox(height:height/40.5),
                          InkWell(
                            onTap: (){
                              if(_formKey.currentState!.validate()&&passWord.text.length>=6){
                                documentcreatfunc();
                              }


                            },
                            child: Container(
                                width: 120,
                                height: 38,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: const Center(child:  Text("Submit",style: TextStyle(color: Colors.white),))
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },);
    },);
  }


}