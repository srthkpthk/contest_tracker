class Resource {
  String icon;
  int id;
  String name;

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
