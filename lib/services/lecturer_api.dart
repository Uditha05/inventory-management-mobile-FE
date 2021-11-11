import '../model/request_list.dart';
import './network_helper.dart';
import '../model/availability_detail_list.dart';
import '../model/pending_detail.dart';
import 'package:http/http.dart' as http;

class LecturerApi {
  http.Client client = new http.Client();
  Future<dynamic> getItems() async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://sep-uom-inventory.herokuapp.com/student/checkAvaiabilitymobile',
        client);
    //NetworkHelper networkHelper = NetworkHelper('https://sep-backend-inventory.herokuapp.com/checkAvaiability');
    var data = await networkHelper.getData();
    var lst = [];
    //print(data);
    for (var m in data) {
      var newObj;
      if (m['availability'] == 1) {
        newObj = {
          'availability': true,
          'Item': {
            'category': m['Category.categoryName'],
            'model': m['Model.modelName'],
            'storeCode': m['id'],
            'labName': m['Lab.labName'],
            'imageURL': m['imageURL'],
          },
          'availableDate': m['returnDate']
        };
      } else {
        print(m['status']);
        if (m['status'] == 'damage') {
          newObj = {
            'availability': false,
            'Item': {
              'category': m['Category.categoryName'],
              'model': m['Model.modelName'],
              'storeCode': m['id'],
              'labName': m['Lab.labName'],
              'imageURL': m['imageURL'],
            },
            'availableDate': 'Not Available',
          };
        } else {
          newObj = {
            'availability': false,
            'Item': {
              'category': m['Category.categoryName'],
              'model': m['Model.modelName'],
              'storeCode': m['id'],
              'labName': m['Lab.labName'],
              'imageURL': m['imageURL'],
            },
            'availableDate': m['returnDate']
          };
        }
      }
      lst.add(newObj);
    }
    print(lst);
    return AvailabilityDetailList.fromJson(lst);
  }

  Future<dynamic> getPendingRequest(id) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://sep-uom-inventory.herokuapp.com/lecturer/pending/${id}',
        client);
    var data = await networkHelper.getData();
    var lst = [];
    for (var m in data) {
      var newObj;
      newObj = {
        "id": m['id'],
        "storeCode": m['equipmentId'],
        "requestDate": m['requestDate'],
        "studentId": m['RequestBorrowings.studentId'],
      };
      lst.add(newObj);
    }
    print(lst);
    return RequestsList.fromJson(lst);
  }

  Future<dynamic> getPendingItemDetail(String id) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://sep-uom-inventory.herokuapp.com/lecturer/requestDetail/${id}',
        client);
    var data = await networkHelper.getData();
    var newObj = {
      'studentId': data[0]['Requests.RequestBorrowings.studentId'],
      'Item': {
        'category': data[0]['Category.categoryName'],
        'model': data[0]['Model.modelName'],
        'storeCode': data[0]['id'],
        'labName': data[0]['Lab.labName'],
      },
      'fromDate': data[0]['Requests.requestDate'],
      'dueDate': data[0]['Requests.returnDate'],
    };
    return PendingDetail.fromJson(newObj);
  }

  Future approveRequest(String id, Object obj) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://sep-uom-inventory.herokuapp.com/lecturer/approve/${id}',
        client);
    var data = await networkHelper.sendDate(obj);
    print('send approve request');
    return data;
  }

  Future rejectRequest(String id, Object obj) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://sep-uom-inventory.herokuapp.com/lecturer/reject/${id}',
        client);
    var data = await networkHelper.sendDate(obj);
    print('send reject request');
    return data;
  }

  Future getCategory() async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://sep-uom-inventory.herokuapp.com/student/category', client);
    //NetworkHelper networkHelper = NetworkHelper('https://sep-backend-inventory.herokuapp.com/category');
    var data = await networkHelper.getData();
    var lst = [];
    for (var m in data) {
      lst.add(m['Category.categoryName']);
    }
    return lst;
  }

  Future getModel(String category) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://sep-uom-inventory.herokuapp.com/student/model/${category}',
        client);
    //NetworkHelper networkHelper = NetworkHelper('https://sep-backend-inventory.herokuapp.com/model/${category}');
    var data = await networkHelper.getData();
    var lst = [];
    for (var m in data) {
      lst.add(m['Model.modelName']);
    }
    return lst;
    //print(data);
  }

  Future getLab(String model, String category) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://sep-uom-inventory.herokuapp.com/student/lab/${category}/${model}',
        client);
    //NetworkHelper networkHelper = NetworkHelper('https://sep-backend-inventory.herokuapp.com/lab/${category}/${model}');
    var data = await networkHelper.getData();
    //print(data);
    var lst = [];
    for (var m in data) {
      lst.add(m['Lab.labName']);
    }
    return lst;
  }

  Future getStoreCode(String category, String model, String lab) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://sep-uom-inventory.herokuapp.com/student/storeCode/${category}/${model}/${lab}',
        client);
    //NetworkHelper networkHelper = NetworkHelper('https://sep-backend-inventory.herokuapp.com/storeCode/${category}/${model}/${lab}');
    var data = await networkHelper.getData();
    //print(data);
    var lst = [];
    for (var m in data) {
      lst.add(m['id']);
    }
    return lst;
  }

  // Future getStoreCode(String category,String model, String lab)async{
  //   NetworkHelper networkHelper = NetworkHelper('http://10.0.2.2:5000/student/storeCode/${category}/${model}/${lab}}');
  //   //NetworkHelper networkHelper = NetworkHelper('https://sep-backend-inventory.herokuapp.com/storeCode/${category}/${model}/${lab}');
  //   var data = await networkHelper.getData();
  //   print('stiuerea');
  //   print(data);
  //   var lst=[];
  //   for(var m in data){
  //     lst.add(m['id']);
  //   }
  //   return lst;
  // }

  Future getLecturers(String lab) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://sep-uom-inventory.herokuapp.com/student/lecturer/${lab}',
        client);
    //NetworkHelper networkHelper = NetworkHelper('https://sep-backend-inventory.herokuapp.com/lecturer/${lab}');
    var data = await networkHelper.getData();
    var lst = [[], []];
    for (var m in data) {
      //print(m['id']);
      var lec = m['firstName'];
      var id = m['id'];
      lst[0].add(lec);
      lst[1].add(id);
    }
    return lst;
  }

  Future sendNormalRequest(Object detail) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://sep-uom-inventory.herokuapp.com/student/sendNormalRequest',
        client);
    var data = await networkHelper.sendDate(detail);
    print('send normal request');
    return data;
  }

  Future sendTemporyRequest(Object detail) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://sep-uom-inventory.herokuapp.com/student/sendTemporyRequest',
        client);
    var data = await networkHelper.sendDate(detail);
    print('send normal request');
    return data;
  }

  Future sendLecturerRequest(Object detail) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://sep-uom-inventory.herokuapp.com/lecturer/sendTemporyRequest',
        client);
    var data = await networkHelper.sendDate(detail);
    print('send normal request');
    return data;
  }
}
