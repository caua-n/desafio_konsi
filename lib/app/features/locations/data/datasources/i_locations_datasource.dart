abstract class ILocationsDatasource {
  Future<List<Map<String, dynamic>>> getLocations();
  Future<void> addLocation(Map<String, dynamic> location);
  Future<void> deleteLocation(int locationId);
  Future<void> updateLocation(Map<String, dynamic> location);
  Future<Map<String, dynamic>> searchCEP(String cep);
}
