-- Exercise 1
CREATE PARTITION FUNCTION myRangePF1 (datetime)
	AS RANGE RIGHT FOR VALUES (
		'2013-07-01', '2013-08-01', '2013-09-01', '2013-10-01', 
		'2013-11-01', '2013-12-01', '2014-01-01', '2014-02-01', 
		'2014-03-01','2014-04-01', '2014-05-01', '2014-06-01', 
		'2014-07-01');
GO

CREATE PARTITION SCHEME myRangePS1
	AS PARTITION myRangePF1
	ALL TO ('PRIMARY');
GO

CREATE TABLE order_part (
	order_id INT NOT NULL,
	order_date DATETIME NOT NULL, 
	order_customer_id INT NOT NULL, 
	order_status VARCHAR(16) NOT NULL
) ON myRangePS1 (order_date);
GO

--Exercise 2
INSERT INTO order_part
SELECT * FROM orders;

SELECT COUNT(*) FROM order_part;
GO

SELECT SCHEMA_NAME(t.schema_id) AS SchemaName, t.name AS TableName, i.name AS IndexName, 
    p.partition_number, p.partition_id, i.data_space_id, f.function_id, f.type_desc, 
    r.boundary_id, r.value AS BoundaryValue   
FROM sys.tables AS t  
JOIN sys.indexes AS i  
    ON t.object_id = i.object_id  
JOIN sys.partitions AS p  
    ON i.object_id = p.object_id AND i.index_id = p.index_id   
JOIN  sys.partition_schemes AS s   
    ON i.data_space_id = s.data_space_id  
JOIN sys.partition_functions AS f   
    ON s.function_id = f.function_id  
LEFT JOIN sys.partition_range_values AS r   
    ON f.function_id = r.function_id and r.boundary_id = p.partition_number  
WHERE 
    t.name = 'order_part' 
    AND i.type <= 1  
ORDER BY SchemaName, t.name, i.name, p.partition_number;  
GO
