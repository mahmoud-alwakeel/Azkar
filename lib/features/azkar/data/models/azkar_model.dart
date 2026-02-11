class AzkarModel {
  final int id;
  final String title;
  final String text;
  final int repeat;
  int counter;

  AzkarModel({
    required this.id,
    required this.title,
    required this.text,
    required this.repeat,
    this.counter = 0,
  });

  factory AzkarModel.fromJson(Map<String, dynamic> json) {
    return AzkarModel(
      id: json['id'] as int,
      title: json['title'] as String,
      text: json['text'] as String,
      repeat: json['repeat'] as int,
      counter: json['counter'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'repeat': repeat,
      'counter': counter,
    };
  }

  AzkarModel copyWith({
    int? id,
    String? title,
    String? text,
    int? repeat,
    int? counter,
  }) {
    return AzkarModel(
      id: id ?? this.id,
      title: title ?? this.title,
      text: text ?? this.text,
      repeat: repeat ?? this.repeat,
      counter: counter ?? this.counter,
    );
  }
}
