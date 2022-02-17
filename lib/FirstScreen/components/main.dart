// import 'package:flutter/material.dart';

// void main() {
//   runApp(App());
// }

// class App extends StatelessWidget {
//   const App({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "BNPL",
//       home: HomeScreen(),
//     );
//   }
// }

// AppBar buildAppBar() {
//   return AppBar(
//     backgroundColor: Color.fromRGBO(242, 150, 150, 1),
//     elevation: 0,
//   );
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: buildAppBar(),
//       body: Test(),
//     );
//   }
// }

// class Test extends StatelessWidget {
//   const Test({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     return Stack(children: <Widget>[
//       Positioned(
//           top: -0.3 * 2,
//           child: Container(
//             color: Colors.amber,
//           )),
//       Positioned(
//           top: height * 0.45 - 0.6 * 2,
//           child: Container(
//             color: Colors.teal,
//           )),
//       ListView(controller: _scrollController)
//     ]);
//   }
// }


// // class Body extends StatelessWidget {
// //   const Body({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     var sizeOfScreen = MediaQuery.of(context).size;
// //     return SingleChildScrollView(
// //       child: Column(
// //         children: const <Widget>[
// //           TopBar(),
// //           SizedBox(
// //             height: 300,
// //             child: Grid(),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class TopBar extends StatelessWidget {
// //   const TopBar({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     var sizeOfScreen = MediaQuery.of(context).size;
// //     return Container(
// //         width: double.infinity,
// //         height: sizeOfScreen.height * 0.2,
// //         decoration: const BoxDecoration(
// //             color: Color.fromRGBO(242, 150, 150, 1),
// //             borderRadius: BorderRadius.only(
// //                 bottomLeft: Radius.circular(50),
// //                 bottomRight: Radius.circular(50))),
// //         child: Container(
// //           alignment: Alignment.centerLeft,
// //           margin: const EdgeInsets.only(left: 20),
// //           child: Text("Hello User!",
// //               style: Theme.of(context)
// //                   .textTheme
// //                   .headline4!
// //                   .copyWith(color: Colors.black)),
// //         ));
// //   }
// // }

// // class Grid extends StatelessWidget {
// //   const Grid({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.all(3),
// //       child: GridView.count(primary: false, crossAxisCount: 4,
// //           // mainAxisSpacing: 5.0,
// //           // crossAxisSpacing: 10.0,
// //           children: <Widget>[
// //             Padding(
// //               padding: EdgeInsets.all(8),
// //               child: Container(
// //                 alignment: Alignment.center,
// //                 padding: const EdgeInsets.all(8),
// //                 child: const Text('Sound of screams but the'),
// //                 decoration: const BoxDecoration(
// //                     color: Color.fromRGBO(255, 226, 173, 1),
// //                     borderRadius: BorderRadius.all(Radius.circular(10)),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: Colors.black,
// //                         blurRadius: 7.0,
// //                         spreadRadius: 2.0,
// //                       )
// //                     ]),
// //               ),
// //             ),
// //             Padding(
// //               padding: EdgeInsets.all(8),
// //               child: Container(
// //                 alignment: Alignment.center,
// //                 padding: const EdgeInsets.all(8),
// //                 child: const Text('Sound of screams but the'),
// //                 decoration: const BoxDecoration(
// //                     color: Color.fromRGBO(255, 226, 173, 1),
// //                     borderRadius: BorderRadius.all(Radius.circular(10)),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: Colors.black,
// //                         blurRadius: 7.0,
// //                         spreadRadius: 2.0,
// //                       )
// //                     ]),
// //               ),
// //             ),
// //             Padding(
// //               padding: EdgeInsets.all(8),
// //               child: Container(
// //                 alignment: Alignment.center,
// //                 padding: const EdgeInsets.all(8),
// //                 child: const Text('Sound of screams but the'),
// //                 decoration: const BoxDecoration(
// //                     color: Color.fromRGBO(255, 226, 173, 1),
// //                     borderRadius: BorderRadius.all(Radius.circular(10)),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: Colors.black,
// //                         blurRadius: 7.0,
// //                         spreadRadius: 2.0,
// //                       )
// //                     ]),
// //               ),
// //             ),
// //             Padding(
// //               padding: EdgeInsets.all(8),
// //               child: Container(
// //                 alignment: Alignment.center,
// //                 padding: const EdgeInsets.all(8),
// //                 child: const Text('Sound of screams but the'),
// //                 decoration: const BoxDecoration(
// //                     color: Color.fromRGBO(255, 226, 173, 1),
// //                     borderRadius: BorderRadius.all(Radius.circular(10)),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: Colors.black,
// //                         blurRadius: 7.0,
// //                         spreadRadius: 2.0,
// //                       )
// //                     ]),
// //               ),
// //             ),
// //           ]),
// //     );
// //   }
// // }

// // class Another extends StatelessWidget {
// //   const Another({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container();
// //   }
// // }
