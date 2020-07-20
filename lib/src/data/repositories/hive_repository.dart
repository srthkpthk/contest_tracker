import 'package:competition_tracker/src/data/model/competitions/contest_entity.dart';
import 'package:hive/hive.dart';

class HiveRepository {
  final Box _box;

  HiveRepository(this._box);

  getData(int id) async {
    if (this.boxIsClosed) {
      return null;
    }
    return this._box.get(id);
  }

  addToHive(int id, ContestEntity contest) async {
    if (this.boxIsClosed) {
      return;
    }
    await this._box.put(id, contest);
  }

  bool get boxIsClosed => !(this._box?.isOpen ?? false);

  clear() async {
    if (this.boxIsClosed) {
      return;
    }
    await _box.clear();
  }
}
