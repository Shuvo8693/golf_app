class CompleteTournamentModel {
  int? code;
  String? message;
  CompleteTournamentData? data;

  CompleteTournamentModel({this.code, this.message, this.data});

  CompleteTournamentModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? CompleteTournamentData.fromJson(json['data']) : null;
  }
}

class CompleteTournamentData {
  List<CompleteTournamentAttributes>? attributes;

  CompleteTournamentData({this.attributes});

  CompleteTournamentData.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      attributes = <CompleteTournamentAttributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new CompleteTournamentAttributes.fromJson(v));
      });
    }
  }
}

class CompleteTournamentAttributes {
  String? sId;
  String? clubName;
  String? tournamentType;
  String? typeName;
  String? date;
  String? time;
  String? courseName;
  String? tournamentName;

  CompleteTournamentAttributes(
      {this.sId,
        this.clubName,
        this.tournamentType,
        this.typeName,
        this.date,
        this.time,
        this.courseName,
        this.tournamentName});

  CompleteTournamentAttributes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    clubName = json['clubName'];
    tournamentType = json['tournamentType'];
    typeName = json['typeName'];
    date = json['date'];
    time = json['time'];
    courseName = json['courseName'];
    tournamentName = json['tournamentName'];
  }
}
