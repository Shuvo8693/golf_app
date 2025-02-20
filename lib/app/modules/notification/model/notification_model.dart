class NotificationModel {
  int? code;
  String? message;
  NotificationData? data;

  NotificationModel({this.code, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? NotificationData.fromJson(json['data']) : null;
  }
}

class NotificationData {
  List<NotificationAttributes>? attributes;

  NotificationData({this.attributes});

  NotificationData.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      attributes = <NotificationAttributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(NotificationAttributes.fromJson(v));
      });
    }
  }

}

class NotificationAttributes {
  String? sId;
  String? sender;
  String? receiver;
  String? tournamentId;
  dynamic paymentId;
  String? title;
  String? body;
  String? linkId;
  String? type;
  bool? isRead;
  DateTime? createdAt;
  String? updatedAt;
  int? iV;

  NotificationAttributes(
      {this.sId,
        this.sender,
        this.receiver,
        this.tournamentId,
        this.paymentId,
        this.title,
        this.body,
        this.linkId,
        this.type,
        this.isRead,
        this.createdAt,
        this.updatedAt,
        this.iV});

  NotificationAttributes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sender = json['sender'];
    receiver = json['receiver'];
    tournamentId = json['tournamentId'];
    paymentId = json['paymentId'];
    title = json['title'];
    body = json['body'];
    linkId = json['linkId'];
    type = json['type'];
    isRead = json['isRead'];
    createdAt = DateTime.tryParse (json['createdAt'] as String);
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
