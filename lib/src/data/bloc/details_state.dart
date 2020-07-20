part of 'details_bloc.dart';

@immutable
abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsLoaded extends DetailsState {
  ContestEntity contestEntity;

  DetailsLoaded(this.contestEntity);
}

class DetailsError extends DetailsState {}
