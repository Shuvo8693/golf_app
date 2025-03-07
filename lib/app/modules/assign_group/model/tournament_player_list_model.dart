class TournamentPlayerListModel {
  int? code;
  String? message;
  TournamentPlayerData? data;

  TournamentPlayerListModel({this.code, this.message, this.data});

  TournamentPlayerListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? TournamentPlayerData.fromJson(json['data']) : null;
  }
}

class TournamentPlayerData {
  TournamentPlayerAttributes? attributes;

  TournamentPlayerData({this.attributes});

  TournamentPlayerData.fromJson(Map<String, dynamic> json) {
    attributes = json['attributes'] != null
        ? TournamentPlayerAttributes.fromJson(json['attributes'])
        : null;
  }
}

class TournamentPlayerAttributes {
  String? tournamentId;
  String? type;
  List<TournamentPlayersItemList>? tournamentPlayersList;

  TournamentPlayerAttributes({this.tournamentId, this.type, this.tournamentPlayersList});

  TournamentPlayerAttributes.fromJson(Map<String, dynamic> json) {
    tournamentId = json['tournamentId'];
    type = json['type'];
    if (json['tournamentPlayersList'] != null) {
      tournamentPlayersList = <TournamentPlayersItemList>[];
      json['tournamentPlayersList'].forEach((v) {
        tournamentPlayersList!.add(TournamentPlayersItemList.fromJson(v));
      });
    }
  }
}

class TournamentPlayersItemList {
  String? name;
  String? id;

  TournamentPlayersItemList({this.name, this.id});

  TournamentPlayersItemList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }
}
