import 'package:competition_tracker/src/data/model/competitions/resource.dart';
import 'package:hive/hive.dart';

part 'objects.g.dart';

@HiveType(typeId: 1)
class Objects extends HiveObject {
  @HiveField(0)
  int duration;
  @HiveField(1)
  String end;
  @HiveField(2)
  String event;
  @HiveField(3)
  String href;
  @HiveField(4)
  int id;
  @HiveField(5)
  Resource resource;
  @HiveField(6)
  String start;

  Objects(this.duration, this.end, this.event, this.href, this.id, this.resource, this.start);

  Objects.fromJsonMap(Map<String, dynamic> map)
      : duration = map["duration"],
        end = map["end"],
        event = map["event"],
        href = map["href"],
        id = map["id"],
        resource = Resource.fromJsonMap(map["resource"]),
        start = map["start"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration'] = duration;
    data['end'] = end;
    data['event'] = event;
    data['href'] = href;
    data['id'] = id;
    data['resource'] = resource == null ? null : resource.toJson();
    data['start'] = start;
    return data;
  }
}
