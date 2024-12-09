import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/gauge.dart';
import '../widgets/custom_elev_button.dart';
import '../view_models/home_viewmodel.dart';

class HomePage extends StatelessWidget {
  final HomeViewModel viewModel = Get.put(HomeViewModel());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MQTT Control'),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 16.0),
        //     child: IconButton(
        //       icon: const Icon(Icons.power_settings_new_outlined),
        //       onPressed: () => {
        //         _viewModel.isActive.value
        //             ? _viewModel.disconnect()
        //             : _viewModel.connect()
        //       },
        //     ),
        //   ),
        // ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // Make the content scrollable
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                    childAspectRatio: 1,
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    children: [
                      Obx(
                        () => Gauge(
                          label:
                              "Temperature : ${viewModel.dhtController.temperatureValue.value.temperature.obs} (C) ",
                          value: viewModel.dhtController.temperatureValue.value
                              .temperature.obs,
                          min: 0,
                          max: 60,
                        ),
                      ),
                      Obx(() => Gauge(
                            label:
                                "Humidity : ${viewModel.dhtController.humidityValue.value.humidity.obs} (%) ",
                            value: viewModel
                                .dhtController.humidityValue.value.humidity.obs,
                            min: 0,
                            max: 100,
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CustomElevButton(
                  label: 'Start',
                  onPressed: () => viewModel.start(),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomElevButton(
                    label: 'Stop', onPressed: () => viewModel.stop())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
