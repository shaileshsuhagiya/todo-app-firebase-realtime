import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:firebasedemo/src/configs/app_strings.dart';
import 'package:firebasedemo/src/configs/app_text_style.dart';
import 'package:provider/provider.dart';

import '../../../../configs/app_colors.dart';
import '../../../business_logic/view_models/multi_file_upload_view_model.dart';
import '../../../services/dependency_assembler_education.dart';

class FileUploadScreen extends StatefulWidget {
  const FileUploadScreen({Key? key}) : super(key: key);

  @override
  State<FileUploadScreen> createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  final MultiFileUploadViewModel _multiFileUploadViewModel =
      dependencyAssembler<MultiFileUploadViewModel>();

  @override
  void initState() {
    _multiFileUploadViewModel.getCurrentUserAllFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider<MultiFileUploadViewModel>.value(
          value: _multiFileUploadViewModel,
          child: Consumer<MultiFileUploadViewModel>(builder: (context,
              MultiFileUploadViewModel multiFileUploadViewModel, child) {
            return multiFileUploadViewModel.allFileCurrentUser.isEmpty?Center(child: Text(AppStrings.noUploadedFile,style: AppTextStyle().kTitleTextStyle)):ListView.builder(
              itemCount: multiFileUploadViewModel.allFileCurrentUser.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return Padding(
                  padding:const EdgeInsets.symmetric(vertical: 5) ,
                  child: Container(
                    padding:const EdgeInsets.symmetric(vertical: 5,horizontal: 10) ,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColor.btnColor)
                    ),
                    child: Text(
                      multiFileUploadViewModel.allFileCurrentUser[index],
                      style: AppTextStyle().kFileName,
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            LineAwesomeIcons.plus,
            color: AppColor.tileColor,
            size: 20,
          ),
          onPressed: () {
            _multiFileUploadViewModel.fileSelect();
          }),
    );
  }
}
