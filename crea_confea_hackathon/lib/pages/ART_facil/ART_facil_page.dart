import 'dart:ffi';

import 'package:crea_confea_hackathon/pages/ART_facil/art_facil_controller.dart';
import 'package:crea_confea_hackathon/pages/ART_facil/art_pdf_controller.dart';
import 'package:crea_confea_hackathon/pages/sucess/sucess_page.dart';
import 'package:crea_confea_hackathon/shared/themes/app_text_styles.dart';
import 'package:crea_confea_hackathon/shared/widgets/button_widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ArtFacilPage extends StatefulWidget {
  const ArtFacilPage({super.key});

  @override
  State<ArtFacilPage> createState() => _ArtFacilPageState();
}

class _ArtFacilPageState extends State<ArtFacilPage> {
  ArtFacilController controller = ArtFacilController();
  double height = 0;
  String? text;

  TextEditingController editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Obras e serviços",
                style: AppTextStyles.title,
              ),
              FutureBuilder(
                future: controller.createTOS(text),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Carregando...");
                  }
                  print(snapshot.data);

                  if (snapshot.hasData && snapshot.data!.isEmpty) {
                    return Text(
                      "Com base na sua descrição de obra ou serviço buscaremos nos dados da TOS, com as especificações usando IA",
                      style: AppTextStyles.subtile,
                    );
                  }

                  if (snapshot.hasData) {
                    final dados = snapshot.data;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                TextEditingController areaController =
                                    TextEditingController(
                                        text: dados![index]["area"]);
                                TextEditingController subAreaController =
                                    TextEditingController(
                                        text: dados[index]["sub_area"]);
                                TextEditingController obrasServicosController =
                                    TextEditingController(
                                        text: dados[index]["obras_servicos"]);
                                TextEditingController complementoController =
                                    TextEditingController(
                                        text: dados[index]["complemento"]);
                                TextEditingController quantidadeController =
                                    TextEditingController(
                                        text: dados[index]["quantidade"]
                                            .toString());
                                TextEditingController unidadeController =
                                    TextEditingController(
                                        text: dados[index]["unidade"]);

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: areaController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: 'Área',
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    TextField(
                                      controller: subAreaController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: 'Sub-area',
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    TextField(
                                      controller: obrasServicosController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: 'obras e servicos',
                                      ),
                                    ),
                                    // Sou engenheiro civil construindo uma casa de 80 metros quadrados de madeira
                                    const SizedBox(height: 8),
                                    TextField(
                                      controller: complementoController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: 'complemento',
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextField(
                                      controller: quantidadeController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: 'quantidade',
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    TextField(
                                      controller: unidadeController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: 'unidade',
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        ButtonWidget(
                          onPressed: () async {
                            await ArtPdfController().emitirArt(dados!);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => SucessPage(),
                              ),
                            );
                          },
                          text: "Concluir e emitir ART",
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          width: 300,
          child: Row(
            children: [
              Expanded(
                flex: 8,
                child: TextField(
                  controller: editingController,
                  decoration: const InputDecoration(
                    hintText: 'descreva um pouco sobre a obra ou serviço',
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      text = editingController.text;
                      editingController.text = "";
                    });
                  },
                  icon: const Icon(Icons.send),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
