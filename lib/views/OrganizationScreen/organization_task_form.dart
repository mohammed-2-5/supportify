import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:on_bording/controller/HomeController.dart';
import 'package:on_bording/controller/OrganizationController.dart';

import '../../core/Widgets/CustomElevatedButton.dart';
import '../../core/Widgets/InputField.dart';
import '../Settings/ThankYouScreen.dart';

class OrganizationTaskForm extends StatefulWidget {
  final OrganizationController controller = Get.find();
  final HomeController homeController = Get.find();

  OrganizationTaskForm({super.key});

  @override
  _OrganizationTaskFormState createState() => _OrganizationTaskFormState();
}

class _OrganizationTaskFormState extends State<OrganizationTaskForm> {
  final _formKey = GlobalKey<FormState>();

  // Initialize form field controllers
  final _eventNameController = TextEditingController(text: '');
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _contactPhoneController = TextEditingController();
  final _contactEmailController = TextEditingController();
  final _dateController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  int _organizationCount = 1; // Default value for volunteers count

  TimeOfDay _timeFrom = TimeOfDay.now();
  TimeOfDay _timeTo = TimeOfDay.now();
  bool isPicked = false;
  String timeToPicked = '';
  String timeFromPicked = '';

  // TimeOfDay _timeFrom = const TimeOfDay(hour: 9, minute: 0);
  // TimeOfDay _timeTo = const TimeOfDay(hour: 13, minute: 0);

  @override
  void initState() {
    super.initState();
    _dateController.text = "7/5/2024"; // Initialize with a default date
  }

  File? file;
  String? url;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InputField(
                onTap: () {},
                controller: _eventNameController,
                label: 'Task Name',
                hintLabel: 'Organization task '),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Description',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: _descriptionController,
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
              controller: _dateController,
              onTap: () {
                _selectDate(context);
              },
              icon: null,
            ),
            DropdownButtonFormField<int>(
              value: _organizationCount,
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
                setState(() {
                  _organizationCount = newValue!;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const Text('Time From'),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: OutlinedButton(
                      onPressed: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                            context: context, initialTime: _timeFrom);

                        if (pickedTime != null && pickedTime != _timeFrom) {
                          setState(() {
                            _timeFrom = pickedTime;
                            timeFromPicked =
                                '${_timeFrom.hour}:${_timeFrom.minute}';
                            isPicked = true;
                            print(
                                'Time from: ${_timeFrom.hour}:${_timeFrom.minute}');
                          });
                        }
                      },
                      child: isPicked
                          ? Text(timeFromPicked)
                          : const Text('00:00')),
                ),
                const SizedBox(width: 8),
                const Text(' to'),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                      onPressed: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                            context: context, initialTime: _timeTo);

                        if (pickedTime != null && pickedTime != _timeTo) {
                          setState(() {
                            _timeTo = pickedTime;
                            timeToPicked = '${_timeTo.hour}:${_timeTo.minute}';
                            isPicked = true;
                            print('Time to: ${_timeTo.hour}:${_timeTo.minute}');
                          });
                        }
                      },
                      child:
                          isPicked ? Text(timeToPicked) : const Text('00:00')),
                )
              ],
            ),
            const SizedBox(height: 20),
            InputField(
              label: 'Location',
              hintLabel: 'Enter Location Link',
              controller: _locationController,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Media addition

            Obx(() {
              return Column(
                children: [
                  if (widget.controller.isLoading.isTrue)
                    const CircularProgressIndicator(),
                  CustomElevatedButton(
                    title: 'Post',
                    onPressed: widget.controller.isLoading.isTrue
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              // Calling the asynchronous function without changing the onPressed signature.
                              await widget.controller.addOrganization(
                                eventName: _eventNameController.text,
                                description: _descriptionController.text,
                                date: _dateController.text,
                                location: _locationController.text,
                                phone: _phoneController.text,
                                email: _emailController.text,
                                organizationCount: _organizationCount,
                                timeFrom: _timeFrom.format(context),
                                timeTo: _timeTo.format(context),
                                imageUrl: widget
                                    .homeController.userModel.value.imageUrl,
                              );
                              widget.controller.fetchOrganizations();
                              Get.to(() => const ThankYouScreen());
                              // Potentially navigate or update UI post submission
                            }
                          },
                  ),
                ],
              );
            }),
            const SizedBox(
              height: 150,
            )
          ],
        ));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateFormat('dd/MM/yyyy').parse(_dateController.text),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null &&
        pickedDate != DateFormat('dd/MM/yyyy').parse(_dateController.text)) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    _eventNameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _contactPhoneController.dispose();
    _contactEmailController.dispose();
    super.dispose();
  }
}
