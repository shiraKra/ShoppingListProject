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
INSERT INTO Statuses (StatusName) VALUES (N'èøí ð÷ðä'), (N'áòâìä'), (N'áåöò');


INSERT INTO Categories (CategoryName) VALUES (N'îåöøé çìá'), (N'ôéøåú åéø÷åú'), (N'ðé÷éåï');

USE ShoppingListDB;
GO

-----------------------------------------------------------
-- 1. ôøåöãåøä ìéöéøú îåöø çãù (Create)
-----------------------------------------------------------
CREATE PROCEDURE sp_AddItem
    @ItemName NVARCHAR(100),
    @ItemDescription NVARCHAR(MAX),
    @CategoryId INT,
    @StatusId INT = 1 -- áøéøú îçãì: èøí ð÷ðä
AS
BEGIN
    INSERT INTO ShoppingItems (ItemName, ItemDescription, CategoryId, StatusId, CreatedAt)
    VALUES (@ItemName, @ItemDescription, @CategoryId, @StatusId, GETDATE());
    
    SELECT SCOPE_IDENTITY() AS NewItemId; -- îçæéø ì-API àú äîæää äçãù
END
GO

-----------------------------------------------------------
-- 2. ôøåöãåøä ìùìéôú ëì äøùéîä (Read All)
-- ëåììú JOIN ëãé ìäöéâ ùîåú åìà ø÷ îñôøé ID
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
-- 3. ôøåöãåøä ìùìéôú îåöø áåãã ìôé ID (Read One)
-----------------------------------------------------------
CREATE PROCEDURE sp_GetItemById
    @Id INT
AS
BEGIN
    SELECT * FROM ShoppingItems WHERE Id = @Id;
END
GO

-----------------------------------------------------------
-- 4. ôøåöãåøä ìòãëåï îåöø ÷ééí (Update)
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
-- 5. ôøåöãåøä ìçéôåù îåöø ìôé ùí (Search)
-----------------------------------------------------------
CREATE PROCEDURE sp_SearchItems
    @SearchTerm NVARCHAR(100)
AS
BEGIN
    SELECT * FROM ShoppingItems 
    WHERE ItemName LIKE '%' + @SearchTerm + '%';
END
GO
