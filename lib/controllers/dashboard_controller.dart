import 'package:get/get.dart';
import 'package:visitor_pass_v2/models/check_in_out_model.dart';
import 'package:intl/intl.dart';
import 'package:visitor_pass_v2/models/summary_report_model.dart';
import '../config/encryption_helper.dart';
import '../services/api_function.dart';
import '../services/pdf_services.dart';

class DashBoardController extends GetxController {
  @override
  void onInit() {
    fetchDate();
    super.onInit();
  }

  // Api Functions
  final ApiFunction _apiFunction = ApiFunction();

  RxList<CheckInOutModel> checkInList = <CheckInOutModel>[].obs;
  RxList<CheckInOutModel> checkOutList = <CheckInOutModel>[].obs;
  RxList<CheckInOutModel> visitorList = <CheckInOutModel>[].obs;
  RxList<SummaryReportModel> summaryReportList = <SummaryReportModel>[].obs;
  final PdfServices _pdfServices = PdfServices();



  Rxn<DateTime> selectedStart = Rxn<DateTime>();
  Rxn<DateTime> selectedEnd = Rxn<DateTime>();

  final isLoading = false.obs;

  RxString fromDate = "".obs;
  RxString toDate = "".obs;

  fetchDate() {
    fromDate.value = DateFormat('yyyy/MM/dd').format(DateTime.now());
    toDate.value = DateFormat('yyyy/MM/dd').format(DateTime.now());
    final today = DateTime.now();
    final onlyDate = DateTime(today.year, today.month, today.day);

    selectedStart.value = onlyDate;
    selectedEnd.value = onlyDate;
  }

  fetchSummaryDetail(fromDate) async {
    final data = await _apiFunction.fetchSummrayReportModel({
      "strQuery":
      "exec astil_mapps.dbo.sp_visitors_checking @opt = '9', @search = '', @dcheckin = '$fromDate'",
      "strCon": "EMR_CONSTR",
    });
    summaryReportList.assignAll(data);
    print("Summary Detail Details List : $summaryReportList");
  }



  generateQrAttender(title, url) {
    _pdfServices.visitorQrPdf(url: url);
  }
}
