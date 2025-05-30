import 'package:flutter/material.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({super.key});

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  // Sample vocabulary list with completion status
  final List<Map<String, dynamic>> vocabularyList = [
    {'word': 'Abundant', 'meaning': 'Dồi dào', 'isLearned': false},
    {'word': 'Benevolent', 'meaning': 'Nhân từ', 'isLearned': false},
    {'word': 'Candid', 'meaning': 'Thẳng thắn', 'isLearned': false},
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate progress
    int learnedCount = vocabularyList.where((item) => item['isLearned']).length;
    int totalCount = vocabularyList.length;
    double progress = totalCount > 0 ? learnedCount / totalCount : 0;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vocabulary List Section
            Card(
              elevation: 2,
              color: Colors.yellow[100], // Light yellow background
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Danh sách từ vựng',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...vocabularyList.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> item = entry.value;
                      return ListTile(
                        title: Text(item['word']),
                        subtitle: Text(
                          item['meaning'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        trailing: Checkbox(
                          value: item['isLearned'],
                          onChanged: (bool? value) {
                            setState(() {
                              vocabularyList[index]['isLearned'] =
                                  value ?? false;
                            });
                          },
                        ),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Chi tiết: ${item['word']}'),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Learning Progress Section
            Card(
              elevation: 2,
              color: Colors.blue[100], // Light blue background
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tiến độ học tập',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blue,
                      minHeight: 10,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Đã học: $learnedCount/$totalCount từ',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
