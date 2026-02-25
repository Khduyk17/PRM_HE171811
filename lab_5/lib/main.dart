import 'package:flutter/material.dart';

// --- STEP 2: DEFINE DATA MODEL ---
class Movie {
  final String title;
  final String posterUrl;
  final double rating;
  final List<String> genres;
  final String overview;
  final List<String> trailers;

  Movie({
    required this.title,
    required this.posterUrl,
    required this.rating,
    required this.genres,
    required this.overview,
    required this.trailers,
  });
}

// SAMPLE DATA
final List<Movie> sampleMovies = [
  Movie(
    title: "Dune: Part Two",
    posterUrl: "https://picsum.photos/id/101/400/600",
    rating: 8.6,
    genres: ["Sci-Fi", "Adventure", "Drama"],
    overview: "Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.",
    trailers: ["Official Trailer #1", "IMAX Sneak Peek"],
  ),
  Movie(
    title: "Deadpool & Wolverine",
    posterUrl: "https://picsum.photos/id/102/400/600",
    rating: 8.3,
    genres: ["Action", "Comedy"],
    overview: "The multiverse gets messy when Wade Wilson teams up with Wolverine for a not-so-family-friendly mission.",
    trailers: ["Red Band Trailer", "Behind the Scenes"],
  ),
];

void main() => runApp(const MovieApp());

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

// --- STEP 3: BUILD HOME SCREEN ---
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movies")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sampleMovies.length,
        itemBuilder: (context, index) {
          final movie = sampleMovies[index];
          return Card(
            child: ListTile(
              leading: Image.network(movie.posterUrl, width: 50, fit: BoxFit.cover),
              title: Text(movie.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("⭐ ${movie.rating} • ${movie.genres.join(', ')}"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // NAVIGATION: Pass Movie object
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailScreen(movie: movie)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// --- STEP 4: BUILD MOVIE DETAIL SCREEN ---
class DetailScreen extends StatelessWidget {
  final Movie movie;
  const DetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Layout scrollable
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Banner with Gradient
            Stack(
              children: [
                Image.network(movie.posterUrl, height: 300, width: double.infinity, fit: BoxFit.cover),
                Positioned(
                  bottom: 0, left: 0, right: 0,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter, end: Alignment.topCenter,
                        colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Text(movie.title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                ),
                SafeArea(child: BackButton(color: Colors.white)),
              ],
            ),
            // Genres as Chips
            Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 8,
                children: movie.genres.map((g) => Chip(label: Text(g))).toList(),
              ),
            ),
            // Overview Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(movie.overview, style: const TextStyle(fontSize: 16)),
            ),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAction(Icons.favorite_border, "Favorite"),
                _buildAction(Icons.star_border, "Rate"),
                _buildAction(Icons.share, "Share"),
              ],
            ),
            const Divider(),
            // List of Trailers
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text("Trailers", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ...movie.trailers.map((t) => ListTile(
              leading: const Icon(Icons.play_circle_fill),
              title: Text(t),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(IconData icon, String label) {
    return Column(
      children: [
        IconButton(icon: Icon(icon), onPressed: () {}),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}