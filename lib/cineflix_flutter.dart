import 'package:flutter/material.dart';

void main() {
  runApp(const CineFlixApp());
}

// ============================================================
// APP
// ============================================================

class CineFlixApp extends StatelessWidget {
  const CineFlixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CineFlix',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF080808),
        primaryColor: Colors.redAccent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.redAccent,
          brightness: Brightness.dark,
        ),
        fontFamily: 'Arial',
      ),
      home: const CineFlixHome(),
    );
  }
}

// ============================================================
// MOVIE MODEL
// ============================================================

class Movie {
  final String title;
  final String image;
  final String genre;
  final String rating;
  final String description;
  final String year;

  const Movie({
    required this.title,
    required this.image,
    required this.genre,
    required this.rating,
    required this.description,
    required this.year,
  });
}

// ============================================================
// MOVIE DATA
// ============================================================

const List<Movie> movies = [
  Movie(
    title: 'Avengers',
    image:
        'https://image.tmdb.org/t/p/w500/RYMX2wcKCBAr24UyPD7xwmjaTn.jpg',
    genre: 'Action • Adventure',
    rating: '8.4',
    year: '2012',
    description:
        'Earths mightiest heroes come together to protect the world from a powerful enemy.',
  ),
  Movie(
    title: 'Interstellar',
    image:
        'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
    genre: 'Sci-Fi • Drama',
    rating: '8.7',
    year: '2014',
    description:
        'A team of explorers travels through a wormhole in space to find a new home for humanity.',
  ),
  Movie(
    title: 'Inception',
    image:
        'https://image.tmdb.org/t/p/w500/oYuLEt3zVCKq57qu2F8dT7NIa6f.jpg',
    genre: 'Action • Sci-Fi',
    rating: '8.8',
    year: '2010',
    description:
        'A skilled thief who steals secrets through dreams is given a difficult mission.',
  ),
  Movie(
    title: 'The Dark Knight',
    image:
        'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
    genre: 'Action • Crime',
    rating: '9.0',
    year: '2008',
    description:
        'Batman faces a dangerous criminal who creates chaos across Gotham City.',
  ),
  Movie(
    title: 'Avatar',
    image:
        'https://image.tmdb.org/t/p/w500/kyeqWdyUXW608qlYkRqosgbbJyK.jpg',
    genre: 'Action • Fantasy',
    rating: '7.9',
    year: '2009',
    description:
        'A marine joins an extraordinary world on another planet and discovers a new purpose.',
  ),
  Movie(
    title: 'Joker',
    image:
        'https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg',
    genre: 'Crime • Drama',
    rating: '8.4',
    year: '2019',
    description:
        'A troubled man struggles with society and gradually transforms into a mysterious criminal figure.',
  ),
  Movie(
    title: 'Spider-Man',
    image:
        'https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
    genre: 'Action • Adventure',
    rating: '8.2',
    year: '2021',
    description:
        'A young superhero faces new challenges while protecting the people he loves.',
  ),
  Movie(
    title: 'The Matrix',
    image:
        'https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg',
    genre: 'Action • Sci-Fi',
    rating: '8.7',
    year: '1999',
    description:
        'A computer programmer discovers that the world he knows is not what it seems.',
  ),
];

// ============================================================
// MAIN HOME / NAVIGATION
// ============================================================

class CineFlixHome extends StatefulWidget {
  const CineFlixHome({super.key});

  @override
  State<CineFlixHome> createState() => _CineFlixHomeState();
}

class _CineFlixHomeState extends State<CineFlixHome> {
  int selectedIndex = 0;

  final Set<String> myList = {};

  void toggleMyList(Movie movie) {
    setState(() {
      if (myList.contains(movie.title)) {
        myList.remove(movie.title);
      } else {
        myList.add(movie.title);
      }
    });
  }

  void openMovie(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsScreen(
          movie: movie,
          isInList: myList.contains(movie.title),
          onToggleList: () {
            toggleMyList(movie);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        onMovieTap: openMovie,
        onNotificationTap: () {
          showSnack(context, 'No new notifications');
        },
      ),
      SearchScreen(
        onMovieTap: openMovie,
      ),
      MyListScreen(
        myList: myList,
        onMovieTap: openMovie,
      ),
      ProfileScreen(),
    ];

    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF111111),
        indicatorColor: Colors.redAccent.withOpacity(0.2),
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'My List',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HOME SCREEN
// ============================================================

class HomeScreen extends StatelessWidget {
  final Function(Movie) onMovieTap;
  final VoidCallback onNotificationTap;

  const HomeScreen({
    super.key,
    required this.onMovieTap,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    final featuredMovie = movies[1];

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // TOP BAR
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
              child: Row(
                children: [
                  const Text(
                    'CineFlix',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                      letterSpacing: 1,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: onNotificationTap,
                    icon: const Icon(
                      Icons.notifications_none,
                      size: 28,
                    ),
                  ),
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.redAccent,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // HERO BANNER
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              child: GestureDetector(
                onTap: () => onMovieTap(featuredMovie),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: 360,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          featuredMovie.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[900],
                              child: const Icon(
                                Icons.movie,
                                size: 80,
                              ),
                            );
                          },
                        ),

                        // DARK GRADIENT
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Color(0xCC000000),
                              ],
                            ),
                          ),
                        ),

                        Positioned(
                          left: 20,
                          right: 20,
                          bottom: 20,
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'FEATURED MOVIE',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                featuredMovie.title,
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${featuredMovie.year} • ${featuredMovie.genre}',
                                style: const TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      showSnack(
                                        context,
                                        'Playing ${featuredMovie.title}',
                                      );
                                    },
                                    icon: const Icon(Icons.play_arrow),
                                    label: const Text('Play'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  OutlinedButton.icon(
                                    onPressed: () {
                                      onMovieTap(featuredMovie);
                                    },
                                    icon: const Icon(
                                      Icons.info_outline,
                                    ),
                                    label: const Text('Details'),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // TRENDING
          const SliverToBoxAdapter(
            child: SectionTitle(
              title: 'Trending Now',
              icon: Icons.local_fire_department,
            ),
          ),

          SliverToBoxAdapter(
            child: MovieHorizontalList(
              movies: movies.take(5).toList(),
              onMovieTap: onMovieTap,
            ),
          ),

          // POPULAR
          const SliverToBoxAdapter(
            child: SectionTitle(
              title: 'Popular Movies',
              icon: Icons.star,
            ),
          ),

          SliverToBoxAdapter(
            child: MovieHorizontalList(
              movies: movies.skip(3).toList(),
              onMovieTap: onMovieTap,
            ),
          ),

          // GENRES
          const SliverToBoxAdapter(
            child: SectionTitle(
              title: 'Browse Genres',
              icon: Icons.category,
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 55,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  GenreChip(
                    title: 'Action',
                    icon: Icons.flash_on,
                    onTap: () {
                      showSnack(context, 'Action movies selected');
                    },
                  ),
                  GenreChip(
                    title: 'Sci-Fi',
                    icon: Icons.rocket_launch,
                    onTap: () {
                      showSnack(context, 'Sci-Fi movies selected');
                    },
                  ),
                  GenreChip(
                    title: 'Drama',
                    icon: Icons.theater_comedy,
                    onTap: () {
                      showSnack(context, 'Drama movies selected');
                    },
                  ),
                  GenreChip(
                    title: 'Adventure',
                    icon: Icons.explore,
                    onTap: () {
                      showSnack(context, 'Adventure movies selected');
                    },
                  ),
                  GenreChip(
                    title: 'Crime',
                    icon: Icons.gavel,
                    onTap: () {
                      showSnack(context, 'Crime movies selected');
                    },
                  ),
                ],
              ),
            ),
          ),

          // NEW RELEASES
          const SliverToBoxAdapter(
            child: SectionTitle(
              title: 'New Releases',
              icon: Icons.new_releases,
            ),
          ),

          SliverToBoxAdapter(
            child: MovieHorizontalList(
              movies: movies.reversed.toList(),
              onMovieTap: onMovieTap,
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION TITLE
// ============================================================

class SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const SectionTitle({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.redAccent,
            size: 22,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HORIZONTAL MOVIE LIST
// ============================================================

class MovieHorizontalList extends StatelessWidget {
  final List<Movie> movies;
  final Function(Movie) onMovieTap;

  const MovieHorizontalList({
    super.key,
    required this.movies,
    required this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 275,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 12);
        },
        itemBuilder: (context, index) {
          return SizedBox(
            width: 155,
            child: MovieCard(
              movie: movies[index],
              onTap: () => onMovieTap(movies[index]),
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// MOVIE CARD
// ============================================================

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onTap;

  const MovieCard({
    super.key,
    required this.movie,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 155,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  movie.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[900],
                      child: const Center(
                        child: Icon(
                          Icons.movie,
                          size: 40,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 6),

            Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 3),

            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15,
                ),
                const SizedBox(width: 3),
                Text(
                  movie.rating,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// GENRE CHIP
// ============================================================

class GenreChip extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const GenreChip({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ActionChip(
        onPressed: onTap,
        avatar: Icon(
          icon,
          size: 18,
          color: Colors.redAccent,
        ),
        label: Text(title),
        backgroundColor: const Color(0xFF1A1A1A),
      ),
    );
  }
}

// ============================================================
// SEARCH SCREEN
// ============================================================

class SearchScreen extends StatefulWidget {
  final Function(Movie) onMovieTap;

  const SearchScreen({
    super.key,
    required this.onMovieTap,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final filteredMovies = movies.where((movie) {
      final query = searchText.toLowerCase();

      return movie.title.toLowerCase().contains(query) ||
          movie.genre.toLowerCase().contains(query);
    }).toList();

    return SafeArea(
      child: Column(
        children: [
          // SEARCH BAR
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(14),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white70,
                  ),
                  hintText: 'Search movies...',
                  hintStyle: TextStyle(
                    color: Colors.white54,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: filteredMovies.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 60,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'No movies found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      5,
                      16,
                      20,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 14,
                        runSpacing: 18,
                        children: filteredMovies.map((movie) {
                          return SizedBox(
                            width: 155,
                            height: 255,
                            child: MovieCard(
                              movie: movie,
                              onTap: () {
                                widget.onMovieTap(movie);
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// MY LIST SCREEN
// ============================================================

class MyListScreen extends StatelessWidget {
  final Set<String> myList;
  final Function(Movie) onMovieTap;

  const MyListScreen({
    super.key,
    required this.myList,
    required this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    final savedMovies = movies
        .where((movie) => myList.contains(movie.title))
        .toList();

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 18, 16, 10),
            child: Text(
              'My List',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: savedMovies.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 65,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Your list is empty',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Add movies you want to watch later.',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      5,
                      16,
                      20,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 14,
                        runSpacing: 18,
                        children: savedMovies.map((movie) {
                          return SizedBox(
                            width: 155,
                            height: 255,
                            child: MovieCard(
                              movie: movie,
                              onTap: () => onMovieTap(movie),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// MOVIE DETAILS
// ============================================================

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;
  final bool isInList;
  final VoidCallback onToggleList;

  const MovieDetailsScreen({
    super.key,
    required this.movie,
    required this.isInList,
    required this.onToggleList,
  });

  @override
  State<MovieDetailsScreen> createState() =>
      _MovieDetailsScreenState();
}

class _MovieDetailsScreenState
    extends State<MovieDetailsScreen> {
  late bool saved;

  @override
  void initState() {
    super.initState();
    saved = widget.isInList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 430,
            pinned: true,
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.movie.image,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.title,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Text(
                        widget.movie.year,
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        widget.movie.genre,
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(widget.movie.rating),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            showSnack(
                              context,
                              'Playing ${widget.movie.title}',
                            );
                          },
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('Play'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.redAccent,
                            foregroundColor: Colors.white,
                            padding:
                                const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            widget.onToggleList();

                            setState(() {
                              saved = !saved;
                            });

                            showSnack(
                              context,
                              saved
                                  ? 'Added to My List'
                                  : 'Removed from My List',
                            );
                          },
                          icon: Icon(
                            saved
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          label: Text(
                            saved ? 'Saved' : 'My List',
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding:
                                const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'About the movie',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    widget.movie.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'More Like This',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    height: 245,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length > 4
                          ? 4
                          : movies.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 12);
                      },
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 145,
                          child: MovieCard(
                            movie: movies[index],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PROFILE SCREEN
// ============================================================

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final List<Map<String, dynamic>> options = [
    {
      'icon': Icons.edit,
      'title': 'Edit Profile',
    },
    {
      'icon': Icons.notifications,
      'title': 'Notifications',
    },
    {
      'icon': Icons.download,
      'title': 'Downloads',
    },
    {
      'icon': Icons.settings,
      'title': 'Settings',
    },
    {
      'icon': Icons.help_outline,
      'title': 'Help & Support',
    },
    {
      'icon': Icons.logout,
      'title': 'Logout',
    },
  ];

  void handleOption(
    BuildContext context,
    String title,
  ) {
    if (title == 'Logout') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Logout'),
            content: const Text(
              'Are you sure you want to logout?',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);

                  showSnack(
                    context,
                    'Logged out successfully',
                  );
                },
                child: const Text('Logout'),
              ),
            ],
          );
        },
      );
      return;
    }

    if (title == 'Edit Profile') {
      showDialog(
        context: context,
        builder: (context) {
          final nameController =
              TextEditingController(text: 'CineFlix User');

          return AlertDialog(
            title: const Text('Edit Profile'),
            content: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);

                  showSnack(
                    context,
                    'Profile updated',
                  );
                },
                child: const Text('Save'),
              ),
            ],
          );
        },
      );
      return;
    }

    if (title == 'Notifications') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Notifications'),
            content: const Text(
              'You are all caught up! New movie notifications will appear here.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    if (title == 'Downloads') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Downloads'),
            content: const Text(
              'No downloaded movies yet.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    if (title == 'Settings') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Settings'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('Language'),
                  trailing: const Text('English'),
                  onTap: () {
                    Navigator.pop(context);
                    showSnack(
                      context,
                      'Language settings selected',
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: const Text('Appearance'),
                  trailing: const Text('Dark'),
                  onTap: () {
                    Navigator.pop(context);
                    showSnack(
                      context,
                      'Dark mode is enabled',
                    );
                  },
                ),
              ],
            ),
          );
        },
      );
      return;
    }

    if (title == 'Help & Support') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Help & Support'),
            content: const Text(
              'Need help?\n\n'
              'Email: support@cineflix.com\n'
              'Available 24/7 for CineFlix users.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          20,
          20,
          20,
          30,
        ),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 48,
              backgroundColor: Colors.redAccent,
              child: Icon(
                Icons.person,
                size: 55,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'CineFlix User',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              'user@cineflix.com',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 25),

            ...options.map(
              (option) => ProfileOption(
                icon: option['icon'] as IconData,
                title: option['title'] as String,
                onTap: () {
                  handleOption(
                    context,
                    option['title'] as String,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// PROFILE OPTION
// ============================================================

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Material(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 58,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.redAccent,
                    size: 21,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SNACKBAR
// ============================================================

void showSnack(
  BuildContext context,
  String message,
) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    ),
  );
}