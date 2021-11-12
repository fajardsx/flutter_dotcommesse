import 'package:dotcom_mart/controller/counter_controller.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterController c = Get.put(CounterController());

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text("Click : ${c.count}")),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("go to other page"),
          onPressed: () => Get.to(() => OtherScreen()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: c.incerement,
      ),
    );
  }
}

class OtherScreen extends StatelessWidget {
  final CounterController c = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("other"),
      ),
      body: Column(
        children: [
          Center(
            child: Text("${c.count}"),
          )
        ],
      ),
    );
  }
}
