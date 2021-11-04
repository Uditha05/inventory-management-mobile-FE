import 'package:inventory_management/services/iteam.dart';
import 'package:inventory_management/services/request.dart';
import 'package:inventory_management/api/technical_officer/technical_officer.dart'
    as api;

class IRequestUser {
  String id;
  Request request;

  IRequestUser({this.id}) {
    // getRequest(id);
  }

  Future<Request> getRequest(id) async {
    var result = await api.getRequestData(id);
    print(result);
    if (result == null) return null;
    if (result is String) return null;

    if (result['Equipment'] != null) {
      var equ = result['Equipment'];
      Iteam iteam = new Iteam(
          catogary: equ['Category']['categoryName'],
          store_code: equ['id'],
          model: equ['Model']['modelName'],
          lab: equ['Lab']['labName'],
          isAvailable: equ['availability'] == 1,
          status: equ['status']);
      iteam.imgURL = equ['imageURL'];

      Request req = new Request(
          iRequestUser: this,
          reqdate: result['requestDate'],
          status: result['status'],
          iteam: iteam,
          id: result['id']);
      request = req;
      return req;
    }
    return null;
  }

  static Future<IRequestUser> findStudentByID(String quary) async {
    if (quary.isNotEmpty) {
      IRequestUser user = new IRequestUser(id: quary);
      await user.getRequest(user.id);
      return user;
    } else {
      return null;
    }
  }
}