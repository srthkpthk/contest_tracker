import 'package:competition_tracker/src/data/model/competitions/meta.dart';
import 'package:competition_tracker/src/data/model/competitions/objects.dart';

class ContestEntity {
  final Meta meta;
  final List<Objects> objects;

  ContestEntity.fromJsonMap(Map<String, dynamic> map)
      : meta = Meta.fromJsonMap(map["meta"]),
        objects = List<Objects>.from(map["objects"].map((it) => Objects.fromJsonMap(it)));

  @override
  String toString() {
    return 'ContestEntity{meta: $meta, objects: $objects}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meta'] = meta == null ? null : meta.toJson();
    data['objects'] = objects != null ? this.objects.map((v) => v.toJson()).toList() : null;
    return data;
  }
}
