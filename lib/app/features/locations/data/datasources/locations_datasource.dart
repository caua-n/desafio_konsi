abstract class LocationsDatasource {
  Future<List<Map<String, dynamic>>> fetchSavedLocations();
  Future<void> addLocation(Map<String, dynamic> location);
  Future<Map<String, dynamic>> searchCEP(String cep);
}
