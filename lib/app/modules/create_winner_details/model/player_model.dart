class PlayerModel {
  int? code;
  String? message;
  PlayerData? data;

  PlayerModel({this.code, this.message, this.data});

  PlayerModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new PlayerData.fromJson(json['data']) : null;
  }
}

class PlayerData {
  List<PlayerAttributes>? attributes;

  PlayerData({this.attributes});

  PlayerData.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      attributes = <PlayerAttributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new PlayerAttributes.fromJson(v));
      });
    }
  }
}

class PlayerAttributes {
  String? name;
  String? id;

  PlayerAttributes({this.name, this.id});

  PlayerAttributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }
}
