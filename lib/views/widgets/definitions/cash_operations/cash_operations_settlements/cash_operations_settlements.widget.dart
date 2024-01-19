import 'package:communitybank/utils/colors/colors.util.dart';
import 'package:communitybank/views/widgets/globals/global.widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CashOperationsSettlements extends ConsumerWidget {
  const CashOperationsSettlements({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
          //  color: Colors.blueAccent,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(
              15.0,
            ),
            topRight: Radius.circular(
              15.0,
            ),
          ),
          border: Border.all(
            color: CBColors.sidebarTextColor.withOpacity(.5),
            width: 1.5,
          )),
      height: 370.0,
      width: double.infinity,
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
                text: 'Carte',
                textAlign: TextAlign.start,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            DataColumn(
              label: CBText(
                text: 'Nombre de Mise',
                textAlign: TextAlign.start,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            DataColumn(
              label: CBText(
                text: 'Montant',
                textAlign: TextAlign.start,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            DataColumn(
              label: CBText(
                text: 'Date Collecte',
                textAlign: TextAlign.start,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            DataColumn(
              label: CBText(
                text: 'Date Saisie',
                textAlign: TextAlign.start,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            DataColumn(
              label: CBText(
                text: 'Agent',
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
            for (int i = 0; i < 20; i++)
              DataRow(
                cells: [
                  DataCell(
                    CBText(
                      text: '000${i + 1}',
                    ),
                  ),
                  DataCell(
                    CBText(
                      text: 'COO0${i + 1}',
                    ),
                  ),
                  DataCell(
                    Center(
                      child: CBText(
                        text: '${i + 1}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: CBText(
                        text: '${(i + 1) * 100} f',
                      ),
                    ),
                  ),
                  DataCell(
                    CBText(
                      text: '1${i + 1} Janvier 2024',
                    ),
                  ),
                  DataCell(
                    CBText(
                      text: '1${i + 2} Janvier 2024',
                    ),
                  ),
                  DataCell(
                    CBText(
                      text: 'Agent ${i + 1}',
                    ),
                  ),
                  DataCell(
                    onTap: () {
                      // FunctionsController.showAlertDialog(
                      //   context: context,
                      //   alertDialog: LocalityUpdateForm(
                      //       locality: locality),
                      // );
                    },
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
                    onTap: () async {
                      // FunctionsController.showAlertDialog(
                      //   context: context,
                      //   alertDialog:
                      //       LocalityDeletionConfirmationDialog(
                      //     locality: locality,
                      //     confirmToDelete:
                      //         LocalityCRUDFunctions.delete,
                      //   ),
                      // );
                    },
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
    );
  }
}
