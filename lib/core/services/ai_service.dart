import 'dart:convert';
import 'package:flutter_template/core/models/question.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AIService {
  static const String apiKey = 'YOUR_API_KEY';
  late final GenerativeModel _model;

  AIService() {
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: apiKey,
    );
  }

  Future<List<Question>> generateQuestions(int count) async {
    try {
      final prompt = '''
Generate $count interesting trivia questions that ask for numerical answers. 
Each question should be about fascinating facts that most people wouldn't know exactly but could make an educated guess.

Important formatting rules:
1. All numerical values must be plain numbers without commas or special formatting
2. Use only digits and decimal points for numbers (e.g., 12742 or 12742.5, not 12,742)
3. Keep answers reasonable (between 0.01 and 1000000)
4. Units should be simple and clear (e.g., "kilometers", "years", "kilograms")

Return ONLY a valid JSON array with exactly this structure:
[
  {
    "text": "What is the diameter of Earth in kilometers?",
    "correctAnswer": 12742,
    "unit": "kilometers",
    "explanation": "The Earth has a diameter of 12742 kilometers at the equator."
  }
]

Do not include any other text or formatting. Only return the JSON array.
''';

      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      final responseText = response.text;

      if (responseText == null) {
        throw Exception('No response from AI');
      }

      print('Raw AI response: $responseText'); // Debug logging

      // Clean up the response
      final jsonStr =
          responseText.replaceAll('```json', '').replaceAll('```', '').replaceAll(RegExp(r'(\d),(\d)'), r'$1$2').trim();

      print('Cleaned JSON string: $jsonStr'); // Debug logging

      final List<dynamic> jsonList;
      try {
        jsonList = json.decode(jsonStr);
      } catch (e) {
        print('JSON decode error: $e');
        throw Exception('Failed to parse AI response as JSON: $e');
      }

      return jsonList.map((json) {
        // Validate each field
        final text = json['text'];
        final correctAnswer = json['correctAnswer'];
        final unit = json['unit'];
        final explanation = json['explanation'];

        if (text == null || correctAnswer == null || unit == null || explanation == null) {
          print('Invalid question data: $json'); // Debug logging
          throw Exception('Missing required fields in question data');
        }

        if (text is! String || unit is! String || explanation is! String) {
          throw Exception('Invalid data types in question data');
        }

        if (correctAnswer is! num) {
          throw Exception('Invalid answer format: $correctAnswer');
        }

        return Question(
          text: text,
          correctAnswer: correctAnswer.toDouble(),
          unit: unit,
          explanation: explanation,
        );
      }).toList();
    } catch (e) {
      print('Error generating questions: $e');
      rethrow;
    }
  }
}
