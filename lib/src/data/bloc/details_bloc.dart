import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:competition_tracker/src/data/api/api.dart';
import 'package:competition_tracker/src/data/model/competitions/ContestEntity.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial());

  @override
  Stream<DetailsState> mapEventToState(
    DetailsEvent event,
  ) async* {
    if (event is GetDetails) {
      try {
        ContestEntity contestEntity = await Repository().getContestsById(event.id);
        if (contestEntity != null) {
          if (contestEntity.objects.isEmpty) {
            yield DetailsEmpty();
          } else {
            contestEntity.objects.forEach((element) {
              element.start = DateFormat('d-MM-yyyy hh:mm aa').format(DateTime.parse(element.start));
              element.end = DateFormat('d-MM-yyyy hh:mm aa').format(DateTime.parse(element.end));
              element.duration = Duration(seconds: element.duration).inHours;
            });
            yield DetailsLoaded(contestEntity);
          }
        } else {
          yield DetailsError();
        }
      } catch (e) {
        yield DetailsError();
      }
    }
  }
}
