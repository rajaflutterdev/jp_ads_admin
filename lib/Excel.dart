import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html; // Import the html package
import 'dart:typed_data';
import 'package:path/path.dart';

class excel{

  static
  excelsheetfunc(List lotsOfData) async {
    var excel = Excel.createExcel();
    var sheet = excel['Sheet1'];

    // Add header row
    sheet.appendRow(['Name', 'Age', 'Occupation']);

    // Example: Adding lots of data
    List<Map<String, dynamic>> lotsOfData = [
      {'Name': 'John Doe', 'Age': 25, 'Occupation': 'Engineer'},
      {'Name': 'Jane Doe', 'Age': 30, 'Occupation': 'Designer'},
      // Add more data as needed
    ];

    for (var data in lotsOfData) {
      sheet.appendRow([data['Name'], data['Age'], data['Occupation']]);
    }

    // Save the Excel file
    final bytes = excel.encode();
    final blob = html.Blob([Uint8List.fromList(bytes!)], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Trigger the download
    final anchor = html.AnchorElement(href: url)
      ..target = 'webbrowser'
      ..download = 'example.xlsx';
    html.document.body!.append(anchor);
    anchor.click();

    // Clean up
    html.Url.revokeObjectUrl(url);

    print('Excel file created and downloaded successfully.');
  }


}