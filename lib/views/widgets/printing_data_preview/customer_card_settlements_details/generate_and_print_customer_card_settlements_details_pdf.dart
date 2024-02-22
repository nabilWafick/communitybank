// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:communitybank/functions/common/common.function.dart';
import 'package:communitybank/models/data/customer/customer.model.dart';
import 'package:communitybank/models/data/customer_card/customer_card.model.dart';
import 'package:communitybank/models/data/customer_card_settlement_detail/customer_card_settlement_detail.model.dart';

import 'package:communitybank/models/data/type/type.model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> generateAndPrintCustomerCardSettlementsDetailsPdf({
  required BuildContext context,
  required DateFormat format,
  required Customer customer,
  required CustomerCard customerCard,
  required Type customerCardType,
  required List<CustomerCardSettlementDetail> customerCardSettlementsDetails,
}) async {
  final pdf = pw.Document();

  // Function to create the header text
  pw.Widget buildHeader(
      {required CustomerCard customerCard, required Type customerCardType}) {
    return pw.Column(
      children: [
        pw.Container(
          child: OtherInfos(
            label: 'Client',
            value: '${customer.name} ${customer.firstnames}',
          ),
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            OtherInfos(
              label: 'Carte',
              value: customerCard.label,
            ),
            OtherInfos(
              label: 'Nombre Type',
              value: customerCard.typeNumber.toString(),
            ),
          ],
        ),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            OtherInfos(
              label: 'Type',
              value: customerCardType.name,
            ),
            OtherInfos(
              label: 'Mise',
              value: '${customerCardType.stake.ceil().toString()} f',
            ),
          ],
        ),
      ],
    );
  }

  // Function to create the table
  pw.Widget buildDataTable({
    required List<CustomerCardSettlementDetail> customerCardSettlementsDetails,
  }) {
    return pw.Table(
      border: pw.TableBorder.all(),
      children: [
        pw.TableRow(
          children: [
            pw.Container(
              margin: const pw.EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 5.0,
              ),
              child: pw.Text(
                'Date Collecte',
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Container(
              margin: const pw.EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 5.0,
              ),
              child: pw.Text(
                'Nombre Mise',
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Container(
              margin: const pw.EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 5.0,
              ),
              child: pw.Text(
                'Montant',
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Container(
              margin: const pw.EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 5.0,
              ),
              child: pw.Text(
                'Date Saisie',
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Container(
              margin: const pw.EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 5.0,
              ),
              child: pw.Text(
                'Agent',
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        for (int i = 0; i < customerCardSettlementsDetails.length; ++i)
          pw.TableRow(
            children: [
              pw.Container(
                margin: const pw.EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 5.0,
                ),
                child: pw.Text(
                  format
                      .format(customerCardSettlementsDetails[i].settlementDate),
                  style: const pw.TextStyle(
                    fontSize: 9,
                  ),
                ),
              ),
              pw.Container(
                margin: const pw.EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 5.0,
                ),
                child: pw.Text(
                  customerCardSettlementsDetails[i].settlementNumber.toString(),
                  style: const pw.TextStyle(
                    fontSize: 9,
                  ),
                ),
              ),
              pw.Container(
                margin: const pw.EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 5.0,
                ),
                child: pw.Text(
                  customerCardSettlementsDetails[i]
                      .settlementAmount
                      .ceil()
                      .toString(),
                  style: const pw.TextStyle(
                    fontSize: 9,
                  ),
                ),
              ),
              pw.Container(
                margin: const pw.EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 5.0,
                ),
                child: pw.Text(
                  format.format(
                    customerCardSettlementsDetails[i].settlementEntryDate,
                  ),
                  style: const pw.TextStyle(
                    fontSize: 9,
                  ),
                ),
              ),
              pw.Container(
                margin: const pw.EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 5.0,
                ),
                child: pw.Text(
                  '${customerCardSettlementsDetails[i].agentName} ${customerCardSettlementsDetails[i].agentFirstname}',
                  style: const pw.TextStyle(
                    fontSize: 9,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  pw.Widget buildFooter({
    required List<CustomerCardSettlementDetail> customerCardSettlementsDetails,
  }) {
    double settlementAmountsTotal = 0;
    for (CustomerCardSettlementDetail customerCardSettlementDetail
        in customerCardSettlementsDetails) {
      settlementAmountsTotal += customerCardSettlementDetail.settlementAmount;
    }

    String dateTime = format.format(
      DateTime.now(),
    );
    dateTime += ' ';
    dateTime += FunctionsController.getFormatedTime(
      dateTime: DateTime.now(),
    );

    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        OtherInfos(
          label: 'Fait le ',
          value: dateTime,
        ),
        OtherInfos(
          label: 'Total',
          value: customerCardSettlementsDetails.isNotEmpty
              ? '${settlementAmountsTotal.ceil()} f'
              : '0 f',
        ),
      ],
    );
  }

  // Build PDF content
  pdf.addPage(
    pw.MultiPage(
      build: (context) => [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            buildHeader(
              customerCard: customerCard,
              customerCardType: customerCardType,
            ),
            pw.SizedBox(
              height: 20,
            ),
            buildDataTable(
              customerCardSettlementsDetails: customerCardSettlementsDetails,
            ),
            pw.SizedBox(
              height: 20,
            ),
            buildFooter(
              customerCardSettlementsDetails: customerCardSettlementsDetails,
            )
          ],
        ),
      ],
    ),
  );

  // Save and open the PDF
  final output = await getDownloadsDirectory();
  final file = File('${output!.path}/Situation_${customerCard.label}.pdf');
  await file.writeAsBytes(
    await pdf.save(),
  );
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text('PDF Générée!'),
      action: SnackBarAction(
        label: 'Open',
        onPressed: () {
          file.open();
        },
      ),
    ),
  );
}

// OtherInfos Widget
class OtherInfos extends pw.StatelessWidget {
  final String label;
  final String value;

  OtherInfos({
    required this.label,
    required this.value,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Row(
      children: [
        pw.Text(
          '$label: ',
          style: const pw.TextStyle(
            fontSize: 9,
          ),
        ),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: 9,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
