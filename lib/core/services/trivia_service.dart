import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_template/core/models/question.dart';

class TriviaService {
  static const String _baseUrl = 'https://opentdb.com/api.php';

  Future<List<Question>> getQuestions(int count) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?amount=$count'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch questions');
      }

      final data = jsonDecode(response.body);
      if (data['response_code'] != 0) {
        throw Exception('API returned an error');
      }

      return (data['results'] as List).map((json) => _convertToQuestion(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch questions. Please try again.');
    }
  }

  Question _convertToQuestion(Map<String, dynamic> json) {
    final question = json['question'] as String;
    final correctAnswer = json['correct_answer'] as String;
    final incorrectAnswers = (json['incorrect_answers'] as List).cast<String>();
    final category = json['category'] as String;

    return Question(
      text: _decodeHtmlEntities(question),
      correctAnswer: _decodeHtmlEntities(correctAnswer),
      incorrectAnswers: incorrectAnswers.map((a) => _decodeHtmlEntities(a)).toList(),
      category: category,
    );
  }

  String _decodeHtmlEntities(String text) {
    return text
        .replaceAll('&quot;', '"')
        .replaceAll('&#039;', "'")
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>');
  }
}