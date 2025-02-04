class Question {
  final String text;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  final String category;
  late final List<String> _shuffledAnswers;

  Question({
    required this.text,
    required this.correctAnswer,
    required this.incorrectAnswers,
    required this.category,
  }) {
    _shuffledAnswers = List<String>.from(incorrectAnswers);
    _shuffledAnswers.add(correctAnswer);
    _shuffledAnswers.shuffle();
  }

  List<String> get allAnswers => _shuffledAnswers;

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['text'] as String,
      correctAnswer: json['correctAnswer'] as String,
      incorrectAnswers: (json['incorrectAnswers'] as List).cast<String>(),
      category: json['category'] as String,
    );
  }
}
