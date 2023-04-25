import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../widgets/global_alert.dart';

class PaymentRecordPage extends StatelessWidget {
  const PaymentRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Stack(
          children: [
            Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: const Color.fromARGB(255, 11, 92, 130),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Registro'),
                      IconButton(
                        onPressed: () {
                          showAlert(
                            context,
                            logout: true,
                            title: 'importante',
                            msg: '¿Está seguro que desea cerrar sesión?',
                          );
                        },
                        icon: const Icon(Icons.logout_rounded),
                      )
                    ],
                  ),
                  leading: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back)),
                ),
                body: ListView(children: <Widget>[
                  const Center(
                      heightFactor: 2,
                      child: Text(
                        'Registro de Pagos',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      )),
                  DataTable(
                    columns: const [
                      DataColumn(
                          label: Text('Apart.',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Nombre',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Monto',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                    ],
                    rows: const [
                      DataRow(cells: [
                        DataCell(Text('1')),
                        DataCell(Text('Stephen')),
                        DataCell(Text('Actor')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('5')),
                        DataCell(Text('John')),
                        DataCell(Text('Student')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('10')),
                        DataCell(Text('Harry')),
                        DataCell(Text('Leader')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('15')),
                        DataCell(Text('Peter')),
                        DataCell(Text('Scientist')),
                      ]),
                    ],
                  ),
                ])),
          ],
        ),
        onWillPop: () async {
          return false;
        });
  }
}
