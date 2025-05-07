class MessengerModel {
  int? code;
  String? message;
  MessengerData? data;

  MessengerModel({this.code, this.message, this.data});

  MessengerModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? MessengerData.fromJson(json['data']) : null;
  }
}

class MessengerData {
  List<MessageAttributes>? attributes;

  MessengerData({this.attributes});

  MessengerData.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      attributes = <MessageAttributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(MessageAttributes.fromJson(v));
      });
    }
  }
}

class MessageAttributes {
  String? sId;
  List<Participants>? participants;
  String? chatCreator;
  TournamentInfo? btournamentId;
  TournamentInfo? stournamentId;
  String? type;
  bool? isPinned;
  LastMessage? lastMessage;

  MessageAttributes({
    this.sId,
    this.participants,
    this.chatCreator,
    this.btournamentId,
    this.type,
    this.isPinned,
    this.lastMessage,
  });

  MessageAttributes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(Participants.fromJson(v));
      });
    }
    chatCreator = json['chatCreator'];
    btournamentId = json['btournamentId'] != null
        ? TournamentInfo.fromJson(json['btournamentId'])
        : null;
    stournamentId = json['stournamentId'] != null
        ? TournamentInfo.fromJson(json['stournamentId'])
        : null;
    type = json['type'];
    isPinned = json['isPinned'];
    lastMessage = json['lastMessage'] != null
        ? LastMessage.fromJson(json['lastMessage'])
        : null;
  }
}

class TournamentInfo {
  String? sId;
  String? clubName;
  String? tournamentName;
  String? tournamentCreatorId;
  TournamentImage? tournamentImage;

  TournamentInfo({
    this.sId,
    this.clubName,
    this.tournamentImage,
  });

  TournamentInfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    clubName = json['clubName'];
    tournamentName = json['tournamentName'];
    tournamentCreatorId = json['tournamentCreator'];
    tournamentImage = json['tournamentImage'] != null
        ? TournamentImage.fromJson(json['tournamentImage'])
        : null;
  }
}

class TournamentImage {
  String? url;
  String? path;

  TournamentImage({this.url, this.path});

  TournamentImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    path = json['path'];
  }
}

class Participants {
  String? name;
  Image? image;
  String? id;

  Participants({this.name, this.image, this.id});

  Participants.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    id = json['id'];
  }
}

class Image {
  String? url;
  String? path;

  Image({this.url, this.path});

  Image.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    path = json['path'];
  }
}

class LastMessage {
  String? sId;
  Sender? sender;
  String? message;
  String? media;
  DateTime? timestamp;

  LastMessage({this.sId, this.sender, this.message, this.media, this.timestamp});

  LastMessage.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    message = json['message'];
    media = json['media'];
    timestamp = DateTime.parse(json['timestamp'].toString()) ;
  }
}

class Sender {
  String? name;
  String? id;

  Sender({this.name, this.id});

  Sender.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }
}