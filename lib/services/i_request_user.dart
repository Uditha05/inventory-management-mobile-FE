import 'package:inventory_management/services/iteam.dart';
import 'package:inventory_management/services/request.dart';

class IRequestUser {
  String id;
  Request request;

  IRequestUser({this.id}) {
    getRequest();
  }

  Future<Request> getRequest() async {
    Request req = new Request(
        iRequestUser: this,
        reqdate: DateTime.now(),
        status: "Approved",
        iteam: new Iteam(
            isAvailable: true,
            catogary: "Projector",
            model: "model 123456789",
            store_code: "store code",
            lab: "lab"),
        id: '123467',
        lecture: IRequestUser(id: '122nn'));
    request = req;
    return req;
  }

  static Future<IRequestUser> findStudentByID(String quary) async {
    if (quary.isNotEmpty) {
      return await IRequestUser(id: quary);
    } else {
      return null;
    }
  }
}
