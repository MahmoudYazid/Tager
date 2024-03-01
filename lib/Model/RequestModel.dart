class RequestModel{
  String requestOwnerEmail;
  String requestOwnerNumber;

  String date;
  String diverEmail;
  String diverNumber;
  String Type;
  String StartLat;
  String StartLong;
  String EndLat;
  String EndLong;
  String Cash;
  String TargetPlaceName;
  String StartPlaceName;
  String Km;
  String id;
  RequestModel({
    required this.id,
    required this.Cash,
    required this.date,
    required this.diverEmail,
    required this.diverNumber,
    required this.EndLat,
    required this.EndLong,
    required this.requestOwnerEmail,
    required this.requestOwnerNumber,
    required this.StartLat,
    required this.StartLong,
    required this.Type,
    required this.TargetPlaceName,
    required this.StartPlaceName,
    required this.Km,
});
  Map<String, dynamic> toMap() {
    return {
      'Cash': Cash,
      'date': date,
      'diverEmail': diverEmail,
      'diverNumber': diverNumber,
      'EndLat': EndLat,
      'EndLong': EndLong,
      'requestOwnerEmail': requestOwnerEmail,
      'requestOwnerNumber': requestOwnerNumber,
      'StartLat': StartLat,
      'StartLong': StartLong,
      'Type': Type,
      'TargetPlaceName': TargetPlaceName,
      'StartPlaceName': StartPlaceName,
      'Km': Km,
      'id': id,
    };
  }


}