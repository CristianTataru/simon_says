import 'dart:async';
import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simon_game/model/choice.dart';
import 'package:simon_game/theme/custom_colors.dart';
part 'play_page_event.dart';
part 'play_page_state.dart';

class PlayPageBloc extends Bloc<PlayPageEvent, PlayPageState> {
  PlayPageBloc()
      : super(
            PlayPageInitial(squares: [CustomColors.yellow, CustomColors.blue, CustomColors.red, CustomColors.green])) {
    on<PlayPageOnStartPressed>(_onPlayPageOnStartPressed);
    on<PlayPageUserPicked>(_onPlayPageUserPicked);
  }

  List<Color> squares = [CustomColors.yellow, CustomColors.blue, CustomColors.red, CustomColors.green];
  List<Color> squaresYellowHighlight = [
    CustomColors.yellowHighlighted,
    CustomColors.blue,
    CustomColors.red,
    CustomColors.green
  ];
  List<Color> squaresBlueHighlight = [
    CustomColors.yellow,
    CustomColors.blueHighlighted,
    CustomColors.red,
    CustomColors.green
  ];
  List<Color> squaresRedHighlight = [
    CustomColors.yellow,
    CustomColors.blue,
    CustomColors.redHighlighted,
    CustomColors.green
  ];
  List<Color> squaresGreenHighlight = [
    CustomColors.yellow,
    CustomColors.blue,
    CustomColors.red,
    CustomColors.greenHighlighted
  ];

  Choice getRandomChoice() {
    int randomNumber = Random().nextInt(4) + 1;
    if (randomNumber == 1) {
      return Choice.yellow;
    } else if (randomNumber == 2) {
      return Choice.blue;
    } else if (randomNumber == 3) {
      return Choice.red;
    } else {
      return Choice.green;
    }
  }

  List<Color> getSquaresForChoice(Choice? choice) {
    if (choice == Choice.yellow) {
      return squaresYellowHighlight;
    } else if (choice == Choice.blue) {
      return squaresBlueHighlight;
    } else if (choice == Choice.red) {
      return squaresRedHighlight;
    } else if (choice == Choice.green) {
      return squaresGreenHighlight;
    } else {
      return squares;
    }
  }

  FutureOr<void> _onPlayPageOnStartPressed(PlayPageOnStartPressed event, Emitter<PlayPageState> emit) async {
    if (state is! PlayPageInitial) {
      emit(PlayPageInitial(squares: squares));
    } else {
      List<Choice> computerChoices = [getRandomChoice()];
      userChoices = [];
      emit(PlayPageComputerChoice(computerChoices: computerChoices, squares: getSquaresForChoice(null)));
      await Future.delayed(const Duration(milliseconds: 800));
      emit(PlayPageComputerChoice(computerChoices: computerChoices, squares: getSquaresForChoice(computerChoices[0])));
      await Future.delayed(const Duration(milliseconds: 800));
      emit(
        PlayPageUserChoice(computerChoices: computerChoices, squares: getSquaresForChoice(null)),
      );
    }
  }

  List<Choice> userChoices = [];
  FutureOr<void> _onPlayPageUserPicked(PlayPageUserPicked event, Emitter<PlayPageState> emit) async {
    final previousState = state as PlayPageUserChoice;

    emit(
      PlayPageUserChoice(
          computerChoices: previousState.computerChoices, squares: getSquaresForChoice(event.userChoice)),
    );
    await Future.delayed(const Duration(milliseconds: 800));
    emit(
      PlayPageUserChoice(computerChoices: previousState.computerChoices, squares: getSquaresForChoice(null)),
    );
    userChoices.add(event.userChoice);
    if (listEquals(userChoices, previousState.computerChoices)) {
      List<Choice> computerChoices = [...previousState.computerChoices, getRandomChoice()];
      emit(PlayPageComputerChoice(computerChoices: computerChoices, squares: getSquaresForChoice(null)));
      for (int i = 0; i < computerChoices.length; i++) {
        await Future.delayed(const Duration(milliseconds: 800));
        if ((state is PlayPageUserChoice && (state as PlayPageUserChoice).computerChoices.length == 1) ||
            (state is PlayPageComputerChoice && (state as PlayPageComputerChoice).computerChoices.length == 1) ||
            state is PlayPageInitial) {
          return;
        }
        emit(
            PlayPageComputerChoice(computerChoices: computerChoices, squares: getSquaresForChoice(computerChoices[i])));
        await Future.delayed(const Duration(milliseconds: 800));
        if ((state is PlayPageUserChoice && (state as PlayPageUserChoice).computerChoices.length == 1) ||
            (state is PlayPageComputerChoice && (state as PlayPageComputerChoice).computerChoices.length == 1) ||
            state is PlayPageInitial) {
          return;
        }
        emit(PlayPageComputerChoice(computerChoices: computerChoices, squares: getSquaresForChoice(null)));
        userChoices = [];
      }
      emit(
        PlayPageUserChoice(computerChoices: computerChoices, squares: getSquaresForChoice(null)),
      );
    } else if (userChoices.last != previousState.computerChoices[userChoices.length - 1]) {
      emit(PlayPageGameOver(
          score: previousState.computerChoices.length, squares: getSquaresForChoice(event.userChoice)));
    }
  }
}
