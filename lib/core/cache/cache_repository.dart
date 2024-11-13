abstract class CacheRepository {
  Future<void> saveData(String key, String data);
  Future<String?> getData(String key);
}
