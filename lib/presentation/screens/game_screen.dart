import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/core/models/question.dart';
import 'package:flutter_template/router/app_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int currentQuestionIndex = 0;
  bool isAnswerRevealed = false;
  List<Question> questions = Question.sampleQuestions;

  void nextQuestion() {
    setState(() {
      currentQuestionIndex = (currentQuestionIndex + 1) % questions.length;
      isAnswerRevealed = false;
    });
  }

  void revealAnswer() {
    setState(() {
      isAnswerRevealed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: CupertinoColors.systemBackground,
      body: SafeArea(
        child: Column(
          children: [
            // iOS-style navigation bar
            CupertinoNavigationBar(
              backgroundColor: CupertinoColors.systemBackground,
              border: null,
              leading: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(CupertinoIcons.back),
                onPressed: () => context.router.pop(),
              ),
              middle: Text(
                'Question ${currentQuestionIndex + 1}/${questions.length}',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(CupertinoIcons.settings),
                onPressed: () => context.pushRoute(const SettingsRoute()),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const SizedBox(height: 20),
                  // Question card
                  Container(
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey6,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Icon(
                          CupertinoIcons.question_circle,
                          size: 48,
                          color: CupertinoColors.systemBlue,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          question.text,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.label,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Answer in ${question.unit}',
                          style: const TextStyle(
                            fontSize: 17,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (isAnswerRevealed) ...[
                    // Answer card
                    Container(
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Icon(
                            CupertinoIcons.lightbulb,
                            size: 32,
                            color: CupertinoColors.systemBlue,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Correct Answer:',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: CupertinoColors.label,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${question.correctAnswer} ${question.unit}',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: CupertinoColors.systemBlue,
                            ),
                          ),
                          if (question.explanation.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            Text(
                              question.explanation,
                              style: TextStyle(
                                fontSize: 15,
                                color: CupertinoColors.label.withOpacity(0.8),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Next button
                    CupertinoButton.filled(
                      onPressed: nextQuestion,
                      borderRadius: BorderRadius.circular(12),
                      child: const Text(
                        'Next Question',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ] else
                    // Reveal button
                    CupertinoButton.filled(
                      onPressed: revealAnswer,
                      borderRadius: BorderRadius.circular(12),
                      child: const Text(
                        'Reveal Answer',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
