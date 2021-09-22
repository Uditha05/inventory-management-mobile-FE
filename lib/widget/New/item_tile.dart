// import 'package:flutter/material.dart';
// import 'package:inventory_management/screen/student/tile_style.dart';
// import 'package:inventory_management/model/item.dart';

// class ItemTile extends StatelessWidget {
//   final String month;
//   final String date;
//   final Item itemDetail;

//   ItemTile({this.month,this.date,this.itemDetail});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(10),
//       padding: EdgeInsets.all(5),
//       decoration: BoxDecoration(
//         color: Color(0xff4CAB8B),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 month,
//                 style: dateStyle,
//               ),
//               Text(
//                 date,
//                 style: dateStyle,
//               )
//             ],
//           ),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.only(left: 50,right: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     itemDetail.category,
//                     style: dataCategoryStyle,
//                   ),
//                   Text(
//                     itemDetail.model,
//                     style: dataDetailStyle,
//                   ),
//                   Text(
//                     itemDetail.storeCode,
//                     style: dataDetailStyle,
//                   ),
//                   Text(
//                     itemDetail.labName,
//                     style: dataDetailStyle,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             width: 100,
//             height: 100,
//             child: Image(
//               image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTCKA6akZjVZfHmZaluLOTZzE-3_j_-MBScw&usqp=CAU'),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
