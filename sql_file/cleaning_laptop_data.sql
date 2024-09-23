use campusx;

select * from laptops;

Alter table laptops change `Unnamed: 0` `Index` INT;

create table laptops_backup like laptops;

insert into laptops_backup
select * from laptops;

SELECT * FROM laptops
WHERE Company IS NULL AND TypeName IS NULL AND Inches IS NULL
AND ScreenResolution IS NULL AND Cpu IS NULL AND Ram IS NULL
AND Memory IS NULL AND Gpu IS NULL AND OpSys IS NULL AND
WEIGHT IS NULL AND Price IS NULL;

alter table laptops modify column Inches Decimal(10,1);

select * from laptops;

with TempLaptops AS (
	select `index`, REPLACE(Ram, 'GB', '') as NewRam
    from laptops
)

update laptops l1 
join TempLaptops t on l1.`index` = t.`index`
set l1.Ram = t.NewRam;            

Alter table laptops modify column Ram Integer;

WITH TempLaptops AS (
    SELECT `index`, REPLACE(Weight, 'kg', '') AS NewWeight
    FROM laptops
)
UPDATE laptops l1
JOIN TempLaptops t ON l1.`index` = t.`index`
SET l1.Weight = t.NewWeight;

create TEMPORARY TABLE TempLaptops AS
select `index`, ROUND(Price) AS RoundedPrice
from laptops;

update laptops l1
join TempLaptops t on l1.`index` = t.`index`
set l1.price = t.RoundedPrice;

DROP TEMPORARY TABLE TempLaptops;

select * from laptops;

alter table laptops modify column Price Integer;


SELECT DATA_LENGTH/1024 FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'campusx'
AND TABLE_NAME = 'laptops';

select Distinct(OpSys) from laptops;

select OpSys,
CASE
	when OpSys like '%mac%' THEN 'macos'
    when OpSys like 'windows%' then 'windows'
    when OpSys like '%linux%' then 'linux'
    when OpSys = 'No OS' then 'N/A'
    else 'other'
end as 'os_brand'
from laptops;

UPDATE laptops
set OpSys = CASE
	when OpSys like '%mac%' THEN 'macos'
    when OpSys like 'windows%' then 'windows'
    when OpSys like '%linux%' then 'linux'
    when OpSys = 'No OS' then 'N/A'
    else 'other'
END;

select * from laptops;


alter table laptops 
ADD column gpu_brand varchar(255) AFTER Gpu,
add column gpu_name varchar(255) after gpu_brand;

select * from laptops;

create temporary table TempLaptops as
select `index`, substring_index(Gpu,' ', 1) as GpuBrand
from laptops;

select * from TempLaptops;

drop temporary table TempLaptops;

update laptops l1
join TempLaptops t on l1.`index` = t.`index`
set l1.gpu_brand = t.GpuBrand;

select * from laptops;

create temporary table TempLaptops as
select `index`, replace(Gpu,gpu_brand,'') as GpuName from laptops;

select * from TempLaptops;

Update laptops l1
join TempLaptops t on l1.`index` = t.`index`
set l1.gpu_name = t.GpuName;

select * from laptops;

drop temporary table TempLaptops;

alter table laptops drop column Gpu; 

select Cpu from laptops;

alter table laptops 
ADD column cpu_brand varchar(255) AFTER Cpu,
add column cpu_name varchar(255) after cpu_brand,
add column cpu_speed decimal(10,1) after cpu_name;

select * from laptops;

WITH TempLaptops AS (
    SELECT `index`, substring_index(Cpu, ' ', 1) AS CpuBrand
    FROM laptops
)
UPDATE laptops l1
JOIN TempLaptops t ON l1.`index` = t.`index`
SET l1.cpu_brand = t.CpuBrand;


select * from laptops;

ALTER TABLE laptops RENAME COLUMN cpu_name TO cpu_speed;
alter table laptops drop column cpu_name;

alter table laptops 
add column cpu_name varchar(255) after cpu_brand;

WITH TempLaptop AS (
    SELECT 
        `index`, 
        CAST(REPLACE(SUBSTRING_INDEX(Cpu, ' ', -1), 'GHz', '') 
        AS DECIMAL(10, 2)) AS CpuSpeed
    FROM laptops
)


UPDATE laptops l1
JOIN TempLaptop t ON l1.`index` = t.`index`
SET l1.cpu_speed = t.CpuSpeed;

With TempLaptops as (
	select 
		`index`,
		replace(replace(cpu,cpu_brand,''),substring_index(replace(cpu,cpu_brand,''),' ',-1),' ') as CpuName
    from laptops
    )
    
update laptops l1
join TempLaptops t on l1.`index`  = t.`index`
set l1.cpu_name = t.CpuName;
    
select * from laptops;

alter table laptops drop column Cpu;

alter table laptops 
ADD column resolution_width integer AFTER ScreenResolution,
ADD column resolution_height integer AFTER resolution_width;


select ScreenResolution,
substring_index(substring_index(ScreenResolution,' ',-1),'x',1),
substring_index(substring_index(ScreenResolution,' ',-1),'x',-1)
from laptops;

update laptops
set resolution_width = substring_index(substring_index(ScreenResolution,' ',-1),'x',1),
resolution_height = substring_index(substring_index(ScreenResolution,' ',-1),'x',-1);

select * from laptops;

alter table laptops drop column ScreenResolution;

alter table laptops
add column touchscreen integer after resolution_height;

update laptops
set touchscreen = screenresolution like '%Touch%';

select cpu_name,
substring_index(TRIM(cpu_name), ' ' , 2) 
from laptops;

update laptops
set cpu_name = substring_index(TRIM(cpu_name), ' ' , 2);

select distinct Memory from laptops;

alter table laptops
add column memory_type varchar(255) after memory,
add column primary_storage varchar(255) after memory_type,
add column secondary_storage varchar(255) after primary_storage;

select Memory,
CASE
	WHEN Memory LIKE '%SSD%' AND Memory LIKE '%HDD%' THEN 'Hybrid'
    WHEN Memory LIKE '%SSD' THEN 'SSD'
    WHEN Memory LIKE '%HDD%' THEN 'HDD'
    WHEN Memory LIKE '%Flash Storage%' THEN 'Flash Storage'
    WHEN Memory LIKE '%Hybrid%' THEN 'Hybrid'
    WHEN Memory LIKE '%Flash Storage%' AND Memory Like '%HDD%' THEN 'Hybrid'
    ELSE null
END AS 'memory_type'
from laptops;

Update laptops
set memory_type = CASE
	WHEN Memory LIKE '%SSD%' AND Memory LIKE '%HDD%' THEN 'Hybrid'
    WHEN Memory LIKE '%SSD' THEN 'SSD'
    WHEN Memory LIKE '%HDD%' THEN 'HDD'
    WHEN Memory LIKE '%Flash Storage%' THEN 'Flash Storage'
    WHEN Memory LIKE '%Hybrid%' THEN 'Hybrid'
    WHEN Memory LIKE '%Flash Storage%' AND Memory Like '%HDD%' THEN 'Hybrid'
    ELSE null
END;

select * from laptops;

select memory, memory_type,
regexp_substr(substring_index(Memory,'+',1),'[0-9]+'),
case when memory like '%+%' then regexp_substr(substring_index(Memory,'+',-1),'[0-9]+') else 0 end
from laptops;

update laptops
set primary_storage = regexp_substr(substring_index(Memory,'+',1),'[0-9]+'),
secondary_Storage = case when memory like '%+%' then regexp_substr(substring_index(Memory,'+',-1),'[0-9]+') else 0 end;

select primary_storage,
case when primary_storage <= 2 then primary_storage*1024 else primary_storage end,
secondary_storage,
case when secondary_storage <= 2 then secondary_storage*1024 else primary_storage end
from laptops;

update laptops
set 
primary_storage =  case when primary_storage <= 2 then primary_storage*1024 else primary_storage end,
secondary_storage = case when secondary_storage <= 2 then secondary_storage*1024 else primary_storage end;

select * from laptops;

alter table laptops
drop column Memory;

            

 