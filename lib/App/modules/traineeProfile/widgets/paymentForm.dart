// import 'package:flutter/material.dart';

// import '../controller.dart';

// class PaymentForm extends StatelessWidget {
//   const PaymentForm({
//     super.key,
//     required this.controller,

//   });

//   final TraineeProfileController controller;


//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment:
//           CrossAxisAlignment.start,
//       children: [
//         Text(
//             'Current Balance: ${controller.balance.value}'),
//         SizedBox(height: 16.0),
//         TextField(
//           controller: controller
//               .balanceController,
//           keyboardType:
//               TextInputType.number,
//           decoration: InputDecoration(
//             labelText: 'Amount to Add',
//           ),
//         ),
//         SizedBox(height: 16.0),
//         ElevatedButton(
//           onPressed: () {
//             controller.increaseBalance(
//                 controller.uId.value);
//           },
//           child: Text('Increase Balance'),
//         ),
//       ],
//     );
//   }
// }
