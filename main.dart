import 'package:flutter/material.dart';

void main() {
  runApp(const NetflixClone());
}

class NetflixClone extends StatelessWidget {
  const NetflixClone({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class Movie {
  final String name;
  final String image;
  final String description;

  Movie(this.name, this.image, this.description);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String searchText = "";

  List<Movie> allMovies = [

    Movie(
      "Wonder Woman",
      "https://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg",
      "Amazon warrior fights to save the world.",
    ),

    Movie(
      "Your Name",
      "https://image.tmdb.org/t/p/w500/q719jXXEzOoYaps6babgKnONONX.jpg",
      "Two strangers mysteriously switch bodies.",
    ),

    Movie(
      "Doctor Strange",
      "https://image.tmdb.org/t/p/w500/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg",
      "A surgeon learns the mystic arts.",
    ),

    Movie(
      "Avengers",
      "https://image.tmdb.org/t/p/w500/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg",
      "Superheroes unite to save the universe.",
    ),

    Movie(
      "Interstellar",
      "https://image.tmdb.org/t/p/w500/aNtAP8ZzUMdnCPoqYgVOcgI0Eh4.jpg",
      "Space journey to save humanity.",
    ),

    Movie(
      "Batman",
      "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
      "Dark knight protects Gotham city.",
    ),

    Movie(
      "Joker",
      "https://image.tmdb.org/t/p/w500/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg",
      "Origin story of Gotham's villain.",
    ),

    Movie(
      "Parasite",
      "https://image.tmdb.org/t/p/w500/lyQBXzOQSuE59IsHyhrp0qIiPAz.jpg",
      "Thriller about class struggle.",
    ),

    Movie(
      "Dune",
      "https://image.tmdb.org/t/p/w500/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg",
      "Epic sci-fi adventure.",
    ),

    Movie(
      "Kill Bill",
      "https://image.tmdb.org/t/p/w500/2yhg0mZQMhDyvUQ4rG1IZ4oIA8L.jpg",
      "Bride seeks revenge.",
    ),

  ];

  List<Movie> filterMovies() {

    if (searchText.isEmpty) {
      return allMovies;
    }

    return allMovies
        .where(
          (m) => m.name
              .toLowerCase()
              .contains(searchText.toLowerCase()),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {

    List<Movie> results = filterMovies();

    return Scaffold(
      backgroundColor: const Color(0xff0b0b1a),

      appBar: AppBar(
        backgroundColor: Colors.red,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [

            const Text(
              "NETFLIX",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),

            Row(
              children: [

                // SEARCH
                Container(
                  width: 250,
                  height: 40,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),

                  child: TextField(

                    onChanged: (v) {

                      setState(() {
                        searchText = v;
                      });

                    },

                    decoration: const InputDecoration(
                      hintText: "Search movie...",
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );

                  },

                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              searchText.isEmpty
                  ? "All Movies"
                  : "Search Results",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: GridView.builder(

                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.7,
                ),

                itemCount: results.length,

                itemBuilder: (context, index) {

                  Movie movie = results[index];

                  return GestureDetector(

                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MovieDetails(movie: movie),
                        ),
                      );

                    },

                    child: ClipRRect(

                      borderRadius: BorderRadius.circular(8),

                      child: Image.network(
                        movie.image,
                        fit: BoxFit.cover,
                      ),
                    ),
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

class MovieDetails extends StatelessWidget {

  final Movie movie;

  const MovieDetails({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(movie.name),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Row(

          children: [

            Image.network(
              movie.image,
              height: 300,
            ),

            const SizedBox(width: 20),

            Expanded(

              child: Text(
                movie.description,

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String email = "";
  String password = "";

  void login() {

    if (email == "admin" && password == "1234") {

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login successful"),
        ),
      );

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid login"),
        ),
      );

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      body: Center(

        child: Container(
          width: 320,
          padding: const EdgeInsets.all(20),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                onChanged: (v) => email = v,
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                obscureText: true,
                onChanged: (v) => password = v,
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: login,
                child: const Text("Login"),
              )

            ],
          ),
        ),
      ),
    );
  }
}