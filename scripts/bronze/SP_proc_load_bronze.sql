/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================

Code For Dynamic File_Path

DECLARE @filepate AS VARCHAR(MAX) = 'C:\Users\SAM HP\Desktop\KHI AI backup (till 04-Oct-24)\SAM Personal Projects\SQL Data Warehouse from Scratch  Full Hands-On Data Engineering Project (Data with Baraa)\sql-data-warehouse-project\datasets\source_crm\';
DECLARE @sql AS NVARCHAR(MAX);

SET @sql = N'
BULK INSERT bronze.crm_prd_info
FROM ''' + @filepate + 'prd_info.csv'' 
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = '','',
    TABLOCK
);';

EXEC sp_executesql @sql;
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
		
	/* 1) add TRY CATCH, Ensure error handling, data integrity, and issues logging for easier debugging */
	/* 2) SQL runs the TRY Block, and if it fails, it run the CATCH Block to handle errors */
	
	
	------------------------------------------- TRY BLOCK -------------------------------------------
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '================================================';

		PRINT '------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info -- getting insert data whole data into the table from file located on system.
		FROM 'C:\Users\SAM HP\Desktop\KHI AI backup (till 04-Oct-24)\SAM Personal Projects\SQL Data Warehouse from Scratch  Full Hands-On Data Engineering Project (Data with Baraa)\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH ( -- need to provide some configuration here,
			FIRSTROW = 2, -- 1st row is heading in the file, we need to data retrive data from 2nd row
			FIELDTERMINATOR = ',', -- our values int the file is seperated by delimeter ','
			TABLOCK -- TABLOCK. Specifies that the acquired lock is applied at the table level. The type of lock that is acquired depends on the statement being executed. For example, a SELECT statement might acquire a shared lock. By specifying TABLOCK , the shared lock is applied to the entire table instead of at the row or page level.
		);
		
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

        SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM  'C:\Users\SAM HP\Desktop\KHI AI backup (till 04-Oct-24)\SAM Personal Projects\SQL Data Warehouse from Scratch  Full Hands-On Data Engineering Project (Data with Baraa)\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

        SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\SAM HP\Desktop\KHI AI backup (till 04-Oct-24)\SAM Personal Projects\SQL Data Warehouse from Scratch  Full Hands-On Data Engineering Project (Data with Baraa)\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

		PRINT '------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '------------------------------------------------';
		
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\SAM HP\Desktop\KHI AI backup (till 04-Oct-24)\SAM Personal Projects\SQL Data Warehouse from Scratch  Full Hands-On Data Engineering Project (Data with Baraa)\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\SAM HP\Desktop\KHI AI backup (till 04-Oct-24)\SAM Personal Projects\SQL Data Warehouse from Scratch  Full Hands-On Data Engineering Project (Data with Baraa)\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\SAM HP\Desktop\KHI AI backup (till 04-Oct-24)\SAM Personal Projects\SQL Data Warehouse from Scratch  Full Hands-On Data Engineering Project (Data with Baraa)\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

		SET @batch_end_time = GETDATE();
		PRINT '=========================================='
		PRINT 'Loading Bronze Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='
	END TRY	

	------------------------------------------- Catch Block -------------------------------------------
	BEGIN CATCH 
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();  --Will print error if we have any error in the ETL (above TRY BLOCK)
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH
END


-- TO run Store_Procedure and checkout data --
EXEC bronze.load_bronze
-- CRM TABLES
select count(*) from bronze.crm_cust_info;
select count(*) from bronze.crm_prd_info;
select count(*) from bronze.crm_sales_details;
-- ERP TABLES
select count(*) from bronze.erp_cust_az12;
select count(*) from bronze.erp_loc_a101;
select count(*) from bronze.erp_px_cat_g1v2;
