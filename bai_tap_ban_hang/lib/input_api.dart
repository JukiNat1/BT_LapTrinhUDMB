import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PostManagementScreen(),
    );
  }
}

class PostManagementScreen extends StatefulWidget {
  const PostManagementScreen({super.key});

  @override
  _PostManagementScreenState createState() => _PostManagementScreenState();
}

class _PostManagementScreenState extends State<PostManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  List<Post> _postedList = []; // Danh sách các bài đã gửi

  Future<void> submitPost() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'title': _titleController.text,
          'body': _bodyController.text,
          'userId': 1,
        }),
      );

      if (response.statusCode == 201) {
        final newPost = Post(
          id: DateTime.now().millisecondsSinceEpoch, // Tạo ID giả lập
          title: _titleController.text,
          body: _bodyController.text,
        );
        setState(() {
          _postedList.add(newPost); // Thêm bài mới vào danh sách
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post submitted successfully!')),
        );
        _titleController.clear();
        _bodyController.clear();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Failed to submit post.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Management')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _bodyController,
                    decoration: const InputDecoration(labelText: 'Body'),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a body';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: submitPost,
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child:
                  _postedList.isEmpty
                      ? const Center(child: Text('No posts yet'))
                      : ListView.builder(
                        itemCount: _postedList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_postedList[index].title),
                            subtitle: Text(_postedList[index].body),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }
}

class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(id: json['id'], title: json['title'], body: json['body']);
  }
}
