//memasukan package yang dibutuhakan oleh aplikasi
import 'package:english_words/english_words.dart';//untuk bahasa inggris
import 'package:flutter/material.dart';//untuk tampilan ui
import 'package:provider/provider.dart';//untuk interaksi aplikasi

//fungsi utama
void main() {
  runApp(MyApp());//memanggil fungsi run app(yg menjalankan keseluruhan aplikasi)
}

//membuat abstrak aplikasi dari stateleswidget (template aplikasi) aplikasinya bernama MyApp
class MyApp extends StatelessWidget {
  const MyApp({super.key}); //menunjukan bahwa aplikasi ini akan tetap, tidak berubah setelah di-build

  @override//mengganti nilai lama yg sudah ada di tamplate, dgn nilai" yang baru (replace/overwrite)

  //fungsi buld adalah yang membangun ui (mengatusr posisi widget, dst)
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(//mendeteksi semua interaksi yang terjadi do aplikasi
      create: (context) => MyAppState(),//membuat satu state bernama MyApp state
      child: MaterialApp(
        title: 'Namer App',//judul aplikasinya
        theme: ThemeData(//data tema aplikasi
          useMaterial3: true,//versi material ui yang dipakai versi 3
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),//
        ),
        home: MyHomePage(),//nama halaman "myhomepage" yang menggunakan state "myappstate"
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
    var appState = context.watch<MyAppState>();//widget menggunakan state MyAppState

//kode program untuk menyusun layout
    return Scaffold(//canvas dari layout
      body: Column(//diatas scaffold, ada body. bodynya diberi colum
        children: [//sesuatu yang di dalam body
          Text('A random idea:'),
          Text(appState.current.asLowerCase),//mengambil random texs dari appstate pada variabel wordpair current, lalu diubah menjdi huruf kecil semua, dan di tampilkan sebagai teks
       ElevatedButton(
      onPressed: () {
        appState.getNext();  // ← This instead of print().
      },
      child: Text('Next'),
    ),
        ],
      ),
    );
  }
}
