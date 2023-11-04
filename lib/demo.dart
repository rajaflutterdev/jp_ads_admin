// import 'package:flutter/cupertino.dart';
//
// class demo extends StatefulWidget {
//   const demo({super.key});
//
//   @override
//   State<demo> createState() => _demoState();
// }
//
// class _demoState extends State<demo> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         FutureBuilder(
//           future: FirebaseFirestore.instance.collection("Users").
//           doc(Userdocuid).collection("Histroy").where("Type",isEqualTo:"Correction").get(),
//           builder: (context, snapshot) {
//
//             if(snapshot.hasData==null){
//               return const Center(child: CircularProgressIndicator(),);
//             }
//             if(!snapshot.hasData){
//               return const Center(child: CircularProgressIndicator(),);
//             }
//
//             return ListView.builder(
//               shrinkWrap: true,
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//
//                 documentcount=snapshot.data!.docs.length;
//                 var applieddata=snapshot.data!.docs[index];
//                 return Row(
//
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//
//                   children: [
//
//                     SizedBox(
//                       width: 100,
//                       height: 40,
//                       child: Center(
//                         child: Text(
//                           (index+1).toString(),
//                           style:
//                           GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
//                         ),
//                       ),
//                     ),
//
//                     SizedBox(
//                       width: 200,
//                       height: 40,
//                       child: Center(
//                         child: Text(
//                           applieddata['Crtname'].toString(),
//                           style:
//                           GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
//                         ),
//                       ),
//                     ),
//
//                     SizedBox(
//                       width: 100,
//                       height: 40,
//                       child: Center(
//                         child: Text(
//                           applieddata['crtphonenumber'].toString(),
//                           style:
//                           GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
//                         ),
//                       ),
//                     ),
//
//                     SizedBox(
//                       width: 100,
//                       height: 40,
//                       child: Center(
//                         child: Text(
//                           applieddata['crgender'].toString(),
//                           style:
//                           GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
//                         ),
//                       ),
//                     ),
//
//                     SizedBox(
//                       width: 100,
//                       height: 40,
//                       child: Center(
//                         child: Text(
//                           applieddata['Type'].toString(),
//                           style:
//                           GoogleFonts.poppins(fontSize: 14, color: Colors.indigo,fontWeight:FontWeight.w700),
//                         ),
//                       ),
//                     ),
//
//                     SizedBox(
//                       width: 100,
//                       height: 40,
//                       child: Center(
//                         child: Text(
//                           "${ applieddata['date'].toString()}\n${ applieddata['time'].toString()}",
//                           textAlign: TextAlign.center,
//                           style:
//                           GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
//                         ),
//                       ),
//                     ),
//
//                     InkWell(
//                       onTap: (){
//                         detailspopup(
//                           applieddata['Crtname'].toString(),
//                           applieddata['crtfathername'].toString(),
//                           applieddata['crtphonenumber'].toString(),
//                           applieddata['crgender'].toString(),
//                           applieddata['crtdate_of_birth'].toString(),
//                           applieddata['pancardno'].toString(),
//                           applieddata['crtnameandbuildsno'].toString(),
//                           applieddata['crtnadddress'].toString(),
//                           applieddata['crtdistrict'].toString(),
//                           applieddata['crtstate'].toString(),
//                           applieddata['date'].toString(),
//                           applieddata['time'].toString(),
//                           applieddata['updatestatus'].toString(),
//                           applieddata['correctionupdate'].toString(),
//                           applieddata['Type'].toString(),
//                           applieddata['crtpincode'].toString(),
//                         );
//                       },
//                       child: Container(
//                           width: 100,
//                           height: 30,
//                           decoration: BoxDecoration(
//                               color: Colors.green,
//                               borderRadius: BorderRadius.circular(8)
//                           ),
//                           child: Center(child: const Text("View",style: TextStyle(color: Colors.white),))
//                       ),
//                     ),
//
//                     InkWell(
//                       onTap: (){
//                         ///delete popup
//                         _deleteHistroypopup(applieddata.id);
//                       },
//                       child: SizedBox(
//                           width: 60,
//                           height: 40,
//                           child: Center(child: const Icon(Icons.delete))
//                       ),
//                     ),
//
//
//
//
//
//
//                   ],
//                 );
//               },);
//           },
//         ),
//
//         StreamBuilder(
//           stream: FirebaseFirestore.instance.collection("Users").doc(Userdocuid).collection("Histroy").where("Type",isEqualTo:"Applied").snapshots(),
//           builder: (context, snapshot) {
//
//             if(snapshot.hasData==null){
//               return const Center(child: CircularProgressIndicator(),);
//             }
//             if(!snapshot.hasData){
//               return const Center(child: CircularProgressIndicator(),);
//             }
//
//             return ListView.builder(
//               shrinkWrap: true,
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//
//                 var applieddata=snapshot.data!.docs[index];
//                 return Row(
//
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//
//                   children: [
//
//                     SizedBox(
//                       width: 100,
//                       height: 40,
//                       child: Center(
//                         child: Text(
//                           (documentcount+1).toString(),
//                           style:
//                           GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
//                         ),
//                       ),
//                     ),
//
//                     SizedBox(
//                       width: 200,
//                       height: 40,
//                       child: Center(
//                         child: Text(
//                           applieddata['name'].toString(),
//                           style:
//                           GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
//                         ),
//                       ),
//                     ),
//
//                     SizedBox(
//                       width: 100,
//                       height: 40,
//                       child: Center(
//                         child: Text(
//                           applieddata['father name'].toString(),
//                           style:
//                           GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
//                         ),
//                       ),
//                     ),
//
//                     SizedBox(
//                       width: 100,
//                       height: 40,
//                       child: Center(
//                         child: Text(
//                           applieddata['updatestatus'].toString(),
//                           style:
//                           GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
//                         ),
//                       ),
//                     ),
//
//                     SizedBox(
//                       width: 100,
//                       height: 40,
//                       child: Center(
//                         child: Text(
//                           applieddata['Type'].toString(),
//                           style:
//                           GoogleFonts.poppins(fontSize: 14, color:  Colors.green,fontWeight:FontWeight.w700),
//                         ),
//                       ),
//                     ),
//
//                     SizedBox(
//                       width: 100,
//                       height: 40,
//                       child: Center(
//                         child: Text(
//                           "${ applieddata['date'].toString()}\n${ applieddata['time'].toString()}",
//                           textAlign: TextAlign.center,
//                           style:
//                           GoogleFonts.poppins(fontSize: 14, color: const Color(0xff000000)),
//                         ),
//                       ),
//                     ),
//
//                     InkWell(
//                       onTap: (){
//                         Applieddetailspopup(
//                           applieddata['name'].toString(),
//                           applieddata['father name'].toString(),
//                           applieddata['gender'].toString(),
//                           applieddata['dob'].toString(),
//                           applieddata['pantype'].toString(),
//                           applieddata['updatestatus'].toString(),
//                           applieddata['date'].toString(),
//                           applieddata['time'].toString(),
//                           applieddata['Type'].toString(),
//                           applieddata['aadharpicture'].toString(),
//                           applieddata['signpicture'].toString(),
//                           applieddata['photo'].toString(),
//
//                         );
//                       },
//                       child: Container(
//                           width: 100,
//                           height: 30,
//                           decoration: BoxDecoration(
//                               color: Colors.green,
//                               borderRadius: BorderRadius.circular(8)
//                           ),
//                           child: Center(child: const Text("View",style: TextStyle(color: Colors.white),))
//                       ),
//                     ),
//
//                     InkWell(
//                       onTap: (){
//                         ///delete popup
//                         _deleteHistroypopup(applieddata.id);
//                       },
//                       child: SizedBox(
//                           width: 60,
//                           height: 40,
//                           child: Center(child: const Icon(Icons.delete))
//                       ),
//                     ),
//
//
//
//
//
//
//                   ],
//                 );
//               },);
//           },
//         ),
//
//       ],
//     );
//   }
// }
