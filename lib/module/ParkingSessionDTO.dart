class ParkingSessionDTO {
  String sessionId;
  String startTime;
  String endTime;
 // List<String> clientIds;
  String matricule;
  String status;

  ParkingSessionDTO({
    required this.sessionId,
    required this.startTime,
    required this.endTime,
  //  required this.clientIds,
    required this.matricule,
    required this.status,
  });


}
