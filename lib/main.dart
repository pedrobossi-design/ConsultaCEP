import 'package:material_ui/material_ui.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
  
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Consulta CEP',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Consulta CEP', style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Consulta CEP', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Digite o CEP',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 1.0),
                    )
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  child: Text('Consultar'),
                  onPressed:() => print('Botão pressionado'),)
              ],
            ),
          ) 
        ,)
      )

    );
  }
}