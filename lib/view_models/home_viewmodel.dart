import 'package:get/get.dart';
import 'dart:async';
import '../services/utils.dart';
import '../services/mqtt_service.dart';
import '../controllers/dht_controller.dart';
import '../controllers/led_controller.dart';

class HomeViewModel extends GetxController {
  final MqttService mqttService = MqttService();
  final dhtController = Get.put(DhtController());
  final ledController = Get.put(LedController());

  final Utils utils = Utils();

  RxBool isActive = false.obs;
  RxBool mqttConnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    getDhtData();
  }

  // Connect to MQTT and update the connection status
  Future<void> connect() async {
    await mqttService.connect();
    utils.refreshVariableValue(mqttConnected, true); // Update connection status
  }

  void getDhtData() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      dhtController.fetchDhtData();
    });
  }

  void start() {
    ledController.sendLedState(true);
    utils.refreshVariableValue(isActive, true);
  }

  void stop() {
    ledController.sendLedState(false);
    utils.refreshVariableValue(isActive, false);
  }

  // Disconnect from MQTT and update the connection status
  void disconnect() {
    stop();
    mqttService.disconnect();
    utils.refreshVariableValue(
        mqttConnected, false); // Update connection status
  }
}
