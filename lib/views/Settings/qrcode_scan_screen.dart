import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../controller/qr_controller.dart';

class QRScanPage extends StatelessWidget {
  const QRScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final QRController qrScanController = Get.put(QRController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(
            controller: qrScanController.cameraController,
            onDetect: (barcode) => qrScanController.onDetect(barcode),
          ),
          Obx(() {
            return qrScanController.isCodeDetected.value
                ? Positioned(
                    bottom: 50,
                    child: ElevatedButton(
                      onPressed: qrScanController.navigateToDoneRateScreen,
                      child: const Text('Withdraw'),
                    ),
                  )
                : Positioned(
                    top: 50,
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
          }),
        ],
      ),
    );
  }
}
