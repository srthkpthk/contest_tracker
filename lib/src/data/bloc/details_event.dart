part of 'details_bloc.dart';

@immutable
abstract class DetailsEvent {}

class GetDetails extends DetailsEvent {
  int id;

  GetDetails(this.id);
}

class PullRefresh extends DetailsEvent {
  int id;

  PullRefresh(this.id);
}
