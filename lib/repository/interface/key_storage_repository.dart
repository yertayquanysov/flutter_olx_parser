abstract class KeyStorageRepository {
  Future<String> getActivationKey();

  void setActivationKey(String newKey);
}