import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Bảng thông tin')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Table(
            border: TableBorder.all(), // Adds borders to all cells
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(1),
            },
            children: [
              // Header row
              TableRow(
                decoration: BoxDecoration(color: Colors.grey[200]),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Tên',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Địa chỉ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Tuổi',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              // Data rows
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('An'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Hà Nội'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('20'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Bình'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Hải Phòng'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('22'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Chi'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Đà Nẵng'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('21'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
