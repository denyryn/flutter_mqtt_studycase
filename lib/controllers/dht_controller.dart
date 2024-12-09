import 'package:get/get.dart';
import '../repositories/topic_repository.dart';
import '../models/temperature_model.dart';
import '../models/humidity_model.dart';
import '../services/mqtt_service.dart';

class DhtController extends GetxController {
  final _mqttService = Get.put(MqttService());

  late Rx<TemperatureModel> temperatureValue =
      Rx(TemperatureModel(temperature: 0.0));

  late Rx<HumidityModel> humidityValue = Rx(HumidityModel(humidity: 0.0));

  RxBool isSubscribed = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDhtData();
  }

  Future<void> fetchDhtData() async {
    return getDhtData(TopicsRepository.humTopic, TopicsRepository.tempTopic);
  }

  Future<void> getDhtData(String humTopic, String tempTopic) async {
    if (!isSubscribed.value) {
      await _mqttService.subscribe(humTopic);
      await _mqttService.subscribe(tempTopic);
      isSubscribed.value = true;
    }

    _getTemperatureMessage(tempTopic);
    _getHumidityMessage(humTopic);
  }

  Future<void> _getTemperatureMessage(String topic) async {
    _mqttService.registerCallback(topic, (String message) {
      print('Received message from topic $topic: $message');
      try {
        final tempData = message;

        temperatureValue.update((value) {
          value?.temperature = tempData as double;
        });

        temperatureValue.refresh();
      } catch (e) {
        print('Error parsing message: $e');
      }
    });
  }

  Future<void> _getHumidityMessage(String topic) async {
    _mqttService.registerCallback(topic, (String message) {
      print('Received message from topic $topic: $message');
      try {
        final humData = message;

        humidityValue.update((value) {
          value?.humidity = humData as double;
        });

        humidityValue.refresh();
      } catch (e) {
        print('Error parsing message: $e');
      }
    });
  }

  Future<bool> connectToMqtt() async {
    return await _mqttService.connect();
  }
}
