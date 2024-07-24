import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ViaCepAPI {
  Future fetch({required String cep, required BuildContext context}) async {
    var url = Uri.https('viacep.com.br', 'ws/$cep/json/');
    // await http.get(url).then(
    //       (value) => setState(
    //         () {
    //           enderecoModel = EnderecoModel.fromJson(value.body);
    //           logradouroController.text = enderecoModel.logradouro!;
    //           numeroController.text = enderecoModel.numero!;
    //           complementoController.text = "";
    //           bairroController.text = enderecoModel.bairro!;
    //           localidadeController.text = enderecoModel.localidade!;
    //           uFController.text = enderecoModel.uf!;
    //           hasCEP = true;
    //         },
    //       ),
    //     );
  }
}
