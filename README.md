# 🍽 Smart Canteen Management System (Java Full Stack)

Smart Canteen is a Java Full Stack web application designed to digitalize the traditional canteen ordering process.  
It allows students to register, login, view menu items, and place food orders online, while admins can manage menu items and monitor orders through an admin dashboard.

This project is built using **JSP, Servlets, JDBC, MySQL, and Apache Tomcat** following a simple MVC architecture.

---

## 🚀 Key Features

### 👨‍🎓 Student Module
- Student Registration & Login (Roll Number included)
- View Menu Items with Price and Availability
- Place Orders Online
- Cancel Orders (only before admin accepts)
- View Order History

### 👨‍💼 Admin Module
- Admin Login
- View All Orders (Pending / Accepted / Delivered)
- Accept / Reject / Deliver Orders
- Add / Update / Delete Menu Items
- View Daily Sales Report
- Item-wise Quantity & Revenue Report

---

## 🛠 Technologies Used
- **Frontend:** HTML, CSS, JSP
- **Backend:** Java, Servlets, JDBC
- **Database:** MySQL
- **Server:** Apache Tomcat 9
- **Tools:** Eclipse / VS Code, MySQL Workbench, GitHub

---

## 🗃 Database Tables
- `users` (student/admin accounts with roll number)
- `menu_items` (canteen food items)
- `orders` (order details and status)
- `order_items` (items inside each order)

---

## 🔥 CRUD Operations Implemented
- **Create:** Register users, add menu items, place orders
- **Read:** Display menu, view orders, view reports
- **Update:** Update order status, update menu items, cancel orders
- **Delete:** Delete menu items

---

## 📌 Project Highlights
- Role-based access control (Student/Admin)
- Session management for secure login
- Daily report feature for admin dashboard
- Unique constraint for menu item names to avoid duplicates
- User-friendly UI for better ordering experience

---

## ⚙ How to Run the Project
1. Install **MySQL** and create database.
2. Import the SQL tables.
3. Configure DB credentials in `DBConnection.java`
4. Add MySQL Connector JAR inside `WEB-INF/lib`
5. Run the project on **Apache Tomcat 9**
6. Open browser:
