part of 'details_bloc.dart';

@immutable
abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsLoaded extends DetailsState {
  List<Objects> contests;

  DetailsLoaded(this.contests);
}

class DetailsError extends DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsEmpty extends DetailsState {}

class InternetNotAvailable extends DetailsState {}
