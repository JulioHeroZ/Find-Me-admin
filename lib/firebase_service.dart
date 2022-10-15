import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categorias');
  CollectionReference vendor =
      FirebaseFirestore.instance.collection('vendedor');

  Future<void> saveCategory(Map<String, dynamic> data) {
    return categories.doc(data['name']).set(data);
  }

  Future<void> updateData(
      {CollectionReference? reference,
      Map<String, dynamic>? data,
      String? docName}) {
    return reference!.doc(docName).update(data!);
  }
}
