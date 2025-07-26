/*

This script create a new database named DataWarehouse. Additionally, it will create 3 schemas: Bronze, Silver and Gold.

*/

use master;
GO

create database DataWarehouse;
GO

use DataWarehouse;
GO

create schema bronze;
GO
create schema silver;
GO
create schema gold;
GO
