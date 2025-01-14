import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_template/core/models/question.dart';

class AIService {
  static const String _baseUrl = 'https://flutter-ai-backend-dev.onrender.com';

  Future<List<Question>> generateQuestions(int count) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/generate-questions'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'count': count,
        }),
      );

      if (response.statusCode != 200) {
        final error = jsonDecode(response.body)['error'] ?? 'Unknown error';
        throw Exception('Failed to generate questions: $error');
      }

      final data = jsonDecode(response.body) as List;
      return data.map((json) => Question.fromJson(json)).toList();
    } catch (e) {
      print('Error generating questions: $e');
      throw Exception('Failed to generate questions. Please try again.');
    }
  }
}
