class ChallengeMatchModel {
  final int? code;
  final String? message;
  final ChallengeMatchData? data;

  ChallengeMatchModel({this.code, this.message, this.data});

  factory ChallengeMatchModel.fromJson(Map<String, dynamic> json) {
    return ChallengeMatchModel(
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? ChallengeMatchData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class ChallengeMatchData {
  final List<ChallengeMatchAttributes>? attributes;

  ChallengeMatchData({this.attributes});

  factory ChallengeMatchData.fromJson(Map<String, dynamic> json) {
    return ChallengeMatchData(
      attributes: json['attributes'] != null
          ? (json['attributes'] as List)
          .map((v) => ChallengeMatchAttributes.fromJson(v as Map<String, dynamic>))
          .toList()
          : null,
    );
  }
}

class ChallengeMatchAttributes {
  final String? id;
  final TournamentCreator? tournamentCreator;
  final BigTournament? bigTournament;
  final String? gagleName;
  final Player? player1;
  final Player? player2;
  final String? date;
  final String? time;
  final String? courseName;
  final String? createdAt;
  final String? updatedAt;
  final int? version;

  ChallengeMatchAttributes({
    this.id,
    this.tournamentCreator,
    this.bigTournament,
    this.gagleName,
    this.player1,
    this.player2,
    this.date,
    this.time,
    this.courseName,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory ChallengeMatchAttributes.fromJson(Map<String, dynamic> json) {
    return ChallengeMatchAttributes(
      id: json['_id'] as String?,
      tournamentCreator: json['tournamentCreator'] != null
          ? TournamentCreator.fromJson(json['tournamentCreator'] as Map<String, dynamic>)
          : null,
      bigTournament: json['bigTournament'] != null
          ? BigTournament.fromJson(json['bigTournament'] as Map<String, dynamic>)
          : null,
      gagleName: json['gagleName'] as String?,
      player1: json['playeare1'] != null
          ? Player.fromJson(json['playeare1'] as Map<String, dynamic>)
          : null,
      player2: json['playeare2'] != null
          ? Player.fromJson(json['playeare2'] as Map<String, dynamic>)
          : null,
      date: json['date'] as String?,
      time: json['time'] as String?,
      courseName: json['courseName'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      version: json['__v'] as int?,
    );
  }
}

class TournamentCreator {
  final String? name;
  final String? email;
  final String? id;

  TournamentCreator({this.name, this.email, this.id});

  factory TournamentCreator.fromJson(Map<String, dynamic> json) {
    return TournamentCreator(
      name: json['name'] as String?,
      email: json['email'] as String?,
      id: json['id'] as String?,
    );
  }
}

class BigTournament {
  final String? id;
  final String? courseName;

  BigTournament({this.id, this.courseName});

  factory BigTournament.fromJson(Map<String, dynamic> json) {
    return BigTournament(
      id: json['_id'] as String?,
      courseName: json['courseName'] as String?,
    );
  }
}

class Player {
  final String? name;
  final String? handicap;
  final String? clubHandicap;
  final Image? image;
  final String? id;

  Player({this.name, this.handicap, this.clubHandicap, this.image, this.id});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'] as String?,
      handicap: json['handicap'] as String?,
      clubHandicap: json['clubHandicap'] as String?,
      image: json['image'] != null
          ? Image.fromJson(json['image'] as Map<String, dynamic>)
          : null,
      id: json['id'] as String?,
    );
  }
}

class Image {
  final String? url;
  final String? path;

  Image({this.url, this.path});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      url: json['url'] as String?,
      path: json['path'] as String?,
    );
  }
}