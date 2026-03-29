# 📊 Business Intelligence Project (End-to-End)

## 🎯 Objective
The objective of this project is to solve a Business Intelligence business case using tools such as dbt, Google BigQuery, and Looker.

The final deliverable is a dashboard in Looker Studio, built through an end-to-end data pipeline covering ingestion, transformation, and modeling.
 <br>
 <br>
## 🧱 Repository Structure
The repository is organized into two main folders:

### 📁 dbt
This folder contains the data modeling structure used in dbt.

#### 📌 Models:
- **staging:**
    - Initial transformation layer for raw data.
    - Includes: Source definitions (sources.yml) and basic cleaning and standardization
- **exercises:**
    - SQL models created to solve specific analytical objectives.
    - Includes: Source definition (sources.yml) for each sql model.
- **datamarts:**
    - Final analytical tables used for reporting.
    - These models: Combine transformed data, apply business logic and include features such as customer segmentation

#### ⚙️ dbt_project.yml: 
Main configuration file for the dbt project.

### 📁 Looker:
Due to the need for a paid GCP Looker instance, the model was developed using the VS Code extension: **“LookML Syntax for Looker”** This allows maintaining a valid LookML structure without requiring a full Looker instance.

Includes views for:
- orders
- sales
- Contains a generic connection as a reference (no active Looker instance was used).
 <br>
 
## 🗄️ Data Architecture in BigQuery

### Raw Data:
Data provided in Excel format (.xlsx) and converted to CSV for ingestion.
All fields were loaded as strings to preserve the original data integrity.

<img width="415" height="127" alt="image" src="https://github.com/user-attachments/assets/9ff0040b-3dad-4a4b-8706-5bbd26f4488c" />

### Exercises:
Tables and views created using dbt.
Each model addresses a specific analytical use case.

<img width="415" height="264" alt="image" src="https://github.com/user-attachments/assets/23056280-f6b8-4e51-9f3c-cd9904f0ff61" />

### Looker Tables (Datamarts):
Final tables used for dashboarding.
Result from: Transformation of raw data and dbt models.

<img width="415" height="126" alt="image" src="https://github.com/user-attachments/assets/0ef965bd-ed21-49a9-8035-d5c96197837f" />
 <br>

## 🔗 Dashboard:
[LokerStudio Dashboard](https://lookerstudio.google.com/reporting/b1a5952e-987d-46f9-84aa-ed4ac43147c2)
