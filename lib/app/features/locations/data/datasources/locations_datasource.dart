abstract class LocationsDatasource {
  Future<List<Map<String, dynamic>>> fetchSavedLocations();
  Future<void> saveLocations(List<Map<String, dynamic>> locations);
  Future<Map<String, dynamic>> searchCEP(String cep);
}
