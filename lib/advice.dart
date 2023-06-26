class Advice {
  int? id;
  String? advice;

  Advice({required this.id, required this.advice});

  Advice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advice = json['advice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['advice'] = advice;

    return data;
  }
}
