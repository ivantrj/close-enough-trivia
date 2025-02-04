class Question {
  final String text;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  final String category;

  Question({
    required this.text,
    required this.correctAnswer,
    required this.incorrectAnswers,
    required this.category,
  });

  List<String> get allAnswers {
    final answers = List<String>.from(incorrectAnswers);
    answers.add(correctAnswer);
    answers.shuffle();
    return answers;
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['text'] as String,
      correctAnswer: json['correctAnswer'] as String,
      incorrectAnswers: (json['incorrectAnswers'] as List).cast<String>(),
      category: json['category'] as String,
    );
  }
}
