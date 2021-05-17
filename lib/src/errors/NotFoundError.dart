part of flutter_web_bluetooth;

class NotFoundError extends Error {
  final String searchUUID;
  final String? fromUUID;
  final String searchType;

  NotFoundError.forService(this.searchUUID, this.fromUUID)
      : searchType = 'Service';

  NotFoundError.forCharacteristic(this.searchUUID, this.fromUUID)
      : searchType = 'Characteristic';

  @override
  String toString() {
    final startMessage = "No $searchType matching UUID $searchUUID found";
    if (fromUUID == null) {
      return startMessage;
    }
    return "$startMessage in Service with UUID $fromUUID.";
  }
}
