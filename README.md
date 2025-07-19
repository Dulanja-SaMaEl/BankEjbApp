## 🏦 Enterprise Java Banking System (EJB-based)

This project is a **modular, secure, and scalable core banking system** built using **Jakarta EE (J2EE)** technologies, specifically leveraging **Enterprise JavaBeans (EJB)** for business logic and **EJB Timer Services** for time-sensitive operations.

### 🔧 Modules Overview:

* **core-module**: Contains JPA entities (e.g., `Account`, `Transaction`, `ScheduledTransfer`) and shared interfaces used across the application.
* **account-module**: Implements EJB business logic for account operations, transfers, interest calculation, and timer-based automation.
* **web-module**: Contains JSF/JSP views, Servlets for HTTP interaction, and handles user requests.
* **auth-module**: Manages authentication and role-based access control using container-managed security.
* **ear-module**: Aggregates all modules for deployment on GlassFish.

---

### ✅ Key Features:

* **Scheduled Transfers**: Users can schedule future fund transfers. These are processed via EJB `@Schedule` methods using a `ScheduledTransfer` entity.
* **Interest Calculation**: Automatically calculates and credits yearly interest to customer accounts using a `TimerService` task.
* **Transaction Management**: Ensures atomic and consistent database updates using container-managed and bean-managed transactions.
* **Security**: Role-based access secured via `@RolesAllowed`, container-managed JAAS, and logging of all unauthorized access attempts.
* **Interceptors**: Used for logging, auditing, and exception handling across all critical services.
* **Monitoring**: Includes load testing with JMeter, Chrome DevTools testing for UI, and JMX/logging for backend task reliability.

---

### 📦 Technologies Used:

* Jakarta EE 10 (EJB, JPA, JSF)
* GlassFish 7
* MySQL (or H2 for local test DB)
* JUnit / Arquillian for testing
* Apache JMeter for performance testing
* Git + GitHub for version control

---

### 📁 Sample GitHub Structure:

```
/core
/account
/web
/auth
/ear
README.md
LICENSE
pom.xml
```

---

```md
## 📝 Description
This EJB-based enterprise application simulates a real-world banking backend. It supports time-based operations like scheduled fund transfers and interest calculations, leveraging Jakarta EE’s built-in scheduling APIs. With strict security, role-based access, and modular architecture, it is suitable for learning and deploying scalable, enterprise-grade banking applications.

> Developed with Jakarta EE 10, GlassFish 7, and MySQL. Deployed using EAR packaging for full modular separation.
```

---

