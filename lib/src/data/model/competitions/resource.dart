import 'package:hive/hive.dart';

part 'resource.g.dart';

@HiveType(typeId: 2)
class Resource extends HiveObject {
  @HiveField(0)
  String icon;
  @HiveField(1)
  int id;
  @HiveField(2)
  String name;

  Resource(this.id, this.name, this.icon);

  Resource.fromJsonMap(Map<String, dynamic> map)
      : icon = map["icon"],
        id = map["id"],
        name = map["name"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = icon;
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
