import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:notlar_uygulamasi_firebase/Notlar.dart';
import 'package:notlar_uygulamasi_firebase/main.dart';


class Not_detay_sayfa extends StatefulWidget {

  Notlar not;

  Not_detay_sayfa({required this.not});

  @override
  State<Not_detay_sayfa> createState() => _Not_detay_sayfaState();
}

class _Not_detay_sayfaState extends State<Not_detay_sayfa> {
  var tf_ders_adi = TextEditingController();
  var tf_not1 = TextEditingController();
  var tf_not2 = TextEditingController();

  var refNotlar = FirebaseDatabase.instance.ref().child("notlar");

  Future<void> sil(String not_id) async {
    refNotlar.child("not_id").remove();
  }

  Future<void> guncelle(
      String not_id, String ders_adi, int not1, int not2) async {
    var bilgi = HashMap<String, dynamic>();
    {
      bilgi["ders_adi"] = ders_adi;
      bilgi["not1"] = not1;
      bilgi["not2"] = not2;
      refNotlar.child("not_id").update(bilgi);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));
    }
  }

  @override
  void initState() {
    super.initState();
    var not = widget.not;
    tf_ders_adi.text = not.ders_adi;
    tf_not1.text = not.not1.toString();
    tf_not2.text = not.not2.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          "NOT DETAY",
          style: TextStyle(color: Colors.indigo, fontSize: 16),
        ),
        actions: [
          TextButton(
            child: Text(
              "SİL",
              style: TextStyle(color: Colors.teal),
            ),
            onPressed: () {
              sil(widget.not.not_id);
            },
          ),
          TextButton(
            child: Text(
              "GÜNCELLE",
              style: TextStyle(color: Colors.teal),
            ),
            onPressed: () {
              guncelle(widget.not.not_id, tf_ders_adi.text,
                  int.parse(tf_not1.text), int.parse(tf_not2.text));
            },
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tf_ders_adi,
                decoration: InputDecoration(hintText: "Ders adı"),
              ),
              TextField(
                controller: tf_not1,
                decoration: InputDecoration(hintText: "Birinci not"),
              ),
              TextField(
                controller: tf_not2,
                decoration: InputDecoration(hintText: "İkinci not"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
