import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/core/models/player.dart';
import 'package:flutter_template/core/services/trivia_service.dart';
import 'package:flutter_template/presentation/widgets/loading_overlay.dart';
import 'package:flutter_template/presentation/widgets/question_count_dialog.dart';
import 'package:flutter_template/router/app_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  final _triviaService = TriviaService();

  Future<void> _startGame() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => const QuestionCountDialog(),
    );

    if (result == null) return;

    final questionCount = result['count'] as int;
    final players = result['players'] as List<Player>?;

    setState(() => _isLoading = true);

    try {
      final questions = await _triviaService.getQuestions(questionCount);
      if (!mounted) return;

      context.pushRoute(GameRoute(
        questions: questions,
        players: players,
      ));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error generating questions: ${e.toString()}',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red.shade900,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.deepPurple.shade900,
                  Colors.black,
                ],
                stops: const [0.2, 0.9],
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  // Backdrop pattern
                  Positioned.fill(
                    child: ShaderMask(
                      blendMode: BlendMode.softLight,
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withOpacity(0.1),
                            Colors.white.withOpacity(0.05),
                          ],
                        ).createShader(bounds);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),

                  // Settings button
                  Positioned(
                    top: 24,
                    right: 24,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () =>
                            context.pushRoute(const SettingsRoute()),
                        icon: const Icon(
                          FontAwesomeIcons.gear,
                          color: Colors.white,
                          size: 24,
                        ),
                        style: IconButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                        ),
                      ),
                    ),
                  ),

                  // Main content
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              FontAwesomeIcons.brain,
                              size: 100,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            'Close Enough',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.5,
                                ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'The Trivia Drinking Game',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: Colors.white.withOpacity(0.8),
                                  letterSpacing: 0.5,
                                ),
                          ),
                          const SizedBox(height: 64),
                          ElevatedButton.icon(
                            onPressed: _startGame,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple.shade400,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 20,
                              ),
                              textStyle: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                              elevation: 8,
                              shadowColor: Colors.deepPurple.withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            icon: const Icon(
                              FontAwesomeIcons.play,
                              size: 24,
                            ),
                            label: const Text('Start Game'),
                          ),
                          const SizedBox(height: 24),
                          TextButton.icon(
                            onPressed: () =>
                                context.pushRoute(const HowToPlayRoute()),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white.withOpacity(0.9),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                              ),
                            ),
                            icon: const Icon(
                              FontAwesomeIcons.circleInfo,
                              size: 20,
                            ),
                            label: const Text('How to Play'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_isLoading) const LoadingOverlay(),
      ],
    );
  }
}
