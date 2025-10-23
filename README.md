# 🏥 HealthDB SQL Data Analysis

This project focuses on analyzing healthcare data using SQL. The database `healthdb` contains information about **patients**, **doctors**, **appointments**, **prescriptions**, and **billing records**. Through various SQL queries, the project aims to provide insights into hospital operations, doctor performance, patient behavior, and financial trends.

---

## 🚀 Project Overview

* **Database Name:** `healthdb`
* **Imported File:** `healthdb.sql`
* **Tables Used:**

  * `patients` — patient details such as name, gender, and date of birth.
  * `doctors` — doctor information including specialty and contact details.
  * `appointments` — records of patient-doctor visits with appointment dates and reasons.
  * `billing` — financial transactions, payment amounts, and status.
  * `prescriptions` — medicines prescribed to patients for each appointment.

---

## 🔍 Analysis Performed

1. **Patient-Specific Appointments and Prescriptions**

   * Retrieve all appointments or prescriptions linked to a specific patient or appointment ID.
   * Helps in tracking patient history and treatment progress.

2. **Billing and Payment Insights**

   * Analyze billing information per appointment and identify **paid** and **pending** payments.
   * Calculate **total billed amount** vs **total paid amount** to measure revenue flow.

3. **Appointments Overview**

   * Join data from `patients`, `doctors`, and `billing` tables to view full appointment details with billing status.
   * Analyze appointment distribution by **doctor specialty** and **appointment reason** to identify high-demand areas.

4. **Doctor Performance Metrics**

   * Count the number of appointments per doctor.
   * Identify doctors generating the **highest total billed amount**.
   * Track doctor activity over time (e.g., appointments in August or recent months).

5. **Patient Analysis**

   * List patients with their **latest appointment date**.
   * Identify patients who have **no appointments** or **unpaid bills**.
   * Filter patients who visited in the **last 30 or 90 days** to understand engagement trends.

6. **Prescription Analysis**

   * Find the **most frequently prescribed medications** and their **total dosage**.
   * Retrieve prescriptions linked with **pending billing** to monitor unpaid treatments.

7. **Demographic Analysis**

   * Analyze patient demographics by gender distribution.
   * Understand the hospital’s patient base composition for better service planning.

8. **Financial and Time-Based Trends**

   * Study **monthly payment status trends** to observe payment behaviors over time.
   * Calculate **average billing per patient** based on appointment frequency.
   * Analyze unpaid bills and revenue gaps using status and total amount comparisons.

9. **Data Integrity Checks**

   * Identify **appointments without billing** and **patients without appointments** to ensure data completeness.
   * Convert appointment date from text to date format for accurate time-based filtering.

10. **Monthly and Day-Wise Analysis**

    * Retrieve appointments and payments for a specific month (e.g., August 2025).
    * Count total appointments per day to track hospital workload.

---

## 📈 Key Insights

* **Revenue Overview:** The total billed and paid amounts highlight the hospital’s financial health.
* **Doctor Performance:** Doctors with high appointment counts or billed totals can be identified for performance reviews.
* **Patient Engagement:** Frequent visits and high ratings indicate loyal or critical patients needing more attention.
* **Pending Payments:** Unpaid billing records show areas needing improvement in financial follow-up.
* **Prescription Trends:** Helps in identifying commonly used medicines and their demand frequency.

---

## 🛠️ Tech Stack

* **Database System:** MySQL
* **Imported Data:** `healthdb.sql`
* **Skills Used:**

  * SQL Joins (INNER, LEFT)
  * Aggregations (SUM, COUNT, AVG)
  * Filtering (WHERE, BETWEEN, LIKE)
  * Grouping & Ordering
  * Date Formatting and Conversion

---

## 🤝 Contribution

You can fork this repository to:

* Add more analytical SQL queries.
* Improve data visualization using Power BI or Tableau.
* Create dashboards or reports based on SQL outputs.

---

## 📜 License

This project is licensed under the **MIT License**.


