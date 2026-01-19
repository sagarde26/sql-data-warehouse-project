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
*/


-- script to load crm csv files into the bronze table



create or alter procedure bronze.load_bronze as
begin
	declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
	begin try

		set @batch_start_time = getdate();
		print'==================================================';
		print 'Loading bronze layer';
		print'==================================================';


		print '-------------------------------------------------';
		print 'loading CRM tables';
		print '-------------------------------------------------';


		set @start_time = getdate();
		PRINT ' >> Truncating Table: bronze.crm_cust_info';
		truncate table bronze.crm_cust_info; 
		PRINT ' >> Inserting data into: bronze.crm_cust_info';
		bulk insert bronze.crm_cust_info
		from 'C:\Users\vemul\OneDrive\Desktop\COURSES\SQL\DWH PROJECT\mine\datasets\crm\cust_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',' ,
			tablock
			);
		set @end_time = getdate();
		print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		print '>> -------------';


		set @start_time = getdate();
		PRINT ' >> Truncating Table: bronze.crm_prd_info';
		truncate table bronze.crm_prd_info;
		PRINT ' >> Inserting data into: bronze.crm_cust_info';
		bulk insert bronze.crm_prd_info
		from 'C:\Users\vemul\OneDrive\Desktop\COURSES\SQL\DWH PROJECT\mine\datasets\crm\prd_info.csv'
		with (
				firstrow = 2,
				fieldterminator = ',' ,
				tablock
			);
		set @end_time = getdate();
		print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		print '>> -------------';



		set @start_time = getdate();
		PRINT ' >> Truncating Table: bronze.crm_sales-details';
		truncate table bronze.crm_sales_details;
		PRINT ' >> Inserting data into: bronze.crm_sales_details';
		bulk insert bronze.crm_sales_details
		from 'C:\Users\vemul\OneDrive\Desktop\COURSES\SQL\DWH PROJECT\mine\datasets\crm\sales_details.csv'
		with (
			firstrow = 2,
			fieldterminator = ',' ,
			tablock
			);
		set @end_time = getdate();
		print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		print '>> -------------';


		print '-------------------------------------------------';
		print 'loading ERP tables';
		print '-------------------------------------------------';


		set @start_time = getdate();
		PRINT ' >> Truncating Table: bronze.erp_cust_az12';
		truncate table bronze.erp_cust_az12;
		PRINT ' >> Inserting data into: bronze.erp_cust_az12';
		bulk insert bronze.erp_cust_az12 
		from 'C:\Users\vemul\OneDrive\Desktop\COURSES\SQL\DWH PROJECT\mine\datasets\erp\CUST_AZ12.csv'
		with (
			firstrow = 2,
			fieldterminator =',' ,
			tablock
			);
		set @end_time = getdate();
		print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		print '>> -------------';


		
		set @start_time = getdate();
		PRINT ' >> Truncating Table: bronze.erp_loc_a101';
		truncate table bronze.erp_loc_a101;
		PRINT ' >> Inserting data into: bronze.erp_loc_a101';
		bulk insert bronze.erp_loc_a101 
		from 'C:\Users\vemul\OneDrive\Desktop\COURSES\SQL\DWH PROJECT\mine\datasets\erp\LOC_A101.csv'
		with (
			firstrow = 2,
			fieldterminator =',' ,
			tablock
			);
		set @end_time = getdate();
		print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		print '>> -------------';



		set @start_time = getdate();
		PRINT ' >> Truncating Table: bronze.erp_px_cat_g1v2';
		truncate table bronze.erp_px_cat_g1v2;
		PRINT ' >> Inserting data into: bronze.erp_px_cat_g1v2';
		bulk insert bronze.erp_px_cat_g1v2 
		from 'C:\Users\vemul\OneDrive\Desktop\COURSES\SQL\DWH PROJECT\mine\datasets\erp\PX_CAT_G1V2.csv'
		with (
			firstrow = 2,
			fieldterminator =',' ,
			tablock
			);
		set @end_time = getdate();
		print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		print '>> -------------';

		
		set @batch_end_time = getdate();
		print '=============================';
		print ' Loading bronze layer is completed';
		print '--Entire batch Load Duration: ' + cast(datediff(second, @batch_start_time, @batch_end_time) as nvarchar) + 'seconds';
		print '=============================';
			

	end try

	 
	begin catch
		print '=============================================';
		print 'error occured during bronze layer';
		print 'Error Message' + error_message();
		print 'error Message' + cast(error_number() as nvarchar);
		print 'error Message' + cast(error_state() as nvarchar);
		print '=============================================';
	end catch
end



execute bronze.load_bronze
