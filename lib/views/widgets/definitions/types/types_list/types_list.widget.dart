import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TypesList extends ConsumerWidget {
  const TypesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 640.0,
      // width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
            child: DataTable(
          columns: const [
            DataColumn(
              label: CBText(
                text: 'Code',
                textAlign: TextAlign.start,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            DataColumn(
              label: CBText(
                text: 'Photo',
                textAlign: TextAlign.start,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            DataColumn(
              label: CBText(
                text: 'Nom',
                textAlign: TextAlign.start,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            DataColumn(
              label: CBText(
                text: 'Mise',
                textAlign: TextAlign.start,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            DataColumn(
              label: CBText(
                text: 'Produits',
                textAlign: TextAlign.start,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            DataColumn(label: SizedBox()),
            DataColumn(label: SizedBox()),
          ],
          rows: [
            for (int i = 0; i < 20; ++i)
              DataRow(
                cells: [
                  DataCell(
                    CBText(text: '0000${i + 1}'),
                  ),
                  DataCell(
                    Container(
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.photo,
                        color: CBColors.primaryColor,
                      ),
                    ),
                  ),
                  DataCell(
                    CBText(text: 'Type ${i + 1}'),
                  ),
                  DataCell(
                    CBText(text: '${(i + 1) * 100}f/Jour'),
                  ),
                  const DataCell(
                    CBText(
                      text:
                          '3 Produit 1, 2 Produit 2, 1 Produit 3, 2 Produit 4, 5 Produit 5',
                    ),
                  ),
                  DataCell(
                    Container(
                      alignment: Alignment.centerRight,
                      child: const Icon(
                        Icons.edit,
                        color: Colors.green,
                      ),
                    ),
                    // showEditIcon: true,
                  ),
                  DataCell(
                    Container(
                      alignment: Alignment.centerRight,
                      child: const Icon(
                        Icons.delete_sharp,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        )),
      ),
    );
  }
}
