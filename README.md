# Student-Transaction

# README for COBOL Program: CBLJRM05

---

![COBOL Program](https://via.placeholder.com/728x90.png "Banner Image")

## 📋 Overview

Welcome to the COBOL program **CBLJRM05**, crafted by Jake McDowell on **10/12/2023**. This program's primary objective is to efficiently process student transaction files, update student and course records, and produce a comprehensive, detailed report of the results. Through seamless file integration and robust error handling, this program exemplifies the power of COBOL in data management.

---

## 📜 Features

### 📂 File Processing
- **Reads Transaction Data**: Utilizes the `TRAN-STU-FILE` to gather records for processing.
- **Updates Files**:
  - Modifies the `STUDENT-FILE` with accurate, up-to-date student information.
  - Manages `COURSE-FILE` records by adding, updating, or deleting as required.

### 📊 Report Generation
- **Summary Report**: Produces a detailed summary of student and course data, exported to `STDNTCRS.PRT`.

### 🚨 Error Handling
- **Error Messaging**: Detects and notifies users of invalid operations or missing data, ensuring process reliability.

---

## 🗂️ Files Used

| **File Name**        | **Type**     | **Description**                     | **Path**                        |
|----------------------|--------------|-------------------------------------|---------------------------------|
| STUDENT-FILE         | Input        | Indexed file with core student data | `C:\COBOL LL\STUDMAST.DAT`    |
| COURSE-FILE          | Input        | Indexed file containing course data | `C:\COBOL LL\STCOURSE.DAT`    |
| TRAN-STU-FILE        | Input        | Sequential file for transactions    | `C:\COBOL LL\STCRTRAN.DAT`    |
| COURSE-PRTOUT        | Output       | Report file with summary details    | `C:\COBOL\STDNTCRS.PRT`       |

---

## 🔑 Key Sections

### 🔍 Identification Division
Captures program metadata, such as program ID and author details.

### 🌐 Environment Division
Defines the relationships between physical files and the program's logical structure.

### 🗂️ Data Division
Declares variables, constants, and file structures:
- **TRAN-REC**: Manages transaction data.
- **STUDENT-MAST & COURSE-MAST**: Store master records for students and courses.

### 🔄 Procedure Division
Organized into logical sections for streamlined operations:
- **1000-INIT**: Initializes files and processes the first transaction record.
- **2000-MAINLINE**: Core logic for reading and updating data.
- **3000-INIT-REPORT**: Sets up the report's structure and counters.
- **4000-MAINLINE-REPORT**: Generates and formats the final report.
- **5000-CLOSING**: Finalizes processing and closes files.
- **9200-ERROR-MES**: Handles and displays errors effectively.

---

## ⚙️ Key Constants and Variables

### 🛠️ Operational Constants
- **RESPONSE-CODE**: Status codes for file operations.
  - `'00'`: Success
  - `'23'`: Record Not Found

### 🕒 Dynamic Variables
- **CURRENT-DATE-AND-TIME**: Inserts current date into reports.
- **C-TOT-CRED-EARN & C-TOT-COURSE-GPA**: Tracks total credits and GPA for students.

---

## ▶️ How to Run

1. Place the input files (`STUDMAST.DAT`, `STCOURSE.DAT`, `STCRTRAN.DAT`) in the specified locations.
2. Use a COBOL compiler to compile the program.
3. Run the compiled program and locate the output in `STDNTCRS.PRT`.
4. Monitor the console for error messages or process logs.

---

## 🛡️ Error Handling

### ⚠️ Common Errors
- **Record Not Found**: Alerts and prompts user intervention.
- **Invalid Operations**: Logs details directly to the console for debugging.

---

## 📈 Improvements and Future Enhancements

- 🛡️ **Data Validation**: Implement stricter validation to avoid incorrect updates.
- 📂 **Format Expansion**: Support additional formats like CSV for greater versatility.
- 📈 **Enhanced Logging**: Introduce error-specific logs for improved debugging.

---

## 👤 Author

**Jake McDowell**  
🎓 A.A.S. in Computer Software Development, Indian Hills Community College  
📧 [Your Email Here]  

---

This program exemplifies the practical application of COBOL in handling complex file operations, delivering detailed reports, and ensuring data accuracy with robust error management.

---

![Footer Image](https://via.placeholder.com/728x90.png "Footer")
