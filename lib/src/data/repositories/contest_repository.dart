import 'package:competition_tracker/src/data/model/competitions/contest_entity.dart';
import 'package:competition_tracker/src/data/repositories/hive_repository.dart';
import 'package:competition_tracker/src/exceptions/exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'contest_api_repository.dart';

class ContestsRepository {
  final ContestsApiRepository source;
  final HiveRepository cache;
  final bool Function() hasConnection;

  ContestsRepository({
    @required this.source,
    @required this.cache,
    @required this.hasConnection,
  });

  getData(int id) async {
    ContestEntity cachedContest = await this.cache.getData(id);
    print(cachedContest);
    if (cachedContest != null) {
      return cachedContest;
    }
    print('online');
    if (!this.hasConnection()) {
      throw NoConnectionException();
    }

    ContestEntity remoteContest = await this.source.getDataFromInternet(id);
    remoteContest.objects.forEach((element) {
      element.start = DateFormat('d-MM-yyyy hh:mm aa').format(DateTime.parse(element.start));
      element.end = DateFormat('d-MM-yyyy hh:mm aa').format(DateTime.parse(element.end));
      element.duration = Duration(seconds: element.duration).inHours;
    });
    this.cache.addToHive(id, remoteContest);
    print(remoteContest.objects);
    return remoteContest;
  }

  getDataFromInternet(int id) async {
    cache.clear();
    if (!this.hasConnection()) {
      throw NoConnectionException();
    }
    ContestEntity contestEntity = await source.getDataFromInternet(id);
    cache.addToHive(id, contestEntity);
    return contestEntity;
  }
}
