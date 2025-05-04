// import 'package:flutter/material.dart';

// class Test extends StatelessWidget {
//   const Test({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: getData(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) print(snapshot.error);

//           return snapshot.hasData
//               ? ListView.builder(
//                 itemCount: snapshot.data.length,
//                 itemBuilder: (context, index) {
//                   List list = snapshot.data;
//                   return ListTile(title: Text(list[index]['fullname']));
//                 },
//               )
//               : Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
// }
