# Clean Train Station Score Card App

A Flutter application to digitize the **Score Card Form** used for evaluating the cleanliness of train coaches and stations as part of the Clean Train Station (CTS) initiative.

---

## Features Implemented

- Score Entry Grid  
  Users can input cleanliness scores for toilets, doorways, vestibule areas, and waste disposal, coach-by-coach (C1–C13), using dropdowns.

- Form Data Entry 
  Includes:
  - W.O. Number
  - Date of Inspection (auto-filled)
  - Name of Work
  - Contractor Name
  - Supervisor Name & Designation
  - Arrival / Departure Times
  - Train Number, Total Coaches, etc.

- Live Totals Calculation 
  - Calculates `Total Score` (number of “1” entries)
  - Calculates `Inaccessible Items` (entries marked as “X”)

- Review Page  
  - All entered data is shown in a read-only summary.
  - Data sent to a mock API endpoint upon confirmation (`https://httpbin.org/post`).

- Beautiful UI  
  - Gradient background with modern styling.
  - Colored tables and form sections for clarity.
  - Consistent color palette matching railway theme.

- State Management with Provider  
  - Form data is managed globally and reused across screens.


---
## **Folder Structure**
  lib/
  ├── main.dart
  ├── provider/
  │   └── form_data_provider.dart
  ├── screens/
  │   └── home/
  │       ├── home_screen.dart
  │       ├── score_card_form.dart
  │       └── review_page.dart
  ├── utils/
  │   └── form_config.dart
  assets/
  └── images/

---
## **API Submission**
  POST https://httpbin.org/post
  Content-Type: application/json
---

## License
This project is for educational/demo purposes only. No license applies.

---

##  Project Setup Instructions

1. **Clone this repo**
```bash
git clone https://github.com/your-username/cts_scorecard_app.git
cd cts_scorecard_app


