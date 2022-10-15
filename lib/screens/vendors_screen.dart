// ignore_for_file: prefer_const_constructors

import 'package:find_me_admin/widgets/vendors_list.dart';
import 'package:flutter/material.dart';

class VendorScreen extends StatelessWidget {
  static const String id = 'vendors-screen';
  const VendorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _rowHeader({int? flex, String? text}) {
      return Expanded(
        flex: flex!,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade700),
              color: Colors.grey.shade500),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }

    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            'Vendedores',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 36,
            ),
          ),
          Row(
            children: [
              _rowHeader(flex: 1, text: 'LOGO'),
              _rowHeader(flex: 3, text: 'NOME DA EMPRESA'),
              _rowHeader(flex: 2, text: 'CIDADE'),
              _rowHeader(flex: 2, text: 'ESTADO'),
              _rowHeader(flex: 1, text: 'AÇÃO'),
              _rowHeader(flex: 1, text: 'MAIS'),
            ],
          ),
          VendorsList()
        ],
      ),
    );
  }
}
