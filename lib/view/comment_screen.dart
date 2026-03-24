import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CommentScreen extends StatefulWidget {
  @override
  _CommentScreenState createState() => _CommentScreenState();
  static String screenRoot = 'sign_screen';
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  final List<String> _comments = [];
  final int journeyId = 1; // معرف الرحلة المناسب
  final String token =
      '5|xNut0XJikTIXu4MKMjIQ0HDLUJ8JWHjyFdLP2gJ8db35cb31'; // التوكن

  @override
  void initState() {
    super.initState();
    _loadComments(); // تحميل التعليقات عند بدء التطبيق
  }

  // وظيفة لتحميل التعليقات من السيرفر
  Future<void> _loadComments() async {
    final String url =
        'http://192.168.1.108:8000/api/journeys/$journeyId/feedbacks';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _comments.clear(); // مسح التعليقات السابقة
          _comments.addAll(
            data.map((item) => item['comment'] as String).toList(),
          );
        });
      } else {
        print(
          "Failed to load comments. Status code: ${response.statusCode}. Response body: ${response.body}",
        );
      }
    } catch (e) {
      print("Error occurred while loading comments: $e");
    }
  }

  // وظيفة لإرسال التعليق إلى السيرفر
  Future<void> _sendCommentToServer(String comment) async {
    final String url =
        'http://192.168.1.108:8000/api/journeys/$journeyId/feedbacks';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "user_id": 2,
          "journey_id": journeyId.toString(),
          "comment": comment,
          "date": DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        print("Comment sent successfully");
        _loadComments();
      } else {
        print(
          "Failed to send comment. Status code: ${response.statusCode}. Response body: ${response.body}",
        );
      }
    } catch (e) {
      print("Error occurred while sending comment: $e");
    }
  }

  void _addComment() async {
    final String comment = _commentController.text;
    if (comment.isNotEmpty) {
      await _sendCommentToServer(comment);
      _commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Comment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Enter your comment',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: _addComment, child: Text('Submit')),
            Expanded(
              child: ListView.builder(
                itemCount: _comments.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(_comments[index]));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
