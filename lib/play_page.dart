import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simon_game/bloc/play_page_bloc.dart';
import 'package:simon_game/model/choice.dart';

final bloc = PlayPageBloc();

class PlayPage extends StatelessWidget {
  const PlayPage({super.key});

  void userPicks(Choice pick) {
    bloc.add(PlayPageUserPicked(userChoice: pick));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayPageBloc, PlayPageState>(
      bloc: bloc,
      builder: (context, playPageState) {
        return Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Simon Says",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  bloc.add(PlayPageOnStartPressed());
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(150, 70),
                ),
                child: Text(
                  playPageState is PlayPageInitial ? 'Start' : 'Reset',
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: playPageState is! PlayPageUserChoice?
                        ? null
                        : () {
                            userPicks(Choice.yellow);
                          },
                    child: Container(
                      decoration: BoxDecoration(color: playPageState.squares[0]),
                      height: 150,
                      width: 150,
                    ),
                  ),
                  GestureDetector(
                    onTap: playPageState is! PlayPageUserChoice?
                        ? null
                        : () {
                            userPicks(Choice.blue);
                          },
                    child: Container(
                      decoration: BoxDecoration(color: playPageState.squares[1]),
                      height: 150,
                      width: 150,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: playPageState is! PlayPageUserChoice?
                        ? null
                        : () {
                            userPicks(Choice.red);
                          },
                    child: Container(
                      decoration: BoxDecoration(color: playPageState.squares[2]),
                      height: 150,
                      width: 150,
                    ),
                  ),
                  GestureDetector(
                    onTap: playPageState is! PlayPageUserChoice?
                        ? null
                        : () {
                            userPicks(Choice.green);
                          },
                    child: Container(
                      decoration: BoxDecoration(color: playPageState.squares[3]),
                      height: 150,
                      width: 150,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (playPageState is PlayPageComputerChoice) ...[
                Text(
                  "Round ${playPageState.computerChoices.length}",
                  style: const TextStyle(
                    fontSize: 50,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              if (playPageState is PlayPageUserChoice) ...[
                Text(
                  "Round ${playPageState.computerChoices.length}",
                  style: const TextStyle(
                    fontSize: 50,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              const SizedBox(
                height: 20,
              ),
              if (playPageState is PlayPageGameOver) ...[
                const SizedBox(height: 16),
                const Text(
                  "Game Over!",
                  style: TextStyle(fontSize: 35),
                ),
                const SizedBox(height: 8),
                Text(
                  "Score: ${playPageState.score - 1}",
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ]
            ],
          ),
        );
      },
    );
  }
}
