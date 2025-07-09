import 'package:flutter/material.dart';

// ✅ موديل ScoreRow المستخدم في المراجعة و العرض
class ScoreRow {
  final String parentId;
  final String description;
  final String tletLabel;
  final List<String?> values;

  ScoreRow({
    required this.parentId,
    required this.description,
    required this.tletLabel,
    required this.values,
  });
}

class FormDataProvider extends ChangeNotifier {
  Map<String, dynamic> formData = {}; // بيانات عامة
  List<Map<String, dynamic>> scoreTable = []; // جدول التقييم

  // ---------- تحديث البيانات العامة ----------
  void updateGeneralField(String key, dynamic value) {
    formData[key] = value;
    notifyListeners();
  }

  // ---------- تحديث صف من الجدول ----------
  void updateScoreRow(int index, String column, String value) {
    if (index >= scoreTable.length) return;
    if (column == 'scores') return; // استخدم updateScoreCell بدلًا منها
    scoreTable[index][column] = value;
    notifyListeners();
  }

  // ---------- تحديث خلية واحدة داخل scores ----------
  void updateScoreCell(int rowIndex, int cellIndex, String value) {
    if (rowIndex >= scoreTable.length) return;
    (scoreTable[rowIndex]['scores'] as List)[cellIndex] = value;
    notifyListeners();
  }

  // ---------- تهيئة الجدول ----------
  void initializeScoreTable(int length) {
    scoreTable = List.generate(length, (index) => {
      'N': '',
      'Description': '',
      'Tlet': '',
      'scores': List.filled(13, '-'),
    });
  }

  // ---------- Getter للـ totalScore ----------
  int get totalScore => scoreTable.fold(
    0,
        (sum, row) =>
    sum + (row['scores'] as List).where((v) => v == '1' || v == '0').length,
  );

  // ---------- Getter للـ X count ----------
  int get totalX => scoreTable.fold(
    0,
        (sum, row) =>
    sum + (row['scores'] as List).where((v) => v == 'X').length,
  );

  // ✅ Getter بديل للإسم المتوقع في ReviewPage
  int get inaccessibleCount => totalX;

  // ✅ Getter للعرض في صفحة المراجعة
  List<ScoreRow> get scoreRows => scoreTable.map((row) {
    return ScoreRow(
      parentId: row['N'] ?? '',
      description: row['Description'] ?? '',
      tletLabel: row['Tlet'] ?? '',
      values: List<String?>.from(row['scores']),
    );
  }).toList();

  // ---------- Getter عام للبيانات كلها ----------
  Map<String, dynamic> get fullFormData => {
    'general': formData,
    'scoreTable': scoreTable,
    'totalScore': totalScore,
    'inaccessibleCount': totalX,
  };

  // ---------- Getters فردية لتسهيل المراجعة ----------
  String? get selectedWO => formData['woNumber'];
  String? get date => formData['date'];
  String? get workName => formData['workName'];
  String? get contractorName => formData['contractorName'];
  String? get supervisorName => formData['supervisorName'];
  String? get selectedDesignation => formData['designation'];
  String? get selectedTrainNo => formData['trainNo'];
  String? get selectedArrivalTime => formData['arrivalTime'];
  String? get selectedDepartureTime => formData['departureTime'];
  String? get selectedCoachesByContractor => formData['coachesByContractor'];
  String? get selectedTotalCoaches => formData['totalCoaches'];
}
