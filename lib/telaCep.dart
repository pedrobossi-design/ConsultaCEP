import 'package:material_ui/material_ui.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';

class TelaCep extends StatefulWidget {
  const TelaCep({super.key});

  @override
  State<TelaCep> createState() => _TelaCepState();
}

class _TelaCepState extends State<TelaCep> {
  final TextEditingController _cepController = TextEditingController();
  Map<String, dynamic>? _endereco;

  Future<Map<String, dynamic>?> _buscarCep(String cep) async {
    final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
    final resposta = await http.get(url);

    final dados = jsonDecode(resposta.body);

    if(dados.containsKey('erro')) return null;

    return dados;
  }

  Widget _linha(String titulo, String chave){
    final valor = _endereco![chave];
    final texto = (valor == null || valor == '') ? '-' : valor;
    return Text('$titulo: $texto', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  controller: _cepController,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.green,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(8),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Digite o CEP',
                    border: OutlineInputBorder(),
                    floatingLabelStyle: TextStyle(color: Colors.green),
                    helperText: 'Somente números',
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
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
            final cep = _cepController.text;
            setState(() => _endereco = null);   // limpa o resultado anterior

            if (cep.length != 8) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('CEP inválido. Digite um CEP com 8 dígitos.'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            try {
              final dados = await _buscarCep(cep);
              if (!mounted) return;

              if (dados == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('CEP não encontrado.'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              setState(() => _endereco = dados);
            } catch (e) {
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Erro de conexão. Verifique sua internet.'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: const Text('Consultar'),
              ),
              SizedBox(height: 16.0,),
                
                if (_endereco != null) ...[
                  Divider(
                  color: Colors.lightGreen,
                ),
                    _linha('CEP', 'cep'),
                    _linha('Rua', 'logradouro'),
                    _linha('Complemento', 'complemento'),
                    _linha('Unidade', 'unidade'),
                    _linha('Bairro', 'bairro'),
                    _linha('Cidade', 'localidade'),
                    _linha('UF', 'uf'),
                    _linha('Estado', 'estado'),
                    _linha('Região', 'regiao'),
                    _linha('IBGE', 'ibge'),
                    _linha('GIA', 'gia'),
                    _linha('DDD', 'ddd'),
                    _linha('SIAFI', 'siafi'),
                  Divider(
                  color: Colors.lightGreen,
                ),
                ],
              ],
            ),
          ) 
        ,)
      );
  }
}