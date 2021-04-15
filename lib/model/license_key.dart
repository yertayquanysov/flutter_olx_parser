class LicenseKey {

  final String deviceId;
  late DateTime activationDate;

  LicenseKey({
    required this.deviceId,
  });

  static LicenseKey fromJson(Map<String, dynamic> data) {
    return LicenseKey(
      deviceId: data["deviceId"] ?? "",
    );
  }

  Map<String, Object> toDocument() {
    return {
      "deviceId": deviceId,
      "activationDate": activationDate,
    };
  }
}
