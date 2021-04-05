class UserData {
  final String uid;
  final String displayName;
  // final String phoneNumber;
  final String creationDate;
  final String email;
  final int avatar;

  const UserData ({
    this.uid,
    // this.phoneNumber,
    this.displayName,
    this.creationDate,
    this.avatar,
    this.email
  });

  factory UserData.fromJson(Map<String, dynamic> json){
    return UserData(
      uid: json['UID'].toString(),
      displayName: json['DisplayName'].toString(),
      // phoneNumber: json['PhoneNumber'].toString(),
      creationDate: json['CreationDate'].toString(),
      email: json['email'].toString(),
      avatar: json['Avatar'] as int,
    );
  }
}