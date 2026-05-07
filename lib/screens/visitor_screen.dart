import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:visitor_pass_v2/controllers/visitor_entry_controller.dart';
import 'package:visitor_pass_v2/models/company_model.dart';
import '../config/app_colors.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/custom_header_card.dart';
import '../widgets/custom_text_field.dart';

class VisitorScreen extends StatefulWidget {
  const VisitorScreen({super.key});

  @override
  State<VisitorScreen> createState() => _VisitorScreenState();
}

class _VisitorScreenState extends State<VisitorScreen> {
  @override
  Widget build(BuildContext context) {
    final VisitorEntryController visitorEntryController = Get.put(
      VisitorEntryController(),
    );
    return Scaffold(
      appBar: CustomAppBar(
        title: "VISITOR REGISTRATION",
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          return Column(
            children: [
              CustomHeaderCard(
                title: "Visitor Information",
                accentColor: Colors.blue,
                showAction: false,
                actionText: "Reset",
                actionIcon: Icons.refresh,
                actionColor: AppColors.secondary,
                onActionPressed: () {
                  print("Reset clicked");
                  visitorEntryController.clear();
                },
                padding: const EdgeInsets.all(8),
              ),

              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller:
                            visitorEntryController.visitorNameController,
                        labelText: "Visitor Name",
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z ]'),
                          ),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Visitor Name";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          visitorEntryController.validate();
                        },
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        filled: true,
                        fillColor: Colors.white,
                        isRequired: true,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller:
                            visitorEntryController.companyNameController,
                        labelText: "Company Name",
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z ]'),
                          ),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Company Name";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          visitorEntryController.validate();
                        },
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        filled: true,
                        fillColor: Colors.white,
                        isRequired: true,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: visitorEntryController.mobileController,
                        labelText: "Mobile Number",
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Mobile Number";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          visitorEntryController.validate();
                        },
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.words,
                        filled: true,
                        fillColor: Colors.white,
                        isRequired: true,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: visitorEntryController.addressController,
                        labelText: "Address",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Address Number";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          visitorEntryController.validate();
                        },
                        maxLength: 50,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        filled: true,
                        fillColor: Colors.white,
                        isRequired: true,
                      ),
                    ),
                  ),
                ],
              ),

              CustomHeaderCard(
                title: "Company Information",
                accentColor: Colors.blue,
                showAction: false,
                actionText: "Reset",
                actionIcon: Icons.refresh,
                actionColor: AppColors.secondary,
                onActionPressed: () {
                  print("Reset clicked");
                  visitorEntryController.clear();
                },
                padding: const EdgeInsets.all(8),
              ),

              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CommonDropdown<CompanyModel>(
                        items: visitorEntryController.companyList,
                        selectedValue:
                            visitorEntryController.companyList.contains(
                              visitorEntryController.selectedCompany.value,
                            )
                            ? visitorEntryController.selectedCompany.value
                            : null,
                        labelText: 'Company',
                        itemLabel: (CompanyModel item) =>
                            item.ccompanyname.toString(),
                        onChanged: (value) {
                          visitorEntryController.selectedCompany.value = value;
                          visitorEntryController.validate();
                          print(
                            "Selected RelationShip : ${visitorEntryController.selectedCompany.value?.ccompanyname}",
                          );
                        },
                        isRequired: true,
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: visitorEntryController.whomToMeetController,
                        labelText: "Whom to Meet",
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z ]'),
                          ),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Whom to Meet";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          visitorEntryController.validate();
                        },
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        filled: true,
                        fillColor: Colors.white,
                        isRequired: true,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: visitorEntryController.purposeController,
                        labelText: "Purpose",

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Purpose";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          visitorEntryController.validate();
                        },
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        filled: true,
                        fillColor: Colors.white,
                        isRequired: true,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                        backgroundColor: AppColors.primary,
                        sufIcon: Icon(Icons.send, color: Colors.white),
                        isEnabled: visitorEntryController.isSubmitEnabled.value,
                        isLoading: visitorEntryController.isLoading.value,
                        // disabledColor: Colors.grey,
                        text: "Submit",
                        onPressed: () async {
                          await visitorEntryController.submit();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
