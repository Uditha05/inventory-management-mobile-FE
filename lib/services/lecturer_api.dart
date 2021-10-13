import '../model/request_list.dart';
import './network_helper.dart';
import '../model/availability_detail_list.dart';
import '../model/pending_detail.dart';


class LecturerApi{
  Future<dynamic> getItems() async{
    NetworkHelper networkHelper = NetworkHelper('http://10.0.2.2:5000/checkAvaiability');
    var data = await networkHelper.getData();
    var lst =[];
    for(var m in data){
      var newObj;
      if(m['availability'] == '1'){
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

  Future<dynamic> getPendingRequest() async{
    NetworkHelper networkHelper = NetworkHelper('http://10.0.2.2:5000/pending');
    var data = await networkHelper.getData();
    var lst=[];
    for(var m in data){
      var newObj;
      newObj = {
        "id" : m['id'],
        "storeCode": m['equipmentId'],
        "requestDate": m['requestDate'],
        "studentId": m['RequestBorrowing.studentId'],
      };
      lst.add(newObj);
    }
    return RequestsList.fromJson(lst);
  }
  Future<dynamic> getPendingItemDetail(String id) async{
    NetworkHelper networkHelper = NetworkHelper('http://10.0.2.2:5000/requestDetail/${id}');
    var data = await networkHelper.getData();
    var newObj = {
      'studentId': data[0]['Requests.RequestBorrowing.studentId'],
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

  Future approveRequest(String id,Object obj)async{
    NetworkHelper networkHelper = NetworkHelper('http://10.0.2.2:5000/approve/${id}');
    var data = await networkHelper.sendDate(obj);
    print('send approve request');
    return data;
  }

  Future rejectRequest(String id,Object obj)async{
    NetworkHelper networkHelper = NetworkHelper('http://10.0.2.2:5000/reject/${id}');
    var data = await networkHelper.sendDate(obj);
    print('send reject request');
    return data;
  }

  Future getCategory()async{
    NetworkHelper networkHelper = NetworkHelper('http://10.0.2.2:5000/category');
    var data = await networkHelper.getData();
    var lst=[];
    for(var m in data){
      lst.add(m['Category.categoryName']);
    }
    return lst;
  }

  Future getModel(String category)async{
    NetworkHelper networkHelper = NetworkHelper('http://10.0.2.2:5000/model/${category}');
    var data = await networkHelper.getData();
    var lst=[];
    for(var m in data){
      lst.add(m['Model.modelName']);
    }
    return lst;
    //print(data);
  }
  
  Future getLab(String model,String category)async{
    NetworkHelper networkHelper = NetworkHelper('http://10.0.2.2:5000/lab/${category}/${model}');
    var data = await networkHelper.getData();
    //print(data);
    var lst=[];
    for(var m in data){
      lst.add(m['Lab.labName']);
    }
    return lst;
  }

  Future getStoreCode(String category,String model, String lab)async{
    NetworkHelper networkHelper = NetworkHelper('http://10.0.2.2:5000/storeCode/${category}/${model}/${lab}');
    var data = await networkHelper.getData();
    //print(data);
    var lst=[];
    for(var m in data){
      lst.add(m['id']);
    }
    return lst;
  }

  Future getLecturers(String lab)async{
    NetworkHelper networkHelper = NetworkHelper('http://10.0.2.2:5000/lecturer/${lab}');
    var data = await networkHelper.getData();
    //print(data);
    var lst=[];
    for(var m in data){
      lst.add(m['firstName']);
    }
    return lst;
  }
}