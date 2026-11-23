# Library Management — Spring MVC + JSP/JSTL

A Java 17 library web app using Spring MVC, JSP, JSTL, and reusable JSP tag files.

## Architecture
- `controller`: HTTP request handling.
- `model`: plain Java data classes.
- `service`: application logic and in-memory data storage.
- `WEB-INF/tags`: reusable JSP components.

No MySQL, WampServer, Hibernate, JPA, DAO, or repository is used. Data resets when the app restarts.

## Requirements
- JDK 17
- Maven 3.8+
- Apache Tomcat 9

## Run
1. Import as a Maven project.
2. Run `mvn clean package`.
3. Deploy `target/DoAnJava1.war` to Tomcat 9.
4. Open `http://localhost:8080/DoAnJava1/`.

Demo administrator: `admin` / `admin123`. Register a normal user to borrow books.
