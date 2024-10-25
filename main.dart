//memasukan package yang dibutuhakan oleh aplikasi
import 'package:english_words/english_words.dart'; //untuk bahasa inggris
import 'package:flutter/material.dart'; //untuk tampilan ui
import 'package:provider/provider.dart'; //untuk interaksi aplikasi

//fungsi utama
void main() {
  runApp(
      MyApp()); //memanggil fungsi run app(yg menjalankan keseluruhan aplikasi)
}

//membuat abstrak aplikasi dari stateleswidget (template aplikasi) aplikasinya bernama MyApp
class MyApp extends StatelessWidget {
  const MyApp(
      {super.key}); //menunjukan bahwa aplikasi ini akan tetap, tidak berubah setelah di-build

  @override //mengganti nilai lama yg sudah ada di tamplate, dgn nilai" yang baru (replace/overwrite)

  //fungsi buld adalah yang membangun ui (mengatusr posisi widget, dst)
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //mendeteksi semua interaksi yang terjadi do aplikasi
      create: (context) =>
          MyAppState(), //membuat satu state bernama MyApp state
      child: MaterialApp(
        title: 'Namer App', //judul aplikasinya
        theme: ThemeData(
          //data tema aplikasi
          useMaterial3: true, //versi material ui yang dipakai versi 3
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 227, 159, 13)), //
        ),
        home:
            MyHomePage(), //nama halaman "myhomepage" yang menggunakan state "myappstate"
      ),
    );
  }
}

//mendefinisikan MyAppState
class MyAppState extends ChangeNotifier {
  //state MyAppState diisi dengan 2 kata rendom yang digabung. kata rendom tsb disimpan di variable WordPair
  var current = WordPair.random();
  void getNext() {
    current = WordPair.random();//untuk manampilkan kata rendom bahasa inggris
    notifyListeners();//menampilkan fungsi ini ke button
  }
  var favorites = <WordPair>[];
 //fungsi untuk menambahkan kata kedalam atau menghapus kata dari list favotites
  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);//untuk menghapus kata
    } else {
      favorites.add(current);//untuk menambahkan kata
    }
    notifyListeners();
  }
}



// ...

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget page;
switch (selectedIndex) {
  case 0:
    page = GeneratorPage();
    break;
  case 1:
    page = Placeholder();
    break;
  default:
    throw UnimplementedError('no widget for $selectedIndex');
}
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
                  ],
                  selectedIndex: selectedIndex,    
                  onDestinationSelected: (value) {
                  setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: GeneratorPage(),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),//untuk membuat tampilan text lebih besar
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ...
class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(pair.asLowerCase, style: style),
      ),
    );
  }
}
