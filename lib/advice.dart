class Advice {
  int? id;
  String? advice;

  Advice({required this.id, required this.advice});

  Advice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advice = json['advice'];
  }
}
