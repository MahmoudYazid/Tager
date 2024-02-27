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
  RequestModel({

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
    required this.Type
});


}