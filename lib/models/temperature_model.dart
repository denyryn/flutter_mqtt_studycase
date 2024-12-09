class TemperatureModel {
  double temperature;
  // final Array? topic;

  TemperatureModel({required this.temperature});

  factory TemperatureModel.fromJson(Map<String, dynamic> json) {
    return TemperatureModel(
      temperature: json['temperature'],
      // topic: json['topic'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'temperature': temperature,
      // 'topic': topic
    };

    return data;
  }
}
