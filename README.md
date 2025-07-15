# 🎯 Data Warehouse & Analytics Project

Welcome to my **Data Warehouse & Analytics** portfolio project!  
This is my **first hands-on project** in data engineering and analytics, where I built a complete data warehouse and created insights using SQL and reporting tools.  

It’s based on the Medallion Architecture and follows best practices to show my skills in data processing, modeling, and analysis.

---

## 🧱 Project Architecture: Medallion Layers

We follow the **Medallion Architecture** which organizes data into 3 clear layers:

- 🔸 **Bronze Layer**  
  Raw data straight from the source (CSV files), loaded into **SQL Server**.

- ⚪ **Silver Layer**  
  Cleaned, standardized, and ready-to-use data.

- 🟡 **Gold Layer**  
  Final business-friendly data in a **star schema** – ready for analytics and reporting.

📌  
**Here's a quick look at the architecture:**  
![Data Architecture](docs/data_architecture.png)

---

## 📘 What’s in the Project?

This project includes:

- 🔄 **ETL Pipelines** – Load and transform data from ERP and CRM CSV files into the data warehouse.
- 🧩 **Data Modeling** – Design dimension and fact tables using a star schema.
- 📊 **Analytics** – Write SQL queries to generate insights into:
  - Customer behavior  
  - Product performance  
  - Sales trends

---

## 💡 Goals

### 🔧 Data Engineering  
- ✅ Build a simple, clean data warehouse using SQL Server  
- ✅ Import and clean ERP & CRM datasets  
- ✅ Integrate both sources into one model  
- ✅ Document the whole process  

### 📈 Data Analytics  
- ✅ Write SQL queries for key business questions  
- ✅ Share insights with easy-to-read reports  

---

## 🧰 Project Files Structure
data-warehouse-project/
│
├── datasets/ # Raw ERP & CRM CSV data
├── docs/ # Documentation & diagrams (ETL, data flow, models)
│
├── scripts/ # SQL scripts for each layer
│ ├── bronze/ # Load raw data
│ ├── silver/ # Clean & transform
│ ├── gold/ # Build star schema
│
├── tests/ # Data quality tests
├── README.md # You’re reading it now!
├── LICENSE
├── .gitignore
└── requirements.txt # Project setup requirements
