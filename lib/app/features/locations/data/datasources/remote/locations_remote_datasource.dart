import 'package:desafio_konsi/app/features/locations/data/datasources/locations_datasource.dart';
import 'package:uno/uno.dart';

const _apiUrl = 'https://example.com/api/locations';

class RemoteLocationsDatasource implements LocationsDatasource {
  final Uno uno;

  RemoteLocationsDatasource(this.uno);

  @override
  Future<Map<String, dynamic>> fetchLocations() async {
    final response = await uno.get(
      _apiUrl,
      responseType: ResponseType.json,
    );

    return response.data;
  }
}
