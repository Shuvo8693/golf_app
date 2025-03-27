class SubscriptionModel {
  int? code;
  String? message;
  SubscriptionData? data;

  SubscriptionModel({this.code, this.message, this.data});

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? SubscriptionData.fromJson(json['data']) : null;
  }
}

class SubscriptionData {
  List<SubscriptionAttributes>? attributes;

  SubscriptionData({this.attributes});

  SubscriptionData.fromJson(Map<String, dynamic> json) {
    if (json['attributes'] != null) {
      attributes = <SubscriptionAttributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(SubscriptionAttributes.fromJson(v));
      });
    }
  }

}

class SubscriptionAttributes {
  String? sId;
  String? subscribeType;
  int? price;
  List<String>? features;
  String? typeOfSubscription;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SubscriptionAttributes(
      {this.sId,
        this.subscribeType,
        this.price,
        this.features,
        this.typeOfSubscription,
        this.createdAt,
        this.updatedAt,
        this.iV});

  SubscriptionAttributes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    subscribeType = json['subscribeType'];
    price = json['price'];
    features = json['features'] != null? List.from(json['features']) : [];
    typeOfSubscription = json['typeOfSubscription'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
