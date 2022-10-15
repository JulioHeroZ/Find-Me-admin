import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_me_admin/model/vendor_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../firebase_service.dart';
import 'package:flutter/material.dart';

class VendorsList extends StatelessWidget {
  const VendorsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseService _service = FirebaseService();
    Widget _vendorData({int? flex, String? text, Widget? widget}) {
      return Expanded(
        flex: flex!,
        child: Container(
          height: 66,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey.shade500)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget ?? Text(text!),
          ),
        ),
      );
    }

    return StreamBuilder<QuerySnapshot>(
        stream: _service.vendor.orderBy('time').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Tem algo de errado'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              Vendedor vendedor = Vendedor.fromJson(
                  snapshot.data!.docs[index].data() as Map<String, dynamic>);

              return Row(
                children: [
                  _vendorData(
                      flex: 1,
                      widget: Container(
                          height: 50,
                          width: 50,
                          child: Image.network(vendedor.logo!))),
                  _vendorData(flex: 3, text: vendedor.businessName),
                  _vendorData(flex: 2, text: vendedor.cidade),
                  _vendorData(flex: 2, text: vendedor.estado),
                  _vendorData(
                      flex: 1,
                      widget: vendedor.aprovado == true
                          ? ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                              child: Text(
                                'Rejeitar',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                EasyLoading.show();
                                _service.updateData(
                                    data: {'aprovado': false},
                                    docName: vendedor.uid,
                                    reference:
                                        _service.vendor).then(
                                    (value) => EasyLoading.dismiss());
                              },
                            )
                          : ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 13, 131, 72))),
                              child: Text(
                                'Aprovar',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                EasyLoading.show();
                                _service.updateData(
                                    data: {'aprovado': true},
                                    docName: vendedor.uid,
                                    reference:
                                        _service.vendor).then(
                                    (value) => EasyLoading.dismiss());
                              },
                            )),
                  _vendorData(
                      flex: 1,
                      widget: ElevatedButton(
                          onPressed: () {}, child: Text('Ver mais'))),
                ],
              );
            },
          );
        });
  }
}
