import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class HowToPlayScreen extends StatelessWidget {
  const HowToPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primary,
              colorScheme.secondary,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                    ),
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
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    _buildInstructionCard(
                      context,
                      icon: FontAwesomeIcons.users,
                      title: '1. Gather Your Friends',
                      description:
                          'Get a group of friends together and make sure everyone has something to drink!',
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
                      description:
                          'The person whose guess was furthest from the correct answer has to drink!',
                    ),
                    _buildInstructionCard(
                      context,
                      icon: FontAwesomeIcons.forward,
                      title: '6. Keep Playing',
                      description:
                          'Tap "Next Question" to continue. Keep playing until you\'ve had enough... or had too much! 😉',
                    ),
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
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyLarge,
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
