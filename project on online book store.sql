SELECT TOP (1000) [Book_ID]
      ,[Title]
      ,[Author]
      ,[Genre]
      ,[Published_Year]
      ,[Price]
      ,[Stock]
  FROM [project].[dbo].[Books csv]



  USE [project]
GO

SELECT [Order_ID]
      ,[Customer_ID]
      ,[Book_ID]
      ,[Order_Date]
      ,[Quantity]
      ,[Total_Amount]
  FROM [dbo].[Orders]


  GO


SELECT [Customer_ID]
      ,[Name]
      ,[Email]
      ,[Phone]
      ,[City]
      ,[Country]
  FROM [dbo].[Customers]

GO






  -- Q1 Retrieve all books in Fiction genre.--
  SELECT*FROM [Books csv]
  WHERE Genre='Fiction';

  --Q2  find the books published after year 1950.--
  SELECT * FROM [Books csv]
  WHERE Published_Year>1950;

  --Q3 list all the customer from the canada.
  SELECT*FROM [Customers]
  WHERE Country='canada';
  
  --Q4 show the order placed in november 2023.
  SELECT*FROM [Orders]
  WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

  --Q5 RETRIVE total stock of book available.
  SELECT SUM(Stock) as total_stock
  FROM [Books csv];

  --Q6 FIND THE details of most expensive book.
  SELECT MAX(Price) as most_expensive_book
  FROM  [Books csv];

  --Q7 Select all customer who ordered more than 1 quantity of book.
  SELECT*FROM [Orders]
  WHERE Quantity>'1';

  --Q8 list the all Genres availables in book table.
  SELECT DISTINCT Genre FROM  [Books csv];

  --Q9 find the books with books with lowest stock.
  SELECT*FROM [Books csv] ORDER BY Stock;
 
 --Q9 calculate total revenue generated from all orders.
 SELECT SUM(Total_Amount) as total_revenue
 FROM [Orders];

 --ADVANCE QUERRY--

-- Q-1- Retrieve the total number of books sold for each genre--
SELECT b.Genre,SUM(o.quantity) as total_book_sold
FROM Orders o
JOIN
[Books csv] b ON b.Book_ID=o.Book_ID
GROUP BY Genre;

--Q2-- Find the average price of books in the "Fantasy" genre
SELECT AVG(Price) FROM [Books csv]
WHERE Genre='Fantasy';

--Q3--List customers who have placed at least 2 orders
SELECT customer_id,count(order_id) as orders_count
from [Orders]
group by Customer_ID
having COUNT(Order_ID)>=2;

--Q4--List customers who have placed at least 2 orders with customer name
SELECT c.Name,o.customer_id,count(o.order_id) as orders_count
from [Orders] o
JOIN [Customers] c on  c.customer_id=o.customer_id
group by o.Customer_ID,c.Name
having COUNT(Order_ID)>=2;

--Q5-- Find the most frequently ordered book
SELECT book_id,count(order_id) as orderd_book 
from [Orders]
group by book_id
order by count(order_id) desc;

--Q6-- Find the most frequently ordered book and book name
SELECT b.Title, o.book_id,COUNT(o.order_id) as order_book
FROM [Orders] o
join
[Books csv] b ON o.Book_ID=b.Book_ID
Group by o.book_id,b.Title
order by COUNT(o.order_id) desc;

--Q7-- Show the top 3 most expensive books of 'Fantasy' Genre

SELECT Genre,Price FROM [Books csv]
WHERE Genre='Fantasy'
order by Price desc;

--Q8-- Retrieve the total quantity of books sold by each author
SELECT b.Author,SUM(o.quantity) as total_book_sold
FROM [Orders] o
JOIN
[Books csv] b ON b.book_id=o.book_id
Group by b.Author;

--Q9-- List the cities where customers who spent over $30 are located
SELECT DISTINCT(c.City),c.Name,o.total_amount  
from [Orders] o
join
[Customers] c ON o.Customer_ID=c.Customer_ID
WHERE Total_Amount>30;

--Q10-- Find the customer who spent the most on orders
 SELECT c.customer_id,c.Name,SUM(o.total_amount) as total_spent
 FROM [Orders] o
 join
 [Customers] c ON o.Customer_ID=c.Customer_ID
 GROUP by c.customer_id,C.Name 
 order by total_spent DESC;

 --Q11--Calculate the stock remaining after fulfilling all orders
 SELECT b.book_id,b.Title,b.stock,COALESCE(SUM(o.quantity),0) as order_quantity,
 b.stock-COALESCE(SUM(o.quantity) as remaining_order 
 FROM [Books csv] b
 left join
 [Orders] o ON b.Book_ID=o.Book_ID
 Group by  b.Book_ID;
 

