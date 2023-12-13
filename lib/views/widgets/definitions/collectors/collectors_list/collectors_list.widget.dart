import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/text/text.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollectorsList extends ConsumerWidget {
  const CollectorsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 640.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            showCheckboxColumn: true,
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
                  text: 'Adresse',
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
                      Container(
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.account_circle_sharp,
                          size: 35.0,
                          color: CBColors.primaryColor,
                        ),
                      ),
                    ),
                    DataCell(
                      CBText(text: 'COLLECTOR Collecteur ${i + 1}'),
                    ),
                    DataCell(
                      CBText(text: 'Téléphone ${i + 1}'),
                    ),
                    DataCell(
                      CBText(text: 'Adresse ${i + 1}'),
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
          ),
        ),
      ),
    );
  }
}
