import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:inventory_management/services/borrow_data.dart';
import 'package:inventory_management/services/category.dart';
import 'package:inventory_management/services/iteam.dart';
import 'package:inventory_management/services/lab.dart';
import 'package:inventory_management/services/modal.dart';
import 'package:inventory_management/widget/chart.dart';
import 'package:inventory_management/config/constant_data.dart';

class API {
  var apiurl = "https://sep-uom-inventory.herokuapp.com";
  var headers = {
    "Authorization": 'Bearer ' + ConstantData.TOKEN,
  };
  http.Client client = new http.Client();
  getCategories(Category c) async {
    var url = Uri.parse(apiurl + '/technicalofficer/categories');

    var response = await client.get(url, headers: headers);
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
      print(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  getLabs(Lab c) async {
    var url = Uri.parse(apiurl + '/technicalofficer/labs');

    var response = await client.get(url, headers: headers);
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
      print(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  getModels(Model c) async {
    var url = Uri.parse(apiurl + '/technicalofficer/models/${c.id}');

    var response = await client.get(url, headers: headers);
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
      print(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  getRequestData(String id) async {
    var url = Uri.parse(apiurl + '/technicalofficer/requestdata/$id');

    var response = await client.get(url, headers: headers);
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
      print(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  findIteamsByCatogary(id) async {
    var url = Uri.parse(apiurl + '/technicalofficer/categories/$id');

    var response = await client.get(url, headers: headers);
    if (response.statusCode == 200) {
      List result = convert.jsonDecode(response.body);
      List<Iteam> iteams = [];
      for (int i = 0; i < result.length; i++) {
        Iteam iteam = new Iteam(
            catogary: result[i]['Category']['categoryName'],
            store_code: result[i]['id'],
            model: result[i]['Model']['modelName'],
            lab: result[i]['Lab']['labName'],
            isAvailable: result[i]['availability'] == 1,
            status: result[i]['status']);
        iteam.imgURL = result[i]['imageURL'];
        iteams.add(iteam);
      }
      return iteams;
    } else {
      return 'Request failed with status: ${response.statusCode}.';
    }
  }

  getBorrowData(id, fromDate, toDate) async {
    var url = Uri.parse(apiurl + '/technicalofficer/borrowdata/');
    var response = await client.post(url,
        body: {
          'store_code': id,
          'fromDate': '${fromDate.year}/${fromDate.month}/${fromDate.day}',
          'toDate': '${toDate.year}/${toDate.month}/${toDate.day}'
        },
        headers: headers);
    if (response.statusCode == 200) {
      List result = convert.jsonDecode(response.body);
      // result.map((e) => print(e));
      for (var item in result) {
        print(result);
        if (item['type'] == 'lecturer') {
          print(item['LecturerBorrowings']);
        }
      }
      List<BorrowData> list = result
          .map((e) => new BorrowData(
              type: e['type'],
              name: e['type'] == 'lecturer'
                  ? e['LecturerBorrowings'][0]['Lecturer']['firstName']
                  : e['type'] == 'normal'
                      ? e['RequestBorrowings'][0]['student']['firstName']
                      : e['type'] == 'temporary'
                          ? e['TemoryBorrowings'][0]['student']['firstName']
                          : '',
              status: e['status'],
              fromDate: DateTime.parse(e['fromDate']),
              toDate: DateTime.parse(e['dueDate']),
              returnDate: e['returnDate'] == null
                  ? null
                  : DateTime.parse(e['returnDate'])))
          .toList();
      print(list);
      return list;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  getLastBorrowData(id) async {
    print("hhhhhhh");
    var url = Uri.parse(apiurl + '/technicalofficer/borrowdata/$id');
    var response = await client.get(url, headers: headers);
    if (response.statusCode == 200) {
      List result = convert.jsonDecode(response.body);

      var e = result[0];

      BorrowData data = new BorrowData(
          type: e['type'],
          name: e['type'] == 'lecturer'
              ? e['LecturerBorrowings'][0]['Lecturer']['firstName']
              : e['type'] == 'normal'
                  ? e['RequestBorrowings'][0]['student']['firstName']
                  : e['type'] == 'temporary'
                      ? e['TemoryBorrowings'][0]['student']['firstName']
                      : '',
          status: e['status'],
          fromDate: DateTime.parse(e['fromDate']),
          toDate: DateTime.parse(e['dueDate']),
          id: e['id'].toString(),
          returnDate:
              e['returnDate'] == null ? null : DateTime.parse(e['returnDate']));
      print(data);

      if (e['type'] == 'temporary') {
        data.userid = e['TemoryBorrowings'][0]['student']['id'];
      } else if (e['type'] == 'normal') {
        data.userid = e['RequestBorrowings'][0]['student']['id'];
      } else if (e['type'] == 'lecturer') {
        data.userid = e['LecturerBorrowings'][0]['Lecturer']['id'];
      }
      print("result");
      return data;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  getEquipmentByStoreCode(storeid) async {
    var url = Uri.parse(apiurl + '/technicalofficer/equipment/$storeid');

    var response = await client.get(url, headers: headers);
    if (response.statusCode == 200) {
      var result = convert.jsonDecode(response.body);
      print(result);
      if (result != null) {
        Iteam iteam = new Iteam(
            catogary: result['Category']['categoryName'],
            store_code: result['id'],
            model: result['Model']['modelName'],
            lab: result['Lab']['labName'],
            isAvailable: result['availability'] == 1,
            status: result['status']);
        iteam.imgURL = result['imageURL'];
        return iteam;
      }
      return null;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  temporyIssueEquipment(userid, storeid, fromdate, todate, reason) async {
    var url = Uri.parse(apiurl + '/technicalofficer/temporyborrowing');

    var response = await client.post(url,
        body: {
          'userid': userid,
          'storeid': storeid,
          'fromdate': fromdate.toString(),
          'todate': todate.toString(),
          'reason': reason
        },
        headers: headers);
    if (response.statusCode == 201) {
      var result = convert.jsonDecode(response.body);
      print(result);
      return null;
    } else {
      return ('Request failed with status: ${response.statusCode}.');
    }
  }

  NormalIssueEquipment(userid, storeid, fromdate, todate, requestId) async {
    var url = Uri.parse(apiurl + '/technicalofficer/normalborrowing');

    var response = await client.post(url,
        body: {
          'userid': userid,
          'storeid': storeid,
          'fromdate': fromdate.toString(),
          'todate': todate.toString(),
          'requestId': requestId
        },
        headers: headers);
    if (response.statusCode == 201) {
      var result = convert.jsonDecode(response.body);
      print(result);
      return null;
    } else {
      return ('Request failed with status: ${response.statusCode}.');
    }
  }

  updateEquipment(store_code, status, imgUrl, issetimage) async {
    var url = Uri.parse(apiurl + '/technicalofficer/updateequipment/');
    var bd = {
      'store_code': store_code,
      'status': status,
      'imgPreview': imgUrl,
      'issetimage': issetimage.toString()
    };
    print(bd);
    var response = await client.post(url, body: bd, headers: headers);
    if (response.statusCode < 300) {
      return [true, 'none'];
    } else {
      return [false, 'Request failed with status: ${response.statusCode}.'];
    }
  }

  AddEquipment(category, model, lab, imgUrl) async {
    var url = Uri.parse(apiurl + '/technicalofficer/addequipment/');
    var response = await client.post(url,
        body: {
          'category': category,
          'model': model,
          'lab': lab,
          'imgPreview': imgUrl
        },
        headers: headers);
    if (response.statusCode < 300) {
      var item = convert.jsonDecode(response.body);
      return [true, 'none', convert.jsonDecode(response.body)['id']];
    } else {
      return [false, 'Request failed with status: ${response.statusCode}.'];
    }
  }

  acceptEquipment(id, status) async {
    var url = Uri.parse(apiurl + '/technicalofficer/acceptEquipment/');
    var response = await client.post(url,
        body: {'id': id, 'status': status}, headers: headers);
    if (response.statusCode < 400) {
      return false;
    } else {
      return true;
    }
  }

  getReport(fromdate, toDate, categories, reportType) async {
    print([fromdate, toDate, categories, reportType]);
    var url = Uri.parse(apiurl + '/technicalofficer/report/');
    var response = await client.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": 'Bearer ' + ConstantData.TOKEN,
      },
      body: convert.jsonEncode({
        'fromdate': fromdate.toString(),
        'toDate': toDate.toString(),
        'categories': categories,
        'reportType': reportType
      }),
    );
    if (response.statusCode < 300) {
      print(response.statusCode);
      var data = convert.jsonDecode(response.body);
      List<ChartData> report = [];
      for (int i = 0; i < data.length; i++) {
        List temp = [];
        for (int j = 0; j < data[i]['data'].length; j++) {
          temp.add([data[i]['data'][j]['cat'], data[i]['data'][j]['data']]);
        }
        report.add(new ChartData(data[i]['date'], temp));
      }
      print(report);

      return report;
    } else {
      return [false, 'Request failed with status: ${response.statusCode}.'];
    }
  }
}
