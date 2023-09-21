// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SecurityScreen(),
//     );
//   }
// }
//
// class SecurityScreen extends StatefulWidget {
//   @override
//   _SecurityScreenState createState() => _SecurityScreenState();
// }
//
// class _SecurityScreenState extends State<SecurityScreen> {
//   String pin = ''; // To store the entered PIN
//   int selectedIndex = -1; // To store the index of the selected button
//
//   void addToPin(String digit, int index) {
//     setState(() {
//       if (pin.length < 4) {
//         pin += digit;
//         selectedIndex = index;
//       }
//     });
//   }
//
//   void removeLastDigit() {
//     setState(() {
//       if (pin.isNotEmpty) {
//         pin = pin.substring(0, pin.length - 1);
//         selectedIndex = -1;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Security Screen'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Enter PIN:',
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 for (int i = 1; i <= 9; i++)
//                   SecurityButton(
//                     digit: '$i',
//                     onPressed: () => addToPin('$i', i),
//                     isSelected: i == selectedIndex,
//                   ),
//                 SecurityButton(
//                   digit: '0',
//                   onPressed: () => addToPin('0', 0),
//                   isSelected: 0 == selectedIndex,
//                 ),
//                 SecurityButton(
//                   digit: '⌫', // Backspace character
//                   onPressed: () => removeLastDigit(),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Text(
//               pin,
//               style: TextStyle(fontSize: 36),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class lock extends StatefulWidget {
//   const lock({super.key});
//
//   @override
//   State<lock> createState() => _lockState();
// }
//
// class _lockState extends State<lock> {
//   String pin = ''; // To store the entered PIN
//   int selectedIndex = -1; // To store the index of the selected button
//
//   void addToPin(String digit, int index) {
//     setState(() {
//       if (pin.length < 4) {
//         pin += digit;
//         selectedIndex = index;
//       }
//     });
//   }
//
//   void removeLastDigit() {
//     setState(() {
//       if (pin.isNotEmpty) {
//         pin = pin.substring(0, pin.length - 1);
//         selectedIndex = -1;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Security Screen'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Enter PIN:',
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 for (int i = 1; i <= 9; i++)
//                   SecurityButton(
//                     digit: '$i',
//                     onPressed: () => addToPin('$i', i),
//                     isSelected: i == selectedIndex,
//                   ),
//                 SecurityButton(
//                   digit: '0',
//                   onPressed: () => addToPin('0', 0),
//                   isSelected: 0 == selectedIndex,
//                 ),
//                 SecurityButton(
//                   digit: '⌫', // Backspace character
//                   onPressed: () => removeLastDigit(),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Text(
//               pin,
//               style: TextStyle(fontSize: 36),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// class SecurityButton extends StatelessWidget {
//   final String digit;
//   final VoidCallback onPressed;
//   final bool isSelected;
//
//   SecurityButton({
//     required this.digit,
//     required this.onPressed,
//     this.isSelected = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         child: Text(
//           digit,
//           style: TextStyle(
//             fontSize: 24,
//             color: isSelected ? Colors.white : Colors.black,
//           ),
//         ),
//         style: ElevatedButton.styleFrom(
//           primary: isSelected ? Colors.blue : Colors.grey,
//           onPrimary: Colors.white,
//           padding: EdgeInsets.all(20),
//           shape: CircleBorder(),
//         ),
//       ),
//     );
//   }
// }
