import 'package:competition_tracker/src/data/model/competitions/contest_entity.dart';
import 'package:competition_tracker/src/util/api_utils.dart';
import 'package:dio/dio.dart';

class ContestsApiRepository {
  getDataFromInternet(int id) async {
    const CONTESTS_URL = 'https://clist.by:443/api/v1/contest/';
    var response = await Dio().get(CONTESTS_URL, queryParameters: {
      'username': API_UTILS.USERNAME,
      'api_key': API_UTILS.API_KEY,
      'resource__id': id,
      'end__gt': DateTime.now().toIso8601String(),
      'format': 'json'
    });
    return ContestEntity.fromJsonMap(response.data);
  }
}
