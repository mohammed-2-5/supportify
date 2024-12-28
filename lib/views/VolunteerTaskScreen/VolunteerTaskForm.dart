import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/HomeController.dart';
import '../../controller/volunteercontroller.dart';
import '../../core/Widgets/CustomElevatedButton.dart';
import '../../core/Widgets/InputField.dart';
import '../Settings/ThankYouScreen.dart';

class VolunteerTaskForm extends StatelessWidget {
  final VolunteerController controller = Get.find();
  final HomeController homeController = Get.find();
  final _formKey = GlobalKey<FormState>();

  VolunteerTaskForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          InputField(
            onTap: () {},
            controller: controller.eventNameController,
            label: 'Task Name',
            hintLabel: 'Volunteering task',
          ),
          const SizedBox(height: 20),
          const Text(
            'Description',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller.descriptionController,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: 'Enter Your Data',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              alignLabelWithHint: true,
            ),
          ),
          InputField(
            label: 'Date',
            hintLabel: 'Date',
            controller: controller.dateController,
            onTap: () {
              controller.selectDate(context);
            },
            icon: null,
          ),
          Obx(() => DropdownButtonFormField<int>(
                value: controller.volunteersCount.value,
                decoration: const InputDecoration(
                  labelText: 'Volunteers Count',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                ),
                items: List.generate(10, (index) => index + 1)
                    .map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (int? newValue) {
                  controller.volunteersCount.value = newValue!;
                },
              )),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Text('Time From'),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    controller.selectTime(context, true);
                  },
                  child: Obx(() => controller.isPicked.value
                      ? Text(controller.timeFromPicked.value)
                      : const Text('00:00')),
                ),
              ),
              const SizedBox(width: 8),
              const Text('to'),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    controller.selectTime(context, false);
                  },
                  child: Obx(() => controller.isPicked.value
                      ? Text(controller.timeToPicked.value)
                      : const Text('00:00')),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          InputField(
            label: 'Location',
            hintLabel: 'Enter Location Link',
            controller: controller.locationController,
          ),
          const SizedBox(height: 20),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: controller.phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Obx(() {
            return Column(
              children: [
                if (controller.isLoading.isTrue)
                  const CircularProgressIndicator(),
                CustomElevatedButton(
                  title: 'Post',
                  onPressed: controller.isLoading.isTrue
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            await controller.addVolunteer();
                            controller.fetchVolunteers();
                            Get.to(() => const ThankYouScreen());
                          }
                        },
                ),
              ],
            );
          }),
          const SizedBox(height: 150),
        ],
      ),
    );
  }
}
