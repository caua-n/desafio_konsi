import 'package:desafio_konsi/app/features/locations/data/datasource/datasource.dart';
import 'package:uno/uno.dart';

const _bodyJsonUrl =
    'https://raw.githubusercontent.com/Flutterando/flutterando_link/refs/heads/main/assets/body.json';

class RemoteBodyDatasource implements BodyDatasource {
  final Uno uno;

  RemoteBodyDatasource(this.uno);

  @override
  Future<Map<String, dynamic>> getJsonBody() async {
    final response = await uno.get(
      _bodyJsonUrl,
      responseType: ResponseType.json,
    );

    return response.data;
  }
}
