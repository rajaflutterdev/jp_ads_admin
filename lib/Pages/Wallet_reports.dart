import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Wallet_reports extends StatefulWidget {
  const Wallet_reports({super.key});

  @override
  State<Wallet_reports> createState() => _Wallet_reportsState();
}




class _Wallet_reportsState extends State<Wallet_reports> with SingleTickerProviderStateMixin {


  TabController?tabController;
  int selectTabIndex=0;
  @override
  void initState() {
    tabController=TabController(length: 2, vsync: this)  ;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(

        children: [

          Padding(
            padding:  EdgeInsets.only(left: width / 75.77,right:  width / 25.77,top:height/30.571
            ),
            child: Row(
              children: [
                Text(
                  "Wallet Reports",
                  style: GoogleFonts.poppins(
                      fontSize: width / 57.57,
                      color: const Color(0xff000000)),
                ),
              ],
            ),
          ),
          SizedBox(height: height/41.143,),
          Center(
            child: Container(
              height: 50,
              width:1100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TabBar(
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
                    child:  const Text("Individual"),
                  ),
                  Tab(
                    child: const Text("Distributors"),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: height/41.143,),


          SizedBox(
            height: 430,
            child: TabBarView(
              controller: tabController,
              children: [

               ///Individual
                SizedBox(
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width:1100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color:  const Color(0xffd8e6ff),
                          ),
                          child: Row(

                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: [

                              SizedBox(
                                width: 100,
                                height:40,
                                child: Center(
                                  child: Text(
                                    "Si.No",
                                    style:
                                    GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 300,
                                height:40,

                                child: Center(
                                  child: Text(
                                    "Name",
                                    style:
                                    GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 200,
                                height:40,

                                child: Center(
                                  child: Text(
                                    "Phone Number",
                                    style:
                                    GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 200,
                                height:40,
                                child: Center(
                                  child: Text(
                                    "Wallet Amount",
                                    style:
                                    GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 150,
                                height:40,

                                child: Center(
                                  child: Text(
                                    "Date",
                                    style:
                                    GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 150,
                                height:40,

                                child: Center(
                                  child: Text(
                                    "Time",
                                    style:
                                    GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),


                        SizedBox(height: 8,),
                        SizedBox(
                          width:1100,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection("Wallet_Transcation").orderBy("timestamp",descending: true).snapshots(),
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


                                    if(_Userdata['userType']=='Individual'){
                                      return
                                        Padding(
                                          padding:  EdgeInsets.only(bottom:8),
                                          child: Material(
                                            color: const Color(0xffFFFFFF),
                                            elevation: 20,
                                            shadowColor: Colors.black12,
                                            child: SizedBox(
                                              height: 40,
                                              width:1100,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,

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
                                                    width: 300,
                                                    height:40,
                                                    child: Center(
                                                      child: Text(
                                                        _Userdata["name"].toString(),
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    width: 200,
                                                    height:40,
                                                    child: Center(
                                                      child: Text(
                                                        _Userdata["Phoneno"].toString(),
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    width: 200,
                                                    height:40,
                                                    child: Center(
                                                      child: Text(
                                                        _Userdata["Amount"].toString(),
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    width: 150,
                                                    height:40,
                                                    child: Center(
                                                      child: Text(
                                                        _Userdata["date"].toString(),
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    width: 150,
                                                    height:40,
                                                    child: Center(
                                                      child: Text(
                                                        _Userdata["time"].toString(),
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                      ),
                                                    ),
                                                  ),



                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                    }
                                    return  SizedBox(
                                        height:250,
                                        child:Center(child: Text("No data",style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: 18),),)
                                    );

                                  },);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                ///distributor

                SizedBox(
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width:1100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color:  const Color(0xffd8e6ff),
                          ),
                          child: Row(

                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: [

                              SizedBox(
                                width: 100,
                                height:40,
                                child: Center(
                                  child: Text(
                                    "Si.No",
                                    style:
                                    GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 300,
                                height:40,

                                child: Center(
                                  child: Text(
                                    "Name",
                                    style:
                                    GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 200,
                                height:40,

                                child: Center(
                                  child: Text(
                                    "Phone Number",
                                    style:
                                    GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 200,
                                height:40,
                                child: Center(
                                  child: Text(
                                    "Wallet Amount",
                                    style:
                                    GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 150,
                                height:40,

                                child: Center(
                                  child: Text(
                                    "Date",
                                    style:
                                    GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 150,
                                height:40,

                                child: Center(
                                  child: Text(
                                    "Time",
                                    style:
                                    GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000),fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),


                        SizedBox(height: 8,),
                        SizedBox(
                          width:1100,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection("Wallet_Transcation").orderBy("timestamp",descending: true).snapshots(),
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


                                    if(_Userdata['userType']=='Distributor'){
                                      return
                                        Padding(
                                          padding:  EdgeInsets.only(bottom:8),
                                          child: Material(
                                            color: const Color(0xffFFFFFF),
                                            elevation: 20,
                                            shadowColor: Colors.black12,
                                            child: SizedBox(
                                              height: 40,
                                              width:1100,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,

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
                                                    width: 300,
                                                    height:40,
                                                    child: Center(
                                                      child: Text(
                                                        _Userdata["name"].toString(),
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    width: 200,
                                                    height:40,
                                                    child: Center(
                                                      child: Text(
                                                        _Userdata["Phoneno"].toString(),
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    width: 200,
                                                    height:40,
                                                    child: Center(
                                                      child: Text(
                                                        _Userdata["Amount"].toString(),
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    width: 150,
                                                    height:40,
                                                    child: Center(
                                                      child: Text(
                                                        _Userdata["date"].toString(),
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    width: 150,
                                                    height:40,
                                                    child: Center(
                                                      child: Text(
                                                        _Userdata["time"].toString(),
                                                        style:
                                                        GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
                                                      ),
                                                    ),
                                                  ),



                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                    }
                                    return  SizedBox(
                                      height:250,
                                      child:Center(child: Text("No data",style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: 18),),)
                                    );

                                  },);
                            },
                          ),
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
    );
  }
}
