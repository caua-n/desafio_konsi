abstract class LocationsDatasource {
  /// Busca as localizações (remotamente ou localmente)
  Future<List<Map<String, dynamic>>> fetchLocations();

  /// Salva as localizações (aplicável ao datasource local)
  Future<void> saveLocations(List<Map<String, dynamic>> locations);
}
