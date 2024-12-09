class HumidityModel {
  double humidity;
  // final Array? topic;

  HumidityModel({required this.humidity});

  factory HumidityModel.fromJson(Map<String, dynamic> json) {
    return HumidityModel(
      humidity: json['humidity'],
      // topic: json['topic'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'humidity': humidity,
      // 'topic': topic
    };

    return data;
  }
}
