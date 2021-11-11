import 'package:inventory_management/model/borrow_detail_list.dart';

import '../model/request_list.dart';
import './network_helper.dart';
import '../model/availability_detail_list.dart';
import '../model/pending_detail.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class StudentApi {
  http.Client client = new http.Client();
  Future<dynamic> getItems() async {
    NetworkHelper networkHelper =
        NetworkHelper('https://sep-uom-inventory.herokuapp.com/student/checkAvaiabilitymobile',client);
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
      lst.add(newObj);
    }
    return AvailabilityDetailList.fromJson(lst);
  }

  Future getCategory() async {
    NetworkHelper networkHelper =
        NetworkHelper('https://sep-uom-inventory.herokuapp.com/student/category',client);
    //NetworkHelper networkHelper = NetworkHelper('https://sep-backend-inventory.herokuapp.com/category');
    var data = await networkHelper.getData();
    var lst = [];
    for (var m in data) {
      lst.add(m['Category.categoryName']);
    }
    return lst;
  }

  Future getModel(String category) async {
    NetworkHelper networkHelper =
        NetworkHelper('https://sep-uom-inventory.herokuapp.com/student/model/${category}',client);
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
    NetworkHelper networkHelper =
        NetworkHelper('https://sep-uom-inventory.herokuapp.com/student/lab/${category}/${model}',client);
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
        'https://sep-uom-inventory.herokuapp.com/student/storeCode/${category}/${model}/${lab}',client);
    //NetworkHelper networkHelper = NetworkHelper('https://sep-backend-inventory.herokuapp.com/storeCode/${category}/${model}/${lab}');
    var data = await networkHelper.getData();
    //print(data);
    var lst = [];
    for (var m in data) {
      lst.add(m['id']);
    }
    return lst;
  }

  Future getBorrowingHistory(String id) async {
    NetworkHelper networkHelper =
        NetworkHelper('https://sep-uom-inventory.herokuapp.com/student/borrowmobile/${id}',client);
    print('here runn');
    //NetworkHelper networkHelper = NetworkHelper('https://sep-backend-inventory.herokuapp.com/borrow');
    var data = await networkHelper.getData();
    var lst = [];
    const months = [
      'JAN',
      'FEB',
      'March',
      'April',
      'May',
      'June',
      'July',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    for (var m in data) {
      var pmonth = int.parse(
              DateFormat('MM').format(DateTime.parse(m['purchesedDate']))) -
          1;
      var pdate = DateTime.parse(m['purchesedDate']);
      print(pdate);
      var newObj = {
        'month': months[pmonth],
        'date': pdate.day.toString(),
        'Item': {
          'category': m['Category.categoryName'],
          'model': m['Model.modelName'],
          'storeCode': m['id'],
          'labName': m['Lab.labName'],
          'imageURL': m['imageURL'],
        },
      };
      lst.add(newObj);
    }
    print(lst.length);
    return BorrowDetailList.fromJson(lst);
  }

  Future sendNormalRequest(Object detail) async {
    NetworkHelper networkHelper =
        NetworkHelper('https://sep-uom-inventory.herokuapp.com/student/borrow/sendNormalRequest',client);
    var data = await networkHelper.sendDate(detail);
    print('send normal request');
    return data;
  }
}
