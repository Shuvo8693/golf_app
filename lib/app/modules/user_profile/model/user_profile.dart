class UserProfile {
  int? code;
  String? message;
  UserProfileData? data;

  UserProfile({this.code, this.message, this.data});

  UserProfile.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? UserProfileData.fromJson(json['data']) : null;
  }
}

class UserProfileData {
  UserProfileAttributes? attributes;

  UserProfileData({this.attributes});

  UserProfileData.fromJson(Map<String, dynamic> json) {
    attributes = json['attributes'] != null
        ? UserProfileAttributes.fromJson(json['attributes'])
        : null;
  }
}

class UserProfileAttributes {
  MyLocation? myLocation;
  CurrentLocation? currentLocation;
  String? name;
  String? email;
  String? role;
  String? phone;
  String? address;
  String? dateOfBirth;
  String? city;
  String? state;
  String? gender;
  String? country;
  String? handicap;
  String? clubHandicap;
  String? clubName;
  String? facebookLink;
  String? instagramLink;
  String? linkdinLink;
  String? xLink;
  bool? privacyPolicyAccepted;
  bool? isAdmin;
  bool? isVerified;
  bool? isDeleted;
  bool? isBlocked;
  bool? isResetPassword;
  bool? isSubscribe;
  bool? isAprovedAsSupperUser;
  Image? image;
  Image? coverImage;
  String? oneTimeCode;
  String? createdAt;
  String? updatedAt;
  String? id;

  UserProfileAttributes(
      {this.myLocation,
        this.currentLocation,
        this.name,
        this.email,
        this.role,
        this.phone,
        this.address,
        this.dateOfBirth,
        this.city,
        this.state,
        this.gender,
        this.country,
        this.handicap,
        this.clubHandicap,
        this.clubName,
        this.facebookLink,
        this.instagramLink,
        this.linkdinLink,
        this.xLink,
        this.privacyPolicyAccepted,
        this.isAdmin,
        this.isVerified,
        this.isDeleted,
        this.isBlocked,
        this.isResetPassword,
        this.isSubscribe,
        this.isAprovedAsSupperUser,
        this.image,
        this.coverImage,
        this.oneTimeCode,
        this.createdAt,
        this.updatedAt,
        this.id});

  UserProfileAttributes.fromJson(Map<String, dynamic> json) {
    myLocation = json['myLocation'] != null
        ? MyLocation.fromJson(json['myLocation'])
        : null;
    currentLocation = json['currentLocation'] != null
        ? CurrentLocation.fromJson(json['currentLocation'])
        : null;
    name = json['name'];
    email = json['email'];
    role = json['role'];
    phone = json['phone'];
    address = json['address'];
    dateOfBirth = json['dateOfBirth'];
    city = json['city'];
    state = json['state'];
    gender = json['gender'];
    country = json['country'];
    handicap = json['handicap'];
    clubHandicap = json['clubHandicap'];
    clubName = json['clubName'];
    facebookLink = json['facebookLink'];
    instagramLink = json['instagramLink'];
    linkdinLink = json['linkdinLink'];
    xLink = json['xLink'];
    privacyPolicyAccepted = json['privacyPolicyAccepted'];
    isAdmin = json['isAdmin'];
    isVerified = json['isVerified'];
    isDeleted = json['isDeleted'];
    isBlocked = json['isBlocked'];
    isResetPassword = json['isResetPassword'];
    isSubscribe = json['isSubscribe'];
    isAprovedAsSupperUser = json['isAprovedAsSupperUser'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    coverImage = json['coverImage'] != null
        ? Image.fromJson(json['coverImage'])
        : null;
    oneTimeCode = json['oneTimeCode'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }
}

class MyLocation {
  List<double>? coordinates;
  String? type;

  MyLocation({this.coordinates, this.type});

  MyLocation.fromJson(Map<String, dynamic> json) {
    coordinates = json['coordinates'].cast<double>();
    type = json['type'];
  }
}

class CurrentLocation {
  String? type;
  List<int>? coordinates;

  CurrentLocation({this.type, this.coordinates});

  CurrentLocation.fromJson(Map<String, dynamic> json) {
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
