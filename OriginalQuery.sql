-- Create Customer table
CREATE TABLE Customer (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL
);
-- Index to speed up searches by name
CREATE NONCLUSTERED INDEX IX_Customer_Name ON Customer(name);

-- Create Category table
CREATE TABLE Category (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL
);
-- Optional: index on name if searching by category name
CREATE NONCLUSTERED INDEX IX_Category_Name ON Category(name);

-- Create Author table
CREATE TABLE Author (
    author_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL
);
-- Index for faster search by author name
CREATE NONCLUSTERED INDEX IX_Author_Name ON Author(name);

-- Create Book table
CREATE TABLE Book (
    book_id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(200) NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);
-- Indexes for joins and searches
CREATE NONCLUSTERED INDEX IX_Book_CategoryId ON Book(category_id);
CREATE NONCLUSTERED INDEX IX_Book_Title ON Book(title);

-- Create BookAuthor table (many-to-many between Book and Author)
CREATE TABLE BookAuthor (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id),
    FOREIGN KEY (author_id) REFERENCES Author(author_id)
);
-- Index for reverse lookup from author
CREATE NONCLUSTERED INDEX IX_BookAuthor_AuthorId ON BookAuthor(author_id);

-- Create Order table
CREATE TABLE [Order] (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);
-- Index for join on customer
CREATE NONCLUSTERED INDEX IX_Order_CustomerId ON [Order](customer_id);

-- Create OrderItem table
CREATE TABLE OrderItem (
    order_item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES [Order](order_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id)
);
-- Indexes to optimize joins
CREATE NONCLUSTERED INDEX IX_OrderItem_OrderId ON OrderItem(order_id);
CREATE NONCLUSTERED INDEX IX_OrderItem_BookId ON OrderItem(book_id);
