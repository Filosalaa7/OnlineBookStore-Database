# OnlineBookstore Database Setup Script

This repository contains the SQL script to create and configure the `OnlineBookstore` database, complete with tables, relationships, indexes, and database settings for optimal performance.

## 📜 Overview

This script is designed to set up a comprehensive database for an online bookstore. The database includes essential entities such as authors, books, categories, customers, and orders, with relevant relationships and indexing strategies to ensure efficient data management and fast query execution.

## 🛠 Features

- **Database Creation**: Creates the `OnlineBookstore` database with custom configurations for performance and data integrity.
- **Tables**: Includes tables for authors, books, categories, customers, orders, and order items.
- **Foreign Keys**: Enforces referential integrity with foreign key constraints between tables.
- **Indexes**: Adds non-clustered indexes on frequently queried fields and foreign keys for improved query performance.
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

- **BookAuthor**
  - `book_id`, `author_id` (Composite Primary Key)

### Relationships

- Books are categorized by `Category`.
- Authors are linked to books through the `BookAuthor` table.
- Orders are linked to customers and contain multiple order items.
- Each order item corresponds to a book and includes quantity and price.

## 📈 Indexing Strategy

To ensure high performance and scalability, the script includes **non-clustered indexes** on frequently queried columns and foreign keys, such as:

- `Customer.name`, `Customer.email`
- `Author.name`
- `Book.title`, `Book.category_id`
- `BookAuthor.author_id`
- `Order.customer_id`
- `OrderItem.order_id`, `OrderItem.book_id`

These indexes speed up join operations, filtering, and lookups for typical query patterns in e-commerce systems.

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
