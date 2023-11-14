import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:universal_html/html.dart'  show AnchorElement;
import 'package:flutter/foundation.dart'  show kIsWeb;
import 'dart:convert';


class Excelsheet  {


  static createExcel(List Data)async{

    final Workbook workbook = Workbook();
    final Worksheet sheet   = workbook.worksheets[0];


    sheet.getRangeByName("A1").setText("Name");
    sheet.getRangeByName("B1").setText("Phone");
    sheet.getRangeByName("C1").setText("Wallet Amount");
    sheet.getRangeByName("D1").setText("Payment");
    sheet.getRangeByName("E1").setText("Applied count");
    // sheet.getRangeByName("F1").setText("Academic Year");
    // sheet.getRangeByName("G1").setText("Blood Group");
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


    for(int i=0;i<Data.length;i++){
      sheet.getRangeByName("A${i + 2}").setText(Data[i].name);
      sheet.getRangeByName("B${i + 2}").setText(Data[i].lastName);
      sheet.getRangeByName("C${i + 2}").setText(Data[i].applicationNumber);
      sheet.getRangeByName("D${i + 2}").setText(Data[i].clasS);
      sheet.getRangeByName("E${i + 2}").setText(Data[i].section);
      // sheet.getRangeByName("F${i + 2}").setText(widget.studentData[i].academicYear);
      // sheet.getRangeByName("G${i + 2}").setText(widget.studentData[i].bloodGroup);
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
class Templatedown extends StatefulWidget {
  const Templatedown({Key? key}) : super(key: key);

  @override
  State<Templatedown> createState() => _TemplatedownState();
}

class _TemplatedownState extends State<Templatedown> {
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return InkWell(
      onTap: (){
        createExcel();
      },
      child: Material(
        borderRadius: BorderRadius.circular(5),
        elevation: 7,
        child: Container(child: Center(
          child:

          Text("Download Template",style: GoogleFonts.poppins(color:Colors.white),),
        ),
          width: width/6.507,
          height: height/16.425,
          // color:Color(0xff00A0E3),
          decoration: BoxDecoration(color: const Color(0xff53B175),borderRadius: BorderRadius.circular(5)),

        ),
      ),
    );
  }


  createExcel()async{

    final Workbook workbook = Workbook();
    final Worksheet sheet   = workbook.worksheets[0];

    sheet.getRangeByName("A1").setText("First Name");
    sheet.getRangeByName("B1").setText("Middle Name");
    sheet.getRangeByName("C1").setText("Last Name");
    sheet.getRangeByName("D1").setText("Class");
    sheet.getRangeByName("E1").setText("Section");
    sheet.getRangeByName("F1").setText("Academic Year");
    sheet.getRangeByName("G1").setText("Blood Group");
    sheet.getRangeByName("H1").setText("Date of Birth");
    sheet.getRangeByName("I1").setText("Gender");
    sheet.getRangeByName("J1").setText("Address");
    sheet.getRangeByName("K1").setText("Community");
    sheet.getRangeByName("L1").setText("House");
    sheet.getRangeByName("M1").setText("Religion");
    sheet.getRangeByName("N1").setText("Mobile");
    sheet.getRangeByName("O1").setText("Email");
    sheet.getRangeByName("P1").setText("Aadhaar No");
    sheet.getRangeByName("Q1").setText("Height (CMS)");
    sheet.getRangeByName("R1").setText("Weight (KG)");
    sheet.getRangeByName("S1").setText("EMIS");
    sheet.getRangeByName("T1").setText("Transport");

    sheet.getRangeByName("U1").setText("Father Name");
    sheet.getRangeByName("V1").setText("Father Occupation");
    sheet.getRangeByName("W1").setText("Father Office");
    sheet.getRangeByName("X1").setText("Father Mobile");
    sheet.getRangeByName("Y1").setText("Father Email");
    sheet.getRangeByName("Z1").setText("Father Aadhaar");

    sheet.getRangeByName("AA1").setText("Mother Name");
    sheet.getRangeByName("AB1").setText("Mother Occupation");
    sheet.getRangeByName("AC1").setText("Mother Office");
    sheet.getRangeByName("AD1").setText("Mother Mobile");
    sheet.getRangeByName("AE1").setText("Mother Email");
    sheet.getRangeByName("AF1").setText("Mother Aadhaar");

    sheet.getRangeByName("AG1").setText("Guardian Name");
    sheet.getRangeByName("AH1").setText("Guardian Occupation");
    sheet.getRangeByName("AI1").setText("Guardian Mobile");
    sheet.getRangeByName("AJ1").setText("Guardian Email");
    sheet.getRangeByName("AK1").setText("Guardian Aadhaar");

    sheet.getRangeByName("AL1").setText("Brother Studying Here");
    sheet.getRangeByName("AM1").setText("Brother Name");

    final List<int>bytes = workbook.saveAsStream();
    workbook.dispose();

    if(kIsWeb){
      AnchorElement(href: 'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
        ..setAttribute('download', 'BULK UPLOAD TEMPLATE.xlsx')
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

// import 'package:excel/excel.dart';
// import 'package:flutter/material.dart';
// import 'dart:html' as html; // Import the html package
// import 'dart:typed_data';
// import 'package:path/path.dart';
//
//
//
// void main() async {
//   var excel = Excel.createExcel();
//   var sheet = excel['Sheet1'];
//
//   // Add header row
//   sheet.appendRow(['Name', 'Age', 'Occupation']);
//
//   // Example: Adding lots of data
//   List<Map<String, dynamic>> lotsOfData = [
//     {'Name': 'John Doe', 'Age': 25, 'Occupation': 'Engineer'},
//     {'Name': 'Jane Doe', 'Age': 30, 'Occupation': 'Designer'},
//     // Add more data as needed
//   ];
//
//   for (var data in lotsOfData) {
//     sheet.appendRow([data['Name'], data['Age'], data['Occupation']]);
//   }
//
//   // Save the Excel file
//   final bytes = excel.encode();
//   final blob = html.Blob([Uint8List.fromList(bytes!)], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
//   final url = html.Url.createObjectUrlFromBlob(blob);
//
//   // Trigger the download
//   final anchor = html.AnchorElement(href: url)
//     ..target = 'webbrowser'
//     ..download = 'example.xlsx';
//   html.document.body!.append(anchor);
//   anchor.click();
//
//   // Clean up
//   html.Url.revokeObjectUrl(url);
//
//   print('Excel file created and downloaded successfully.');
// }
//
//
// class Demo extends StatefulWidget {
//   const Demo({super.key});
//
//   @override
//   State<Demo> createState() => _DemoState();
// }
//
// class _DemoState extends State<Demo> {
//   @override
//   Widget build(BuildContext context) {
//     return  ElevatedButton(onPressed: (){
//       main();
//     }, child: Text("Click"));
//   }
// }
