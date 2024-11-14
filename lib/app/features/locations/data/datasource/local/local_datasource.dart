import 'dart:convert';

import 'package:desafio_konsi/app/features/locations/data/datasource/datasource.dart';
import 'package:flutter/services.dart';

class LocalDatasource implements BodyDatasource {
  @override
  Future<Map<String, dynamic>> getJsonBody() async {
    final json = await rootBundle.loadString('assets/body.json');
    return jsonDecode(json);
  }
}
