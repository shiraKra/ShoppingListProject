CREATE TABLE Statuses (
    StatusId INT PRIMARY KEY IDENTITY(1,1), 
    StatusName NVARCHAR(50) NOT NULL      
);
CREATE TABLE Categories (
    CategoryId INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(50) NOT NULL        
);
CREATE TABLE ShoppingItems (
    Id INT PRIMARY KEY IDENTITY(1,1),          
    ItemName NVARCHAR(100) NOT NULL,           
    ItemDescription NVARCHAR(MAX),             
    StatusId INT NOT NULL,                     
    CategoryId INT NOT NULL,                   
    CreatedAt DATETIME DEFAULT GETDATE(),      

    CONSTRAINT FK_ItemStatus FOREIGN KEY (StatusId) REFERENCES Statuses(StatusId),
    CONSTRAINT FK_ItemCategory FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId)
);
INSERT INTO Statuses (StatusName) VALUES (N'טרם נקנה'), (N'בעגלה'), (N'בוצע');


INSERT INTO Categories (CategoryName) VALUES (N'מוצרי חלב'), (N'פירות וירקות'), (N'ניקיון');

USE ShoppingListDB;
GO

-----------------------------------------------------------
-- 1. פרוצדורה ליצירת מוצר חדש (Create)
-----------------------------------------------------------
CREATE PROCEDURE sp_AddItem
    @ItemName NVARCHAR(100),
    @ItemDescription NVARCHAR(MAX),
    @CategoryId INT,
    @StatusId INT = 1 -- ברירת מחדל: טרם נקנה
AS
BEGIN
    INSERT INTO ShoppingItems (ItemName, ItemDescription, CategoryId, StatusId, CreatedAt)
    VALUES (@ItemName, @ItemDescription, @CategoryId, @StatusId, GETDATE());
    
    SELECT SCOPE_IDENTITY() AS NewItemId; -- מחזיר ל-API את המזהה החדש
END
GO

-----------------------------------------------------------
-- 2. פרוצדורה לשליפת כל הרשימה (Read All)
-- כוללת JOIN כדי להציג שמות ולא רק מספרי ID
-----------------------------------------------------------
CREATE PROCEDURE sp_GetAllItems
AS
BEGIN
    SELECT 
        I.Id, 
        I.ItemName, 
        I.ItemDescription, 
        C.CategoryName, 
        S.StatusName, 
        I.CreatedAt
    FROM ShoppingItems I
    JOIN Categories C ON I.CategoryId = C.CategoryId
    JOIN Statuses S ON I.StatusId = S.StatusId
    ORDER BY I.CreatedAt DESC;
END
GO

-----------------------------------------------------------
-- 3. פרוצדורה לשליפת מוצר בודד לפי ID (Read One)
-----------------------------------------------------------
CREATE PROCEDURE sp_GetItemById
    @Id INT
AS
BEGIN
    SELECT * FROM ShoppingItems WHERE Id = @Id;
END
GO

-----------------------------------------------------------
-- 4. פרוצדורה לעדכון מוצר קיים (Update)
-----------------------------------------------------------
CREATE PROCEDURE sp_UpdateItem
    @Id INT,
    @ItemName NVARCHAR(100),
    @ItemDescription NVARCHAR(MAX),
    @StatusId INT,
    @CategoryId INT
AS
BEGIN
    UPDATE ShoppingItems
    SET ItemName = @ItemName,
        ItemDescription = @ItemDescription,
        StatusId = @StatusId,
        CategoryId = @CategoryId
    WHERE Id = @Id;
END
GO

-----------------------------------------------------------
-- 5. פרוצדורה לחיפוש מוצר לפי שם (Search)
-----------------------------------------------------------
CREATE PROCEDURE sp_SearchItems
    @SearchTerm NVARCHAR(100)
AS
BEGIN
    SELECT * FROM ShoppingItems 
    WHERE ItemName LIKE '%' + @SearchTerm + '%';
END
GO