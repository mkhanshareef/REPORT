

insert into Reports select * from macepa_HRMS_REI.dbo.Reports where RepName='CTC MONTHLY'


select ROW_NUMBER()  OVER (ORDER BY  EMP_CODE) As SrNo, PAYDATE , EMP_CODE, EMP_NAME,ISNULL([ERN_BASIC],0)
  as BASIC, ISNULL([ERN_HRA],0) as HRA, ISNULL([ERN_CONV],0) as CONV,ISNULL([ERN_SPLALL],0) as SPLALL,ISNULL([GROSSPAY],0) as GROSS,ROUND(ISNULL(MEDRIM,0)/12,2) as MEDRIM,ROUND(ISNULL(TELRIM,0)/12,2) AS TELRIM,ROUND(ISNULL(DRVRIM,0)/12,0) AS DRVRIM,ROUND(ISNULL(LTARIM,0)/12,2) AS LTARIM,ROUND(ISNULL(NWSRIM,0)/12,2) AS [Books & Periodicals],ROUND(ISNULL(CARMNT,0)/12,2) AS Vehicle,ROUND((ISNULL(GROSSPAY,0)+ISNULL(MEDRIM,0)/12+ISNULL(TELRIM,0)/12+ISNULL(DRVRIM,0)/12+ISNULL(LTARIM,0)/12+ISNULL(NWSRIM,0)/12+ISNULL(CARMNT,0)/12),0) as CTC
from
(
SELECT HRDHISTQRY.PAYDATE, HRDHISTQRY.EMP_CODE,HRDHISTQRY.EMP_NAME, 
     field_name,
     field_value,RIMHISTQRY.MEDRIM,RIMHISTQRY.TELRIM,RIMHISTQRY.DRVRIM,RIMHISTQRY.LTARIM,RIMHISTQRY.NWSRIM,RIMHISTQRY.CARMNT
FROM HRDHISTQRY
LEFT OUTER JOIN HRDMASTQRY ON HRDHISTQRY.EMP_CODE = HRDMASTQRY.EMP_CODE 
LEFT OUTER JOIN PAYHIST    ON HRDHISTQRY.EMP_CODE = PAYHIST.EMP_CODE    AND HRDHISTQRY.PAYDATE = PAYHIST.PAYDATE
LEFT OUTER JOIN RIMHISTQRY ON HRDHISTQRY.EMP_CODE = RIMHISTQRY.EMP_CODE AND HRDHISTQRY.PAYDATE = RIMHISTQRY.PAYDATE
LEFT OUTER JOIN PAYMAST ON HRDHISTQRY.EMP_CODE = PAYMAST.EMP_CODE AND PAYMAST.FINYEAR=YEAR(HRDHISTQRY.PAYDATE )
WHERE PAYHIST.PAYDATE BETWEEN '2020-03-01' AND '2020-03-31'
   
) d
pivot
(
  max(field_value)
  for field_name in ([ERN_BASIC],[ERN_HRA],[ERN_CONV],[ERN_SPLALL],[ERN_SFTALL],[ERN_MED],[ERN_LTA],[ERN_OSALL],[CTC_ESI],[CTC_BONUS],[FOOD],[CTC_MEDCLM],[GROSSPAY],[CTC])
) piv






select * from Reports where RepName='CTC Monthly' and RepCode='001-115-010-058'

update Reports set  RepCode='001-115-004-010-083' , RepGroup='001-115-004-010' where RepName='CTC Monthly'

insert into Reports(RepCode,RepGroup,RepName,RepFilterOptional,RepFormula,RepFormat,RepFormatExp,QryType,Active)
values('001-115-010-050','001-115-010','CTC Monthly','HRDHISTQRY.EMP_CODE={@EMP_CODE};HRDHISTQRY.STATUS_CODE={@STATUS_CODE};HRDHISTQRY.DSG_CODE={@DSG_CODE};HRDHISTQRY.GRD_CODE={@GRD_CODE};HRDHISTQRY.TYPE_CODE={@TYPE_CODE};HRDHISTQRY.COMP_CODE={@COMP_CODE};HRDHISTQRY.REGN_CODE={@REGN_CODE};HRDHISTQRY.LOC_CODE={@LOC_CODE};HRDHISTQRY.DIVI_CODE={@DIVI_CODE};HRDHISTQRY.SECT_CODE={@SECT_CODE};HRDHISTQRY.DEPT_CODE={@DEPT_CODE};HRDHISTQRY.COST_CODE={@COST_CODE};HRDHISTQRY.PROC_CODE={@PROC_CODE};HRDHISTQRY.MNGR_CODE={@MNGR_CODE};HRDHISTQRY.RMOP_CODE={@RMOP_CODE};HRDHISTQRY.RMOP_CODE={@RMOP_CODE}','select ROW_NUMBER()  OVER (ORDER BY  EMP_CODE) As SrNo, PAYDATE , EMP_CODE, EMP_NAME,ISNULL([ERN_BASIC],0)
  as BASIC, ISNULL([ERN_HRA],0) as HRA, ISNULL([ERN_CONV],0) as CONV,ISNULL([ERN_SPLALL],0) as SPLALL,ISNULL([GROSSPAY],0) as GROSS,ROUND(ISNULL(MEDRIM,0)/12,2) as MEDRIM,ROUND(ISNULL(TELRIM,0)/12,0) AS TELRIM,ROUND(ISNULL(DRVRIM,0)/12,0) AS DRVRIM,ROUND(ISNULL(LTARIM,0)/12,0) AS LTARIM,ROUND(ISNULL(NWSRIM,0)/12,0) AS [Books & Periodicals],ROUND(ISNULL(CARMNT,0)/12,0) AS Vehicle,ROUND((ISNULL(GROSSPAY,0)+ISNULL(MEDRIM,0)/12+ISNULL(TELRIM,0)/12+ISNULL(DRVRIM,0)/12+ISNULL(LTARIM,0)/12+ISNULL(NWSRIM,0)/12+ISNULL(CARMNT,0)/12),0) as CTC
from
(
SELECT HRDHISTQRY.PAYDATE, HRDHISTQRY.EMP_CODE,HRDHISTQRY.EMP_NAME, 
     field_name,
     field_value,RIMHISTQRY.MEDRIM,RIMHISTQRY.TELRIM,RIMHISTQRY.DRVRIM,RIMHISTQRY.LTARIM,RIMHISTQRY.NWSRIM,RIMHISTQRY.CARMNT
FROM HRDHISTQRY
LEFT OUTER JOIN HRDMASTQRY ON HRDHISTQRY.EMP_CODE = HRDMASTQRY.EMP_CODE 
LEFT OUTER JOIN PAYHIST    ON HRDHISTQRY.EMP_CODE = PAYHIST.EMP_CODE    AND HRDHISTQRY.PAYDATE = PAYHIST.PAYDATE
LEFT OUTER JOIN RIMHISTQRY ON HRDHISTQRY.EMP_CODE = RIMHISTQRY.EMP_CODE AND HRDHISTQRY.PAYDATE = RIMHISTQRY.PAYDATE
LEFT OUTER JOIN PAYMAST ON HRDHISTQRY.EMP_CODE = PAYMAST.EMP_CODE AND PAYMAST.FINYEAR=YEAR(HRDHISTQRY.PAYDATE )
WHERE PAYHIST.PAYDATE BETWEEN {@FDATE} AND {@TDATE}
   
) d
pivot
(
  max(field_value)
  for field_name in ([ERN_BASIC],[ERN_HRA],[ERN_CONV],[ERN_SPLALL],[ERN_SFTALL],[ERN_MED],[ERN_LTA],[ERN_OSALL],[CTC_ESI],[CTC_BONUS],[FOOD],[CTC_MEDCLM],[GROSSPAY],[CTC])
) piv

UNION ALL

select ''0'', NULL , ''0'', ''Grand Total'',SUM(CONVERT(INT,ISNULL([ERN_BASIC],0)))
  as BASIC,SUM(CONVERT(INT,ISNULL([ERN_HRA],0))) AS HRA,SUM(CONVERT(INT,ISNULL([ERN_CONV],0))) AS CONV,SUM(CONVERT(INT,ISNULL([ERN_SPLALL],0))) AS SPLALL,SUM(CONVERT(INT,ISNULL([GROSSPAY],0))) AS GROSS,SUM(ROUND(ISNULL(MEDRIM,0)/12,0)) as MEDRIM,SUM(ROUND(ISNULL(TELRIM,0)/12,0)) AS TELRIM,SUM(ROUND(ISNULL(DRVRIM,0)/12,0)) AS DRVRIM,SUM(ROUND(ISNULL(LTARIM,0)/12,0)) AS LTARIM,SUM(ROUND(ISNULL(NWSRIM,0)/12,0)) AS [Books & Periodicals],SUM(ROUND(ISNULL(CARMNT,0)/12,0)) AS Vehicle,SUM(ROUND((ISNULL(GROSSPAY,0)+ISNULL(MEDRIM,0)/12+ISNULL(TELRIM,0)/12+ISNULL(DRVRIM,0)/12+ISNULL(LTARIM,0)/12+ISNULL(NWSRIM,0)/12+ISNULL(CARMNT,0)/12),0)) as CTC
from
(
SELECT HRDHISTQRY.PAYDATE, HRDHISTQRY.EMP_CODE,HRDHISTQRY.EMP_NAME, 
     field_name,
     field_value,RIMHISTQRY.MEDRIM,RIMHISTQRY.TELRIM,RIMHISTQRY.DRVRIM,RIMHISTQRY.LTARIM,RIMHISTQRY.NWSRIM,RIMHISTQRY.CARMNT
FROM HRDHISTQRY
LEFT OUTER JOIN HRDMASTQRY ON HRDHISTQRY.EMP_CODE = HRDMASTQRY.EMP_CODE 
LEFT OUTER JOIN PAYHIST    ON HRDHISTQRY.EMP_CODE = PAYHIST.EMP_CODE    AND HRDHISTQRY.PAYDATE = PAYHIST.PAYDATE
LEFT OUTER JOIN RIMHISTQRY ON HRDHISTQRY.EMP_CODE = RIMHISTQRY.EMP_CODE AND HRDHISTQRY.PAYDATE = RIMHISTQRY.PAYDATE
LEFT OUTER JOIN PAYMAST ON HRDHISTQRY.EMP_CODE = PAYMAST.EMP_CODE AND PAYMAST.FINYEAR=YEAR(HRDHISTQRY.PAYDATE )
WHERE PAYHIST.PAYDATE BETWEEN {@FDATE} AND {@TDATE}
   
) d
pivot
(
  max(field_value)
  for field_name in ([ERN_BASIC],[ERN_HRA],[ERN_CONV],[ERN_SPLALL],[ERN_SFTALL],[ERN_MED],[ERN_LTA],[ERN_OSALL],[CTC_ESI],[CTC_BONUS],[FOOD],[CTC_MEDCLM],[GROSSPAY],[CTC])
) piv','SQL','HTML;XLS','H','Y')





select * from Reports where RepName='CTC Monthly'

update Reports set RepFormula='select ROW_NUMBER()  OVER (ORDER BY  EMP_CODE) As SrNo, PAYDATE , EMP_CODE, EMP_NAME,ISNULL([ERN_BASIC],0)
  as BASIC, ISNULL([ERN_HRA],0) as HRA, ISNULL([ERN_CONV],0) as CONV,ISNULL([ERN_SPLALL],0) as SPLALL,ISNULL([GROSSPAY],0) as GROSS,ROUND(ISNULL(MEDRIM,0)/12,2) as MEDRIM,ROUND(ISNULL(TELRIM,0)/12,0) AS TELRIM,ROUND(ISNULL(DRVRIM,0)/12,0) AS DRVRIM,ROUND(ISNULL(LTARIM,0)/12,0) AS LTARIM,ROUND(ISNULL(NWSRIM,0)/12,0) AS [Books & Periodicals],ROUND(ISNULL(CARMNT,0)/12,0) AS Vehicle,ROUND((ISNULL(GROSSPAY,0)+ISNULL(MEDRIM,0)/12+ISNULL(TELRIM,0)/12+ISNULL(DRVRIM,0)/12+ISNULL(LTARIM,0)/12+ISNULL(NWSRIM,0)/12+ISNULL(CARMNT,0)/12),0) as CTC
from
(
SELECT HRDHISTQRY.PAYDATE, HRDHISTQRY.EMP_CODE,HRDHISTQRY.EMP_NAME, 
     field_name,
     field_value,RIMHISTQRY.MEDRIM,RIMHISTQRY.TELRIM,RIMHISTQRY.DRVRIM,RIMHISTQRY.LTARIM,RIMHISTQRY.NWSRIM,RIMHISTQRY.CARMNT
FROM HRDHISTQRY
LEFT OUTER JOIN HRDMASTQRY ON HRDHISTQRY.EMP_CODE = HRDMASTQRY.EMP_CODE 
LEFT OUTER JOIN PAYHIST    ON HRDHISTQRY.EMP_CODE = PAYHIST.EMP_CODE    AND HRDHISTQRY.PAYDATE = PAYHIST.PAYDATE
LEFT OUTER JOIN RIMHISTQRY ON HRDHISTQRY.EMP_CODE = RIMHISTQRY.EMP_CODE AND HRDHISTQRY.PAYDATE = RIMHISTQRY.PAYDATE
LEFT OUTER JOIN PAYMAST ON HRDHISTQRY.EMP_CODE = PAYMAST.EMP_CODE AND PAYMAST.FINYEAR=YEAR(HRDHISTQRY.PAYDATE )
WHERE  Payhist.Emp_Code not in(''tempcg'',''tempdn'') and  PAYHIST.PAYDATE BETWEEN {@FDATE} AND {@TDATE}
   
) d
pivot
(
  max(field_value)
  for field_name in ([ERN_BASIC],[ERN_HRA],[ERN_CONV],[ERN_SPLALL],[ERN_SFTALL],[ERN_MED],[ERN_LTA],[ERN_OSALL],[CTC_ESI],[CTC_BONUS],[FOOD],[CTC_MEDCLM],[GROSSPAY],[CTC])
) piv

UNION ALL

select ''0'', NULL , ''0'', ''Grand Total'',SUM(CONVERT(INT,ISNULL([ERN_BASIC],0)))
  as BASIC,SUM(CONVERT(INT,ISNULL([ERN_HRA],0))) AS HRA,SUM(CONVERT(INT,ISNULL([ERN_CONV],0))) AS CONV,SUM(CONVERT(INT,ISNULL([ERN_SPLALL],0))) AS SPLALL,SUM(CONVERT(INT,ISNULL([GROSSPAY],0))) AS GROSS,SUM(ROUND(ISNULL(MEDRIM,0)/12,0)) as MEDRIM,SUM(ROUND(ISNULL(TELRIM,0)/12,0)) AS TELRIM,SUM(ROUND(ISNULL(DRVRIM,0)/12,0)) AS DRVRIM,SUM(ROUND(ISNULL(LTARIM,0)/12,0)) AS LTARIM,SUM(ROUND(ISNULL(NWSRIM,0)/12,0)) AS [Books & Periodicals],SUM(ROUND(ISNULL(CARMNT,0)/12,0)) AS Vehicle,SUM(ROUND((ISNULL(GROSSPAY,0)+ISNULL(MEDRIM,0)/12+ISNULL(TELRIM,0)/12+ISNULL(DRVRIM,0)/12+ISNULL(LTARIM,0)/12+ISNULL(NWSRIM,0)/12+ISNULL(CARMNT,0)/12),0)) as CTC
from
(
SELECT HRDHISTQRY.PAYDATE, HRDHISTQRY.EMP_CODE,HRDHISTQRY.EMP_NAME, 
     field_name,
     field_value,RIMHISTQRY.MEDRIM,RIMHISTQRY.TELRIM,RIMHISTQRY.DRVRIM,RIMHISTQRY.LTARIM,RIMHISTQRY.NWSRIM,RIMHISTQRY.CARMNT
FROM HRDHISTQRY
LEFT OUTER JOIN HRDMASTQRY ON HRDHISTQRY.EMP_CODE = HRDMASTQRY.EMP_CODE 
LEFT OUTER JOIN PAYHIST    ON HRDHISTQRY.EMP_CODE = PAYHIST.EMP_CODE    AND HRDHISTQRY.PAYDATE = PAYHIST.PAYDATE
LEFT OUTER JOIN RIMHISTQRY ON HRDHISTQRY.EMP_CODE = RIMHISTQRY.EMP_CODE AND HRDHISTQRY.PAYDATE = RIMHISTQRY.PAYDATE
LEFT OUTER JOIN PAYMAST ON HRDHISTQRY.EMP_CODE = PAYMAST.EMP_CODE AND PAYMAST.FINYEAR=YEAR(HRDHISTQRY.PAYDATE )
WHERE  Payhist.Emp_Code not in(''tempcg'',''tempdn'') and  PAYHIST.PAYDATE BETWEEN {@FDATE} AND {@TDATE}
   
) d
pivot
(
  max(field_value)
  for field_name in ([ERN_BASIC],[ERN_HRA],[ERN_CONV],[ERN_SPLALL],[ERN_SFTALL],[ERN_MED],[ERN_LTA],[ERN_OSALL],[CTC_ESI],[CTC_BONUS],[FOOD],[CTC_MEDCLM],[GROSSPAY],[CTC])
) piv'

 where RepName='CTC Monthly'
 
 
 select * from Reports where RepName='CTC HISTORY'
 select * from Reports where RepName='CTC MONTHLY'
 
 
 update macepa_HRMS_REI.dbo.Reports set RepGroup='001-115-004-010',RepFormula='select PAYDATE , EMP_CODE, EMP_NAME,ROUND(ISNULL([ERN_BASIC],0),0)       as BASIC, ROUND(ISNULL([ERN_HRA],0),0)    as HRA, ROUND(ISNULL([ERN_CONV],0),0) as CONV,ROUND(ISNULL([ERN_SPLALL],0),0) as SPLALL,ROUND(ISNULL([ERN_EDUALL],0),0)    as CHILD_EDU_ALL,ROUND(ISNULL([GROSSPAY],0),0)    as GROSS,ROUND(ISNULL(MEDRIM,0)/12,2) as MEDRIM,ROUND(ISNULL(TELRIM,0)/12,0)    AS TELRIM,ROUND(ISNULL(DRVRIM,0)/12,0)    AS DRVRIM,ROUND(ISNULL(UNIRIM,0)/12,0) AS [UNIFORM REIMB], ROUND(ISNULL(PTLRIM,0)/12,0)    AS PTLRIM,ROUND(ISNULL(LTARIM,0)/12,0)    AS LTARIM,ROUND(ISNULL(ENTRIM/12,0),0)    AS ENTRIM,ROUND(ISNULL(FOOD/12,0),0)       AS FOODRIM,ROUND(ISNULL(NWSRIM,0)/12,0) AS [Books & Periodicals],ROUND(ISNULL(CARMNT,0)/12,0)    AS Vehicle,ROUND(ISNULL(PF,0),0)       AS PF,ROUND(ISNULL(EESI,0),0)       AS ESI_Employer,ROUND(ISNULL([CTC_GRAT],0)/12,0) as GRATUITY,ROUND((ISNULL(GROSSPAY,0)+ISNULL(MEDRIM,0)/12+ISNULL(TELRIM,0)/12+ISNULL(DRVRIM,0)/12+ISNULL(UNIRIM,0)/12+ISNULL(PTLRIM,0)/12+ISNULL(LTARIM,0)/12+ISNULL(NWSRIM,0)/12+ISNULL(CARMNT,0)/12),0)+ISNULL(PF,0)+ISNULL(EESI,0)+ISNULL(ENTRIM/12,0)+ISNULL(FOOD/12,0)+ISNULL([CTC_GRAT]/12,0)   as CTC,ROUND(ISNULL([CTC_BONUS],0),0) as BONUS,ROUND(ISNULL([CTC_RTNBNS],0),0)    as RETENTION_BONUS,ROUND((ISNULL(GROSSPAY,0)+ISNULL(MEDRIM,0)/12+ISNULL(TELRIM,0)/12+ISNULL(DRVRIM,0)/12+ISNULL(UNIRIM,0)/12+ISNULL(PTLRIM,0)/12+ISNULL(LTARIM,0)/12+ISNULL(NWSRIM,0)/12+ISNULL(CARMNT,0)/12),0)+ISNULL(PF,0)+ISNULL(EESI,0)+ISNULL(ENTRIM/12,0)+ISNULL(FOOD/12,0)+ISNULL([CTC_BONUS],0)+ISNULL([CTC_RTNBNS],0)+ISNULL([CTC_GRAT]/12,0) AS TOTAL_CTC      from  (  SELECT HRDHISTQRY.PAYDATE, HRDHISTQRY.EMP_CODE,HRDHISTQRY.EMP_NAME, field_name, field_value,RIMHISTQRY.MEDRIM,RIMHISTQRY.TELRIM,RIMHISTQRY.DRVRIM,RIMHISTQRY.UNIRIM, RIMHISTQRY.PTLRIM,RIMHISTQRY.LTARIM,RIMHISTQRY.NWSRIM,RIMHISTQRY.CARMNT     FROM HRDHISTQRY  LEFT OUTER JOIN HRDMASTQRY ON HRDHISTQRY.EMP_CODE = HRDMASTQRY.EMP_CODE   LEFT OUTER JOIN PAYHIST    ON HRDHISTQRY.EMP_CODE = PAYHIST.EMP_CODE    AND HRDHISTQRY.PAYDATE = PAYHIST.PAYDATE  LEFT OUTER JOIN RIMHISTQRY ON HRDHISTQRY.EMP_CODE = RIMHISTQRY.EMP_CODE AND HRDHISTQRY.PAYDATE = RIMHISTQRY.PAYDATE  LEFT OUTER JOIN PAYMAST ON HRDHISTQRY.EMP_CODE = PAYMAST.EMP_CODE AND PAYMAST.FINYEAR=YEAR(HRDHISTQRY.PAYDATE)      WHERE Payhist.Emp_Code not in(''tempcg'',''tempdn'') and   PAYHIST.PAYDATE BETWEEN {@FDATE} AND {@TDATE} AND HRDHISTQRY.Status_Code=''01''   ) d     pivot      (      max(field_value)       for field_name in ([ERN_BASIC],[ERN_HRA],[ERN_CONV],[ERN_SPLALL],[ERN_SFTALL],[ERN_EDUALL],[ERN_MED],[ERN_LTA],[ERN_OSALL],[CTC_ESI],[CTC_BONUS],[CTC_GRAT],[CTC_RTNBNS],[FOOD],[CTC_MEDCLM],[GROSSPAY],[CTC],[PF],[ENTRIM],[EESI])      ) piv' where RepName='CTC Monthly'