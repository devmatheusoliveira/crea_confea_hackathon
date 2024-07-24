import 'dart:convert';

import 'package:crea_confea_hackathon/shared/tos_base64.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ArtFacilController {
  Future<List> createTOS(String? text) async {
    if (text == null || text.isEmpty) return [];

    await dotenv.load(fileName: ".env");
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: dotenv.env["gemini_key"]!,
      systemInstruction: Content.text(
        'com base na tabela, identifique crie um json contendo area, sub_area, obras_servicos, complemento, quantidade e unidade',
      ),
      generationConfig: GenerationConfig(
        temperature: 0,
      ),
    );
    final response = await model.generateContent(
      [
        Content.multi(
          [
            DataPart(
              'application/pdf',
              base64Decode(TosBase64.base64),
            ),
            TextPart(text),
          ],
        ),
      ],
    );
    print(
      jsonDecode(
        response.text!
            .replaceAll(RegExp(r'```json\n'), "")
            .replaceAll(RegExp(r'```'), "")
            .replaceAll(RegExp(r'\n'), ""),
      ),
    );
    // Sou engenheiro civil construindo uma casa de 80 metros de madeira
    return jsonDecode(
      response.text!
          .replaceAll(RegExp(r'```json\n'), "")
          .replaceAll(RegExp(r'```'), "")
          .replaceAll(RegExp(r'\n'), ""),
    );
  }
}
