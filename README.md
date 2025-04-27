# OnlineBookstore Database Setup Script

This repository contains the SQL script to create and configure the `OnlineBookstore` database, complete with tables, relationships, and database settings for optimal performance.

## 📜 Overview

This script is designed to set up a comprehensive database for an online bookstore. The database includes essential entities such as authors, books, categories, customers, and orders, with relevant relationships to ensure efficient data management.

## 🛠 Features

- **Database Creation**: Creates the `OnlineBookstore` database with custom configurations for performance and data integrity.
- **Tables**: Includes tables for authors, books, categories, customers, orders, and order items.
- **Foreign Keys**: Enforces referential integrity with foreign key constraints between tables.
- **Optimized Settings**: Configures the database with advanced settings for performance, full-text indexing, and query optimization.

## 📝 Database Structure

### Tables

- **Author**
  - `author_id` (Primary Key)
  - `name`

- **Book**
  - `book_id` (Primary Key)
  - `title`
  - `category_id` (Foreign Key to `Category`)

- **Category**
  - `category_id` (Primary Key)
  - `name`

- **Customer**
  - `customer_id` (Primary Key)
  - `name`
  - `email` (Unique)

- **Order**
  - `order_id` (Primary Key)
  - `customer_id` (Foreign Key to `Customer`)
  - `order_date`

- **OrderItem**
  - `order_item_id` (Primary Key)
  - `order_id` (Foreign Key to `Order`)
  - `book_id` (Foreign Key to `Book`)
  - `quantity`
  - `price`

### Relationships

- Books are categorized by `Category`.
- Authors are linked to books through the `BookAuthor` table.
- Orders are linked to customers and contain multiple order items.
- Each order item corresponds to a book and includes quantity and price.

## ⚙️ Database Configuration

- **Compatibility Level**: Set to 160 (SQL Server 2019).
- **Full-Text Indexing**: Enabled if supported.
- **Query Store**: Enabled for query performance tracking and optimization.
- **Recovery Model**: Full recovery for data safety.
- **Isolation Level**: Multi-user access with snapshot isolation disabled for consistency.

## 🚀 Running the Script

1. Open SQL Server Management Studio (SSMS).
2. Connect to your SQL Server instance.
3. Paste the entire script into a new query window.
4. Execute the script to create the `OnlineBookstore` database.

## ⚠️ Notes

- Ensure that you have appropriate permissions to create databases and tables.
- Modify the file paths for the database files (`.mdf` and `.ldf`) if needed, depending on your SQL Server instance configuration.


Feel free to fork, clone, or contribute to this repository! If you have any questions or suggestions, please open an issue or pull request.
