# Data Cleaning SQL

## About the Project

The main focus of the project is to clean the dataset using SQL. The project contains dataset that has 19 columns withs 2 identifiers and
other information included in the datset include price, no of bedroom and bathroom. 

### Data Source.
The primary dataset used for this project is the "Nashville Housing Data".

### Tool
- SQL

### Data Cleaning/Preparation.

In the data cleaning phase, i performed the following task;
- standardizing the data & updating the table.
- filling up empty space in property address column.
- selecting only the address column.
- filling up the NULL table A property addrress with data from B property address.
- updating the table.
- splitting of property address.
- splitting OwnerAddress into City,Street and State.
- replacing Y & N with Yes & No From SoldAsVacant column.
- taking out duplicate.
- dropping Unused or Unimportant Column.

### SQL Code

`SELECT SaleDate,
convert(DATE,SaleDate)as New_Date
from Sheet1$`

### Reference.
[AlexTheAnalyst](



