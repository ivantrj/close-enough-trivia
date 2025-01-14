import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_template/core/models/player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuestionCountDialog extends StatefulWidget {
  const QuestionCountDialog({super.key});

  @override
  State<QuestionCountDialog> createState() => _QuestionCountDialogState();
}

class _QuestionCountDialogState extends State<QuestionCountDialog> {
  final _questionController = TextEditingController(text: '5');
  final _playerNameController = TextEditingController();
  bool _withPlayers = false;
  final List<Player> _players = [];

  @override
  void dispose() {
    _questionController.dispose();
    _playerNameController.dispose();
    super.dispose();
  }

  void _addPlayer() {
    if (_playerNameController.text.trim().isEmpty) return;

    setState(() {
      _players.add(Player(name: _playerNameController.text.trim()));
      _playerNameController.clear();
    });
  }

  void _removePlayer(int index) {
    setState(() {
      _players.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
            stops: const [0.2, 0.9],
          ),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.question_answer_rounded,
                  size: 32,
                  color: Colors.deepPurple.shade200,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'How many questions?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.deepPurple.shade200.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: TextField(
                    controller: _questionController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.05),
                      hintText: 'Enter number',
                      hintStyle: TextStyle(
                        color: Colors.deepPurple.shade200.withOpacity(0.3),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Play with Players',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CupertinoSwitch(
                      value: _withPlayers,
                      onChanged: (value) => setState(() => _withPlayers = value),
                      activeColor: Colors.deepPurple.shade400,
                    ),
                  ],
                ),
              ),
              if (_withPlayers) ...[
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.deepPurple.shade200.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Column(
                      children: [
                        TextField(
                          controller: _playerNameController,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter player name',
                            hintStyle: TextStyle(
                              color: Colors.deepPurple.shade200.withOpacity(0.3),
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                            suffixIcon: IconButton(
                              onPressed: _addPlayer,
                              icon: Icon(
                                FontAwesomeIcons.plus,
                                color: Colors.deepPurple.shade200,
                                size: 16,
                              ),
                              padding: const EdgeInsets.all(12),
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.05),
                          ),
                          onSubmitted: (_) => _addPlayer(),
                        ),
                        if (_players.isNotEmpty)
                          Container(
                            constraints: const BoxConstraints(maxHeight: 150),
                            child: ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: _players.length,
                              separatorBuilder: (context, index) => Divider(
                                height: 1,
                                color: Colors.white.withOpacity(0.1),
                              ),
                              itemBuilder: (context, index) {
                                final player = _players[index];
                                return ListTile(
                                  dense: true,
                                  title: Text(
                                    player.name,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () => _removePlayer(index),
                                    icon: Icon(
                                      FontAwesomeIcons.xmark,
                                      color: Colors.deepPurple.shade200,
                                      size: 16,
                                    ),
                                    padding: const EdgeInsets.all(8),
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white.withOpacity(0.7),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 16,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final count = int.tryParse(_questionController.text);
                      if (count != null && count > 0) {
                        if (_withPlayers && _players.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Add at least one player'),
                              backgroundColor: Colors.red.shade900,
                            ),
                          );
                          return;
                        }
                        Navigator.of(context).pop({
                          'count': count,
                          'players': _withPlayers ? _players : null,
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple.shade400,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 16,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                      elevation: 8,
                      shadowColor: Colors.deepPurple.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    child: const Text('Generate'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
