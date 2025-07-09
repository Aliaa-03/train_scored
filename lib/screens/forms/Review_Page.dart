import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../provider/form_data_provider.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  Future<void> submitForm(BuildContext context) async {
    final formData = Provider.of<FormDataProvider>(context, listen: false);
    final Map<String, dynamic> payload = formData.fullFormData;

    try {
      final response = await http.post(
        Uri.parse('https://httpbin.org/post'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Form submitted successfully ✅')),
        );
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit ❌')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Connection error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final formData = Provider.of<FormDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF582f0e),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Review Form', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        color: const Color(0xFFc2c5aa),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'General Data:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              _buildInfoRow('W.O.No:', formData.selectedWO),
              _buildInfoRow('Date:', formData.date),
              _buildInfoRow('Name of Work:', formData.workName),
              _buildInfoRow('Contractor:', formData.contractorName),
              _buildInfoRow('Supervisor:', formData.supervisorName),
              _buildInfoRow('Designation:', formData.selectedDesignation),
              _buildInfoRow('Train No:', formData.selectedTrainNo),
              _buildInfoRow('Arrival Time:', formData.selectedArrivalTime),
              _buildInfoRow('Dep Time:', formData.selectedDepartureTime),
              _buildInfoRow('Coaches by Contractor:', formData.selectedCoachesByContractor),
              _buildInfoRow('Total Coaches:', formData.selectedTotalCoaches),
              _buildInfoRow('Total Score:', formData.totalScore.toString()),
              _buildInfoRow('Inaccessible:', formData.totalX.toString()),

              const SizedBox(height: 24),
              const Text(
                'Score Table Details:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Table(
                border: TableBorder.all(),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const {
                  0: FixedColumnWidth(30),
                  1: FixedColumnWidth(200),
                  2: FixedColumnWidth(50),
                },
                children: [
                  TableRow(
                    decoration: const BoxDecoration(color: Color(0xFF936639)),
                    children: [
                      const Padding(padding: EdgeInsets.all(4), child: Text('N', style: TextStyle(color: Colors.white))),
                      const Padding(padding: EdgeInsets.all(4), child: Text('Description', style: TextStyle(color: Colors.white))),
                      const Padding(padding: EdgeInsets.all(4), child: Text('Tlet', style: TextStyle(color: Colors.white))),
                      for (int i = 1; i <= 13; i++)
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text('C$i', style: const TextStyle(color: Colors.white)),
                        ),
                    ],
                  ),
                  ...formData.scoreTable.asMap().entries.map((entry) {
                    final row = entry.value;
                    final isFirst = entry.key == 0 ||
                        row['N'] != formData.scoreTable[entry.key - 1]['N'];
                    return TableRow(children: [
                      Padding(padding: const EdgeInsets.all(4), child: Text(isFirst ? row['N'] : '')),
                      Padding(padding: const EdgeInsets.all(4), child: Text(isFirst ? row['Description'] : '')),
                      Padding(padding: const EdgeInsets.all(4), child: Text(row['Tlet'])),
                      ...List.generate(13, (i) {
                        final val = (row['scores'] as List)[i];
                        return Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(val.toString()),
                        );
                      }),
                    ]);
                  }),
                ],
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.edit, color: Colors.white),
                    label: const Text('Edit', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF936639),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => submitForm(context),
                    icon: const Icon(Icons.send, color: Colors.white),
                    label: const Text('Submit', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF936639),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 200, child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text(value ?? '-')),
        ],
      ),
    );
  }
}
