import 'package:flutter/material.dart';

class StudyPage extends StatelessWidget {
  const StudyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Upcoming Study Sessions Section
            Card(
              elevation: 2,
              color: Colors.blue[100], // Light blue background
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Lịch học sắp tới',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      title: const Text('Toán tích phân - Buổi 3'),
                      subtitle: const Text('30/05/2025, 14:00 - 16:00'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // Navigate to session details or show a dialog
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Mở chi tiết buổi học')),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text('Vật lý - Ôn tập thi cuối kỳ'),
                      subtitle: const Text('31/05/2025, 09:00 - 11:00'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Mở chi tiết buổi học')),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Study Resources Section
            Card(
              elevation: 2,
              color: Colors.green[100], // Light green background
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tài liệu học tập',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      title: const Text('Sách Toán tích phân PDF'),
                      subtitle: Text(
                        'Tệp PDF, 5MB',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      trailing: const Icon(Icons.download, size: 20),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Tải tài liệu')),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text('Video bài giảng Vật lý'),
                      subtitle: Text(
                        'YouTube, 45 phút',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      trailing: const Icon(Icons.play_arrow, size: 20),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Mở video bài giảng')),
                        );
                      },
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
