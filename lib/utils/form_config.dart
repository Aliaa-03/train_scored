// lib/utils/form_config.dart
class FormInfo {
  final String id;
  final String title;
  final String imagePath;

  FormInfo({required this.id, required this.title, required this.imagePath});
}

List<FormInfo> availableForms = [
  FormInfo(
    id: 'score_card',
    title: 'Score Card for Coach Cleaning',
    imagePath: 'assets/images/score_card.jpg',
  ),
  FormInfo(
    id: 'coach_cleaning',
    title: 'Coach Cleaning',
    imagePath: 'assets/images/coach_cleaning.jpg',
  ),
  FormInfo(
    id: 'chemicals',
    title: 'Details for Chemicals',
    imagePath: 'assets/images/chemicals.jpg',
  ),
  FormInfo(
    id: 'staff_consumables',
    title: 'Staff Consumables',
    imagePath: 'assets/images/staff_consumables.jpg',
  ),
  FormInfo(
    id: 'bpb_stations',
    title: 'BPB Stations',
    imagePath: 'assets/images/bpb_stations.jpg',
  ),
  FormInfo(
    id: 'payment_or_platform',
    title: 'Payment or Platform Return',
    imagePath: 'assets/images/payment_or_platform.jpg',
  ),
];
