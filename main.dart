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
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 225, 2, 255)), //
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
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState =
        context.watch<MyAppState>(); //widget menggunakan state MyAppState
    var pair =
        appState.current; //var pair menyimpan kata yang sedang tampil/aktif

//kode program untuk menyusun layout
    return Scaffold(
      //canvas dari layout
      body: Center(
        child: Column(
          //diatas scaffold, ada body. bodynya diberi colum
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //sesuatu yang di dalam body
          
            BigCard(//widget bigcard
                pair:
                    pair), //mengambil pada variabel pair, lalu diubah menjdi huruf kecil semua, dan di tampilkan sebagai teks kecil
            ElevatedButton(
              onPressed: () {
                appState.getNext(); // ← This instead of print().
              },
              child: Text('rowrrr'),
            ),
          ],
        ),
      ),
    );
  }
}

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
