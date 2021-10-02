import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:inventory_management/services/borrow_data.dart';
import 'package:inventory_management/services/category.dart';
import 'package:inventory_management/services/iteam.dart';
import 'package:inventory_management/services/lab.dart';
import 'package:inventory_management/services/modal.dart';
import 'package:inventory_management/widget/chart.dart';

getCategories(Category c) async {
  var url = Uri.http(
      '10.0.2.2:5000', '/technicalofficer/categories', {'q': '{http}'});

  var response = await http.get(url);
  if (response.statusCode == 200) {
    return convert.jsonDecode(response.body);
    print(response.body);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

getLabs(Lab c) async {
  var url =
      Uri.http('10.0.2.2:5000', '/technicalofficer/labs', {'q': '{http}'});

  var response = await http.get(url);
  if (response.statusCode == 200) {
    return convert.jsonDecode(response.body);
    print(response.body);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

getModels(Model c) async {
  var url = Uri.http(
      '10.0.2.2:5000', '/technicalofficer/models/${c.id}', {'q': '{http}'});

  var response = await http.get(url);
  if (response.statusCode == 200) {
    return convert.jsonDecode(response.body);
    print(response.body);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

findIteamsByCatogary(id) async {
  var url = Uri.http(
      '10.0.2.2:5000', '/technicalofficer/categories/$id', {'q': '{http}'});

  var response = await http.get(url);
  if (response.statusCode == 200) {
    List result = convert.jsonDecode(response.body);
    List<Iteam> iteams = [];
    for (int i = 0; i < result.length; i++) {
      Iteam iteam = new Iteam(
          catogary: result[i]['Category']['categoryName'],
          store_code: result[i]['id'],
          model: result[i]['model']['modelName'],
          lab: result[i]['Laboratory']['labName'],
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
  var url = Uri.http(
      '10.0.2.2:5000', '/technicalofficer/borrowdata/', {'q': '{http}'});
  var response = await http.post(url, body: {
    'store_code': id,
    'fromDate': '${fromDate.year}/${fromDate.month}/${fromDate.day}',
    'toDate': '${toDate.year}/${toDate.month}/${toDate.day}'
  });
  if (response.statusCode == 200) {
    List result = convert.jsonDecode(response.body);
    print(response.body);
    List<BorrowData> list = result
        .map((e) => new BorrowData(
            type: e['type'],
            name: e['type'] == 'lecture'
                ? e['LecturerBorrowings'][0]['lecturer']['firstName']
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

getEquipmentByStoreCode(storeid) async {
  var url = Uri.http(
      '10.0.2.2:5000', '/technicalofficer/equipment/$storeid', {'q': '{http}'});

  var response = await http.get(url);
  if (response.statusCode == 200) {
    var result = convert.jsonDecode(response.body);
    print(result);
    if (result != null) {
      Iteam iteam = new Iteam(
          catogary: result['Category']['categoryName'],
          store_code: result['id'],
          model: result['model']['modelName'],
          lab: result['Laboratory']['labName'],
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
  var url = Uri.http(
      '10.0.2.2:5000', '/technicalofficer/temporyborrowing', {'q': '{http}'});

  var response = await http.post(url, body: {
    'userid': userid,
    'storeid': storeid,
    'fromdate': fromdate.toString(),
    'todate': todate.toString(),
    'reason': reason
  });
  if (response.statusCode == 201) {
    var result = convert.jsonDecode(response.body);
    print(result);
    return null;
  } else {
    return ('Request failed with status: ${response.statusCode}.');
  }
}

updateEquipment(store_code, status) async {
  var url = Uri.http(
      '10.0.2.2:5000', '/technicalofficer/updateequipment/', {'q': '{http}'});
  var response =
      await http.post(url, body: {'store_code': store_code, 'status': status});
  if (response.statusCode < 300) {
    return [true, 'none'];
  } else {
    return [false, 'Request failed with status: ${response.statusCode}.'];
  }
}

AddEquipment(category, model, lab) async {
  var url = Uri.http(
      '10.0.2.2:5000', '/technicalofficer/addequipment/', {'q': '{http}'});
  var response = await http
      .post(url, body: {'category': category, 'model': model, 'lab': lab});
  if (response.statusCode < 300) {
    var item = convert.jsonDecode(response.body);
    return [true, 'none', convert.jsonDecode(response.body)['id']];
  } else {
    return [false, 'Request failed with status: ${response.statusCode}.'];
  }
}

getReport(fromdate, toDate, categories, reportType) async {
  print(reportType);
  var url =
      Uri.http('10.0.2.2:5000', '/technicalofficer/report/', {'q': '{http}'});
  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: convert.jsonEncode({
      'fromdate': fromdate.toString(),
      'toDate': toDate.toString(),
      'categories': categories,
      'reportType': reportType
    }),
  );
  if (response.statusCode < 300) {
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
