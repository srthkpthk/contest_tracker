import 'package:competition_tracker/res.dart';
import 'package:competition_tracker/src/data/model/entries/entries.dart';

class HelperClass {
  List<EntriesEntities> entries = [
    EntriesEntities(1, 'CodeForces', Res.codeforces_logo),
    EntriesEntities(2, 'CodeChef', Res.codechef_logo),
    EntriesEntities(12, 'TopCoder', Res.topcoder_logo),
    EntriesEntities(29, 'Facebook HackerCup', Res.facebook_hackercup_logo),
    EntriesEntities(35, 'Google Coding Competitions', Res.google_coding_competitions_logo),
    EntriesEntities(63, 'Hackerrank', Res.hackerrank_logo),
    EntriesEntities(64, 'CodeForces Gym', Res.codeforces_logo),
    EntriesEntities(65, 'Project Euler', Res.project_euler_logo),
    EntriesEntities(73, 'HackerEarth', Res.hackerearth_logo),
    EntriesEntities(74, 'Kaggle', Res.kaggle_logo),
    EntriesEntities(93, 'AtCoder', Res.atcoder_logo),
    EntriesEntities(102, 'LeetCode', Res.leetcode_logo)
  ];
}
