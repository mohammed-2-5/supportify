import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:on_bording/controller/HomeController.dart';
import 'package:on_bording/core/Widgets/CustomElevatedButton.dart';

import '../../controller/donation_contoller.dart';
import '../../core/Widgets/InputField.dart';

class DonateTaskForm extends StatelessWidget {
  DonateTaskForm({super.key});

  final DonateTaskController controller = Get.find();
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          InputField(
            controller: controller.eventNameController,
            label: 'Event Name',
            hintLabel: 'Donation ',
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 5),
          InputField(
            label: 'Location',
            hintLabel: 'Enter Location Link',
            controller: controller.locationController,
          ),
          const SizedBox(height: 5),
          const Text(
            'Date',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          const Text(
            'Start Date',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Obx(() => OutlinedButton(
                onPressed: () async {
                  await controller.selectDate(context, true);
                },
                child: controller.isPickedStartDate.value
                    ? Text(DateFormat('dd/MM/yyyy')
                        .format(controller.startDate.value))
                    : const Text('Pick a date'),
              )),
          const SizedBox(height: 20),
          const Text(
            'End Date',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Obx(() => OutlinedButton(
                onPressed: () async {
                  await controller.selectDate(context, false);
                },
                child: controller.isPickedEndDate.value
                    ? Text(DateFormat('dd/MM/yyyy')
                        .format(controller.endDate.value))
                    : const Text('Pick a date'),
              )),
          const SizedBox(height: 20),
          Obx(() {
            if (controller.goals.isEmpty) {
              return const CircularProgressIndicator();
            }
            return DropdownButtonFormField<int>(
              value: controller.goal.value,
              decoration: const InputDecoration(
                labelText: 'Goal',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              ),
              items: controller.goals.map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: (int? newValue) {
                controller.goal.value = newValue!;
              },
            );
          }),
          const SizedBox(height: 20),
          Obx(() {
            if (controller.categories.isEmpty) {
              return const CircularProgressIndicator();
            }
            return DropdownButtonFormField<String>(
              value: controller.selectedCategory.value.isEmpty
                  ? null
                  : controller.selectedCategory.value,
              decoration: const InputDecoration(
                labelText: 'Category',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              ),
              items: controller.categories
                  .map<DropdownMenuItem<String>>((category) {
                return DropdownMenuItem<String>(
                  value: category['categoryName'],
                  child: Text(category['categoryName']),
                );
              }).toList(),
              onChanged: (String? newValue) {
                controller.selectedCategory.value = newValue!;
              },
            );
          }),
          const SizedBox(height: 20),
          CustomElevatedButton(
            onPressed: () {
              controller.addDonationTask(
                  context,
                  homeController.userModel.value.imageUrl,
                  homeController.userModel.value.username);
            },
            title: 'Post',
          ),
        ],
      ),
    );
  }
}
