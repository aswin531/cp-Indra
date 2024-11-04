// import 'dart:ui';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Movie Streamer'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 child: Text(
//                   'Categories',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),

//               // Category List
//               SizedBox(
//                 height: 100,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   children: const [
//                     CategoryCard(title: 'Action'),
//                     CategoryCard(title: 'Drama'),
//                     CategoryCard(title: 'Comedy'),
//                     CategoryCard(title: 'Horror'),
//                     CategoryCard(title: 'Sci-Fi'),
//                   ],
//                 ),
//               ),

//               // Popular Movies Section
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: Text(
//                   'Popular Movies',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),

//               // Movie Grid
//               GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 0.7,
//                   mainAxisSpacing: 10,
//                   crossAxisSpacing: 10,
//                 ),
//                 itemCount: 10,
//                 itemBuilder: (context, index) {
//                   return const MovieCard();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Sample Detail Screen
// class DetailScreen extends StatelessWidget {
//   const DetailScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Movie Details'),
//       ),
//       body: const Center(
//         child: Text(
//           'Detailed Information About the Movie',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }

// class CategoryCard extends StatelessWidget {
//   final String title;

//   const CategoryCard({required this.title, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 8),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.deepPurple,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Center(
//         child: Text(
//           title,
//           style: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MovieCard extends StatelessWidget {
//   const MovieCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         image: const DecorationImage(
//           image: AssetImage('assets/images/number 2.png'),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(8),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.black.withOpacity(0.0),
//             ),
//             child: const Center(
//               child: Text(
//                 'Movie Title',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// ///Center(
//                                     child: Container(
//                                       height: 60,
//                                       width: 60,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white.withOpacity(0.2),
//                                         shape: BoxShape.circle,
//                                       ),
//                                       child: const Icon(
//                                         Icons.play_arrow_rounded,
//                                         color: Colors.white,
//                                         size: 35,
//                                       ),
//                                     ),
//                                   ),