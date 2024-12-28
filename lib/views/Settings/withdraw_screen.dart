import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:on_bording/controller/qr_controller.dart';
import 'package:on_bording/core/Widgets/CustomElevatedButton.dart';

import '../../controller/OrganizationController.dart';
import '../../controller/volunteercontroller.dart';
import '../wallet/qrcode_screen.dart';
import 'qrcode_scan_screen.dart';

class WithdrawScreen extends StatelessWidget {
  WithdrawScreen({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();
  final VolunteerController volunteerController = Get.find();
  final OrganizationController organizationController = Get.find();
  final QRController qrController = Get.find();

  Future<int> getUserType() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userDoc.exists) {
      Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
      return data['type'] ?? 0;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset('assets/images/arrow back.svg'),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Balance',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff4F4F4F)),
                  ),
                  Text(
                    '\$15,567',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff333333)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: <Widget>[
                const Expanded(
                  flex: 2,
                  child: Text(
                    'Enter Amount',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      onChanged: (value) {
                        qrController.points.value = value as int;
                      },
                      controller: _controller,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.teal[100],
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: '\$500',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text('Withdraw'),
            const SizedBox(height: 30),
            FutureBuilder<int>(
              future: getUserType(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final userType = snapshot.data!;
                if (userType == 0) {
                  // Organization logic
                  return Expanded(
                    child: Obx(() {
                      if (organizationController.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                        itemCount: organizationController.organizations.length,
                        itemBuilder: (context, index) {
                          final organization =
                              organizationController.organizations[index];
                          final docId =
                              organizationController.organizationIds[index];
                          if (organization['userId'] ==
                              FirebaseAuth.instance.currentUser?.uid) {
                            return ListTile(
                              title: Text(organization['eventname']),
                              onTap: () {
                                Get.to(() => QRCodeScreen(id: docId));
                              },
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      );
                    }),
                  );
                } else {
                  // Volunteer logic
                  return Expanded(
                    child: Obx(() {
                      if (volunteerController.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                        itemCount: volunteerController.volunteers.length,
                        itemBuilder: (context, index) {
                          final volunteer =
                              volunteerController.volunteers[index];
                          final docId = volunteerController.volunteerIds[index];
                          if (volunteer.userId ==
                              FirebaseAuth.instance.currentUser?.uid) {
                            return ListTile(
                              title: Text(volunteer.eventName),
                              onTap: () {
                                Get.to(() => QRCodeScreen(id: docId));
                              },
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      );
                    }),
                  );
                }
              },
            ),
            const SizedBox(height: 50),
            Center(
              child: CustomElevatedButton(
                width: 250,
                onPressed: () {
                  Get.to(() => QRScanPage());
                },
                title: 'Post',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
