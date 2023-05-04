part of 'play_page_bloc.dart';

abstract class PlayPageState extends Equatable {
  final List<Color> squares;

  const PlayPageState({required this.squares});

  @override
  List<Object> get props => [squares];
}

class PlayPageInitial extends PlayPageState {
  const PlayPageInitial({required super.squares});
}

class PlayPageComputerChoice extends PlayPageState {
  final List<Choice> computerChoices;

  const PlayPageComputerChoice({required this.computerChoices, required super.squares});

  @override
  List<Object> get props => [...super.props, computerChoices];
}

class PlayPageUserChoice extends PlayPageState {
  final List<Choice> computerChoices;

  const PlayPageUserChoice({required this.computerChoices, required super.squares});

  @override
  List<Object> get props => [...super.props, computerChoices];
}

class PlayPageGameOver extends PlayPageState {
  final int score;
  const PlayPageGameOver({required this.score, required super.squares});
}
