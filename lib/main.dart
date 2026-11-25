import 'package:consultacep/telaCep.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Consulta CEP',
      home: TelaCep(),
    );
  }
}