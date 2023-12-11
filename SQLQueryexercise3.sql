use exercise3
-- Create the Products table
CREATE TABLE Products (
    PID INT PRIMARY KEY IDENTITY(1,1), 
    PQ INT,
    PPrice DECIMAL(10,2),
    DiscountPercent DECIMAL(5,2),
    ManufacturingDate DATE
)
-- Enable IDENTITY_INSERT for the Products table
SET IDENTITY_INSERT Products ON;

-- Insert records with specified PID values
INSERT INTO Products (PID, PQ, PPrice, DiscountPercent, ManufacturingDate)
VALUES 
    (1, 10, 50.0, 10, '2022-01-01'),
    (2, 20, 100.0, 15, '2022-02-15'),
    (3, 5, 30.0, 5, '2022-03-10'),
    (4,  15, 75.0, 12, '2022-04-20'),
    (5,  8, 40.0, 8, '2022-05-05')

-- Disable IDENTITY_INSERT for the Products table
SET IDENTITY_INSERT Products OFF;

select * from Products

-- Function to calculate discounted value
CREATE FUNCTION CalculateDiscountedValue (@price DECIMAL(10,2), @discountPercent DECIMAL(5,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @discountedPrice DECIMAL(10,2);
    SET @discountedPrice = @price - (@price * @discountPercent / 100)
    RETURN @discountedPrice
END

-- Function to display product details
CREATE PROCEDURE DisplayProductDetails
AS
BEGIN
    SELECT PID, PPrice AS Price, DiscountPercent AS Discount, dbo.CalculateDiscountedValue(PPrice, DiscountPercent) AS PriceAfterDiscount
    FROM Products
END
-- Execute the procedure to display product details
EXEC DisplayProductDetails
