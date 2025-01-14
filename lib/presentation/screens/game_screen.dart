import 'package:flutter/material.dart';
import 'package:flutter_template/core/models/player.dart';
import 'package:flutter_template/core/models/question.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class GameScreen extends StatefulWidget {
  final List<Question> questions;
  final List<Player>? players;

  const GameScreen({
    super.key,
    required this.questions,
    this.players,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _currentQuestionIndex = 0;
  bool _showAnswer = false;
  Player? _roundWinner;

  Question get question => widget.questions[_currentQuestionIndex];

  void _nextQuestion() {
    setState(() {
      _showAnswer = false;
      _roundWinner = null;
      if (_currentQuestionIndex < widget.questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _showGameOver();
      }
    });
  }

  void _showGameOver() {
    if (widget.players == null || widget.players!.isEmpty) {
      context.maybePop();
      return;
    }

    // Sort players by score
    final sortedPlayers = [...widget.players!]..sort((a, b) => b.score.compareTo(a.score));
    final winner = sortedPlayers.first;
    final isMultipleWinners = sortedPlayers.where((p) => p.score == winner.score).length > 1;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.deepPurple.shade900.withOpacity(0.95),
                Colors.black.withOpacity(0.95),
              ],
            ),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isMultipleWinners ? FontAwesomeIcons.trophy : FontAwesomeIcons.crown,
                size: 48,
                color: Colors.amber,
              ),
              const SizedBox(height: 24),
              Text(
                isMultipleWinners ? 'It\'s a Tie!' : 'Winner!',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ...sortedPlayers.map((player) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          player.name,
                          style: TextStyle(
                            color: player.score == winner.score ? Colors.amber : Colors.white.withOpacity(0.9),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${player.score} points',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.maybePop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple.shade400,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                child: const Text(
                  'Finish Game',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectWinner(Player player) {
    setState(() {
      _roundWinner = player;
      player.score++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade900,
              Colors.black,
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () => context.maybePop(),
                    icon: const Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // Main content
              Padding(
                padding: const EdgeInsets.all(32),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Question ${_currentQuestionIndex + 1}/${widget.questions.length}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white.withOpacity(0.8),
                            ),
                      ),
                      const SizedBox(height: 32),
                      Card(
                        color: Colors.white.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple.withOpacity(0.3),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  FontAwesomeIcons.question,
                                  size: 32,
                                  color: Colors.deepPurple.shade200,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                question.text,
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: Colors.white,
                                      height: 1.4,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Answer in ${question.unit}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      if (_showAnswer) ...[
                        Card(
                          color: Colors.deepPurple.shade400.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              children: [
                                Icon(
                                  FontAwesomeIcons.lightbulb,
                                  size: 32,
                                  color: Colors.deepPurple.shade200,
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  '${question.correctAnswer} ${question.unit}',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple.shade200,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                if (question.explanation.isNotEmpty) ...[
                                  const SizedBox(height: 24),
                                  Text(
                                    question.explanation,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white.withOpacity(0.8),
                                      height: 1.5,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                                if (widget.players != null && _roundWinner == null) ...[
                                  const SizedBox(height: 32),
                                  const Text(
                                    'Who was closest?',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    alignment: WrapAlignment.center,
                                    children: widget.players!
                                        .map((player) => ActionChip(
                                              label: Text(player.name),
                                              onPressed: () => _selectWinner(player),
                                              backgroundColor: Colors.deepPurple.shade400,
                                              side: BorderSide(
                                                color: Colors.deepPurple.shade200,
                                                width: 1,
                                              ),
                                              labelStyle: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ],
                                if (_roundWinner != null) ...[
                                  const SizedBox(height: 24),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.trophy,
                                        size: 20,
                                        color: Colors.amber.shade400,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${_roundWinner!.name} wins this round!',
                                        style: TextStyle(
                                          color: Colors.amber.shade400,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton.icon(
                          onPressed: _nextQuestion,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple.shade400,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            elevation: 8,
                            shadowColor: Colors.deepPurple.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          icon: const Icon(FontAwesomeIcons.forward),
                          label: Text(
                            _currentQuestionIndex < widget.questions.length - 1 ? 'Next Question' : 'Finish Game',
                          ),
                        ),
                      ] else
                        ElevatedButton.icon(
                          onPressed: () => setState(() => _showAnswer = true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple.shade400,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            elevation: 8,
                            shadowColor: Colors.deepPurple.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          icon: const Icon(FontAwesomeIcons.eye),
                          label: const Text('Reveal Answer'),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
