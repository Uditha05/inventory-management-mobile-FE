// import 'package:flutter/material.dart';
// import 'package:inventory_management/widget/widget/drop_down_list.dart';
// import 'package:inventory_management/widget/widget/date_picker.dart';
// import 'package:intl/intl.dart';

// class NormalBorrowingRequest extends StatefulWidget {
//   @override
//   _NormalBorrowingRequestState createState() => _NormalBorrowingRequestState();
// }

// class _NormalBorrowingRequestState extends State<NormalBorrowingRequest> {
//   String selectedCategory;
//   String selectedModel;
//   String selectedStoreCode;
//   String labName;
//   String studentId;
//   String fromDate;
//   String toDate;
//   String selectedLecturer;

//   final categoryList = ['category0', 'category1', 'category2'];
//   final modelList = ['model0', 'model1', 'model2'];
//   final storeCodeList = ['storeCode0', 'storeCode1', 'storeCode2'];
//   final lecturerList = ['lecturer0','lecturer1','lecturer2'];

//   void toogleCategory(String category) {
//     setState(() {
//       selectedCategory = category;
//     });
//   }

//   void toogleModel(String model) {
//     setState(() {
//       selectedModel = model;
//     });
//   }

//   void toogleStoreCode(String storeCode) {
//     setState(() {
//       selectedStoreCode = storeCode;
//     });
//   }

//   void toogleFromDate(DateTime date){
//     setState(() {
//       fromDate= DateFormat('dd/MM/yyyy').format(date);
//     });
//   }

//   void toogleToDate(DateTime date){
//     setState(() {
//       toDate= DateFormat('dd/MM/yyyy').format(date);
//     });
//   }

//   void toogleLecturer(String lecturer){
//     setState(() {
//       selectedLecturer = lecturer;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           SizedBox(
//             height: 20,
//           ),
//           FormInput(title: 'Category',lst: categoryList,callback: toogleCategory,value: selectedCategory,),
//           FormInput(title: 'Model',lst: modelList,callback: toogleModel,value: selectedModel,),
//           FormInput(title:'StoreCode',lst: storeCodeList,callback: toogleStoreCode,value: selectedStoreCode,),
//           Padding(
//             padding: EdgeInsets.only(left: 15,right: 15,top: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Lab Name',
//                   style: TextStyle(color: Colors.white, fontSize: 20),
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(5),
//                   color: Colors.white,
//                   width: 200,
//                   child: Text(
//                     'Lab0',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: 15,right: 15,top: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Student Id',style: TextStyle(color: Colors.white,fontSize: 20)),
//                 Container(
//                   width: 200,
//                   child: TextField(
//                     decoration: InputDecoration(
//                       fillColor: Colors.white,
//                       filled: true,
//                       isDense: true,
//                       contentPadding: EdgeInsets.fromLTRB(5, 10, 10, 0),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(0)),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                     style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
//                     onChanged: (value){studentId=value;},
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             //padding: EdgeInsets.only(left: 15,right: 15,top: 10),
//             padding: EdgeInsets.only(left: 15,right: 15,top: 2),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('From Date',style: TextStyle(color: Colors.white,fontSize: 20)),
//                 Container(
//                   width: 200,
//                   child: DatePickerWidget(fromDate, toogleFromDate),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: 15,right: 15,top: 0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('To Date',style: TextStyle(color: Colors.white,fontSize: 20),),
//                 Container(
//                   width: 200,
//                   child: DatePickerWidget(toDate, toogleToDate),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: 15,right: 15,top: 5),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Lecturer',style: TextStyle(color: Colors.white,fontSize: 20),),
//                 DropDownPicker(lecturerList, toogleLecturer, selectedLecturer),
//               ],
//             ),
//           ),
//           SizedBox(height: 20,),
//           FlatButton(
//             child: Text(
//               'Submit',
//               style: TextStyle(fontSize: 20, color: Colors.white),
//             ),
//             color: Color(0xff69C0A1),
//             onPressed: (){
//               print(selectedCategory);
//               print(selectedModel);
//               print(selectedStoreCode);
//               print(studentId);
//               print(fromDate);
//               print(toDate);
//               print(selectedLecturer);
//             },
//           )
//         ],
//       ),
//     );
//   }
// }

// class FormInput extends StatelessWidget {
//   const FormInput({this.title,this.lst,this.callback,this.value});
//   final String title;
//   final List lst;
//   final Function callback;
//   final String value;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: 15, right: 15, top: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(color: Colors.white, fontSize: 20),
//           ),
//           DropDownPicker(lst, callback, value),
//         ],
//       ),
//     );
//   }
// }
