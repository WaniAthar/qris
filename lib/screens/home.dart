// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:qris/screens/qr_scanner.dart';

class Home extends StatelessWidget {
  final String title;
  const Home({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    String res;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          title,
          style: GoogleFonts.inter(
            color: Theme.of(context).colorScheme.onTertiary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              // height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Scan your Secret QR code",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Scan your secret QR code to get the authenticity of your product. It uses 3DES encryption algorithm for secure Message transfer.",
                    style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.secondary),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Lottie.asset('assets/animations/qr.json'),
            SizedBox(
              height: 100,
              width: 100,
              child: FloatingActionButton(
                onPressed: () async {
                  res = await scanQR();
                  if (res != '-1') {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Scanner(scanned: res),
                      ),
                    );
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor:
                            Theme.of(context).colorScheme.surfaceTint,
                        content: Text(
                          "Nothing was scanned!!",
                          style: GoogleFonts.inter(),
                        ),
                      ),
                    );
                  }
                },
                tooltip: "Scan button",
                child: Icon(
                  Icons.qr_code_scanner_rounded,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  size: 80,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String> scanQR() async {
    String barcodeScanRes = '';
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    // print(barcodeScanRes);
    return barcodeScanRes;
  }
}
