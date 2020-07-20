class Meta {
  int limit;
  String next;
  int offset;
  Object previous;
  int total_count;

  Meta.fromJsonMap(Map<String, dynamic> map)
      : limit = map["limit"],
        next = map["next"],
        offset = map["offset"],
        previous = map["previous"],
        total_count = map["total_count"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = limit;
    data['next'] = next;
    data['offset'] = offset;
    data['previous'] = previous;
    data['total_count'] = total_count;
    return data;
  }
}
