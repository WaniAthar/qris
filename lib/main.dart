import 'package:flutter/material.dart';
import 'package:qris/utils/api/decrypt_api_provider.dart';
import 'screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const QR());
}

class QR extends StatelessWidget {
  const QR({super.key});
  @override
  Widget build(BuildContext context) {
    String title = 'Qris';
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ProviderAPI())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          iconTheme: const IconThemeData(color: Colors.white),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
          ),
          useMaterial3: true,
        ),
        home: Home(
          title: title,
        ),
      ),
    );
  }
}
