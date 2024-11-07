
// class MovieDetailScreen extends StatelessWidget {
//   final String movieUrl;
//   final String trailerUrl;

//   const MovieDetailScreen(
//       {super.key, required this.movieUrl, required this.trailerUrl});

//   @override
//   Widget build(BuildContext context) {
//     // Fetch movie details when the screen is built
//     context.read<MovieDetailBloc>().add(FetchMovieDetail(url: movieUrl));

//     return Scaffold(
//       backgroundColor: IAppColors.bgBlack,
//       body: SafeArea(
//         child: BlocConsumer<MovieDetailBloc, MovieDetailState>(
//           listener: (context, state) {
//             if (state is TrailerError) {
//               showCustomSnackbar(context, state.message, IAppColors.red);
//             }
//           },
//           builder: (context, state) {
//             if (state is MovieDetailLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is MovieDetailLoaded) {
//               final movie = state.movie;
//               String fullTrailerUrl =
//                   '${ApiConstants.imageBaseUrl}${movie.trailerVideo}';
//               return SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CachedNetworkImage(
//                       imageUrl:
//                           ApiConstants.imageBaseUrl + movie.movieFullImage,
//                       width: double.infinity,
//                       height: 300,
//                       fit: BoxFit.cover,
//                       placeholder: (context, url) =>
//                           const ShimmerPlaceholder.rectangular(
//                         width: double.infinity,
//                         height: 300,
//                         placeholderImage: 'assets/images/playstore.png',
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Align(
//                             alignment: Alignment.center,
//                             child: Text(
//                               movie.movieName,
//                               style: IAppTextStyles.heading1,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             'Rating: ${movie.rating}',
//                             style: IAppTextStyles.subtitle,
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             'Age: ${movie.ageLimit}+',
//                             style: IAppTextStyles.subtitle,
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             'Duration: ${movie.duration}',
//                             style: IAppTextStyles.subtitle,
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             movie.description,
//                             style: IAppTextStyles.descriptionText,
//                           ),
//                           const SizedBox(height: 8),
//                           Align(
//                             alignment: Alignment.center,
//                             child: Text(
//                               'Starring: ${movie.starring.first}',
//                               style: IAppTextStyles.subtitle,
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//                           Trailerpurchasebutton(
//                             color: Colors.blue,
//                             iconColor: IAppColors.white,
//                             textStyle: IAppTextStyles.bodyText,
//                             icon: Icons.play_arrow,
//                             text: 'Watch Trailer',
//                             onPressed: () {
//                               // Navigate directly to VideoPlayerScreen
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => VideoPlayerScreen(
//                                     trailerUrl: fullTrailerUrl,
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                           const SizedBox(height: 20),
//                           Trailerpurchasebutton(
//                             iconColor: IAppColors.bgBlack,
//                             textStyle: IAppTextStyles.bodyTextBlack,
//                             color: Colors.yellow,
//                             icon: Icons.workspace_premium,
//                             text: 'Purchase Premium',
//                             onPressed: () async {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       const SubscriptionPage(),
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             } else if (state is MovieDetailError) {
//               return Center(child: Text('Error: ${state.message}'));
//             }
//             return const Center(child: CircularProgressIndicator());
//           },
//         ),
//       ),
//     );
//   }
// }