import 'package:competition_tracker/src/data/model/competitions/objects.dart';
import 'package:hive/hive.dart';

part 'contest_entity.g.dart';

@HiveType(typeId: 0)
class ContestEntity extends HiveObject {
  @HiveField(0)
  List<Objects> objects;

  ContestEntity(this.objects);

  ContestEntity.fromJsonMap(Map<String, dynamic> map)
      : objects = List<Objects>.from(map["objects"].map((it) => Objects.fromJsonMap(it)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['objects'] = objects != null ? this.objects.map((v) => v.toJson()).toList() : null;
    return data;
  }
}
