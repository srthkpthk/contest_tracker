class Resource {
  final String icon;
  final int id;
  final String name;

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

  @override
  String toString() {
    return 'Resource{icon: $icon, id: $id, name: $name}';
  }
}
