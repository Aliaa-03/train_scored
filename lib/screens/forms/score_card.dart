import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Review_Page.dart';
import '../../provider/form_data_provider.dart';
import 'package:provider/provider.dart';
import '../../utils/form_config.dart';

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

class ScoreCardForm extends StatefulWidget {
  const ScoreCardForm({Key? key}) : super(key: key);

  @override
  State<ScoreCardForm> createState() => _ScoreCardFormState();
}

class _ScoreCardFormState extends State<ScoreCardForm> {
  final _formKey = GlobalKey<FormState>();

  String? selectedWO, selectedDesignation, selectedTrainNo;
  String? selectedArrivalTime, selectedDepartureTime;
  String? selectedCoachesByContractor, selectedTotalCoaches;

  final TextEditingController workNameController = TextEditingController();
  final TextEditingController contractorNameController = TextEditingController();
  final TextEditingController supervisorNameController = TextEditingController();

  final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final List<String> options = ['0', '1', 'X', '-'];

  List<ScoreRow> scoreRows = [];

  @override
  void initState() {
    super.initState();
    scoreRows = [
      ...['T1', 'T2', 'T3', 'T4'].map((t) => ScoreRow(
        parentId: '1',
        description: 'Toilet cleaning complete using jet, cleaning basin, mirror, shelves, spraying freshener',
        tletLabel: t,
        values: List<String?>.filled(13, '-'),
      )),
      ScoreRow(
        parentId: '2',
        description: 'Cleaning & wiping of outside washbasin, mirror & shelves in doorway area',
        tletLabel: '-',
        values: List<String?>.filled(13, '-'),
      ),
      ...['B1', 'B2', 'D1', 'D2'].map((t) => ScoreRow(
        parentId: '3',
        description: 'Vestibule area, doorway, area between toilets and footsteps',
        tletLabel: t,
        values: List<String?>.filled(13, '-'),
      )),
      ScoreRow(
        parentId: '4',
        description: 'Disposal of collected waste from Coaches & AC Bins',
        tletLabel: '-',
        values: List<String?>.filled(13, '-'),
      ),
    ];
  }

  Widget buildDropdownCell(int rowIndex, int cellIndex) {
    return DropdownButtonFormField<String>(
      value: scoreRows[rowIndex].values[cellIndex],
      dropdownColor: const Color(0xFF582f0e),
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 5),
      ),
      items: options.map((val) => DropdownMenuItem(
        value: val,
        child: Text(val, style: const TextStyle(color: Colors.white)),
      )).toList(),
      onChanged: (val) {
        setState(() {
          scoreRows[rowIndex].values[cellIndex] = val;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Score Card for Coach Cleaning'
          ,style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold,
          ),),

        backgroundColor: const Color(0xFF582f0e),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFFa4ac86),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF582f0e)),
              child: Text('Available Forms', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            ...availableForms.map((form) {
              return ListTile(
                title: Text(form.title, style: const TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pushNamed(context, '/forms/${form.id}');
                },
              );
            }).toList(),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFc2c5aa), Color(0xFFa4ac86)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Clean Train Station for Through Passed Trains',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  buildScrollableRow([
                    buildDropdownField('W.O.No', ['WO1', 'WO2'], selectedWO, (val) => setState(() => selectedWO = val)),
                    buildReadOnlyField('Date', currentDate),
                    buildTextField('Name of Work', workNameController),
                    buildTextField('Contractor Name', contractorNameController),
                  ]),
                  buildScrollableRow([
                    buildTextField('Supervisor Name', supervisorNameController),
                    buildDropdownField('Designation', ['Worker', 'Supervisor'], selectedDesignation, (val) => setState(() => selectedDesignation = val)),
                    buildReadOnlyField('Inspection Date', currentDate),
                    buildDropdownField('Train No.', ['12309', '12345'], selectedTrainNo, (val) => setState(() => selectedTrainNo = val)),
                  ]),
                  buildScrollableRow([
                    buildDropdownField('Arrival Time', ['08:00', '09:00'], selectedArrivalTime, (val) => setState(() => selectedArrivalTime = val)),
                    buildDropdownField('Dep Time', ['10:00', '11:00'], selectedDepartureTime, (val) => setState(() => selectedDepartureTime = val)),
                  ]),
                  buildScrollableRow([
                    buildDropdownField('Coaches by Contractor', ['5', '6', '7'], selectedCoachesByContractor, (val) => setState(() => selectedCoachesByContractor = val)),
                    buildDropdownField('Total Coaches', ['13', '14'], selectedTotalCoaches, (val) => setState(() => selectedTotalCoaches = val)),
                  ]),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFa68a64),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF582f0e)),
                    ),
                    child: const Text(
                      "Note: Please give marks for each item on a scale 0 or 1. All items as above which are inaccessible should be marked 'X' and shall not be counted in total score. Item not available should be marked. No column should be left blank.",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: const [
                      Icon(Icons.edit_note, size: 24, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Score Table', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 400,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          border: TableBorder.all(color: const Color(0xFF582f0e)),
                          columnSpacing: 12,
                          columns: [
                            const DataColumn(label: Text('N', style: TextStyle(color: Colors.white))),
                            const DataColumn(label: Text('Itemized Description of Work', style: TextStyle(color: Colors.white))),
                            const DataColumn(label: Text("T'let", style: TextStyle(color: Colors.white))),
                            ...List.generate(13, (i) => DataColumn(label: Text('C${i + 1}', style: const TextStyle(color: Colors.white)))),
                          ],
                          rows: List.generate(scoreRows.length, (rowIndex) {
                            final row = scoreRows[rowIndex];
                            bool isFirstInGroup = rowIndex == 0 || row.parentId != scoreRows[rowIndex - 1].parentId;
                            return DataRow(cells: [
                              DataCell(isFirstInGroup ? Text(row.parentId, style: const TextStyle(color: Colors.white)) : const Text('')),
                              DataCell(isFirstInGroup ? Text(row.description, style: const TextStyle(color: Colors.white)) : const Text('')),
                              DataCell(Text(row.tletLabel, style: const TextStyle(color: Colors.white))),
                              ...List.generate(13, (i) => DataCell(buildDropdownCell(rowIndex, i)))
                            ]);
                          }),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFa68a64),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final provider = Provider.of<FormDataProvider>(context, listen: false);

                        provider.updateGeneralField('woNumber', selectedWO);
                        provider.updateGeneralField('date', currentDate);
                        provider.updateGeneralField('workName', workNameController.text);
                        provider.updateGeneralField('contractorName', contractorNameController.text);
                        provider.updateGeneralField('supervisorName', supervisorNameController.text);
                        provider.updateGeneralField('designation', selectedDesignation);
                        provider.updateGeneralField('trainNo', selectedTrainNo);
                        provider.updateGeneralField('arrivalTime', selectedArrivalTime);
                        provider.updateGeneralField('departureTime', selectedDepartureTime);
                        provider.updateGeneralField('coachesByContractor', selectedCoachesByContractor);
                        provider.updateGeneralField('totalCoaches', selectedTotalCoaches);

                        provider.scoreTable.clear();
                        for (var row in scoreRows) {
                          provider.scoreTable.add({
                            'N': row.parentId,
                            'Description': row.description,
                            'Tlet': row.tletLabel,
                            'scores': row.values,
                          });
                        }

                        provider.notifyListeners();
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const ReviewPage()));
                      }
                    },
                    child: const Text('Review & Submit', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropdownField(String label, List<String> items, String? selectedValue, Function(String?) onChanged) {
    return SizedBox(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: DropdownButtonFormField<String>(
          value: selectedValue,
          dropdownColor: const Color(0xFF582f0e),
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.white),
            border: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF582f0e))),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF582f0e))),
          ),
          items: items.map((val) => DropdownMenuItem(value: val, child: Text(val, style: const TextStyle(color: Colors.white)))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return SizedBox(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.white),
            border: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF582f0e))),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF582f0e))),
          ),
        ),
      ),
    );
  }

  Widget buildReadOnlyField(String label, String value) {
    return SizedBox(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: TextFormField(
          initialValue: value,
          readOnly: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.white),
            border: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF582f0e))),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF582f0e))),
          ),
        ),
      ),
    );
  }

  Widget buildScrollableRow(List<Widget> children) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: children),
    );
  }
}
