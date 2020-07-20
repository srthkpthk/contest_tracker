import 'package:competition_tracker/src/data/model/competitions/resource.dart';

class Objects {
  final int duration;
  final String end;
  final String event;
  final String href;
  final int id;
  final Resource resource;
  final String start;

  Objects.fromJsonMap(Map<String, dynamic> map)
      : duration = map["duration"],
        end = map["end"],
        event = map["event"],
        href = map["href"],
        id = map["id"],
        resource = Resource.fromJsonMap(map["resource"]),
        start = map["start"];

  @override
  String toString() {
    return 'Objects{duration: $duration, end: $end, event: $event, href: $href, id: $id, resource: $resource, start: $start}';
  }

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
