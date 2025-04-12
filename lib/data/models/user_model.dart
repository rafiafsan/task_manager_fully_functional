class UserModel {
  late final String id;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String mobile;
  late final String createdDate;
  late final String photo;

  //named constructor
  UserModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['_id'] ?? '';
    email = jsonData['email'] ?? '';
    firstName = jsonData['firstName'] ?? '';
    lastName = jsonData['lastName'] ?? '';
    mobile = jsonData['mobile'] ?? '';
    createdDate = jsonData['createdDate'] ?? '';
    photo = jsonData['photo'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return{
      '_id' : id,
      'email' : email,
      'firstName' : firstName,
      'lastName' : lastName,
      'mobile' : mobile,
      'createdDate' : createdDate,
      'photo' : photo,
    };
  }

  String get fullName{
    return '$firstName $lastName';
  }
}

//
// class UserModel {
//   final String id;
//   final String email;
//   final String firstName;
//   final String lastName;
//   final String mobile;
//   final String createdDate;
//   final String photo;
//
//   UserModel({required this.id,
//     required this.email,
//     required this.firstName,
//     required this.lastName,
//     required this.mobile,
//     required this.createdDate,
//     required this.photo
//   });
//
//
// //named constructor
//   factory UserModel.fromJson(Map<String, dynamic> jsonData){
//     return UserModel(
//         id: jsonData['_id'] ?? '',
//         email: jsonData['email'] ?? '',
//         firstName: jsonData['firstName'] ?? '',
//         lastName: jsonData['lastName'] ?? '',
//         mobile: jsonData['mobile'] ?? '',
//         createdDate: jsonData['createdDate'] ?? '',
//         photo: jsonData['photo'] ?? ''
//     );
//   }
// }
