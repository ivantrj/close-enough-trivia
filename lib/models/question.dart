class Question {
  final String text;
  final double correctAnswer;
  final String unit;
  final String explanation;

  Question({
    required this.text,
    required this.correctAnswer,
    required this.unit,
    this.explanation = '',
  });

  static List<Question> sampleQuestions = [
    Question(
      text: "How long is the Great Wall of China?",
      correctAnswer: 21196,
      unit: "kilometers",
      explanation: "The Great Wall of China is approximately 21,196 kilometers long in total.",
    ),
    Question(
      text: "How much does a blue whale's tongue weigh?",
      correctAnswer: 2721.55,
      unit: "kilograms",
      explanation: "A blue whale's tongue weighs about 2,721.55 kilograms (6,000 pounds)!",
    ),
    Question(
      text: "How many bones are in the human body?",
      correctAnswer: 206,
      unit: "bones",
      explanation: "An adult human has 206 bones in their body.",
    ),
    Question(
      text: "What is the speed of light?",
      correctAnswer: 299792,
      unit: "kilometers per second",
      explanation: "Light travels at 299,792 kilometers per second in a vacuum.",
    ),
    Question(
      text: "How deep is the deepest part of the ocean (Mariana Trench)?",
      correctAnswer: 10911,
      unit: "meters",
      explanation: "The Mariana Trench reaches a depth of 10,911 meters at its deepest point.",
    ),
  ];
}
