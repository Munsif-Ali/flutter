class Devices {
  final int iD;
  final String location;
  final String type;
  Devices({required this.iD, required this.location, required this.type});
  factory Devices.fromJson(Map<String, dynamic> json) {
    return Devices(
        iD: json['id'] as int,
        location: json['Ort'] as String,
        type: json['Typ'] as String);
  }
}
