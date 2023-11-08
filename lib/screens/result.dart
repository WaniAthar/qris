import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qris/utils/api/decrypt_api_provider.dart';
import 'package:lottie/lottie.dart';

class Result extends StatefulWidget {
  const Result(
      {super.key,
      required this.orderId,
      required this.cipher,
      required this.seckey});
  final String orderId, cipher, seckey;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: Center(
        child: FutureBuilder(
          future: context.read<ProviderAPI>().decryptAndAuthenticate(
              widget.orderId, widget.cipher, widget.seckey),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError || snapshot.data == false) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/animations/cross.json'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "You are not verified.",
                    style: GoogleFonts.inter(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              );
            } else {
              // Authentication is successful
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/animations/verified.json'),
                  Text(
                    "Keys are verified",
                    style: GoogleFonts.inter(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
