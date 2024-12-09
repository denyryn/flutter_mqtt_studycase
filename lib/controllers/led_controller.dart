// led_controller.dart
import 'package:get/get.dart';
import '../repositories/topic_repository.dart';
import '../services/mqtt_service.dart';

class LedController extends GetxController {
  late final MqttService _mqttService = Get.put(MqttService());
  static const ledTopic = TopicsRepository.ledTopic;

  Future<void> sendLedState(bool isOn) async {
    String topic = ledTopic;
    String message = isOn ? '1' : '0';
    final success = await _mqttService.publish(topic, message);
    if (!success) {
      print("Failed to send LED state. Please check connection.");
    }
  }

  Future<bool> connectToMqtt() async {
    return await _mqttService.connect();
  }
}
