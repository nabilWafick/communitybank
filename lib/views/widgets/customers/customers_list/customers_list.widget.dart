import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomersList extends ConsumerWidget {
  const CustomersList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /* const CBText(
          text: 'Liste des clients',
          fontSize: 20.0,
        ),
        const SizedBox(
          height: 30.0,
        ),*/
        SingleChildScrollView(
          child: SizedBox(
            height: 670,
            child: DataTable(
              showCheckboxColumn: true,
              columns: const [
                DataColumn(
                  label: CBText(
                    text: 'ID Client',
                    textAlign: TextAlign.start,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DataColumn(
                  label: CBText(
                    text: 'Nom & Prénoms',
                    textAlign: TextAlign.start,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DataColumn(
                  label: CBText(
                    text: 'Téléphone',
                    textAlign: TextAlign.start,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DataColumn(
                  label: CBText(
                    text: 'Addresse',
                    textAlign: TextAlign.start,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DataColumn(
                  label: CBText(
                    text: 'Collecteur',
                    textAlign: TextAlign.start,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DataColumn(
                  label: CBText(
                    text: 'Nombre de cartes',
                    textAlign: TextAlign.start,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DataColumn(
                  label: CBText(
                    text: 'Status',
                    textAlign: TextAlign.start,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DataColumn(
                  label: SizedBox(),
                ),
                DataColumn(
                  label: SizedBox(),
                ),
              ],
              rows: [
                for (int i = 0; i < 20; ++i)
                  DataRow(
                    cells: [
                      DataCell(
                        CBText(text: '0000${i + 1}'),
                      ),
                      DataCell(
                        CBText(text: 'USER 1 User ${i + 1}'),
                      ),
                      DataCell(
                        CBText(text: 'Téléphone ${i + 1}'),
                      ),
                      DataCell(
                        CBText(text: 'Adresse ${i + 1}'),
                      ),
                      DataCell(
                        CBText(text: 'Collecteur ${i + 1}'),
                      ),
                      DataCell(
                        CBText(text: '${i + 1}'),
                      ),
                      const DataCell(
                        CBText(
                          text: 'Satisfait',
                        ),
                      ),
                      const DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ),
                        // showEditIcon: true,
                      ),
                      const DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.delete_sharp,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
