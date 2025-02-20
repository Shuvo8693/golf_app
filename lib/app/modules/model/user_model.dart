class UserModel {
  int? code;
  String? message;
  UserData? data;

  UserModel({this.code, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  UserAttributes? attributes;

  UserData({this.attributes});

  UserData.fromJson(Map<String, dynamic> json) {
    attributes = json['attributes'] != null
        ? UserAttributes.fromJson(json['attributes'])
        : null;
  }
}

class UserAttributes {
  User? user;
  Tokens? tokens;

  UserAttributes({this.user, this.tokens});

  UserAttributes.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    tokens =
    json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
  }
}

class User {
  MyLocation? myLocation;
  MyLocation? currentLocation;
  String? name;
  String? email;
  String? role;
  String? city;
  String? state;
  String? gender;
  String? country;
  String? handicap;
  String? clubName;
  String? clubHandicap;
  String? facebookLink;
  String? instagramLink;
  String? linkdinLink;
  String? xLink;
  bool? privacyPolicyAccepted;
  bool? isAdmin;
  bool? isVerified;
  bool? isDeleted;
  bool? isBlocked;
  bool? isSubscribe;
  bool? isAprovedAsSupperUser;
  Image? image;
  CoverImage? coverImage;
  String? createdAt;
  String? updatedAt;
  bool? isResetPassword;
  String? id;

  User(
      {this.myLocation,
        this.currentLocation,
        this.name,
        this.email,
        this.role,
        this.city,
        this.state,
        this.gender,
        this.country,
        this.handicap,
        this.clubName,
        this.clubHandicap,
        this.facebookLink,
        this.instagramLink,
        this.linkdinLink,
        this.xLink,
        this.privacyPolicyAccepted,
        this.isAdmin,
        this.isVerified,
        this.isDeleted,
        this.isBlocked,
        this.isSubscribe,
        this.isAprovedAsSupperUser,
        this.image,
        this.coverImage,
        this.createdAt,
        this.updatedAt,
        this.isResetPassword,
        this.id
      });

  User.fromJson(Map<String, dynamic> json) {
    myLocation = json['myLocation'] != null
        ? MyLocation.fromJson(json['myLocation'])
        : null;
    currentLocation = json['currentLocation'] != null
        ? MyLocation.fromJson(json['currentLocation'])
        : null;
    name = json['name'];
    email = json['email'];
    role = json['role'];
    city = json['city'];
    state = json['state'];
    gender = json['gender'];
    country = json['country'];
    handicap = json['handicap'];
    clubName = json['clubName'];
    clubHandicap = json['clubHandicap'];
    facebookLink = json['facebookLink'];
    instagramLink = json['instagramLink'];
    linkdinLink = json['linkdinLink'];
    xLink = json['xLink'];
    privacyPolicyAccepted = json['privacyPolicyAccepted'];
    isAdmin = json['isAdmin'];
    isVerified = json['isVerified'];
    isDeleted = json['isDeleted'];
    isBlocked = json['isBlocked'];
    isSubscribe = json['isSubscribe'];
    isAprovedAsSupperUser = json['isAprovedAsSupperUser'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    coverImage = json['coverImage'] != null ? CoverImage.fromJson(json['coverImage']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isResetPassword = json['isResetPassword'];
    id = json['id'];
  }
}

class MyLocation {
  String? type;
  List<int>? coordinates;

  MyLocation({this.type, this.coordinates});

  MyLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<int>();
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

class CoverImage {
  String? url;
  String? path;

  CoverImage({this.url, this.path});

  CoverImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    path = json['path'];
  }
}

class Tokens {
  Access? access;

  Tokens({this.access});

  Tokens.fromJson(Map<String, dynamic> json) {
    access =
    json['access'] != null ? Access.fromJson(json['access']) : null;
  }

}

class Access {
  String? token;
  String? expires;

  Access({this.token, this.expires});

  Access.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expires = json['expires'];
  }

}
