# Library Management System

A remake of the original DoAnJava1 library-management project. The original Vietnamese UI and CSS are retained, while reusable page elements use JSP/JSTL tag files.

## Stack
- Java 17
- Spring MVC 5
- JSP + JSTL tag files
- Maven WAR
- Tomcat 9
- In-memory services; no MySQL, WampServer, Hibernate, JPA, or database setup

## Features
- Account registration, login, logout, profile, BCrypt password hashing, active/disabled accounts
- Roles: STUDENT, LIBRARIAN, ADMIN; admin can promote/demote librarians and disable accounts
- Book catalog with keyword search, category filtering, availability filter, detail modal, and grid/list views
- Book create/edit/delete, publisher/year/description fields, cover image upload and serving
- Borrowing with 14-day due dates, prevention of duplicate active loans, active loans, history, detail, overdue list
- Return processing, late-return status, 2,000 VND/day fine calculation, fine payment
- Digital document upload (PDF/DOC/DOCX, max 50 MB), download/PDF preview, download counts, deletion by staff
- Staff dashboard with inventory, monthly borrowing/return totals, overdue count, collected fines, and most-borrowed ranking
- Reusable JSTL tag files for header, navigation, footer, alerts, and book cards

## Run
1. Install JDK 17, Maven, and Tomcat 9.
2. Build: `mvn clean package`
3. Deploy `target/DoAnJava1.war` to Tomcat 9.
4. Open `http://localhost:8080/DoAnJava1/`.

## Demo administrator
- Username: `admin`
- Password: `admin123`

Register a normal account to test the STUDENT role. Use the admin account to promote it to LIBRARIAN and test staff workflows.

## Storage note
All application data and uploaded files are stored in memory. They are reset when the application restarts. This intentionally removes the original MySQL/WampServer dependency; it is suitable for a coursework/demo remake, not persistent production use.
