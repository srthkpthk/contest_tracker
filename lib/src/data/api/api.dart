import 'package:competition_tracker/src/data/model/competitions/ContestEntity.dart';
import 'package:competition_tracker/src/util/api_utils.dart';
import 'package:dio/dio.dart';

class Repository {
  static const CONTESTS_URL = 'https://clist.by:443/api/v1/contest/';
  static const ENTRIES_URL = 'https://clist.by:443/api/v1/resource/';

  Future<ContestEntity> getContestsById(int id) async {
    var response = await Dio().get(CONTESTS_URL, queryParameters: {
      'username': API_UTILS.USERNAME,
      'api_key': API_UTILS.API_KEY,
      'resource__id': id,
      'end__gt': DateTime.now().toIso8601String(),
      'format': 'json'
    });
//    log(response.data);
    return ContestEntity.fromJsonMap(response.data);
  }
}
