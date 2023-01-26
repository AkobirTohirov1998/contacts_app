import 'package:first_app/kernel/contact/table/users.dart';
import 'package:gwslib/common/util.dart';

class ContactData {
  final int userId;
  final String name;
  final String phoneNumber;
  final String photoSha;

  ContactData(this.userId, this.name, this.phoneNumber, this.photoSha);

  factory ContactData.fromData(Map<String, dynamic> data) {
    return ContactData(
      nvlTryInt(data[MdUsers.C_USER_ID]),
      data[MdUsers.C_NAME],
      data[MdUsers.C_PHONE_NUMBER],
      data[MdUsers.C_PHOTO_SHA],
    );
  }

  Map<String, dynamic> toData() {
    return {
      MdUsers.C_USER_ID: userId,
      MdUsers.C_NAME: name,
      MdUsers.C_PHONE_NUMBER: phoneNumber,
      MdUsers.C_PHOTO_SHA: photoSha,
    };
  }
}
