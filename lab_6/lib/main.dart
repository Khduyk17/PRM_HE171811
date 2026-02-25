import 'package:flutter/material.dart';

// --- STEP 2: DEFINE MOVIE MODEL ---
class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });
}

// SAMPLE DATA
final List<Movie> allMovies = [
  Movie(title: "Inception", year: 2010, genres: ["Sci-Fi", "Action"], rating: 8.8, posterUrl: "https://picsum.photos/id/1/200/300"),
  Movie(title: "The Dark Knight", year: 2008, genres: ["Action", "Drama"], rating: 9.0, posterUrl: "https://picsum.photos/id/2/200/300"),
  Movie(title: "Interstellar", year: 2014, genres: ["Sci-Fi", "Drama"], rating: 8.7, posterUrl: "https://picsum.photos/id/3/200/300"),
  Movie(title: "The Avengers", year: 2012, genres: ["Action", "Adventure"], rating: 8.0, posterUrl: "https://picsum.photos/id/4/200/300"),
  Movie(title: "Parasite", year: 2019, genres: ["Drama", "Thriller"], rating: 8.5, posterUrl: "https://picsum.photos/id/5/200/300"),
];

void main() => runApp(const ResponsiveMovieApp());

class ResponsiveMovieApp extends StatelessWidget {
  const ResponsiveMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 6 Responsive UI',
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: const GenreScreen(),
    );
  }
}

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  // STATE VARIABLES
  String searchQuery = '';
  Set<String> selectedGenres = {};
  String selectedSort = "A-Z";
  final List<String> availableGenres = ["Action", "Sci-Fi", "Drama", "Thriller", "Adventure"];

  @override
  Widget build(BuildContext context) {
    // STEP 7: FILTERING AND SORTING LOGIC
    List<Movie> visibleMovies = allMovies.where((movie) {
      bool matchesSearch = movie.title.toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesGenre = selectedGenres.isEmpty ||
          movie.genres.any((g) => selectedGenres.contains(g));
      return matchesSearch && matchesGenre;
    }).toList();

    if (selectedSort == "A-Z") visibleMovies.sort((a, b) => a.title.compareTo(b.title));
    if (selectedSort == "Z-A") visibleMovies.sort((a, b) => b.title.compareTo(a.title));
    if (selectedSort == "Year") visibleMovies.sort((a, b) => b.year.compareTo(a.year));
    if (selectedSort == "Rating") visibleMovies.sort((a, b) => b.rating.compareTo(a.rating));

    return Scaffold(
      appBar: AppBar(title: const Text("Find a Movie")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // STEP 4: SEARCH BAR
              TextField(
                decoration: InputDecoration(
                  hintText: "Search movies...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onChanged: (val) => setState(() => searchQuery = val),
              ),
              const SizedBox(height: 16),

              // STEP 5: GENRE CHIPS USING WRAP
              const Text("Genres", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 8,
                children: availableGenres.map((genre) {
                  final isSelected = selectedGenres.contains(genre);
                  return FilterChip(
                    label: Text(genre),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selected ? selectedGenres.add(genre) : selectedGenres.remove(genre);
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // STEP 6: SORT DROPDOWN
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Results: ${visibleMovies.length}"),
                  DropdownButton<String>(
                    value: selectedSort,
                    items: ["A-Z", "Z-A", "Year", "Rating"].map((s) =>
                        DropdownMenuItem(value: s, child: Text("Sort by $s"))).toList(),
                    onChanged: (val) => setState(() => selectedSort = val!),
                  ),
                ],
              ),

              // STEP 8: RESPONSIVE MOVIE LIST
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 800) {
                      // PHONE VIEW: ListView
                      return ListView.builder(
                        itemCount: visibleMovies.length,
                        itemBuilder: (context, index) => _buildMovieCard(visibleMovies[index]),
                      );
                    } else {
                      // TABLET/WEB VIEW: GridView
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: visibleMovies.length,
                        itemBuilder: (context, index) => _buildMovieCard(visibleMovies[index]),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieCard(Movie movie) {
    return Card(
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(movie.posterUrl, width: 50, height: 75, fit: BoxFit.cover),
        ),
        title: Text(movie.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("${movie.year} • ⭐ ${movie.rating}"),
        trailing: Wrap(
          spacing: 4,
          children: movie.genres.take(1).map((g) => Chip(label: Text(g, style: const TextStyle(fontSize: 10)))).toList(),
        ),
      ),
    );
  }
}