import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/modules/tee_sheet/controllers/tee_sheet_controller.dart';
import 'package:golf_game_play/app/modules/tee_sheet/model/teesheet_model.dart';
import 'package:golf_game_play/common/app_color/app_colors.dart';
import 'package:golf_game_play/common/app_string/app_string.dart';
import 'package:golf_game_play/common/app_text_style/style.dart';
import 'package:golf_game_play/common/widgets/custom_card.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class TeeSheetView extends StatelessWidget {
  TeeSheetView({super.key});
  final TeeSheetController _teeSheetController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () async {
              await generateAndSharePDF();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Center(
          child: Column(
            children: [
              Text(AppString.teeSheetText, style: AppStyles.h1()),
              SizedBox(height: 20.h),
              Obx(() {
                List<TeeSheetAttributes> teeSheetAttributes = _teeSheetController.teeSheetModel.value.data?.attributes ?? [];
                if (_teeSheetController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (teeSheetAttributes.isEmpty) {
                  return const Center(child: Text('Tee sheet is empty'));
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: teeSheetAttributes.length,
                  itemBuilder: (BuildContext context, int index) {
                    final teeSheetAttributesIndex = teeSheetAttributes[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.w),
                      child: buildTeeSheet(teeSheetAttributesIndex),
                    );
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  CustomCard buildTeeSheet(TeeSheetAttributes teeSheetAttributes) {
    return CustomCard(
      padding: 0,
      children: [
        Container(
          height: 25,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${teeSheetAttributes.groupName}'),
                Text('${teeSheetAttributes.dateTime}'),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.w, top: 4.w),
          child: Column(
            children: teeSheetAttributes.playerList!.map((player) {
              Map<String, Color> teeBoxData = _teeSheetController.teeBoxItem;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Text(
                      '${player.name}',
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.h5(),
                    ),
                  ),
                  SizedBox(width: 20.h),
                  Text(
                    player.clubHandicap!.isEmpty
                        ? 'Player(HCP) : ${player.handicap}'
                        : 'Club(HCP) : ${player.clubHandicap}',
                    style: AppStyles.h5(),
                  ),
                  SizedBox(width: 10.h),
                  CustomCard(
                    cardHeight: 30,
                    cardWidth: 50,
                    cardColor: teeBoxData[player.teebox],
                    children: [],
                  ),
                ],
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 6.h),
      ],
    );
  }

  Future<void> generateAndSharePDF() async {
    String tourName='';
    final pdf = pw.Document();
    if(Get.arguments['tournamentName']!=null){
     String name = Get.arguments['tournamentName'];
     tourName = name;
    }

    // Load your custom fonts
    final outfitFont = pw.Font.ttf(await rootBundle.load('assets/font/Outfit-Medium.ttf'));
    final dmSansFont = pw.Font.ttf(await rootBundle.load('assets/font/DMSans-Medium.ttf'));

    final teeSheetAttributes = _teeSheetController.teeSheetModel.value.data?.attributes ?? [];

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Text(tourName, style: pw.TextStyle(fontSize: 24, font: dmSansFont)),
          pw.SizedBox(height: 16),
          for (var group in teeSheetAttributes) ...[
            pw.Container(
              color: PdfColors.amberAccent,
              padding: pw.EdgeInsets.all(8),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(group.groupName??'', style: pw.TextStyle(font: outfitFont)),
                  pw.Text(group.dateTime ?? "", style: pw.TextStyle(font: outfitFont)),
                ],
              ),
            ),
            pw.SizedBox(height: 4),
            for (var player in group.playerList ?? [])
              pw.Container(
                padding: pw.EdgeInsets.symmetric(vertical: 4),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Expanded(
                      child: pw.Text(player.name, style: pw.TextStyle(font: dmSansFont)),
                    ),
                    pw.Text(
                      player.clubHandicap!.isEmpty
                          ? 'Player(HCP): ${player.handicap}'
                          : 'Club(HCP): ${player.clubHandicap}',
                      style: pw.TextStyle(font: dmSansFont),
                    ),
                    pw.SizedBox(width: 8),
                    pw.Container(
                      width: 40,
                      height: 20,
                      decoration: pw.BoxDecoration(
                        color: _flutterColorToPdfColor(
                          _teeSheetController.teeBoxItem[player.teebox] ?? Colors.grey,
                        ),
                        shape: pw.BoxShape.rectangle,
                      ),
                    ),
                  ],
                ),
              ),
            pw.SizedBox(height: 10),
          ]
        ],
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/tee_sheet.pdf");
    await file.writeAsBytes(await pdf.save());

    await Share.shareXFiles([XFile(file.path)], text: 'Tee Sheet PDF');
  }

  PdfColor _flutterColorToPdfColor(Color color) {
    return PdfColor.fromInt(color.value);
  }
}
