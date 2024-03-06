/****** Script for SelectTopNRows command from SSMS  ******/
SELECT*
  FROM [Project].[dbo].[Sheet1$]

--Standardizing the data & updating the table--
SELECT SaleDate,
convert(DATE,SaleDate)as New_Date
from Sheet1$

Alter Table Sheet1$
add New_Date Date 

Update Sheet1$
SET New_Date=convert(DATE,SaleDate)

Alter Table Sheet1$
DROP column SaleDate 

SELECT*
  FROM [Project].[dbo].[Sheet1$]

--filling up empty space in property address column--
 SELECT*
 from Sheet1$ as A inner join Sheet1$ as B
 on a.ParcelID=b.ParcelID 
 and a.[UniqueID ] <> b.[UniqueID ]

 --selecting only the address column--
 SELECT a.ParcelID,b.ParcelID,a.PropertyAddress,b.PropertyAddress
 from Sheet1$ as A inner join Sheet1$ as B
 on a.ParcelID=b.ParcelID 
 and a.[UniqueID ] <> b.[UniqueID ]
 where a.PropertyAddress is null

 --filling up the NULL tA propertiy addrress with data from B property address--
  SELECT a.ParcelID,b.ParcelID,a.PropertyAddress,b.PropertyAddress,
  ISNULL(A.PropertyAddress,B.PropertyAddress)
 from Sheet1$ as A inner join Sheet1$ as B
 on a.ParcelID=b.ParcelID 
 and a.[UniqueID ] <> b.[UniqueID ]
 where a.PropertyAddress is null

-- Updating the table--
Update A 
set PropertyAddress=ISNULL(A.PropertyAddress,B.PropertyAddress)
from Sheet1$ as A inner join Sheet1$ as B
 on a.ParcelID=b.ParcelID 
 and a.[UniqueID ] <> b.[UniqueID ]
 where a.PropertyAddress is null

 --splitting of property address--
 SELECT PropertyAddress,
 SUBSTRING(PropertyAddress,1,(charindex(',',PropertyAddress))-1) as Street_Address,
 SUBSTRING(PropertyAddress,(charindex(',',PropertyAddress)+1),len(PropertyAddress)) as City
  FROM [Project].[dbo].[Sheet1$]

 ALTER tABLE sheet1$
  add Street_Address nvarchar(250)
ALTER tABLE sheet1$
  add City nvarchar(250)

 Update Sheet1$
 Set Street_Address=SUBSTRING(PropertyAddress,1,(charindex(',',PropertyAddress))-1) 
 update Sheet1$
 set City=SUBSTRING(PropertyAddress,(charindex(',',PropertyAddress)+1),len(PropertyAddress)) 

 --Splitting OwnerAddress into City,Street and State--
 SELECT OwnerAddress,
 --Replace(OwnerAddress,',','.')--
PARSENAME(Replace(OwnerAddress,',','.'),3) as OwnerStreet,
PARSENAME(Replace(OwnerAddress,',','.'),2)as OwnerCity,
PARSENAME(Replace(OwnerAddress,',','.'),1) as OwnerState
  FROM [Project].[dbo].[Sheet1$]

  Alter Table Sheet1$
  Add OwnerState nvarchar(250)

  Alter Table Sheet1$
  Add OwnerCity nvarchar(250)

  Alter Table Sheet1$
  Add OwnerStreet nvarchar(250)

Update Sheet1$
set OwnerStreet=PARSENAME(Replace(OwnerAddress,',','.'),3) 

Update Sheet1$
set OwnerCity=PARSENAME(Replace(OwnerAddress,',','.'),2) 

Update Sheet1$
set OwnerState=PARSENAME(Replace(OwnerAddress,',','.'),1) 

--Replacing Y & N with Yes & No From SoldAsVacant column--
 select distinct SoldAsVacant
 FROM Sheet1$

 select SoldAsVacant,
 case
 when SoldAsVacant='Y' then 'Yes'
 when SoldAsVacant='N' then 'No'
 else SoldAsVacant
 end 
 from Sheet1$

  Update Sheet1$
Set SoldAsVacant=case
when SoldAsVacant='Y' then 'Yes'
when SoldAsVacant='N' then 'No'
else SoldAsVacant
end 

 SELECT*
 FROM Sheet1$

--taking out duplicate--
with duplicate as (SELECT*,ROW_NUMBER()OVER (Partition by ParcelID,
 PropertyAddress,SalePrice,LegalReference,
 OwnerName,OwnerAddress,New_Date,Street_Address 
 Order by UniqueID)as RowNumber
 FROM Sheet1$)
Delete from duplicate 
Where RowNumber > 1

SELECT * from Sheet1$

--Dropping Unused or Unimportant Column--
Alter table Sheet1$
Drop column PropertyAddress,OwnerAddress,TaxDistrict






