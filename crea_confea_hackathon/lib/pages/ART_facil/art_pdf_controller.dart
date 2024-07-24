import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class ArtPdfController {
  Future<void> emitirArt(List dados) async {
    final pdf = Document();
    final img = await rootBundle.load("assets/files/template_art_sp.png");
    final imageBytes = img.buffer.asUint8List();

    List<List<dynamic>> tabela = [
      [
        dados.first["area"],
        '',
        '',
        '',
        '',
        '',
      ],
    ];

    for (var dado in dados) {
      tabela.add([
        "",
        dado["sub_area"],
        dado["obras_servicos"],
        dado["complemento"],
        dado["quantidade"],
        dado["unidade"]
      ]);
    }
    pdf.addPage(
      Page(
        build: (Context context) {
          return Stack(
            children: [
              Positioned(
                top: 585,
                left: 0,
                child: Container(
                  color: PdfColor.fromHex("FFFFFF"),
                  width: 410,
                  height: 40,
                ),
              ),
              Positioned(
                top: 503,
                left: 0,
                child: Container(
                  color: PdfColor.fromHex("FFFFFF"),
                  height: 70,
                  child: TableHelper.fromTextArray(
                    context: context,
                    border: TableBorder.all(color: PdfColor.fromHex("FFFFFF")),
                    cellPadding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    // border: TableBorder.all(color: PdfColor.fromHex("FFFFFF")),
                    headerAlignment: Alignment.centerLeft,

                    headerStyle: TextStyle(
                        fontSize: 9, height: 5, fontWeight: FontWeight.bold),
                    cellStyle: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      background: BoxDecoration(),
                    ),

                    columnWidths: {
                      0: const FixedColumnWidth(80),
                      1: const FixedColumnWidth(112),
                      2: const FixedColumnWidth(102),
                      3: const FixedColumnWidth(80),
                      4: const FixedColumnWidth(60),
                      5: const FixedColumnWidth(80),
                    },
                    data: tabela,
                  ),
                ),
              ),
            ],
          );
        },
        pageTheme: PageTheme(
          pageFormat: PdfPageFormat.a4,
          margin: EdgeInsets.symmetric(horizontal: 39),
          buildBackground: (context) => FullPage(
            ignoreMargins: true,
            child: Image(
              MemoryImage(imageBytes),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );

    final file = File("C:/Users/devma/Downloads/art.pdf");

    await file.writeAsBytes(await pdf.save());
  }
}
