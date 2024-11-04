// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:indrajala/core/constants/api_constants.dart';
// class MovieCard extends StatefulWidget {
//   final String title;
//   final String imageUrl;
//   final String? rating;
//   final String? duration;
//   final List<String>? genres;

//   const MovieCard({
//     super.key, 
//     required this.title, 
//     required this.imageUrl,
//     this.rating,
//     this.duration,
//     this.genres,
//   });

//   @override
//   State<MovieCard> createState() => _MovieCardState();
// }

// class _MovieCardState extends State<MovieCard> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   bool _isHovered = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 200),
//       vsync: this,
//     );
//     _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final fullImageUrl = ApiConstants.imageBaseUrl + widget.imageUrl;

//     return MouseRegion(
//       onEnter: (_) {
//         setState(() => _isHovered = true);
//         _controller.forward();
//       },
//       onExit: (_) {
//         setState(() => _isHovered = false);
//         _controller.reverse();
//       },
//       child: ScaleTransition(
//         scale: _scaleAnimation,
//         child: Container(
//           width: 220,
//           height: 320,
//           margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(_isHovered ? 0.4 : 0.2),
//                 spreadRadius: 2,
//                 blurRadius: _isHovered ? 15 : 8,
//                 offset: Offset(0, _isHovered ? 8 : 5),
//               ),
//             ],
//           ),
//           child: Stack(
//             children: [
//               // Main Image
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(15),
//                 child: CachedNetworkImage(
//                   imageUrl: fullImageUrl,
//                   placeholder: (context, url) => Container(
//                     color: Colors.grey[900],
//                     child: const Center(
//                       child: CircularProgressIndicator(
//                         color: Colors.white54,
//                         strokeWidth: 2,
//                       ),
//                     ),
//                   ),
//                   errorWidget: (context, url, error) => Container(
//                     color: Colors.grey[900],
//                     child: const Center(
//                       child: Icon(
//                         Icons.error_outline,
//                         color: Colors.white54,
//                         size: 32,
//                       ),
//                     ),
//                   ),
//                   fit: BoxFit.cover,
//                   height: double.infinity,
//                   width: double.infinity,
//                 ),
//               ),
              
//               // Gradient Overlay
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   gradient: LinearGradient(
//                     begin: Alignment.bottomCenter,
//                     end: Alignment.topCenter,
//                     colors: [
//                       Colors.black.withOpacity(0.9),
//                       Colors.black.withOpacity(0.5),
//                       Colors.transparent,
//                       Colors.transparent,
//                     ],
//                     stops: const [0.0, 0.3, 0.6, 1.0],
//                   ),
//                 ),
//               ),
              
//               // Content Overlay
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: Container(
//                   padding: const EdgeInsets.all(12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Title
//                       Text(
//                         widget.title,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           shadows: [
//                             Shadow(
//                               blurRadius: 4,
//                               color: Colors.black,
//                               offset: Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
                      
//                       const SizedBox(height: 8),
                      
//                       // Movie Info Row
//                       if (widget.rating != null || widget.duration != null)
//                         Row(
//                           children: [
//                             if (widget.rating != null) ...[
//                               const Icon(
//                                 Icons.star_rounded,
//                                 color: Colors.amber,
//                                 size: 16,
//                               ),
//                               const SizedBox(width: 4),
//                               Text(
//                                 widget.rating!,
//                                 style: const TextStyle(
//                                   color: Colors.amber,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                             ],
//                             if (widget.duration != null) ...[
//                               const Icon(
//                                 Icons.access_time_rounded,
//                                 color: Colors.white70,
//                                 size: 14,
//                               ),
//                               const SizedBox(width: 4),
//                               Text(
//                                 widget.duration!,
//                                 style: const TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ],
//                         ),
                        
//                       const SizedBox(height: 8),
                      
//                       // Genres
//                       if (widget.genres != null && widget.genres!.isNotEmpty)
//                         Wrap(
//                           spacing: 4,
//                           runSpacing: 4,
//                           children: widget.genres!.take(2).map((genre) {
//                             return Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 8,
//                                 vertical: 4,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.2),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Text(
//                                 genre,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
              
//               // Play Button (appears on hover)
//               if (_isHovered)
//                 Center(
//                   child: Container(
//                     width: 50,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.9),
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.5),
//                           spreadRadius: 0,
//                           blurRadius: 8,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: const Icon(
//                       Icons.play_arrow_rounded,
//                       color: Colors.black87,
//                       size: 32,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }