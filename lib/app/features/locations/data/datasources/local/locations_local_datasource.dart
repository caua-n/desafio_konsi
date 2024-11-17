import 'dart:convert';

import 'package:desafio_konsi/app/features/locations/data/datasources/locations_datasource.dart';
import 'package:flutter/services.dart';

class LocalLocationsDatasource implements LocationsDatasource {
  @override
  Future<Map<String, dynamic>> fetchLocations() async {
    final json = await rootBundle.loadString('assets/locations.json');
    return jsonDecode(json);
  }
}
