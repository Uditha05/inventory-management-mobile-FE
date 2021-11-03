import 'package:inventory_management/model/borrow_detail_list.dart';

import '../model/request_list.dart';
import './network_helper.dart';
import '../model/availability_detail_list.dart';
import '../model/pending_detail.dart';
import 'package:intl/intl.dart';

class StudentApi{
  Future<dynamic> getItems() async{
    NetworkHelper networkHelper = NetworkHelper('http://10.0.2.2:5000/student/checkAvaiability');
    //NetworkHelper networkHelper = NetworkHelper('https://sep-backend-inventory.herokuapp.com/checkAvaiability');
    var data = await networkHelper.getData();
    var lst =[];
    //print(data);
    for(var m in data){
      var newObj;
      if(m['availability'] == 1){
        newObj = {
          'availability': true,
          'Item': {
            'category': m['Category.categoryName'],
            'model': m['Model.modelName'],
            'storeCode': m['id'],
            'labName': m['Lab.labName']
          },
          'availableDate': m['returnDate']
        };
      }else{
        newObj = {
          'availability': false,
          'Item': {
            'category': m['Category.categoryName'],
            'model': m['Model.modelName'],
            'storeCode': m['id'],
            'labName': m['Lab.labName']
          },
          'availableDate': m['returnDate']
        };
      }
      lst.add(newObj);
    }
    return AvailabilityDetailList.fromJson(lst);
  }

  Future getCategory()async{
    NetworkHelper networkHelper = NetworkHelper('http://10.0.2.2:5000/student/category');
    //NetworkHelper networkHelper = NetworkHelper('https://sep-backend-inventory.herokuapp.com/category');
    var data = await networkHelper.getData();
    var lst=[];
    for(var m in data){
      lst.add(m['Category.categoryName']);
    }
    return lst;
  }

  Future getModel(String category)async{
    NetworkHelper networkHelper = NetworkHelper('http://10.0.2.2:5000/student/model/${category}');
    //NetworkHelper networkHelper = NetworkHelper('https://sep-backend-inventory.herokuapp.com/model/${category}');
    var data = await networkHelper.getData();
    var lst=[];
    for(var m in data){
      lst.add(m['Model.modelName']);
    }
    return lst;
    //print(data);
  }

  Future getLab(String model,String category)async{
    NetworkHelper networkHelper = NetworkHelper('http://10.0.2.2:5000/student/lab/${category}/${model}');
    //NetworkHelper networkHelper = NetworkHelper('https://sep-backend-inventory.herokuapp.com/lab/${category}/${model}');
    var data = await networkHelper.getData();
    //print(data);
    var lst=[];
    for(var m in data){
      lst.add(m['Lab.labName']);
    }
    return lst;
  }

  Future getStoreCode(String category,String model, String lab)async{
    NetworkHelper networkHelper = NetworkHelper('http://10.0.2.2:5000/student/storeCode/${category}/${model}/${lab}}');
    //NetworkHelper networkHelper = NetworkHelper('https://sep-backend-inventory.herokuapp.com/storeCode/${category}/${model}/${lab}');
    var data = await networkHelper.getData();
    //print(data);
    var lst=[];
    for(var m in data){
      lst.add(m['id']);
    }
    return lst;
  }

  Future getBorrowingHistory()async{
    NetworkHelper networkHelper = NetworkHelper('http://10.0.2.2:5000/student/borrow');
    //NetworkHelper networkHelper = NetworkHelper('https://sep-backend-inventory.herokuapp.com/borrow');
    var data = await networkHelper.getData();
    var lst=[];
    const months = ['JAN','FEB','March','April','May','June','July','Aug','Sep','Oct','Nov','Dec'];
    for(var m in data){
      var pmonth = int.parse(DateFormat('MM').format(DateTime.parse(m['purchesedDate'])))-1;
      var pdate = DateTime.parse(m['purchesedDate']);
      print(pdate);
      var newObj={
        'month' : months[pmonth],
        'date' :  pdate.day.toString(),
        'Item' : {
          'category': m['Category.categoryName'],
          'model': m['Model.modelName'],
          'storeCode': m['id'],
          'labName': m['Lab.labName']
        },
      };
      lst.add(newObj);
    }
    return BorrowDetailList.fromJson(lst);
  }
}