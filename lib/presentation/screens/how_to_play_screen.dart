import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class HowToPlayScreen extends StatelessWidget {
  const HowToPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            children: [
              // Custom navigation bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.1),
                        padding: const EdgeInsets.all(12),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'How to Play',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    _buildInstructionCard(
                      context,
                      icon: FontAwesomeIcons.users,
                      title: '1. Gather Your Friends',
                      description: 'Get a group of friends together and make sure everyone has something to drink!',
                    ),
                    _buildInstructionCard(
                      context,
                      icon: FontAwesomeIcons.question,
                      title: '2. Read the Question',
                      description:
                          'One person reads the question aloud from the phone. Each question asks for a numerical answer.',
                    ),
                    _buildInstructionCard(
                      context,
                      icon: FontAwesomeIcons.pencil,
                      title: '3. Write Down Answers',
                      description:
                          'Everyone writes down their guess. Make sure to use the units specified in the question!',
                    ),
                    _buildInstructionCard(
                      context,
                      icon: FontAwesomeIcons.eye,
                      title: '4. Reveal the Answer',
                      description:
                          'Once everyone has written their answer, tap "Reveal Answer" to see the correct answer.',
                    ),
                    _buildInstructionCard(
                      context,
                      icon: FontAwesomeIcons.beerMugEmpty,
                      title: '5. Time to Drink!',
                      description: 'The person whose guess was furthest from the correct answer has to drink!',
                    ),
                    _buildInstructionCard(
                      context,
                      icon: FontAwesomeIcons.forward,
                      title: '6. Keep Playing',
                      description:
                          'Tap "Next Question" to continue. Keep playing until you\'ve had enough... or had too much! 😉',
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                size: 24,
                color: Colors.deepPurple.shade200,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8),
                      height: 1.5,
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
