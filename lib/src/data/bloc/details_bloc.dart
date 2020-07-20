import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:competition_tracker/src/data/model/competitions/contest_entity.dart';
import 'package:competition_tracker/src/data/model/competitions/objects.dart';
import 'package:competition_tracker/src/data/repositories/contest_repository.dart';
import 'package:competition_tracker/src/exceptions/exceptions.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'details_event.dart';

part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final ContestsRepository repository;

  DetailsBloc(this.repository) : super(DetailsInitial());

  @override
  void onTransition(Transition<DetailsEvent, DetailsState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<DetailsState> mapEventToState(
    DetailsEvent event,
  ) async* {
    if (event is GetDetails) {
      yield DetailsLoading();
      try {
        ContestEntity contestEntity = await repository.getData(event.id);
        if (contestEntity != null) {
          if (contestEntity.objects.isEmpty) {
            yield DetailsEmpty();
          } else {
            yield DetailsLoaded(contestEntity.objects);
          }
        } else {
//          print('null');
          yield DetailsError();
        }
      } on NoConnectionException {
        yield InternetNotAvailable();
      } catch (e) {
        print(e);
        yield DetailsError();
      }
    }
    if (event is PullRefresh) {
      yield DetailsLoading();
      try {
        ContestEntity contestEntity = await repository.getDataFromInternet(event.id);
        if (contestEntity != null) {
          if (contestEntity.objects.isEmpty) {
            yield DetailsEmpty();
          } else {
            contestEntity.objects.forEach((element) {
              element.start = DateFormat('d-MM-yyyy hh:mm aa').format(DateTime.parse(element.start));
              element.end = DateFormat('d-MM-yyyy hh:mm aa').format(DateTime.parse(element.end));
              element.duration = Duration(seconds: element.duration).inHours;
            });
            yield DetailsLoaded(contestEntity.objects);
          }
        } else {
          yield DetailsError();
        }
      } on NoConnectionException {
        yield InternetNotAvailable();
      } catch (e) {
        yield DetailsError();
      }
    }
  }
}
