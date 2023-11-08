import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:qris/screens/result.dart';

class Scanner extends StatefulWidget {
  final String scanned;
  const Scanner({super.key, required this.scanned});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  String? orderId;
  String? cipher;

  @override
  Widget build(BuildContext context) {
    List<String> keyCipher = widget.scanned.split(" ");
    orderId = keyCipher[0];
    cipher = keyCipher[1];

    TextEditingController inputkey_ = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Auth",
          style: GoogleFonts.inter(
            color: Theme.of(context).colorScheme.onTertiary,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Lottie.asset("assets/animations/lock.json", height: 300),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(5),
            child: SingleChildScrollView(
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                controller: inputkey_,
                decoration: InputDecoration(
                  hintText: 'Paste your secret key here...',
                  hintStyle: GoogleFonts.inter(
                    color: Colors.grey,
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: ElevatedButton(
              onPressed: () async {
                if (inputkey_.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Please paste your secret key...",
                      style: GoogleFonts.inter(),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.surfaceTint,
                  ));
                } else {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => Result(
                        orderId: orderId!,
                        cipher: cipher!,
                        seckey: inputkey_.text,
                      ),
                    ),
                  );
                }
              },
              child: SizedBox(
                height: 60,
                width: double.infinity,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Auth",
                        style: GoogleFonts.inter(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Icon(Icons.lock)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
