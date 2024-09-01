import 'package:drdrakify/domain/entities/auth/user.dart';

class UserModel {
  String? fullname;
  String? email;
  String? imageURl;

  UserModel({this.fullname, this.email, this.imageURl});

  UserModel.fromJson(Map<String, dynamic> data) {
    fullname = data['name'];
    email = data['email'];
    imageURl = data['imageURl'] ?? ''; // Handle missing fields
  }
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(email: email, fullname: fullname, imageURL: imageURl);
  }
}
