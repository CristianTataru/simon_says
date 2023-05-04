part of 'play_page_bloc.dart';

abstract class PlayPageEvent extends Equatable {
  const PlayPageEvent();

  @override
  List<Object> get props => [];
}

class PlayPageOnStartPressed extends PlayPageEvent {}

class PlayPageUserPicked extends PlayPageEvent {
  final Choice userChoice;

  const PlayPageUserPicked({required this.userChoice});
  @override
  List<Object> get props => [userChoice];
}
