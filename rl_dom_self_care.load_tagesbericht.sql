CREATE procedure [rl_dom_self_care].[load_tagesbericht]
  @arg_job  NVARCHAR(255)
WITH EXECUTE AS OWNER
AS
BEGIN
SET NOCOUNT ON

DECLARE @log_message NVARCHAR(MAX)
DECLARE @proc NVARCHAR(255)
DECLARE @resultcode INT

IF @arg_job  IS NULL SET @arg_job  = USER_NAME() + '#' + CAST(NEWID() AS NVARCHAR(255))
SET @resultcode = 0
SET @proc = etl.get_proc_name (@@procid)

BEGIN TRY
  EXEC etl.log_revision
      @proc
    , @arg_job 
    , '$URL: $'
    , '$LastChangedRevision:  $'
    , '$LastChangedBy:  $'
    , '$LastChangedDate: $'
  
    SET @log_message = 'Started Job ' + @arg_job 
    EXEC etl.log_event @proc, @arg_job , @log_message


---------------------CONTENT
DROP TABLE IF EXISTS #PB_week_prozentual
DROP TABLE IF EXISTS #PB_week
DROP TABLE IF EXISTS #PB_month
DROP TABLE IF EXISTS #PB_month_prozentual
DROP TABLE IF EXISTS #PB_day
DROP TABLE IF EXISTS #PB_day_prozentual

CREATE TABLE #PB_day(
   KPI VARCHAR(200) NOT NULL,
   date_id INT NULL,
   date NVARCHAR(23) NULL,
   Gesamt INT NULL,
   web INT NULL,
   app INT NULL,
   order_id INT NULL,
   Aktualisierungsdatum DATETIME NULL
)


CREATE UNIQUE NONCLUSTERED INDEX IDX_KPI_day ON #PB_day
(
   KPI ASC,
   date_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)


CREATE TABLE #PB_day_prozentual(
   KPI VARCHAR(200) NULL,
   date_id INT NULL,
   date NVARCHAR(14) NULL,
   gesamt_Anz_1 INT NULL,
   gesamt_Anz_2 INT NULL,
   gesamt DECIMAL(21, 13) NULL,
   web_Anz_2 INT NULL,
   web_Anz_1 INT NULL,
   web DECIMAL(21, 13) NULL,
   app_Anz_1 INT NULL,
   app_Anz_2 INT NULL,
   app DECIMAL(21, 13) NULL,
   order_id INT  NULL,
   Aktualisierungsdatum DATETIME NULL
)

CREATE UNIQUE NONCLUSTERED INDEX IDX_KPI_day ON #PB_day_prozentual
(
   KPI ASC,
   date_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)



CREATE TABLE #PB_month(
   KPI NVARCHAR(200) NULL,
   month_id INT NULL,
   month NVARCHAR(3) NULL,
   gesamt INT NULL,
   web INT NULL,
   app INT NULL,
   order_id INT NULL,
   Aktualisierungsdatum DATETIME NULL
)


CREATE UNIQUE NONCLUSTERED INDEX IDX_KPI_Monat ON #PB_month
(
   KPI ASC,
   month_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)


CREATE TABLE #PB_month_prozentual(
   KPI VARCHAR(200) NULL,
   month_id INT NULL,
   month NVARCHAR(3) NULL,
   gesamt_Anz_1 INT NULL,
   gesamt_Anz_2 INT NULL,
   gesamt DECIMAL(21, 13) NULL,
   web_Anz_1 INT NULL,
   web_Anz_2 INT NULL,
   web DECIMAL(21, 13) NULL,
   app_Anz_1 INT NULL,
   app_Anz_2 INT NULL,
   app DECIMAL(21, 13) NULL,
   order_id INT  NULL,
   Aktualisierungsdatum DATETIME NULL
)


CREATE UNIQUE NONCLUSTERED INDEX IDX_KPI_Monat ON #PB_month_prozentual
(
   KPI ASC,
   month_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)


CREATE TABLE #PB_week(
   KPI VARCHAR(200) NOT NULL,
   week_id INT NULL,
   week_in_year_id INT NULL,
   Gesamt INT NULL,
   web INT NULL,
   app INT NULL,
   order_id INT  NULL,
   Aktualisierungsdatum DATETIME NULL
)


CREATE UNIQUE NONCLUSTERED INDEX IDX_KPI_Woche ON #PB_week
(
   KPI ASC,
   week_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)


CREATE TABLE #PB_week_prozentual(
   KPI VARCHAR(200) NULL,
   week_id INT NULL,
   week_in_year_id NVARCHAR(3) NULL,
   gesamt_Anz_1 INT NULL,
   gesamt_Anz_2 INT NULL,
   gesamt DECIMAL(21, 13) NULL,
   web_Anz_2 INT NULL,
   web_Anz_1 INT NULL,
   web DECIMAL(21, 13) NULL,
   app_Anz_1 INT NULL,
   app_Anz_2 INT NULL,
   app DECIMAL(21, 13) NULL,
   order_id INT NULL,
   Aktualisierungsdatum DATETIME NULL
)


CREATE UNIQUE NONCLUSTERED INDEX IDX_KPI_week ON #PB_week_prozentual
(
   KPI ASC,
   week_id ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)

----------------------------------- Declare variables -----------------------------------

DECLARE @calculate_hist int;
SET @calculate_hist =
(
    SELECT CASE
               WHEN (SELECT CAST(MAX(rl_load_datetime) AS DATE) FROM rl_dom_self_care.tagesbericht) < (SELECT CAST(GETDATE() AS DATE)) THEN 1 -- when the tagesbericht was not calculated today, do not calculate hist, we need to calculate the tagebericht first
               WHEN (SELECT CAST(MAX(rl_load_datetime) AS DATE) FROM rl_dom_self_care.tagesbericht) = (SELECT CAST(GETDATE() AS DATE)) AND -- when tagesbericht was calculated today
			   (SELECT ISNULL(MAX(YEAR(hist_load_datetime)*100+month(hist_load_datetime)),190001) FROM rl_dom_self_care.tagesbericht_hist) < (SELECT YEAR(GETDATE())*100+month(GETDATE())) THEN 2 -- and the hist was not calculated, then calculate the hist
			   when (select CAST(MAX(rl_load_datetime) AS DATE) FROM rl_dom_self_care.tagesbericht) = (SELECT CAST(GETDATE() AS DATE)) THEN 3 -- when the tagesbericht was not calculated in the morning, it needs to be calculated the second time
		   end
);


select @calculate_hist

IF @calculate_hist = 1
BEGIN
set @log_message = N'@calculate_hist = 1, we need to calculate the tagesbericht table'
exec etl.log_event @proc, @arg_job , @log_message
END
IF @calculate_hist = 2
BEGIN
set @log_message = N'@calculate_hist = 2, we need to calculate the hist data'
exec etl.log_event @proc, @arg_job , @log_message
end
IF @calculate_hist = 3
BEGIN
set @log_message = N'@calculate_hist = 3, we need to calculate the tagesbericht table the second time'
exec etl.log_event @proc, @arg_job , @log_message
END


------------------- if the @calculate_hist variabile has the values 1 or 2 we need to continue 

DECLARE @MONTH_DIFF INT = (SELECT CASE WHEN DATEPART(DAY,GETDATE()) < 7 THEN -1  ELSE 0 END )

DECLARE @MONTH_ID_START INT --= (SELECT month_id     FROM [dm_dom_calender].[date] WHERE date = DATEADD(MONTH, -1,CAST (GETDATE() AS DATE))) -- olod value -4
DECLARE @WEEK_ID_START  INT --= (SELECT week_id FROM [dm_dom_calender].[date] WHERE date = DATEADD(WEEK, -4,CAST (GETDATE() AS DATE))) -- old value -8
DECLARE @DAY_ID_START   INT --= (SELECT date_id FROM [dm_dom_calender].[date] WHERE date = CAST(DATEADD(DAY, -37, GETDATE()) AS DATE))  -- old value -67

-- @MONTH_ID_START
IF @calculate_hist in (1,3) -- we need to calculate tagesbericht
	SET @MONTH_ID_START = (SELECT month_id FROM [dm_dom_calender].[date] WHERE date = DATEADD(MONTH, -1,CAST (GETDATE() AS DATE)))
IF @calculate_hist = 2 -- we need to calculate the historical data
	SET @MONTH_ID_START = (SELECT month_id FROM [dm_dom_calender].[date] WHERE date = DATEADD(MONTH, -6,CAST (GETDATE() AS DATE)))

-- @WEEK_ID_START
IF @calculate_hist in (1,3) -- we need to calculate tagesbericht
	SET @WEEK_ID_START = (SELECT week_id FROM [dm_dom_calender].[date] WHERE date = DATEADD(WEEK, -4,CAST (GETDATE() AS DATE)))
IF @calculate_hist = 2 -- we need to calculate the historical data
	SET @WEEK_ID_START = (SELECT MIN(week_id) FROM [dm_dom_calender].[date] WHERE month_id = @Month_id_start and weekday_id_de=1)

-- @DAY_ID_START
IF @calculate_hist in (1,3) -- we need to calculate tagesbericht
	SET @DAY_ID_START = (SELECT date_id FROM [dm_dom_calender].[date] WHERE date = CAST(DATEADD(DAY, -37, GETDATE()) AS DATE))
IF @calculate_hist = 2 -- we need to calculate the historical data
	SET @DAY_ID_START = (SELECT min(date_id) FROM [dm_dom_calender].[date] WHERE month_id = @Month_id_start)

SELECT @MONTH_ID_START
SELECT @WEEK_ID_START
SELECT @DAY_ID_START


DECLARE @startdate_month DATE = (SELECT MIN(date) FROM [dm_dom_calender].[date] WHERE month_id = @MONTH_ID_START)
DECLARE @startdate_week  DATE = (SELECT MIN(date) FROM [dm_dom_calender].[date] WHERE week_id = @WEEK_ID_START)
DECLARE @startdate_day   DATE = (SELECT date FROM [dm_dom_calender].[date] WHERE date_id = @DAY_ID_START)

DECLARE @enddate DATE = (SELECT MIN(date) FROM [dm_dom_calender].[date] WHERE date = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE))
DECLARE @startdate DATE = (SELECT CASE WHEN @startdate_month <= @startdate_week THEN @startdate_month ELSE @startdate_week END)
DECLARE @MONTH_ID INT = (SELECT month_id FROM [dm_dom_calender].[date] WHERE date = CASE WHEN DAY(@enddate) < 7 THEN DATEADD(MONTH, -1,@enddate) ELSE @enddate END )

DECLARE @startdate_prev_month DATE = (SELECT DATEADD(MONTH, -1, @startdate_month))
DECLARE @enddate_prev_month DATE = (SELECT EOMONTH(DATEADD(MONTH, -1, @enddate)))

DECLARE @enddate_3_monate_mau DATE = (SELECT MAX(function_call_date)  enddate FROM [dm_dom_self_care].[control_center_function_call])

DECLARE @startdate_3_monate_mau DATE
IF @calculate_hist in (1,3) -- we need to calculate tagesbericht
	SET @startdate_3_monate_mau = DATEFROMPARTS(YEAR(DATEADD(MONTH,-3,GETDATE())),MONTH(DATEADD(MONTH,-3,GETDATE())),1)
IF @calculate_hist = 2 -- we need to calculate the historical data
	SET @startdate_3_monate_mau = DATEFROMPARTS(YEAR(DATEADD(MONTH,-8,GETDATE())),MONTH(DATEADD(MONTH,-8,GETDATE())),1)

--DECLARE @MONTH_ID_3_monate_mau INT = (SELECT month_id FROM [dm_dom_calender].[date] WHERE date = CASE WHEN DAY(@enddate_3_monate_mau) < 7 THEN DATEADD(MONTH, -1,@enddate_3_monate_mau) ELSE @enddate_3_monate_mau END )

DECLARE @week_id_prev_end INT = (SELECT week_id FROM [dm_dom_calendar].[date]   WHERE date = DATEADD(WEEK, -1, @enddate))
DECLARE @startdate_prev_week DATE = (SELECT MIN(date) FROM [dm_dom_calendar].[date] WHERE date = DATEADD(WEEK, -1,@startdate_week))
DECLARE @enddate_prev_week DATE = (SELECT MAX(date) FROM [dm_dom_calendar].[date] WHERE week_id =@week_id_prev_end)





IF @calculate_hist = 2
BEGIN

    set @log_message = N'we do not have a backup in the host table, make a backup now'
    exec etl.log_event @proc, @arg_job , @log_message

INSERT INTO rl_dom_self_care.tagesbericht_hist
(
    KPI_calculation_type,
    KPI,
    tag_calculation_time,
    tag_calculation_time_desc,
    total_1,
    total_2,
    total_percentage,
    web_total_1,
    web_total_2,
    web_percentage,
    app_total_1,
    app_total_2,
    app_percentage,
    order_id,
    rl_load_datetime,
    rl_load_job_id,
	hist_load_datetime
)
SELECT KPI_calculation_type,
       KPI,
       tag_calculation_time,
       tag_calculation_time_desc,
       total_1,
       total_2,
       total_percentage,
       web_total_1,
       web_total_2,
       web_percentage,
       app_total_1,
       app_total_2,
       app_percentage,
       order_id,
       rl_load_datetime,
       rl_load_job_id,
	   getdate()
FROM rl_dom_self_care.tagesbericht
end


------------------------------------------------------------------------------------------
        set @log_message = N'Create 3-Monate MAU KPI'
        exec etl.log_event @proc, @arg_job , @log_message


	DROP TABLE IF EXISTS #dist_months;
	SELECT DISTINCT
		   month_id
	INTO #dist_months
	FROM dm_dom_calendar.date
	WHERE date
	BETWEEN @startdate_3_monate_mau AND @enddate_3_monate_mau;

	;WITH cte AS
		(
			SELECT 
			month_id AS max_month_id,
			lag(month_id,2)OVER(ORDER BY month_id) AS min_month_id
			FROM #dist_months
		)
	SELECT 
		a.max_month_id AS calculated_month,
		b.month_short_desc_de,
		a.max_month_id AS max_month_id,
		MAX(b.date) AS max_date,
		a.min_month_id AS min_month_id,
		MIN(c.date) AS min_date
		INTO #month_matrix
	FROM  cte a INNER JOIN dm_dom_calendar.date b ON a.max_month_id=b.month_id
				INNER JOIN dm_dom_calendar.date c ON a.min_month_id = c.month_id
	GROUP BY a.max_month_id,
			 a.max_month_id,
			 a.min_month_id,
			 b.month_short_desc_de
	ORDER BY 1


DELETE FROM #PB_month  WHERE month_id >= @MONTH_ID AND KPI = '3-Monate MAU'
INSERT INTO  #PB_month
SELECT
   '3-Monate MAU' KPI
   , b.calculated_month AS month_id
   , b.month_short_desc_de month
   ,  COUNT(DISTINCT customer_id)  Gesamt
   ,  COUNT(DISTINCT CASE WHEN control_center_desc = 'web' THEN customer_id END) AS web
   ,  COUNT(DISTINCT CASE WHEN control_center_desc = 'app' THEN customer_id END) AS app
   , 0 AS order_id
   , GETDATE() Aktualisierungsdatum
FROM rl_dom_self_care.user_activity_daily a INNER JOIN #month_matrix b ON a.function_call_date >= min_date AND a.function_call_date <= max_date
AND customer_id <> -1
GROUP BY b.calculated_month,
         b.month_short_desc_de 


         set @log_message = N'3-Monate MAU KPI completed and inserted in #PBI_month'
        exec etl.log_event @proc, @arg_job , @log_message
   

drop table if exists #MAU_TMP;
select
   distinct customer_id,control_center_desc, function_call_date, function_id, b.scm_readonly_ind
   into #MAU_TMP
   from rl_dom_self_care.user_activity_daily ccfc
       left join dm_dom_self_care.control_center_function b on ccfc.function_name_desc = b.function_name_desc
   where  function_call_date between @startdate and @enddate
   and customer_id <> -1;



delete from #PB_month_prozentual  where month_id >= @MONTH_ID_START and KPI like  'MAU%';
with mau as
(
select
   'MAU' KPI
   , month_id
   , [date].month_short_desc_de month
   , count(distinct customer_id) Gesamt
   , count(distinct case when scm_readonly_ind = 0 and function_id not in (124,181) then customer_id end) total_2
   , count(distinct case when control_center_desc = 'web' then customer_id end) web
   , count(distinct case when control_center_desc = 'web' and scm_readonly_ind = 0 and function_id not in (124,181) then customer_id end) web_2
   , count(distinct case when control_center_desc = 'app' then customer_id end) app
   , count(distinct case when control_center_desc = 'app' and scm_readonly_ind = 0 and function_id not in (124,181) then customer_id end) app_2
   , 1 as order_id
    , getdate() Aktualisierungsdatum
   from #MAU_TMP--rl_dom_self_care.user_activity_daily
left outer join [dm_dom_calender].[date]
on date = function_call_date
where
   function_call_date between  @startdate_month and @enddate
group by
   month_short_desc_de, month_id
)
insert into  #PB_month_prozentual
select kpi
       ,month_id
       ,[month]
       ,Gesamt
       ,total_2
       ,case when gesamt <> 0  then cast(convert(decimal(10,4), convert(decimal(10,4),total_2)/gesamt) as decimal(10,4)) else 0 end total_percentage
       ,web
       ,web_2
       ,case when web <> 0  then cast(convert(decimal(10,4), convert(decimal(10,4),web_2)/web) as decimal(10,4)) else 0 end web_percentage
       ,app
       ,app_2
       ,case when app <> 0  then cast(convert(decimal(10,4), convert(decimal(10,4),app_2)/app) as decimal(10,4)) else 0 end app_percentage
       ,order_id
       ,Aktualisierungsdatum
from mau;

          set @log_message = N'MAU KPI completed and inserted in #PB_month_prozentual'
        exec etl.log_event @proc, @arg_job , @log_message

delete from #PB_month  where month_id >= @MONTH_ID_START and KPI like  'MAU%'
insert into  #PB_month
select
   'MAU ' + [product_sales_group_0_desc] KPI
   , month_id
   , [date].month_short_desc_de month
   , count(distinct cast(ccfc.customer_id as varchar(20)) + 'x'+ [product_sales_group_0_desc]) Gesamt
   , count(distinct case when control_center_desc = 'web' then  cast(ccfc.customer_id as varchar(20)) + 'x'+ [product_sales_group_0_desc] end) web
   , count(distinct case when control_center_desc = 'app' then  cast(ccfc.customer_id as varchar(20)) + 'x'+ [product_sales_group_0_desc] end) app
   , case
       when [product_sales_group_0_desc] ='Small Screen' then 12
       when [product_sales_group_0_desc] ='Big Screen' then 14
       when [product_sales_group_0_desc] ='DSL' then 10 end order_id
   , getdate() Aktualisierungsdatum
   from #MAU_TMP ccfc --rl_dom_self_care.user_activity_daily ccfc
   left outer join [dm_dom_calender].[date]
   on date = function_call_date
   left outer join [dm_dom_contract].[contract_hist] ch
   on ccfc.customer_id = ch.customer_id
   and function_call_date between valid_from and valid_to
   left outer join [dm_dom_product].[product_cluster] p
   on ch.product_cluster_id = p.product_cluster_id
   where function_call_date between  @startdate_month and @enddate
       and contract_status_id in (2,4)  -- 4 'active', 2 -- 'preactive'
       and ccfc.customer_id <> -1
       and [product_sales_group_0_desc] not in ('n/a')
   group by month_short_desc_de, month_id, [product_sales_group_0_desc]
   order by month_id

          set @log_message = N'MAU + [Product Sales Desc] KPIs completed and inserted in #PB_month'
        exec etl.log_event @proc, @arg_job , @log_message
--week ---


delete from #PB_week_prozentual  where week_id >= @WEEK_ID_START  and KPI like  'WAU';
with wau as
(
    select
       'WAU' KPI
       , week_id
       , [date].week_in_year_id
       , count(distinct customer_id) Gesamt
       , count(distinct case when scm_readonly_ind = 0 and function_id not in (124,181) then customer_id end) total_2
       , count(distinct case when control_center_desc = 'web' then customer_id end) web
       , count(distinct case when control_center_desc = 'web' and scm_readonly_ind = 0 and function_id not in (124,181) then customer_id end) web_2
       , count(distinct case when control_center_desc = 'app' then customer_id end) app
       , count(distinct case when control_center_desc = 'app' and scm_readonly_ind = 0 and function_id not in (124,181) then customer_id end) app_2
       , 1 order_id
       , getdate() Aktualisierungsdatum
   from  #MAU_TMP --rl_dom_self_care.user_activity_daily
       left outer join [dm_dom_calender].[date]
       on date = function_call_date
    where function_call_date between  @startdate_week and @enddate
    group by week_in_year_id, week_id
)
insert into   #PB_week_prozentual
select kpi
       ,week_id
       ,week_in_year_id
       ,Gesamt
       ,total_2
       ,case when gesamt <> 0  then cast(convert(decimal(10,4), convert(decimal(10,4),total_2)/gesamt) as decimal(10,4)) else 0 end total_percentage
       ,web_2
       ,web
       ,case when web <> 0  then cast(convert(decimal(10,4), convert(decimal(10,4),web_2)/web) as decimal(10,4)) else 0 end web_percentage
       ,app
       ,app_2
       ,case when app <> 0  then cast(convert(decimal(10,4), convert(decimal(10,4),app_2)/app) as decimal(10,4)) else 0 end app_percentage
       ,order_id
       ,Aktualisierungsdatum
from wau;

           set @log_message = N'WAU KPI completed and inserted in #PB_week_prozentual'
        exec etl.log_event @proc, @arg_job , @log_message
        
delete from #PB_week  where week_id >= @WEEK_ID_START  and KPI like  'WAU%';
insert into #PB_week
select
   'WAU ' + [product_sales_group_0_desc] KPI
   , week_id
   , [date].week_in_year_id
   , count(distinct cast(ccfc.customer_id as varchar(20)) + 'x'+ [product_sales_group_0_desc]) Gesamt
   , count(distinct case when control_center_desc = 'web' then  cast(ccfc.customer_id as varchar(20)) + 'x'+ [product_sales_group_0_desc] end) web
   , count(distinct case when control_center_desc = 'app' then  cast(ccfc.customer_id as varchar(20)) + 'x'+ [product_sales_group_0_desc] end) app
   , case    when product_sales_group_0_desc = 'Big Screen' then 14
           when product_sales_group_0_desc = 'DSL' then 10
           when product_sales_group_0_desc = 'Small Screen' then 12
     end as order_id
           
    , getdate() Aktualisierungsdatum
   from #MAU_TMP ccfc -- rl_dom_self_care.user_activity_daily ccfc
left outer join [dm_dom_calender].[date]
on date = function_call_date
left outer join [dm_dom_contract].[contract_hist] ch
on ccfc.customer_id = ch.customer_id
and function_call_date between valid_from and valid_to
left outer join [dm_dom_product].[product_cluster] p
on ch.product_cluster_id = p.product_cluster_id

where function_call_date between  @startdate_week and @enddate
   and contract_status_id in (2,4)   -- 4 'active', 2 -- 'preactive'
   and ccfc.customer_id <> -1
   and [product_sales_group_0_desc] not in ('n/a')
   and ccfc.customer_id <> -1
group by week_in_year_id, week_id, [product_sales_group_0_desc]
        
           set @log_message = N'WAU + [Product Sales Desc] KPI completed and inserted in #PB_week'
        exec etl.log_event @proc, @arg_job , @log_message

-- --- tag ----

delete from #PB_day_prozentual where date_id >= @DAY_ID_START  and KPI like  'DAU';
with dau as
(
   select
       'DAU' KPI
       , date_id
       , weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de [date]
       , count(distinct customer_id) Gesamt
       , count(distinct case when scm_readonly_ind = 0 and function_id not in (124,181) then customer_id end) total_2
       , count(distinct case when control_center_desc = 'web' then customer_id end) web
       , count(distinct case when control_center_desc = 'web' and scm_readonly_ind = 0 and function_id not in (124,181) then customer_id end) web_2
       , count(distinct case when control_center_desc = 'app' then customer_id end) app
       , count(distinct case when control_center_desc = 'app' and scm_readonly_ind = 0 and function_id not in (124,181) then customer_id end) app_2
       , 1 as order_id
       , getdate() Aktualisierungsdatum
   from #MAU_TMP ccfc --rl_dom_self_care.user_activity_daily
       left outer join [dm_dom_calender].[date]
       on date = function_call_date
   where function_call_date between  @startdate_day and @enddate
   group by weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de, date_id
)
insert into #PB_day_prozentual
select kpi
       ,date_id
       ,[date]
       ,Gesamt
       ,total_2
       ,case when gesamt <> 0  then cast(convert(decimal(10,4), convert(decimal(10,4),total_2)/gesamt) as decimal(10,4)) else 0 end total_percentage
       ,web_2
       ,web
       ,case when web <> 0  then cast(convert(decimal(10,4), convert(decimal(10,4),web_2)/web) as decimal(10,4)) else 0 end web_percentage
       ,app
       ,app_2
       ,case when app <> 0  then cast(convert(decimal(10,4), convert(decimal(10,4),app_2)/app) as decimal(10,4)) else 0 end app_percentage
       ,order_id
       ,Aktualisierungsdatum
from dau;
            set @log_message = N'DAU KPI completed and inserted in #PB_day_prozentual'
        exec etl.log_event @proc, @arg_job , @log_message

delete from #PB_day where date_id >= @DAY_ID_START  and KPI like  'DAU%';
insert into #PB_day
select
   'DAU ' + [product_sales_group_0_desc] KPI
   , date_id    
   , weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de [date]
   , count(distinct cast(ccfc.customer_id as varchar(20)) + 'x'+ [product_sales_group_0_desc]) Gesamt
   , count(distinct case when control_center_desc = 'web' then  cast(ccfc.customer_id as varchar(20)) + 'x'+ [product_sales_group_0_desc] end) web
   , count(distinct case when control_center_desc = 'app' then  cast(ccfc.customer_id as varchar(20)) + 'x'+ [product_sales_group_0_desc] end) app
   , case
       when [product_sales_group_0_desc] ='Small Screen' then 12
       when [product_sales_group_0_desc] ='Big Screen' then 14
       when [product_sales_group_0_desc] ='DSL' then 10 end order_id
    , getdate() Aktualisierungsdatum
from #MAU_TMP ccfc --rl_dom_self_care.user_activity_daily ccfc
left outer join [dm_dom_calender].[date]
on date = function_call_date
left outer join [dm_dom_contract].[contract_hist] ch
on ccfc.customer_id = ch.customer_id
and function_call_date between valid_from and valid_to
left outer join [dm_dom_product].[product_cluster] p
on ch.product_cluster_id = p.product_cluster_id

where function_call_date between  @startdate_day and @enddate
and contract_status_id in (2,4)  -- 4 'active', 2 -- 'preactive'
and ccfc.customer_id <> -1
and [product_sales_group_0_desc] not in ('n/a')


group by weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de, date_id, [product_sales_group_0_desc]
order by date_id, [product_sales_group_0_desc]


             set @log_message = N'DAU + [Product Sales Desc] KPIs completed and inserted in #PB_day'
        exec etl.log_event @proc, @arg_job , @log_message

------ Wiederkehrer monthly calculation -----------

          drop table if exists #MAU_TMP2
select
   distinct customer_id,control_center_desc, function_call_date
   into #MAU_TMP2
   from rl_dom_self_care.user_activity_daily ccfc
   where  function_call_date between @startdate_prev_month and @enddate
   and customer_id <> -1


drop table if exists #MAU_Vormonat
select month_id, next_month_id, customer_id, min(function_call_date) min_function_call_date
into #MAU_Vormonat
from #MAU_TMP2--rl_dom_self_care.user_activity_daily
left outer join  [dm_dom_calender].[date]
on date = function_call_date
where function_call_date between @startdate_prev_month and @enddate_prev_month
group by month_id, customer_id, next_month_id

drop table if exists #MAU_aktMonat
select  month_id,  customer_id, min(function_call_date) min_function_call_date
into #MAU_aktMonat
from #MAU_TMP2--rl_dom_self_care.user_activity_daily
left outer join  [dm_dom_calender].[date]
on date = function_call_date
where function_call_date between @startdate_month  and @enddate
group by month_id, customer_id

--- app/web
drop table if exists #MAU_Vormonat_APP_WEB
select control_center_desc, month_id, next_month_id, customer_id, min(function_call_date) min_function_call_date
into #MAU_Vormonat_APP_WEB
from #MAU_TMP2--rl_dom_self_care.user_activity_daily
left outer join  [dm_dom_calender].[date]
on date = function_call_date
where function_call_date between @startdate_prev_month and @enddate_prev_month
and control_center_desc in ('WEB', 'APP')
group by customer_id, month_id,  control_center_desc, next_month_id


drop table if exists #MAU_aktMonat_APP_WEB
select control_center_desc, month_id,  customer_id, min(function_call_date) min_function_call_date
into #MAU_aktMonat_APP_WEB
from #MAU_TMP2--rl_dom_self_care.user_activity_daily
left outer join  [dm_dom_calender].[date]
on date = function_call_date
where function_call_date between @startdate_month  and @enddate
and control_center_desc in ('WEB', 'APP')
group by customer_id, month_id, control_center_desc


drop table if exists #tmp_gesamt
select
   'Wiederkehrer' KPI
   , vm.next_month_id month_id
   , Month_desc.month_short_desc_de month
   , count(AKT.customer_id) [gesamt_Anz_1]
   , count(VM.customer_id) [gesamt_Anz_2]
   , cast (count(AKT.customer_id) as dec(12,2)) /count(VM.customer_id)  gesamt
into #tmp_gesamt
from #MAU_Vormonat VM
left outer join #MAU_aktMonat AKT
on VM.customer_id = aKt.customer_id
and vm.next_month_id = akt.month_id
left outer join (select distinct month_id, month_short_desc_de from [dm_dom_calender].[date]) Month_desc
on Month_desc.Month_id = next_month_id
group by vm.next_month_id
   , month_short_desc_de

      set @log_message = N'Wiederkehrer KPI Gesamt Created '
        exec etl.log_event @proc, @arg_job , @log_message

drop table if exists #tmp_app
select
   'Wiederkehrer' KPI
   , vm.next_month_id month_id
   , Month_desc.month_short_desc_de month
   , count(AKT.customer_id) [app_Anz_1]
   , count(VM.customer_id) [app_Anz_2]
   , cast (count(AKT.customer_id) as dec(12,2)) /count(VM.customer_id)   app
into #tmp_app
from #MAU_Vormonat_APP_WEB VM
left outer join #MAU_aktMonat_APP_WEB AKT
on VM.customer_id = aKt.customer_id
and vm.next_month_id = akt.month_id
and VM.control_center_desc = aKt.control_center_desc    
left outer join (select distinct month_id, month_short_desc_de from [dm_dom_calender].[date]) Month_desc
on Month_desc.Month_id = next_month_id
where VM.control_center_desc = 'App'
group by vm.next_month_id
   , month_short_desc_de
   , VM.control_center_desc

drop table if exists #tmp_web
      set @log_message = N'Wiederkehrer KPI App Created'
        exec etl.log_event @proc, @arg_job , @log_message

select
   'Wiederkehrer' KPI
   , vm.next_month_id month_id
   , Month_desc.month_short_desc_de month
   , count(AKT.customer_id) [web_Anz_1]
   , count(VM.customer_id) [web_Anz_2]
   , cast (count(AKT.customer_id) as dec(12,2)) /count(VM.customer_id)   web
into #tmp_web
from #MAU_Vormonat_APP_WEB VM
left outer join #MAU_aktMonat_APP_WEB AKT
on VM.customer_id = aKt.customer_id
and vm.next_month_id = akt.month_id
and VM.control_center_desc = aKt.control_center_desc    
left outer join (select distinct month_id, month_short_desc_de from [dm_dom_calender].[date]) Month_desc
on Month_desc.Month_id = next_month_id
where VM.control_center_desc = 'web'
group by vm.next_month_id
   , month_short_desc_de
   , VM.control_center_desc

      set @log_message = N'Wiederkehrer KPI Web Created'
        exec etl.log_event @proc, @arg_job , @log_message
insert into #PB_month_prozentual
   select
     g.KPI
     ,g.[month_id]
     ,g.[month]
     , [gesamt_Anz_1]
     , [gesamt_Anz_2]
     , [gesamt]
     , [web_Anz_1]
     , [web_Anz_2]
     , [web]
     , [app_Anz_1]
     , [app_Anz_2]
     , [app]
     , 2 [order_id]
     , getdate() as currdate
--into #PB_month_prozentual
   from
#tmp_gesamt g
   left outer join #tmp_app a
   on a.month = g.month
   left outer join #tmp_web w
   on w.month = g.month

---Wiederkehrer KW calculation -- EBIPB-8425 ------------------------------

drop table if exists #MAU_TMP3
select
   distinct customer_id,control_center_desc, function_call_date
   into #MAU_TMP3
   from rl_dom_self_care.user_activity_daily ccfc
   where  function_call_date between @startdate_prev_week and @enddate
   and customer_id <> -1


drop table if exists #MAU_Vorwoche
select 'Gesamt' as control_center_desc,  week_id, next_week_id, customer_id, min(function_call_date) min_function_call_date
into #MAU_Vorwoche
from #MAU_TMP3
left outer join  [dm_dom_calender].[date]
on date = function_call_date
where function_call_date between @startdate_prev_week and @enddate_prev_week
group by week_id, customer_id, next_week_id

drop table if exists #MAU_aktWoche
select  week_id,  customer_id, min(function_call_date) min_function_call_date
into #MAU_aktWoche
from #MAU_TMP3
left outer join  [dm_dom_calender].[date]
on date = function_call_date
where function_call_date between @startdate_week  and @enddate
group by week_id, customer_id

--- app/web
drop table if exists #MAU_Vorwoche_APP_WEB
select control_center_desc,  week_id, next_week_id, customer_id, min(function_call_date) min_function_call_date
into #MAU_Vorwoche_APP_WEB
from #MAU_TMP3
left outer join  [dm_dom_calender].[date]
on date = function_call_date
where function_call_date between @startdate_prev_week and @enddate_prev_week
and control_center_desc in ('WEB', 'APP')
group by customer_id,control_center_desc, week_id, next_week_id


drop table if exists #MAU_aktWoche_APP_WEB
select control_center_desc, week_id,  customer_id, min(function_call_date) min_function_call_date
into #MAU_aktwoche_APP_WEB
from #MAU_TMP3
left outer join  [dm_dom_calender].[date]
on date = function_call_date
where function_call_date between @startdate_week  and @enddate
and control_center_desc in ('WEB', 'APP')
group by customer_id, week_id, control_center_desc


drop table if exists #tmp_gesamt_wk
select
   'Wiederkehrer KW' KPI
   , vw.next_week_id week_id
   , week_in_year_id week
   , count(AKT.customer_id) [gesamt_Anz_1]
   , count(Vw.customer_id) [gesamt_Anz_2]
   , cast (count(AKT.customer_id) as dec(12,2)) /count(VW.customer_id)  gesamt
into #tmp_gesamt_wk
from #MAU_Vorwoche VW
left outer join #MAU_aktWoche AKT
on VW.customer_id = aKt.customer_id
and vw.next_week_id = akt.week_id
left outer join (select distinct week_id, week_short_desc, week_in_year_id from [dm_dom_calender].[date]) Week_desc
on Week_desc.week_id = next_week_id
group by vw.next_week_id
   , Week_desc.week_in_year_id


      set @log_message = N'Wiederkehrer KW KPI Gesamt Created '
        exec etl.log_event @proc, @arg_job , @log_message

drop table if exists #tmp_app_wk
select
   'Wiederkehrer KW' KPI
   , vw.next_week_id week_id
   , Week_desc.week_in_year_id week
   , count(AKT.customer_id) [app_Anz_1]
   , count(Vw.customer_id) [app_Anz_2]
   , cast (count(AKT.customer_id) as dec(12,2)) /count(Vw.customer_id)   app
into #tmp_app_wk
from #MAU_Vorwoche_APP_WEB VW
left outer join #MAU_aktwoche_APP_WEB AKT
on Vw.customer_id = aKt.customer_id
and VW.next_week_id = akt.week_id
and VW.control_center_desc = aKt.control_center_desc    
left outer join (select distinct week_id, week_short_desc, week_in_year_id from [dm_dom_calender].[date]) Week_desc
on Week_desc.week_id = next_week_id
where VW.control_center_desc = 'App'
group by vw.next_week_id
   , Week_desc.week_in_year_id
   , VW.control_center_desc

      set @log_message = N'Wiederkehrer KW  KPI App Created'
        exec etl.log_event @proc, @arg_job , @log_message

drop table if exists #tmp_web_wk
select
   'Wiederkehrer KW' KPI
   , vw.next_week_id week_id
   , Week_desc.week_in_year_id week
   , count(AKT.customer_id) [web_Anz_1]
   , count(VW.customer_id) [web_Anz_2]
   , cast (count(AKT.customer_id) as dec(12,2)) /count(Vw.customer_id)   web
into #tmp_web_wk
from #MAU_Vorwoche_APP_WEB VW
left outer join #MAU_aktwoche_APP_WEB AKT
on VW.customer_id = aKt.customer_id
and VW.next_week_id = akt.week_id
and VW.control_center_desc = aKt.control_center_desc    
left outer join (select distinct week_id, week_short_desc, week_in_year_id from [dm_dom_calender].[date]) Week_desc
on Week_desc.week_id = next_week_id
where VW.control_center_desc = 'web'
group by VW.next_week_id
   , Week_desc.week_in_year_id
   , VW.control_center_desc

      set @log_message = N'Wiederkehrer KW KPI Web Created'
        exec etl.log_event @proc, @arg_job , @log_message

insert into #PB_week_prozentual
   select
     g.KPI
     ,g.week_id
     ,g.week
     , [gesamt_Anz_1]
     , [gesamt_Anz_2]
     , [gesamt]
     , [web_Anz_1]
     , [web_Anz_2]
     , [web]
     , [app_Anz_1]
     , [app_Anz_2]
     , [app]
     , 2 [order_id]
     , getdate() as currdate
--into #PB_month_prozentual
   from
#tmp_gesamt_wk g
   left outer join #tmp_app_wk a
   on a.week = g.week
   left outer join #tmp_web_wk w
   on w.week = g.week

-----Wiederkehrer KW calculation -- EBIPB-8425 end -------------------------


--drop table if exists #MAU_TMP
--drop table if exists #MAU_Vormonat
--drop table if exists #MAU_aktMonat
--drop table if exists #MAU_Vormonat_APP_WEB
--drop table if exists #MAU_aktMonat_APP_WEB
--drop table if exists #tmp_gesamt
--drop table if exists #tmp_web
--drop table if exists #tmp_app


delete from #PB_day_prozentual where date_id >= @DAY_ID_START  and KPI like  'TCR%'
insert into #PB_day_prozentual
select
   'TCR'
   , date_id    
   , weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de [date]
 , sum ([Anliegen geloest]) [Anliegen geloest]
 , sum ([Gesamt]) [Gesamt]
 , cast(cast(sum ([Anliegen geloest]) as dec(10,2))/ sum ([Gesamt])  as dec(10,4)) [Gesamt]
 , sum ([Anliegen geloest web]) [Anliegen geloest web]
 , sum ([Gesamt web]) [Gesamt web]
 , cast(cast(sum ([Anliegen geloest web]) as dec(10,2))/ sum ([Gesamt web])  as dec(10,4)) [web]
 , sum ([Anliegen geloest]) [Anliegen geloest]
 , sum ([Gesamt app]) [Gesamt app]
 , cast(cast(sum ([Anliegen geloest app]) as dec(10,2))/ sum ([Gesamt app])  as dec(10,4)) app
 , 40 order_id
 , getdate()
from (
   select  
   trigger_Date
   , ea_anliegen_geloest
   , case when ea_anliegen_geloest = 'Ja' then count( customer_id) end [Anliegen geloest]
   , case when ea_anliegen_geloest = 'Nein' then count( customer_id) end [Anliegen gesamt]
   , count( customer_id) as [Gesamt]
   , case when targetgroup_desc = 'Web' and ea_anliegen_geloest = 'Ja' then count( customer_id) end [Anliegen geloest web]
   , case when targetgroup_desc = 'Web' and ea_anliegen_geloest = 'Nein' then count( customer_id) end [Anliegen gesamt web]
   , count(case when targetgroup_desc = 'Web' then customer_id end) as [Gesamt web]
   , case when targetgroup_desc = 'app' and ea_anliegen_geloest = 'Ja' then count( customer_id) end [Anliegen geloest app]
   , case when targetgroup_desc = 'app' and ea_anliegen_geloest = 'Nein' then count( customer_id) end [Anliegen gesamt app]
   , count(case when targetgroup_desc = 'app' then customer_id end) as [Gesamt app]     
   from access.rl_kst.survey_result_pivot_kp_cc
   where trigger_Date between @startdate_day  and @enddate
   group by DATEPART ( iso_week , trigger_Date)
       ,ea_anliegen_geloest
       ,trigger_Date
       ,targetgroup_desc
) tcr
left outer join [dm_dom_calender].[date]
on date = trigger_Date
group by date_id    
   , weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de

insert into #PB_day_prozentual
select
   'TCR ' + ea_produkt
   , date_id    
   , weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de [date]
 , sum ([Anliegen geloest]) [Anliegen geloest]
 , sum ([Gesamt]) [Gesamt]
 , cast(cast(sum ([Anliegen geloest]) as dec(10,2))/ sum ([Gesamt])  as dec(10,4)) [Gesamt]
 , sum ([Anliegen geloest web]) [Anliegen geloest web]
 , sum ([Gesamt web]) [Gesamt web]
 , cast(cast(sum ([Anliegen geloest web]) as dec(10,2))/ sum ([Gesamt web])  as dec(10,4)) [web]
 , sum ([Anliegen geloest]) [Anliegen geloest]
 , sum ([Gesamt app]) [Gesamt app]
 , cast(cast(sum ([Anliegen geloest app]) as dec(10,2))/ sum ([Gesamt app])  as dec(10,4)) app
   , case when  ea_produkt = 'DSL-Vertrag' then 44
       when ea_produkt = 'Mobilfunkvertrag' then 45 end order_id
 , getdate()
from (
   select  
   ea_produkt
   , trigger_Date
   , ea_anliegen_geloest
   , case when ea_anliegen_geloest = 'Ja' then count( customer_id) end [Anliegen geloest]
   , case when ea_anliegen_geloest = 'Nein' then count( customer_id) end [Anliegen gesamt]
   , count( customer_id) as [Gesamt]
   , case when targetgroup_desc = 'Web' and ea_anliegen_geloest = 'Ja' then count( customer_id) end [Anliegen geloest web]
   , case when targetgroup_desc = 'Web' and ea_anliegen_geloest = 'Nein' then count( customer_id) end [Anliegen gesamt web]
   , count(case when targetgroup_desc = 'Web' then customer_id end) as [Gesamt web]
   , case when targetgroup_desc = 'app' and ea_anliegen_geloest = 'Ja' then count( customer_id) end [Anliegen geloest app]
   , case when targetgroup_desc = 'app' and ea_anliegen_geloest = 'Nein' then count( customer_id) end [Anliegen gesamt app]
   , count(case when targetgroup_desc = 'app' then customer_id end) as [Gesamt app]     
   from access.rl_kst.survey_result_pivot_kp_cc
   where trigger_Date between @startdate_day  and @enddate
           --and type_desc not in ('n/a')
           and ea_produkt in ('Mobilfunkvertrag', 'DSL-Vertrag')
   group by DATEPART ( iso_week , trigger_Date)
       ,ea_anliegen_geloest
       ,trigger_Date
       ,targetgroup_desc
       , ea_produkt
) tcr
left outer join [dm_dom_calender].[date]
on date = trigger_Date
group by date_id    
   , weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de
   , case when  ea_produkt = 'DSL-Vertrag' then 44
       when ea_produkt = 'Mobilfunkvertrag' then 45 end  
       ,ea_produkt    

      set @log_message = N'TCR KPIs Created '
        exec etl.log_event @proc, @arg_job , @log_message

delete from #PB_day_prozentual where KPI like  'KST%' and  date_id >= @DAY_ID_START  
insert into #PB_day_prozentual
select
   KPI
   , date_id    
   , weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de [date]
   , sum ([Zufriedenheit]) [Zufriedenheit]
   , sum ([Anzahl]) [Anzahl]
   , cast(cast(sum ([Zufriedenheit]) as dec(10,2))/ sum ([Anzahl])  as dec(10,4))/100  [Gesamt]
   , sum ([Zufriedenheit web]) [Zufriedenheit web]
   , sum ([Anzahl web]) [Anzahl web]
   , cast(cast(sum ([Zufriedenheit web]) as dec(10,2))/ sum ([Anzahl web])  as dec(10,4))/100  [web]
   , sum ([Zufriedenheit app]) [Zufriedenheit app]
   , sum ([Anzahl app]) [Anzahl app]
   , cast(cast(sum ([Zufriedenheit app]) as dec(10,2))/ sum ([Anzahl app])  as dec(10,4))/100  app
   , 30 order_id
 , getdate()
from (
   select
       'KST' KPI
       , trigger_Date
       , sum(ea_kp_zufriedenheit_controlcenter) as Zufriedenheit
       , count(*) as Anzahl
       , case when targetgroup_desc = 'Web' then sum(ea_kp_zufriedenheit_controlcenter) end [Zufriedenheit web]
       , case when targetgroup_desc = 'Web' then count( *) end [Anzahl web]
       , case when targetgroup_desc = 'app' then sum(ea_kp_zufriedenheit_controlcenter) end [Zufriedenheit app]
       , case when targetgroup_desc = 'app' then count( *) end [Anzahl app]
       from access.rl_kst.survey_result_pivot_kp_cc
       where trigger_Date between  @startdate_day  and @enddate

   group by trigger_Date, targetgroup_desc
           ) kst
left outer join [dm_dom_calender].[date]
on date = trigger_Date
group by date_id    
   , weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de
       , kpi

       order by 2,1

insert into #PB_day_prozentual
select
   KPI
   , date_id    
   , weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de [date]
   , sum ([Zufriedenheit]) [Zufriedenheit]
   , sum ([Anzahl]) [Anzahl]
   , cast(cast(sum ([Zufriedenheit]) as dec(10,2))/ sum ([Anzahl])  as dec(10,4))/100  [Gesamt]
   , sum ([Zufriedenheit web]) [Zufriedenheit web]
   , sum ([Anzahl web]) [Anzahl web]
   , cast(cast(sum ([Zufriedenheit web]) as dec(10,2))/ sum ([Anzahl web])  as dec(10,4))/100  [web]
   , sum ([Zufriedenheit app]) [Zufriedenheit app]
   , sum ([Anzahl app]) [Anzahl app]
   , cast(cast(sum ([Zufriedenheit app]) as dec(10,2))/ sum ([Anzahl app])  as dec(10,4))/100  app
   , case when  ea_produkt = 'DSL-Vertrag' then 34
       when ea_produkt = 'Mobilfunkvertrag' then 35 end
 , getdate()
from (
   select
       ea_produkt
       , 'KST ' + ea_produkt KPI
       , trigger_Date
       , sum(ea_kp_zufriedenheit_controlcenter) as Zufriedenheit
       , count(*) as Anzahl
       , case when targetgroup_desc = 'Web' then sum(ea_kp_zufriedenheit_controlcenter) end [Zufriedenheit web]
       , case when targetgroup_desc = 'Web' then count( *) end [Anzahl web]
       , case when targetgroup_desc = 'app' then sum(ea_kp_zufriedenheit_controlcenter) end [Zufriedenheit app]
       , case when targetgroup_desc = 'app' then count( *) end [Anzahl app]
       from access.rl_kst.survey_result_pivot_kp_cc
       where trigger_Date between @startdate_day  and @enddate
       --and type_desc not in ('n/a')
       and ea_produkt in ('Mobilfunkvertrag', 'DSL-Vertrag')
       group by trigger_Date
           , ea_produkt
           ,targetgroup_desc
           ) kst
left outer join [dm_dom_calender].[date]
on date = trigger_Date
group by date_id    
   , weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de
       ,ea_produkt
       , kpi

       order by 2,1
          set @log_message = N'KST daily KPIs Created '
        exec etl.log_event @proc, @arg_job , @log_message

---- WOCHE TCR ---------------

delete from #PB_week_prozentual where KPI like  'TCR%' and WEEK_id >= @WEEK_ID_START  
insert into #PB_week_prozentual
select
   'TCR'
   , week_id
   , week_in_year_id
 , sum ([Anliegen geloest]) [Anliegen geloest]
 , sum ([Gesamt]) [Gesamt]
 , cast(cast(sum ([Anliegen geloest]) as dec(10,2))/ sum ([Gesamt])  as dec(10,4)) [Gesamt]
 , sum ([Anliegen geloest web]) [Anliegen geloest web]
 , sum ([Gesamt web]) [Gesamt web]
 , cast(cast(sum ([Anliegen geloest web]) as dec(10,2))/ sum ([Gesamt web])  as dec(10,4)) [web]
 , sum ([Anliegen geloest]) [Anliegen geloest]
 , sum ([Gesamt app]) [Gesamt app]
 , cast(cast(sum ([Anliegen geloest app]) as dec(10,2))/ sum ([Gesamt app])  as dec(10,4)) app
 , 40 order_id
 , getdate()
from (
   select  
    week_id
   , [date].week_in_year_id
   , case when ea_anliegen_geloest = 'Ja' then count( customer_id) end [Anliegen geloest]
   , case when ea_anliegen_geloest = 'Nein' then count( customer_id) end [Anliegen gesamt]
   , count( customer_id) as [Gesamt]
   , case when targetgroup_desc = 'Web' and ea_anliegen_geloest = 'Ja' then count( customer_id) end [Anliegen geloest web]
   , case when targetgroup_desc = 'Web' and ea_anliegen_geloest = 'Nein' then count( customer_id) end [Anliegen gesamt web]
   , count(case when targetgroup_desc = 'Web' then customer_id end) as [Gesamt web]
   , case when targetgroup_desc = 'app' and ea_anliegen_geloest = 'Ja' then count( customer_id) end [Anliegen geloest app]
   , case when targetgroup_desc = 'app' and ea_anliegen_geloest = 'Nein' then count( customer_id) end [Anliegen gesamt app]
   , count(case when targetgroup_desc = 'app' then customer_id end) as [Gesamt app]     
   from access.rl_kst.survey_result_pivot_kp_cc
    left outer join [dm_dom_calender].[date]
   on date = trigger_Date
   where trigger_Date between @startdate_week and @enddate
   group by
        week_id
       , [date].week_in_year_id
       ,ea_anliegen_geloest
       ,trigger_Date
       ,targetgroup_desc
) tcr
group by
    week_id
   , [week_in_year_id]


insert into #PB_WEEK_prozentual
select
   'TCR ' + ea_produkt
    , week_id
   , [week_in_year_id]
   , sum ([Anliegen geloest]) [Anliegen geloest]
   , sum ([Gesamt]) [Gesamt]
   , cast(cast(sum ([Anliegen geloest]) as dec(10,2))/ sum ([Gesamt])  as dec(10,4)) [Gesamt]
   , sum ([Anliegen geloest web]) [Anliegen geloest web]
   , sum ([Gesamt web]) [Gesamt web]
   , cast(cast(sum ([Anliegen geloest web]) as dec(10,2))/ sum ([Gesamt web])  as dec(10,4)) [web]
   , sum ([Anliegen geloest]) [Anliegen geloest]
   , sum ([Gesamt app]) [Gesamt app]
   , cast(cast(sum ([Anliegen geloest app]) as dec(10,2))/ sum ([Gesamt app])  as dec(10,4)) app
   , case when  ea_produkt = 'DSL-Vertrag' then 44
       when ea_produkt = 'Mobilfunkvertrag' then 45 end
 , getdate()
from (
   select  
   ea_produkt
   , week_id
   , [week_in_year_id]
   , ea_anliegen_geloest
   , case when ea_anliegen_geloest = 'Ja' then count( customer_id) end [Anliegen geloest]
   , case when ea_anliegen_geloest = 'Nein' then count( customer_id) end [Anliegen gesamt]
   , count( customer_id) as [Gesamt]
   , case when targetgroup_desc = 'Web' and ea_anliegen_geloest = 'Ja' then count( customer_id) end [Anliegen geloest web]
   , case when targetgroup_desc = 'Web' and ea_anliegen_geloest = 'Nein' then count( customer_id) end [Anliegen gesamt web]
   , count(case when targetgroup_desc = 'Web' then customer_id end) as [Gesamt web]
   , case when targetgroup_desc = 'app' and ea_anliegen_geloest = 'Ja' then count( customer_id) end [Anliegen geloest app]
   , case when targetgroup_desc = 'app' and ea_anliegen_geloest = 'Nein' then count( customer_id) end [Anliegen gesamt app]
   , count(case when targetgroup_desc = 'app' then customer_id end) as [Gesamt app]     
   from access.rl_kst.survey_result_pivot_kp_cc
    left outer join [dm_dom_calender].[date]
   on date = trigger_Date    
   where trigger_Date between @startdate_week  and @enddate
   --and type_desc not in ('n/a')
   and ea_produkt in ('Mobilfunkvertrag', 'DSL-Vertrag')
   group by
        week_id
       , [week_in_year_id]
       , ea_anliegen_geloest
       , targetgroup_desc
       , ea_produkt
) tcr
group by
       week_id
       , [week_in_year_id]
       , case when  ea_produkt = 'DSL-Vertrag' then 44
       when ea_produkt = 'Mobilfunkvertrag' then 45 end
       ,ea_produkt

          set @log_message = N'TCR weekly KPIs Created '
        exec etl.log_event @proc, @arg_job , @log_message


---- WOCHE KST ---------------

delete from #PB_week_prozentual where KPI like  'KST%' and WEEK_id >= @WEEK_ID_START  
insert into #PB_week_prozentual
select
   KPI
   , week_id
   , [week_in_year_id]
   , sum ([Zufriedenheit]) [Zufriedenheit]
   , sum ([Anzahl]) [Anzahl]
   , cast(cast(sum ([Zufriedenheit]) as dec(10,2))/ sum ([Anzahl])  as dec(10,4)) /100 [Gesamt]
   , sum ([Zufriedenheit web]) [Zufriedenheit web]
   , sum ([Anzahl web]) [Anzahl web]
   , cast(cast(sum ([Zufriedenheit web]) as dec(10,2))/ sum ([Anzahl web])  as dec(10,4)) /100  [web]
   , sum ([Zufriedenheit app]) [Zufriedenheit app]
   , sum ([Anzahl app]) [Anzahl app]
   , cast(cast(sum ([Zufriedenheit app]) as dec(10,2))/ sum ([Anzahl app])  as dec(10,4)) /100  app
   , 30 order_id
 , getdate()
from (
   select
       'KST' KPI
       , week_id
       , [week_in_year_id]
       , sum(ea_kp_zufriedenheit_controlcenter) as Zufriedenheit
       , count(*) as Anzahl
       , case when targetgroup_desc = 'Web' then sum(ea_kp_zufriedenheit_controlcenter) end [Zufriedenheit web]
       , case when targetgroup_desc = 'Web' then count( *) end [Anzahl web]
       , case when targetgroup_desc = 'app' then sum(ea_kp_zufriedenheit_controlcenter) end [Zufriedenheit app]
       , case when targetgroup_desc = 'app' then count( *) end [Anzahl app]
       from access.rl_kst.survey_result_pivot_kp_cc
       left outer join [dm_dom_calender].[date]
       on date = trigger_Date
       where trigger_Date between @startdate_week  and @enddate
       group by
           week_id
           ,[week_in_year_id]
           ,targetgroup_desc
       ) kst
group by week_id
       , [week_in_year_id]
       , kpi


insert into #PB_week_prozentual
select
   KPI
   , week_id
   , [week_in_year_id]
   , sum ([Zufriedenheit]) [Zufriedenheit]
   , sum ([Anzahl]) [Anzahl]
   , cast(cast(sum ([Zufriedenheit]) as dec(10,2))/ sum ([Anzahl])  as dec(10,4)) /100  [Gesamt]
   , sum ([Zufriedenheit web]) [Zufriedenheit web]
   , sum ([Anzahl web]) [Anzahl web]
   , cast(cast(sum ([Zufriedenheit web]) as dec(10,2))/ sum ([Anzahl web])  as dec(10,4)) /100 [web]
   , sum ([Zufriedenheit app]) [Zufriedenheit app]
   , sum ([Anzahl app]) [Anzahl app]
   , cast(cast(sum ([Zufriedenheit app]) as dec(10,2))/ sum ([Anzahl app])  as dec(10,4)) /100 app
   , case when  ea_produkt = 'DSL-Vertrag' then 34
       when ea_produkt = 'Mobilfunkvertrag' then 35 end
 , getdate()
from (
   select
       ea_produkt
       , 'KST ' + ea_produkt KPI
       , week_id
       , [week_in_year_id]
       , sum(ea_kp_zufriedenheit_controlcenter) as Zufriedenheit
       , count(*) as Anzahl
       , case when targetgroup_desc = 'Web' then sum(ea_kp_zufriedenheit_controlcenter) end [Zufriedenheit web]
       , case when targetgroup_desc = 'Web' then count( *) end [Anzahl web]
       , case when targetgroup_desc = 'app' then sum(ea_kp_zufriedenheit_controlcenter) end [Zufriedenheit app]
       , case when targetgroup_desc = 'app' then count( *) end [Anzahl app]
       from access.rl_kst.survey_result_pivot_kp_cc
       left outer join [dm_dom_calender].[date]
       on date = trigger_Date
       where trigger_Date between @startdate_week  and @enddate
       --and type_desc not in ('n/a')
       and ea_produkt in ('Mobilfunkvertrag', 'DSL-Vertrag')
       group by week_id
           , [week_in_year_id]
           , case when  ea_produkt = 'DSL-Vertrag' then 34         
               when ea_produkt = 'Mobilfunkvertrag' then 35 end
           , targetgroup_desc
           ,ea_produkt
           ) kst

group by week_id
       , [week_in_year_id]
       , ea_produkt
       , kpi

       order by 2,1

          set @log_message = N'KST weekly KPIs Created '
        exec etl.log_event @proc, @arg_job , @log_message

---- MONAT TCR --------

delete from #PB_month_prozentual where KPI like  'TCR%' and MONTH_id >= @MONTH_ID_START  
insert into #PB_month_prozentual
select
   'TCR'
   , month_id
   , month
   , sum ([Anliegen geloest]) [Anliegen geloest]
 , sum ([Gesamt]) [Gesamt]
 , cast(cast(sum ([Anliegen geloest]) as dec(10,2))/ sum ([Gesamt])  as dec(10,4)) [Gesamt]
 , sum ([Anliegen geloest web]) [Anliegen geloest web]
 , sum ([Gesamt web]) [Gesamt web]
 , cast(cast(sum ([Anliegen geloest web]) as dec(10,2))/ sum ([Gesamt web])  as dec(10,4)) [web]
 , sum ([Anliegen geloest]) [Anliegen geloest]
 , sum ([Gesamt app]) [Gesamt app]
 , cast(cast(sum ([Anliegen geloest app]) as dec(10,2))/ sum ([Gesamt app])  as dec(10,4)) app
 , 40 order_id
 , getdate()
from (
   select  
    month_id
   , [date].month_short_desc_de month
   , case when ea_anliegen_geloest = 'Ja' then count( customer_id) end [Anliegen geloest]
   , case when ea_anliegen_geloest = 'Nein' then count( customer_id) end [Anliegen gesamt]
   , count( customer_id) as [Gesamt]
   , case when targetgroup_desc = 'Web' and ea_anliegen_geloest = 'Ja' then count( customer_id) end [Anliegen geloest web]
   , case when targetgroup_desc = 'Web' and ea_anliegen_geloest = 'Nein' then count( customer_id) end [Anliegen gesamt web]
   , count(case when targetgroup_desc = 'Web' then customer_id end) as [Gesamt web]
   , case when targetgroup_desc = 'app' and ea_anliegen_geloest = 'Ja' then count( customer_id) end [Anliegen geloest app]
   , case when targetgroup_desc = 'app' and ea_anliegen_geloest = 'Nein' then count( customer_id) end [Anliegen gesamt app]
   , count(case when targetgroup_desc = 'app' then customer_id end) as [Gesamt app]     
   from access.rl_kst.survey_result_pivot_kp_cc
    left outer join [dm_dom_calender].[date]
   on date = trigger_Date
   where trigger_Date between @startdate_month and @enddate
   group by
       month_id
       , [date].month_short_desc_de
       ,ea_anliegen_geloest
       ,trigger_Date
       ,targetgroup_desc
) tcr
group by
    month_id
   , month


insert into #PB_MONTH_prozentual
select
   'TCR ' + ea_produkt
   , month_id
   , month
   , sum ([Anliegen geloest]) [Anliegen geloest]
   , sum ([Gesamt]) [Gesamt]
   , cast(cast(sum ([Anliegen geloest]) as dec(10,2))/ sum ([Gesamt])  as dec(10,4)) [Gesamt]
   , sum ([Anliegen geloest web]) [Anliegen geloest web]
   , sum ([Gesamt web]) [Gesamt web]
   , cast(cast(sum ([Anliegen geloest web]) as dec(10,2))/ sum ([Gesamt web])  as dec(10,4)) [web]
   , sum ([Anliegen geloest]) [Anliegen geloest]
   , sum ([Gesamt app]) [Gesamt app]
   , cast(cast(sum ([Anliegen geloest app]) as dec(10,2))/ sum ([Gesamt app])  as dec(10,4)) app
   , case when  ea_produkt = 'DSL-Vertrag' then 44
       when ea_produkt = 'Mobilfunkvertrag' then 45 end
 , getdate()
from (
   select  
   ea_produkt
   , month_id
   , month_short_desc_de month
   , ea_anliegen_geloest
   , case when ea_anliegen_geloest = 'Ja' then count( customer_id) end [Anliegen geloest]
   , case when ea_anliegen_geloest = 'Nein' then count( customer_id) end [Anliegen gesamt]
   , count( customer_id) as [Gesamt]
   , case when targetgroup_desc = 'Web' and ea_anliegen_geloest = 'Ja' then count( customer_id) end [Anliegen geloest web]
   , case when targetgroup_desc = 'Web' and ea_anliegen_geloest = 'Nein' then count( customer_id) end [Anliegen gesamt web]
   , count(case when targetgroup_desc = 'Web' then customer_id end) as [Gesamt web]
   , case when targetgroup_desc = 'app' and ea_anliegen_geloest = 'Ja' then count( customer_id) end [Anliegen geloest app]
   , case when targetgroup_desc = 'app' and ea_anliegen_geloest = 'Nein' then count( customer_id) end [Anliegen gesamt app]
   , count(case when targetgroup_desc = 'app' then customer_id end) as [Gesamt app]     
   from access.rl_kst.survey_result_pivot_kp_cc
    left outer join [dm_dom_calender].[date]
   on date = trigger_Date    
   where trigger_Date between @startdate_month  and @enddate --and targetgroup_desc = 'Web'
       --and type_desc not in ('n/a')
       and ea_produkt in ('Mobilfunkvertrag', 'DSL-Vertrag')
   group by
        month_id
       , [date].month_short_desc_de
       , ea_anliegen_geloest
       , targetgroup_desc
       , ea_produkt
) tcr
group by
    month_id
   , month
   , case when  ea_produkt = 'DSL-Vertrag' then 44
       when ea_produkt = 'Mobilfunkvertrag' then 45 end
   ,ea_produkt

          set @log_message = N'TCR monthly KPIs Created '
        exec etl.log_event @proc, @arg_job , @log_message


---- MONAT KST ---------------

delete from #PB_month_prozentual where KPI like  'KST%' and MONTH_ID >= @MONTH_ID_START  
insert into #PB_month_prozentual
select
   KPI
   , month_id
   ,  month
   , sum ([Zufriedenheit]) [Zufriedenheit]
   , sum ([Anzahl]) [Anzahl]
   , cast(cast(sum ([Zufriedenheit]) as dec(10,2))/ sum ([Anzahl])  as dec(10,4)) /100 [Gesamt]
   , sum ([Zufriedenheit web]) [Zufriedenheit web]
   , sum ([Anzahl web]) [Anzahl web]
   , cast(cast(sum ([Zufriedenheit web]) as dec(10,2))/ sum ([Anzahl web])  as dec(10,4)) /100  [web]
   , sum ([Zufriedenheit app]) [Zufriedenheit app]
   , sum ([Anzahl app]) [Anzahl app]
   , cast(cast(sum ([Zufriedenheit app]) as dec(10,2))/ sum ([Anzahl app])  as dec(10,4)) /100  app
   , 30 order_id
 , getdate()
from (
   select
       'KST' KPI
       , month_id
       , [date].month_short_desc_de month
       , sum(ea_kp_zufriedenheit_controlcenter) as Zufriedenheit
       , count(*) as Anzahl
       , case when targetgroup_desc = 'Web' then sum(ea_kp_zufriedenheit_controlcenter) end [Zufriedenheit web]
       , case when targetgroup_desc = 'Web' then count( *) end [Anzahl web]
       , case when targetgroup_desc = 'app' then sum(ea_kp_zufriedenheit_controlcenter) end [Zufriedenheit app]
       , case when targetgroup_desc = 'app' then count( *) end [Anzahl app]
       from access.rl_kst.survey_result_pivot_kp_cc
       left outer join [dm_dom_calender].[date]
       on date = trigger_Date
       where trigger_Date between @startdate_month and @enddate
       group by
        month_id
       , [date].month_short_desc_de
       ,targetgroup_desc
       ) kst
group by month_id
   , month
   , kpi

insert into #PB_month_prozentual
select
   KPI
   , month_id
   , month
   , sum ([Zufriedenheit]) [Zufriedenheit]
   , sum ([Anzahl]) [Anzahl]
   , cast(cast(sum ([Zufriedenheit]) as dec(10,2))/ sum ([Anzahl])  as dec(10,4)) /100  [Gesamt]
   , sum ([Zufriedenheit web]) [Zufriedenheit web]
   , sum ([Anzahl web]) [Anzahl web]
   , cast(cast(sum ([Zufriedenheit web]) as dec(10,2))/ sum ([Anzahl web])  as dec(10,4)) /100 [web]
   , sum ([Zufriedenheit app]) [Zufriedenheit app]
   , sum ([Anzahl app]) [Anzahl app]
   , cast(cast(sum ([Zufriedenheit app]) as dec(10,2))/ sum ([Anzahl app])  as dec(10,4)) /100 app
   , case when  ea_produkt = 'DSL-Vertrag' then 34         
               when ea_produkt = 'Mobilfunkvertrag' then 35 end
 , getdate()
from (
   select
       ea_produkt
       ,'KST ' +  ea_produkt KPI
   , month_id
   , [date].month_short_desc_de month
       , sum(ea_kp_zufriedenheit_controlcenter) as Zufriedenheit
       , count(*) as Anzahl
       , case when targetgroup_desc = 'Web' then sum(ea_kp_zufriedenheit_controlcenter) end [Zufriedenheit web]
       , case when targetgroup_desc = 'Web' then count( *) end [Anzahl web]
       , case when targetgroup_desc = 'app' then sum(ea_kp_zufriedenheit_controlcenter) end [Zufriedenheit app]
       , case when targetgroup_desc = 'app' then count( *) end [Anzahl app]
       from access.rl_kst.survey_result_pivot_kp_cc
       left outer join [dm_dom_calender].[date]
       on date = trigger_Date
       where trigger_Date between @startdate_month  and @enddate
       --and type_desc not in ('n/a')
       and ea_produkt in ('Mobilfunkvertrag', 'DSL-Vertrag')
       group by     
           month_id
           , [date].month_short_desc_de
           , case when  ea_produkt = 'DSL-Vertrag' then 34         
               when ea_produkt = 'Mobilfunkvertrag' then 35 end
           , targetgroup_desc
           ,ea_produkt
           ) kst

group by month_id
       , month
       , ea_produkt
       , kpi

       order by 2,1

     set @log_message = N'KST monthly KPIs Created '
     exec etl.log_event @proc, @arg_job , @log_message
--------------------- 05 ------------------------


drop table if exists #function_calls_FCR
select
   customer_id
   ,function_call_date
   , c.week_id
   , min(min_function_call) as min_function_call
   , min (case when control_center_desc = 'app' then min_function_call end) min_function_call_app
   , min (case when control_center_desc = 'web' then min_function_call end) min_function_call_web
into  #function_calls_FCR
from (
   select  
       [customer_id]
       , control_center_desc
       , [function_call_date]
        , MIN (CAST (convert(varchar(20), function_call_date ) +  ' ' + convert(varchar(20),[function_call_timestamp] ) as datetime2)) min_function_call
            from  [dm_dom_self_care].[control_center_function_call]
           where [function_call_date]  between @startdate and  @enddate
               and coalesce([customer_id], -1) <> -1
           group by [customer_id], [function_call_date], control_center_desc
           ) b
   left outer JOIN [dm_dom_calendar].[date] c on b.[function_call_date] = c.date
group by [customer_id], function_call_date , c.week_id


--start and end date of a week
DROP TABLE IF EXISTS #week_table;
SELECT week_id,
      week_in_year_id,
      MIN(date) AS start_week,
      MAX(date) AS end_week,
      COUNT(*) AS cnt_days_in_week,
      CASE WHEN CAST(GETDATE() AS DATE) BETWEEN MIN(date) AND MAX(date) then 1 ELSE 0 end AS is_current_week
INTO #week_table
FROM [dm_dom_calendar].[date]
WHERE date BETWEEN @startdate AND CAST(GETDATE() AS DATE)
GROUP BY week_id,
        week_in_year_id;


drop table if exists #calls
select
   s.customer_id
   , case when min_function_call_app is not null then s.customer_id end customer_id_app
   , case when min_function_call_web is not null then s.customer_id end customer_id_web
   , function_call_date
   , t.date_id as tag_calculation_time
   , t.weekday_short_desc_de + ', '+ substring(t.date_short_desc_de, 1,3) + t.month_short_desc_de as tag_calculation_time_desc
   , t.month_id
   , t.month_short_desc_de
   , min_function_call
   , min_function_call_app
   , min_function_call_web
   , CAST (call_incoming_datetime as date) as call_date
   , wt.week_id
   , wt.week_in_year_id
   , wt.start_week
   , wt.end_week

   , case WHEN function_call_date = CAST(d.call_incoming_datetime AS DATE) and min_function_call <=  call_incoming_datetime then 1 else 0 end call_JN
   , CASE when min_function_call <= call_incoming_datetime and call_incoming_datetime <= DATEADD(Day, 7, function_call_date) then 1 else 0 end call_JN_fcr7
   , CASE WHEN month(call_incoming_datetime) = month(function_call_date) AND  year(function_call_date) = year(call_incoming_datetime) and min_function_call <=  call_incoming_datetime then 1 else 0 end call_JN_cc_nutzer
   , CASE WHEN CAST(d.call_incoming_datetime AS DATE) between wt.start_week and wt.end_week and min_function_call <=  call_incoming_datetime then 1 else 0 end call_JN_cc_nutzer_weekly
   
   , case when function_call_date = CAST(d.call_incoming_datetime AS DATE) AND min_function_call_app <=  call_incoming_datetime then 1 else 0 end call_app_JN
   , CASE when min_function_call_app <= call_incoming_datetime and call_incoming_datetime <= DATEADD(Day, 7, cast(min_function_call_app as date)) then 1 else 0 end call_app_JN_fcr7
   , case when month(call_incoming_datetime) = month(function_call_date) AND  year(function_call_date) = year(call_incoming_datetime) AND min_function_call_app <=  call_incoming_datetime then 1 else 0 end call_app_JN_cc_nutzer
   , CASE WHEN CAST(d.call_incoming_datetime AS DATE) between wt.start_week and wt.end_week and min_function_call_app <=  call_incoming_datetime then 1 else 0 end call_app_JN_cc_nutzer_weekly
  
  , case when function_call_date = CAST(d.call_incoming_datetime AS DATE) AND min_function_call_web <=  call_incoming_datetime then 1 else 0 end call_web_JN
   , CASE when min_function_call_web <= call_incoming_datetime  and call_incoming_datetime <= DATEADD(Day, 7, cast(min_function_call_web as date)) then 1 else 0 end call_web_JN_fcr7
   , case when month(call_incoming_datetime) = month(function_call_date) AND  year(function_call_date) = year(call_incoming_datetime) AND min_function_call_web <=  call_incoming_datetime then 1 else 0 end call_web_JN_cc_nutzer
   , CASE WHEN CAST(d.call_incoming_datetime AS DATE) between wt.start_week and wt.end_week and min_function_call_web <=  call_incoming_datetime then 1 else 0 end call_web_JN_cc_nutzer_weekly

   , call_incoming_datetime
   , call_id
   , dialog_id
   , dialog_incoming_datetime
   , first_queue_hist_id
   , first_queue_id
   , last_queue_hist_id
   , last_queue_id
   , mandator_id
   , d.source_forecast_designation_id
   , fd.forecast_designation_desc
   , case when fd.forecast_designation_desc like '%PTB%' or fd.forecast_designation_desc like '%1_RT%' or fd.forecast_designation_desc like '%Telesales%' then 'Call Sales'
       when forecast_designation_desc is not NULL then 'Call Service'
       else NULL end as call_desc
	 , case when fd.forecast_designation_desc in (    'Not Forecasted',
                                                       '1&1 Customer Service DSL Technology',
                                                       '1&1 Business Service Kfm',
                                                       '1&1 Nachtschicht',
                                                       '1&1 Search Call',
                                                       '1&1 Customer Service BCM Backoffice',
                                                       '1&1 Business Service Technik',
                                                       '1&1 Customer Service Mobile Technology')
                                                   or fd.forecast_designation_desc like '%1&1 Concierge%'
                                                   or fd.forecast_designation_desc like '%1&1 Technik%'
                       then 'Call Customer Service'
						when forecast_designation_desc in (    '1&1 BSD Team II',
                                                       '1&1 Bereitstellung Mobile_Blue_Belt',
                                                       '1&1 BSD Team I',
                                                       '1&1 Bereitstellung Mobile_Green_Belt',
                                                       '1&1 Bereitstellung Mobile_Black_Belt',
                                                       '1&1 BSM Migrationen',
                                                       '1&1 Bereitstellung Mobile',
                                                       'TSM Sales Partner & Business Service',
                                                       'TSM FDM')
                                                   or fd.forecast_designation_desc like '%Onboarding%'
                       then 'Call Onboarding'
						when forecast_designation_desc in (    '1&1 PTB Gesamt',
                                                           'Telesales_Gesamt_FC_Mi_u_DSL')
                       then 'Call PTB'
                     when forecast_designation_desc in ('DE_1u1_RT_Mobile_1st',
                                                        'DE_1u1_RT_Access_1st',
                                                        '1&1_RT_Storno_Online')
                       then 'Call Retention'
                      when forecast_designation_desc in ('1&1 5g Kundenmigration_voice', 'DRI 5g Kundenmigration_voice')
                       then 'Call 5G'
                     when fd.forecast_designation_desc IS NOT NULL
                       then 'Call Rest'
                     else null
                     END as call_desc_detail
           --else 'Call Rest' end as call_desc_detail
   , d.tracking_item_1_hist_id
   , d.tracking_item_2_hist_id
   , tih_1.tracking_item_desc tracking_item_1_desc
   , tih_1.tracking_mgmt_category_desc tracking_mgmt_category_1_desc
   , tih_2.tracking_item_desc tracking_item_2_desc
   , tih_2.tracking_mgmt_category_desc tracking_mgmt_category_2_desc
into #calls
from #function_calls_FCR s
left outer join dm_dom_customer_care.dialog d
on d.customer_id = s.customer_id
       and direction_id='8' /*Incoming*/
       --and is_offered_ind=1 /*wurde nicht vor IVR abgeborchen*/
       and is_handled_ind=1
       and mandator_id = 2
       and CAST(d.call_incoming_datetime AS DATE) between   @startdate and @enddate
left outer join [dm_dom_calendar].[date] t ON s.function_call_date=t.date
left join dm_dom_customer_care.forecast_designation fd
on d.source_forecast_designation_id = fd.forecast_designation_id
left outer join [dm_dom_customer_care].[tracking_item_hist] tih_1
on d.tracking_item_1_hist_id = tih_1. [tracking_item_hist_id]
left outer join [dm_dom_customer_care].[tracking_item_hist] tih_2
on d.tracking_item_2_hist_id = tih_2.[tracking_item_hist_id]
left outer join #week_table wt
on s.week_id=wt.week_id
   

drop table if exists #FCR1
select
    function_call_date
  , 'FCR 1' FCR
  , SUM([Anzahl Kunden ohne anschliessendem Call]) [Anzahl Kunden ohne anschliessendem Call]
  , SUM([Anzahl Kunden mit anschliessendem Call]) [Anzahl Kunden mit anschliessendem Call]
  , SUM([Anzahl Kunden gesamt (DAU)] ) [Anzahl Kunden gesamt (DAU)]
  , SUM([Anzahl Kunden App ohne anschliessendem Call]) [Anzahl Kunden App ohne anschliessendem Call]
  , SUM([Anzahl Kunden App mit anschliessendem Call]) [Anzahl Kunden App mit anschliessendem Call]
  , SUM([Anzahl Kunden App gesamt (DAU)] ) [Anzahl Kunden App gesamt (DAU)]
  , SUM([Anzahl Kunden Web ohne anschliessendem Call]) [Anzahl Kunden Web ohne anschliessendem Call]
  , SUM([Anzahl Kunden Web mit anschliessendem Call]) [Anzahl Kunden Web mit anschliessendem Call]
  , SUM([Anzahl Kunden Web gesamt (DAU)] ) [Anzahl Kunden Web gesamt (DAU)]
  into #FCR1
from (
      select function_call_date
      ,  COUNT(distinct case when call_JN = 0 then customer_id end) [Anzahl Kunden ohne anschliessendem Call]
      ,  COUNT(distinct case when call_JN = 1 then customer_id end) [Anzahl Kunden mit anschliessendem Call]
      ,  COUNT(distinct customer_id) [Anzahl Kunden gesamt (DAU)]
      ,  COUNT(distinct case when call_app_JN = 0 then customer_id_app end) [Anzahl Kunden App ohne anschliessendem Call]
      ,  COUNT(distinct case when call_app_JN = 1 then customer_id_app end) [Anzahl Kunden App mit anschliessendem Call]
      ,  COUNT(distinct customer_id_app) [Anzahl Kunden App gesamt (DAU)]
      ,  COUNT(distinct case when call_web_JN = 0 then customer_id_web end) [Anzahl Kunden Web ohne anschliessendem Call]
      ,  COUNT(distinct case when call_web_JN = 1 then customer_id_web end) [Anzahl Kunden Web mit anschliessendem Call]
      ,  COUNT(distinct customer_id_web) [Anzahl Kunden Web gesamt (DAU)]
      from (
      select
          customer_id
          , customer_id_app
          , customer_id_web
          , function_call_date
           , max(call_JN) call_JN
           , max(call_app_JN) call_app_JN
           , max(call_web_JN) call_web_JN
           from #calls
          group by customer_id
          , customer_id_app
          , customer_id_web
          , function_call_date
          )
          g
          group by call_JN, function_call_date
          )
          g
          group by function_call_date    
          order by 1



delete from  #PB_month_prozentual  where [month_id] >= @MONTH_ID_START and KPI = 'FCR 1'
insert into #PB_month_prozentual
select
   'FCR 1' KPI
   , month_id
   , [date].month_short_desc_de month
   , SUM([Anzahl Kunden ohne anschliessendem Call]) [Anzahl Kunden ohne anschliessendem Call]
   , SUM([Anzahl Kunden gesamt (DAU)] ) [Anzahl Kunden gesamt (DAU)]
   , cast(SUM([Anzahl Kunden ohne anschliessendem Call]) as dec(10,2)) / SUM([Anzahl Kunden gesamt (DAU)] ) [gesamt]

   , SUM([Anzahl Kunden web ohne anschliessendem Call]) [Anzahl Kunden ohne anschliessendem Call]
   , SUM([Anzahl Kunden web gesamt (DAU)] ) [Anzahl Kunden gesamt (DAU)]
   , cast(SUM([Anzahl Kunden web ohne anschliessendem Call]) as dec(10,2)) / SUM([Anzahl Kunden web gesamt (DAU)] ) web

   , SUM([Anzahl Kunden app ohne anschliessendem Call]) [Anzahl Kunden ohne anschliessendem Call]
   , SUM([Anzahl Kunden app gesamt (DAU)] ) [Anzahl Kunden gesamt (DAU)]
   , cast(SUM([Anzahl Kunden app ohne anschliessendem Call]) as dec(10,2)) / SUM([Anzahl Kunden app gesamt (DAU)] ) web
   , 18 order_id
    , getdate() Aktualisierungsdatum
   from #FCR1
left outer join [dm_dom_calender].[date]
    on date = function_call_date
    where function_call_date >= @startdate_month
   group by  month_id
   , [date].month_short_desc_de
   order by 2

              set @log_message = N'FCR 1 monthly KPIs Created '
        exec etl.log_event @proc, @arg_job , @log_message

delete from  #PB_week_prozentual  where week_id >= @WEEK_ID_START and KPI = 'FCR 1'
insert into #PB_week_prozentual
select
   'FCR 1' KPI
   , week_id
   , [date].week_in_year_id
   , SUM([Anzahl Kunden ohne anschliessendem Call]) [Anzahl Kunden ohne anschliessendem Call]
   , SUM([Anzahl Kunden gesamt (DAU)] ) [Anzahl Kunden gesamt (DAU)]
   , cast(SUM([Anzahl Kunden ohne anschliessendem Call]) as dec(10,2)) / SUM([Anzahl Kunden gesamt (DAU)] ) [gesamt]

   , SUM([Anzahl Kunden web ohne anschliessendem Call]) [Anzahl Kunden ohne anschliessendem Call]
   , SUM([Anzahl Kunden web gesamt (DAU)] ) [Anzahl Kunden gesamt (DAU)]
   , cast(SUM([Anzahl Kunden web ohne anschliessendem Call]) as dec(10,2)) / SUM([Anzahl Kunden web gesamt (DAU)] ) web

   , SUM([Anzahl Kunden app ohne anschliessendem Call]) [Anzahl Kunden ohne anschliessendem Call]
   , SUM([Anzahl Kunden app gesamt (DAU)] ) [Anzahl Kunden gesamt (DAU)]
   , cast(SUM([Anzahl Kunden app ohne anschliessendem Call]) as dec(10,2)) / SUM([Anzahl Kunden app gesamt (DAU)] ) web
   , 18 order_id
    , getdate() Aktualisierungsdatum
from #FCR1
left outer join [dm_dom_calender].[date]
    on date = function_call_date
    where function_call_date >= @startdate_week
   group by       week_id
   , [date].week_in_year_id
   order by 2



delete from  #PB_day_prozentual  where date_id >= @DAY_ID_START and KPI = 'FCR 1'
insert into #PB_day_prozentual
select
   'FCR 1' KPI
   , date_id    
   , weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de [date]
   , SUM([Anzahl Kunden ohne anschliessendem Call]) [Anzahl Kunden ohne anschliessendem Call]
   , SUM([Anzahl Kunden gesamt (DAU)] ) [Anzahl Kunden gesamt (DAU)]
   , cast(SUM([Anzahl Kunden ohne anschliessendem Call]) as dec(10,2)) / SUM([Anzahl Kunden gesamt (DAU)] ) [gesamt]

   , SUM([Anzahl Kunden web ohne anschliessendem Call]) [Anzahl Kunden ohne anschliessendem Call]
   , SUM([Anzahl Kunden web gesamt (DAU)] ) [Anzahl Kunden gesamt (DAU)]
   , cast(SUM([Anzahl Kunden web ohne anschliessendem Call]) as dec(10,2)) / SUM([Anzahl Kunden web gesamt (DAU)] ) web

   , SUM([Anzahl Kunden app ohne anschliessendem Call]) [Anzahl Kunden ohne anschliessendem Call]
   , SUM([Anzahl Kunden app gesamt (DAU)] ) [Anzahl Kunden gesamt (DAU)]
   , cast(SUM([Anzahl Kunden app ohne anschliessendem Call]) as dec(10,2)) / SUM([Anzahl Kunden app gesamt (DAU)] ) web
   , 18 order_id
    , getdate() Aktualisierungsdatum
from #FCR1
left outer join [dm_dom_calender].[date]
    on date = function_call_date
        where function_call_date >= @startdate_day
        group by       date_id    
   , weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de
   order by 2
                  set @log_message = N'FCR 1 weekly KPIs Created '
        exec etl.log_event @proc, @arg_job , @log_message

-----------------------------------------
drop table if exists #FCR7
select
     function_call_date
   , 'FCR 7' FCR
   , SUM([Anzahl Kunden ohne anschliessendem Call]) [Anzahl Kunden ohne anschliessendem Call]
   , SUM([Anzahl Kunden mit anschliessendem Call]) [Anzahl Kunden mit anschliessendem Call]
   , SUM([Anzahl Kunden gesamt (DAU)] ) [Anzahl Kunden gesamt (DAU)]
   , SUM([Anzahl Kunden App ohne anschliessendem Call]) [Anzahl Kunden App ohne anschliessendem Call]
   , SUM([Anzahl Kunden App mit anschliessendem Call]) [Anzahl Kunden App mit anschliessendem Call]
   , SUM([Anzahl Kunden App gesamt (DAU)] ) [Anzahl Kunden App gesamt (DAU)]
   , SUM([Anzahl Kunden Web ohne anschliessendem Call]) [Anzahl Kunden Web ohne anschliessendem Call]
   , SUM([Anzahl Kunden Web mit anschliessendem Call]) [Anzahl Kunden Web mit anschliessendem Call]
   , SUM([Anzahl Kunden Web gesamt (DAU)] ) [Anzahl Kunden Web gesamt (DAU)]
   into #FCR7
from (
       select function_call_date
       ,  COUNT(distinct case when call_JN = 0 then customer_id end) [Anzahl Kunden ohne anschliessendem Call]
       ,  COUNT(distinct case when call_JN = 1 then customer_id end) [Anzahl Kunden mit anschliessendem Call]
       ,  COUNT(distinct customer_id) [Anzahl Kunden gesamt (DAU)]
       ,  COUNT(distinct case when call_app_JN = 0 then customer_id_app end) [Anzahl Kunden App ohne anschliessendem Call]
       ,  COUNT(distinct case when call_app_JN = 1 then customer_id_app end) [Anzahl Kunden App mit anschliessendem Call]
       ,  COUNT(distinct customer_id_app) [Anzahl Kunden App gesamt (DAU)]
       ,  COUNT(distinct case when call_web_JN = 0 then customer_id_web end) [Anzahl Kunden Web ohne anschliessendem Call]
       ,  COUNT(distinct case when call_web_JN = 1 then customer_id_web end) [Anzahl Kunden Web mit anschliessendem Call]
       ,  COUNT(distinct customer_id_web) [Anzahl Kunden Web gesamt (DAU)]
            from (
                   select
                      customer_id
                      , customer_id_app
                      , customer_id_web
                      , function_call_date
                       , max(call_JN_fcr7) call_JN
                       , max(call_app_JN_fcr7) call_app_JN
                       , max(call_web_JN_fcr7) call_web_JN
                      FROM #calls
                      group by customer_id
                              , customer_id_app
                              , customer_id_web
                              , function_call_date
                      ) g
                      group by call_JN, function_call_date
               ) g
               group by function_call_date    
               order by 1


delete from  #PB_month_prozentual  where [month_id] >= @MONTH_ID_START and KPI = 'FCR 7'
insert into #PB_month_prozentual
select
   'FCR 7' KPI
   , month_id
   , [date].month_short_desc_de month
   , SUM([Anzahl Kunden ohne anschliessendem Call]) [Anzahl Kunden ohne anschliessendem Call]
   , SUM([Anzahl Kunden gesamt (DAU)] ) [Anzahl Kunden gesamt (DAU)]
   , cast(SUM([Anzahl Kunden ohne anschliessendem Call]) as dec(10,2)) / SUM([Anzahl Kunden gesamt (DAU)] ) [gesamt]

   , SUM([Anzahl Kunden web ohne anschliessendem Call]) [Anzahl Kunden ohne anschliessendem Call]
   , SUM([Anzahl Kunden web gesamt (DAU)] ) [Anzahl Kunden gesamt (DAU)]
   , cast(SUM([Anzahl Kunden web ohne anschliessendem Call]) as dec(10,2)) / SUM([Anzahl Kunden web gesamt (DAU)] ) web

   , SUM([Anzahl Kunden app ohne anschliessendem Call]) [Anzahl Kunden ohne anschliessendem Call]
   , SUM([Anzahl Kunden app gesamt (DAU)] ) [Anzahl Kunden gesamt (DAU)]
   , cast(SUM([Anzahl Kunden app ohne anschliessendem Call]) as dec(10,2)) / SUM([Anzahl Kunden app gesamt (DAU)] ) web
   , 20 order_id
    , getdate() Aktualisierungsdatum
   from #FCR7
left outer join [dm_dom_calender].[date]
    on date = function_call_date

    where function_call_date between @startdate_month and DATEADD(DAY, -7, cast (getdate() as date))

      group by  month_id
   , [date].month_short_desc_de
   order by 2

                    set @log_message = N'FCR 7 monthly KPIs Created '
        exec etl.log_event @proc, @arg_job , @log_message

delete from  #PB_week_prozentual  where week_id >= @WEEK_ID_START and KPI = 'FCR 7'
insert into #PB_week_prozentual
select
   'FCR 7' KPI
   , week_id
   , [date].week_in_year_id
   , SUM([Anzahl Kunden ohne anschliessendem Call]) [Anzahl Kunden ohne anschliessendem Call]
   , SUM([Anzahl Kunden gesamt (DAU)] ) [Anzahl Kunden gesamt (DAU)]
   , cast(SUM([Anzahl Kunden ohne anschliessendem Call]) as dec(10,2)) / SUM([Anzahl Kunden gesamt (DAU)] ) [gesamt]

   , SUM([Anzahl Kunden web ohne anschliessendem Call]) [Anzahl Kunden ohne anschliessendem Call]
   , SUM([Anzahl Kunden web gesamt (DAU)] ) [Anzahl Kunden gesamt (DAU)]
   , cast(SUM([Anzahl Kunden web ohne anschliessendem Call]) as dec(10,2)) / SUM([Anzahl Kunden web gesamt (DAU)] ) web

   , SUM([Anzahl Kunden app ohne anschliessendem Call]) [Anzahl Kunden ohne anschliessendem Call]
   , SUM([Anzahl Kunden app gesamt (DAU)] ) [Anzahl Kunden gesamt (DAU)]
   , cast(SUM([Anzahl Kunden app ohne anschliessendem Call]) as dec(10,2)) / SUM([Anzahl Kunden app gesamt (DAU)] ) web
   , 20 order_id
    , getdate() Aktualisierungsdatum
from #FCR7
left outer join [dm_dom_calender].[date]
    on date = function_call_date
    where function_call_date between @startdate_week and DATEADD(DAY, -7, cast (getdate() as date))
   group by       week_id
   , [date].week_in_year_id
   order by 2



delete from  #PB_day_prozentual  where date_id >= @DAY_ID_START and KPI = 'FCR 7'
insert into #PB_day_prozentual
select
   'FCR 7' KPI
   , date_id    
   , weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de [date]
   , SUM([Anzahl Kunden ohne anschliessendem Call]) [Anzahl Kunden ohne anschliessendem Call]
   , SUM([Anzahl Kunden gesamt (DAU)] ) [Anzahl Kunden gesamt (DAU)]
   , cast(SUM([Anzahl Kunden ohne anschliessendem Call]) as dec(10,2)) / SUM([Anzahl Kunden gesamt (DAU)] ) [gesamt]

   , SUM([Anzahl Kunden web ohne anschliessendem Call]) [Anzahl Kunden ohne anschliessendem Call]
   , SUM([Anzahl Kunden web gesamt (DAU)] ) [Anzahl Kunden gesamt (DAU)]
   , cast(SUM([Anzahl Kunden web ohne anschliessendem Call]) as dec(10,2)) / SUM([Anzahl Kunden web gesamt (DAU)] ) web

   , SUM([Anzahl Kunden app ohne anschliessendem Call]) [Anzahl Kunden ohne anschliessendem Call]
   , SUM([Anzahl Kunden app gesamt (DAU)] ) [Anzahl Kunden gesamt (DAU)]
   , cast(SUM([Anzahl Kunden app ohne anschliessendem Call]) as dec(10,2)) / SUM([Anzahl Kunden app gesamt (DAU)] ) web
   , 18 order_id
    , getdate() Aktualisierungsdatum
from #FCR7
left outer join [dm_dom_calender].[date]
    on date = function_call_date
        where function_call_date between @startdate_day and DATEADD(DAY, -7, cast (getdate() as date))
        group by       date_id    
   , weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de
   order by 2

       set @log_message = N'FCR 7 weekly KPIs Created '
        exec etl.log_event @proc, @arg_job , @log_message

---- fcr end here ---------------------
---- CC-Nutzer mit Call ----------------

       set @log_message = N'Computing KPI CC-Nutzer mit Call'
        exec etl.log_event @proc, @arg_job , @log_message

drop table if exists #CC_Nutzer_mit_Call_base
select
    function_call_date
  , tag_calculation_time
  , tag_calculation_time_desc
  , month_id
  , month_short_desc_de
  , week_id
  , week_in_year_id
  , start_week
  , end_week
  , customer_id
  , customer_id_app
  , customer_id_web
  , max(call_JN_cc_nutzer) call_JN
  , max(call_app_JN_cc_nutzer) call_app_JN
  , max(call_web_JN_cc_nutzer) call_web_JN

  , max(call_JN_cc_nutzer_weekly) call_JN_weekly
  , max(call_app_JN_cc_nutzer_weekly) call_app_JN_weekly
  , max(call_web_JN_cc_nutzer_weekly) call_web_JN_weekly

into #CC_Nutzer_mit_Call_base
from
#calls
group by function_call_date
       , tag_calculation_time
       , tag_calculation_time_desc
       , month_id
       , month_short_desc_de
       , week_id
       , week_in_year_id
       , start_week
       , end_week
       ,  customer_id
       , customer_id_app
       , customer_id_web


DROP TABLE IF EXISTS #CC_Nutzer_mit_Call
CREATE TABLE #CC_Nutzer_mit_Call
(
[KPI_calculation_type] [nvarchar] (100) NULL,
[KPI] [nvarchar] (100) NULL,
[tag_calculation_time] [int] NULL,
[tag_calculation_time_desc] [nvarchar] (30) NULL,
[total_1] [int] NULL,
[total_2] [int] NULL,
[total_percentage] [decimal] (21, 13) NULL,
[web_total_1] [int] NULL,
[web_total_2] [int] NULL,
[web_percentage] [decimal] (21, 13) NULL,
[app_total_1] [int] NULL,
[app_total_2] [int] NULL,
[app_percentage] [decimal] (21, 13) NULL,
[order_id] [int] NULL
)
-- daily
INSERT INTO #CC_Nutzer_mit_Call
select 'daily' as KPI_calculation_type
   , 'CC-Nutzer mit Call' as KPI
   , tag_calculation_time
   , tag_calculation_time_desc
   ,  count(distinct customer_id) as total_1 --dau
   ,  COUNT(distinct case when call_JN = 1 then customer_id end) as total_2 --total_1
   ,  cast(convert(decimal(10,4), convert(decimal(10,4), COUNT(distinct case when call_JN = 1 then customer_id end))/count(distinct customer_id)) as float) as total_percentage
   ,  count(distinct customer_id_web) as web_total_1 --dau_web
   ,  COUNT(distinct case when call_web_JN = 1 then customer_id_web end) web_total_2 --web_total_1
   ,  cast(convert(decimal(10,4), convert(decimal(10,4),COUNT(distinct case when call_web_JN = 1 then customer_id_web end))/count(distinct customer_id_web)) as float) as web_percentage
   ,  count(distinct customer_id_app) as app_total_1 --dau_app
   ,  COUNT(distinct case when call_app_JN = 1 then customer_id_app end) app_total_2 --app_total_1
   ,  cast(convert(decimal(10,4), convert(decimal(10,4), COUNT(distinct case when call_app_JN = 1 then customer_id_app end))/count(distinct customer_id_app)) as float) as app_percentage
   ,  25 as order_id
from #CC_Nutzer_mit_Call_base
group by function_call_date, tag_calculation_time, tag_calculation_time_desc
order by 3

-- monthly
INSERT INTO #CC_Nutzer_mit_Call
select 'monthly' as KPI_calculation_type
   , 'CC-Nutzer mit Call' as KPI
   , month_id as tag_calculation_time
   , month_short_desc_de as tag_calculation_time_desc
   ,  count(distinct customer_id) as total_1 --dau
   ,  COUNT(distinct case when call_JN = 1 then customer_id end) as total_2 --total_1
   ,  cast(convert(decimal(10,4), convert(decimal(10,4), COUNT(distinct case when call_JN = 1 then customer_id end))/count(distinct customer_id)) as float) as total_percentage
   ,  count(distinct customer_id_web) as web_total_1 --dau_web
   ,  COUNT(distinct case when call_web_JN = 1 then customer_id_web end) web_total_2 --web_total_1
   ,  cast(convert(decimal(10,4), convert(decimal(10,4),COUNT(distinct case when call_web_JN = 1 then customer_id_web end))/count(distinct customer_id_web)) as float) as web_percentage
   ,  count(distinct customer_id_app) as app_total_1 --dau_app
   ,  COUNT(distinct case when call_app_JN = 1 then customer_id_app end) app_total_2 --app_total_1
   ,  cast(convert(decimal(10,4), convert(decimal(10,4), COUNT(distinct case when call_app_JN = 1 then customer_id_app end))/count(distinct customer_id_app)) as float) as app_percentage
   ,  25 as order_id
from #CC_Nutzer_mit_Call_base
--fix EBIPB-10758
where function_call_date >= @startdate_month
group by month_id, month_short_desc_de

--weekly
INSERT INTO #CC_Nutzer_mit_Call
select 'weekly' as KPI_calculation_type
  , 'CC-Nutzer mit Call' as KPI
  , a.week_id as tag_calculation_time
  , a.week_in_year_id as tag_calculation_time_desc
  ,  count(distinct customer_id) as total_1 --dau
  ,  COUNT(distinct case when call_JN_weekly = 1 then customer_id end) as total_2 --total_1
  ,  cast(convert(decimal(10,4), convert(decimal(10,4), COUNT(distinct case when call_JN_weekly = 1 then customer_id end))/count(distinct customer_id)) as float) as total_percentage
  ,  count(distinct customer_id_web) as web_total_1 --dau_web
  ,  COUNT(distinct case when call_web_JN_weekly = 1 then customer_id_web end) web_total_2 --web_total_1
  ,  cast(convert(decimal(10,4), convert(decimal(10,4),COUNT(distinct case when call_web_JN_weekly = 1 then customer_id_web end))/count(distinct customer_id_web)) as float) as web_percentage
  ,  count(distinct customer_id_app) as app_total_1 --dau_app
  ,  COUNT(distinct case when call_app_JN_weekly = 1 then customer_id_app end) app_total_2 --app_total_1
  ,  cast(convert(decimal(10,4), convert(decimal(10,4), COUNT(distinct case when call_app_JN_weekly = 1 then customer_id_app end))/count(distinct customer_id_app)) as float) as app_percentage
  ,  25 as order_id
from #CC_Nutzer_mit_Call_base a INNER JOIN #week_table b ON a.week_id=b.week_id
--fix EBIPB-10758
WHERE function_call_date >= @startdate_week
group by a.week_id, a.week_in_year_id


       set @log_message = N'Finished Computing KPI CC-Nutzer mit Call'
        exec etl.log_event @proc, @arg_job , @log_message
----------------------------------------
--Service and Sales Calls
-- last dialog_id for each call_id


--- raw data
drop table if exists #last_dialog;
WITH FirstRow as
       (select *, ROW_NUMBER () over (partition by customer_id, function_call_date, call_date, call_id  order by dialog_incoming_datetime desc) as [ROW_NUMBER]
       from #calls
       )
select *
into #last_dialog
from FirstRow
where [ROW_NUMBER]=1


DROP TABLE IF EXISTS #service_and_sales_calls
CREATE TABLE #service_and_sales_calls
(
kpi_calculation_type VARCHAR(255),
kpi varchar(255),
tag_calculation_time INT,
tag_calculation_time_desc VARCHAR(255),
total_1 INT,
total_app INT,
total_web INT,
order_id int
)

-- daily calculation
INSERT INTO #service_and_sales_calls
(
   kpi_calculation_type,
   kpi,
   tag_calculation_time,
   tag_calculation_time_desc,
   total_1,
   total_app,
   total_web,
   order_id
)
select 'daily' as kpi_calculation_type,
       call_desc as kpi,
       date_id as tag_calculation_time,  
       weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + d.month_short_desc_de as tag_calculation_time_desc
   , count(distinct case when call_JN=1 then dialog_id end) as total_1
   , count(distinct case when call_app_JN=1 then dialog_id end) as total_app
   , count(distinct case when call_web_JN=1 then dialog_id end) as total_web
   , 26 as order_id
from #last_dialog
left outer join [dm_dom_calender].[date] d
   on date = function_call_date
   where dialog_id is not NULL
  group by  date_id, weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + d.month_short_desc_de, call_desc
  order by 3,1

-- weekly calculation
INSERT INTO #service_and_sales_calls
(
   kpi_calculation_type,
   kpi,
   tag_calculation_time,
   tag_calculation_time_desc,
   total_1,
   total_app,
   total_web,
   order_id
)
select 'weekly' as kpi_calculation_type,
       call_desc as kpi,
       d.week_id as tag_calculation_time,  
       d.week_in_year_id as tag_calculation_time_desc
   , count(distinct case when call_JN=1 then dialog_id end) as total_1
   , count(distinct case when call_app_JN=1 then dialog_id end) as total_app
   , count(distinct case when call_web_JN=1 then dialog_id end) as total_web
   , 26 as order_id
from #last_dialog
left outer join [dm_dom_calender].[date] d
   on date = function_call_date
   where dialog_id is not NULL 
      --fix EBIPB-10758
      and function_call_date >= @startdate_week
  group by  d.week_id, d.week_in_year_id, call_desc
  order by 3,1

-- monthly_calculation
INSERT INTO #service_and_sales_calls
(
   kpi_calculation_type,
   kpi,
   tag_calculation_time,
   tag_calculation_time_desc,
   total_1,
   total_app,
   total_web,
   order_id
)
select 'monthly' as kpi_calculation_type,
       call_desc as kpi,
       d.month_id as tag_calculation_time,  
       d.month_short_desc_de as tag_calculation_time_desc
   , count(distinct case when call_JN=1 then dialog_id end) as total_1
   , count(distinct case when call_app_JN=1 then dialog_id end) as total_app
   , count(distinct case when call_web_JN=1 then dialog_id end) as total_web
   , 26 as order_id
from #last_dialog
left outer join [dm_dom_calender].[date] d
   on date = function_call_date
   where dialog_id is not NULL 
   --fix EBIPB-10758
      and function_call_date >= @startdate_month
  group by  d.month_id, d.month_short_desc_de, call_desc
  order by 3,1

  ----------------------------------------------------------------
--PTB, RET, Onboarding, Customer Service, Rest

-- daily calculation
INSERT INTO #service_and_sales_calls
(
   kpi_calculation_type,
   kpi,
   tag_calculation_time,
   tag_calculation_time_desc,
   total_1,
   total_app,
   total_web,
   order_id
)
select 'daily' as kpi_calculation_type,
       call_desc_detail as kpi,
       date_id as tag_calculation_time,  
       weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + d.month_short_desc_de as tag_calculation_time_desc
   , count(distinct case when call_JN=1  then dialog_id end) as total_1
   , count(distinct case when call_app_JN=1  then dialog_id end) as total_app
   , count(distinct case when call_web_JN=1  then dialog_id end) as total_web
   , 27 as order_id
from #last_dialog
left outer join [dm_dom_calender].[date] d
   on date = function_call_date
   where dialog_id is not NULL
  group by  date_id, weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + d.month_short_desc_de, call_desc_detail
  order by 3,1

-- weekly calculation
INSERT INTO #service_and_sales_calls
(
   kpi_calculation_type,
   kpi,
   tag_calculation_time,
   tag_calculation_time_desc,
   total_1,
   total_app,
   total_web,
   order_id
)
select 'weekly' as kpi_calculation_type,
       call_desc_detail as kpi,
       d.week_id as tag_calculation_time,  
       d.week_in_year_id as tag_calculation_time_desc
   , count(distinct case when call_JN=1  then dialog_id end) as total_1
   , count(distinct case when call_app_JN=1  then dialog_id end) as total_app
   , count(distinct case when call_web_JN=1  then dialog_id end) as total_web
   , 27 as order_id
from #last_dialog
left outer join [dm_dom_calender].[date] d
   on date = function_call_date
   where dialog_id is not NULL
      --fix EBIPB-10758
      and function_call_date >= @startdate_week
  group by  d.week_id, d.week_in_year_id, call_desc_detail
  order by 3,1

-- monthly calculation
INSERT INTO #service_and_sales_calls
(
   kpi_calculation_type,
   kpi,
   tag_calculation_time,
   tag_calculation_time_desc,
   total_1,
   total_app,
   total_web,
   order_id
)
select 'monthly' as kpi_calculation_type,
       call_desc_detail as kpi,
       d.month_id as tag_calculation_time,  
       d.month_short_desc_de as tag_calculation_time_desc
   , count(distinct case when call_JN=1  then dialog_id end) as total_1
   , count(distinct case when call_app_JN=1  then dialog_id end) as total_app
   , count(distinct case when call_web_JN=1  then dialog_id end) as total_web
   , 27 as order_id
from #last_dialog
left outer join [dm_dom_calender].[date] d
   on date = function_call_date
   where dialog_id is not NULL
      --fix EBIPB-10758
      and function_call_date >= @startdate_month
  group by  d.month_id, d.month_short_desc_de, call_desc_detail
  order by 3,1



----------------------------------------
--drop table if exists #function_calls_FCR
drop table if exists #FCR1
drop table if exists #FCR7
drop table if exists #CC_Nutzer_mit_Call_base
DROP TABLE IF EXISTS #calls
--DROP TABLE IF EXISTS #last_dialog


------------------ 06 --------------------------------------

drop table if exists #neuvertraege
select *
into #neuvertraege
from (
   select
       customer_id
       , contract_id
       , contract_creation_date
       , 'contract_id' src
   from dm_dom_contract.contract  
   where
       contract_creation_date between @startdate and @enddate
       and is_qa_testcontract_ind='0'
       and contract_creation_date is not NULL
) h


drop table if exists #NV_order
   select
       cal_contract.month_id
       , cal_contract.month_short_desc_de
       , cal_contract.week_id
       , cal_contract.[week_in_year_id]
       , cal_contract.date_id    
       , cal_contract.weekday_short_desc_de + ', ' + substring(cal_contract.date_short_desc_de, 1,3) + cal_contract.month_short_desc_de [date]
       , contract_creation_date
       , nv.customer_id customer_id_contract
       , [order].customer_id customer_id_order
       , [order].contract_id
       , coalesce([order].customer_id, nv.customer_id) customer_id
       , coalesce(order_date, contract_creation_date) order_date
       , order_datetime
       , is_new_customer_ind is_new_customer_ind_order
       , ROW_NUMBER() over(partition by cal_contract.month_id, nv.contract_id  order by coalesce(order_datetime, '2099-01-01')) as [ROW_NUMBER]
       , registered_since_date
       , case when coalesce(cal_reg.month_id, 199901) = cal_contract.month_id then 1 else 0 end is_new_customer_ind_reg_date
       , coalesce(is_new_customer_ind, case when coalesce(cal_reg.month_id, 199901) = cal_contract.month_id then 1 else 0 end) is_new_customer_ind
into #NV_order
   from #neuvertraege nv
   left outer join [dm_dom_order].[order]
   on nv.contract_id = [order].contract_id
    left outer join [dm_dom_calender].[date] cal_contract
    on date = contract_creation_date
    left outer join dm_dom_customer.[customer]
    on nv.customer_id = customer.customer_id
    left outer join [dm_dom_calender].[date] cal_reg
    on cal_reg.date = registered_since_date


drop table if exists #order_month
select *
into  #order_month
   from (
   select month_id,
       month_short_desc_de,
       contract_creation_date
       , registered_since_date
       , customer_id
       , customer_id_order
       , customer_id_contract
       , contract_id
       , is_new_customer_ind_order
       , is_new_customer_ind_reg_date
       , is_new_customer_ind
       , ROW_NUMBER() over(partition by month_id, customer_id     order by contract_creation_date, coalesce(order_datetime, '2099-01-01')) as [ROW_NUMBER]
   from #NV_order nv
   where month_id >= @month_ID_START  
) o
where [ROW_NUMBER] = 1


drop table if exists #Onboarding
       select
           month_id
           , month_short_desc_de
           --, week_id
           --, [week_in_year_id]
           --, date_id    
           --, [date]
           , contract_creation_date
           , nk.customer_id
           , gesamt.first_user_activity_date first_user_activity_date_gesamt
           , web.first_user_activity_date first_user_activity_date_web
           , app.first_user_activity_date first_user_activity_date_app
           , case when gesamt.first_user_activity_date between DATEADD(DAY,-5,contract_creation_date)
               and DATEADD(DAY, 30, contract_creation_date)  then nk.customer_id end  first_user_activity_gesamt_30  
           , case when web.first_user_activity_date between DATEADD(DAY,-5,contract_creation_date)
               and DATEADD(DAY, 30, contract_creation_date)  then nk.customer_id end  first_user_activity_web_30  
           , case when app.first_user_activity_date between DATEADD(DAY,-5,contract_creation_date)
               and DATEADD(DAY, 30, contract_creation_date)  then nk.customer_id end  first_user_activity_app_30  
           --, case when gesamt.first_user_activity_date between DATEADD(DAY,-5,contract_creation_date)
           --    and DATEADD(DAY, 7, contract_creation_date)  then nk.customer_id end  first_user_activity_gesamt_7  
           --, case when web.first_user_activity_date between DATEADD(DAY,-5,contract_creation_date)
           --    and DATEADD(DAY, 7, contract_creation_date)  then nk.customer_id end  first_user_activity_web_7
           --, case when app.first_user_activity_date between DATEADD(DAY,-5,contract_creation_date)
           --    and DATEADD(DAY, 7, contract_creation_date)  then nk.customer_id end  first_user_activity_app_7                  
       into #Onboarding
       from #order_month nk
       left outer join [dm_dom_self_care].[control_center_first_user_activity] app
       on nk.customer_id = app.customer_id
       and app.[Control Center] = 'app'
       left outer join [dm_dom_self_care].[control_center_first_user_activity] web
       on nk.customer_id = web.customer_id
       and web.[Control Center] = 'web'
       left outer join (select customer_id, min (first_user_activity_date) first_user_activity_date
               from [dm_dom_self_care].[control_center_first_user_activity]
               group by customer_id ) gesamt
       on nk.customer_id = gesamt.customer_id
       where is_new_customer_ind =1


drop table if exists #Erstbesucher
select
   month_id
   , month_short_desc_de
   , week_id
   , [week_in_year_id]
   , date_id    
   , weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de [date]
   , [Control Center]
   , ccfca.customer_id
   , gesamt.customer_id customer_id_gesamt
   , registered_since_date
   , [first_user_activity_date]
   , case when DATEADD(DAY, 40, coalesce(registered_since_date, getdate())) < [first_user_activity_date]  then 'BK'
       when DATEADD(DAY, 40, coalesce(registered_since_date, getdate())) >= [first_user_activity_date] then 'NK'
       else 'nv' end Kundentyp
   into #Erstbesucher
   from [dm_dom_self_care].[control_center_first_user_activity] ccfca
   left outer join [dm_dom_calender].[date]
   on date = [first_user_activity_date]
   left outer join (select customer_id, min (first_user_activity_date) MIN_first_user_activity_date
       from [dm_dom_self_care].[control_center_first_user_activity]
       group by customer_id ) gesamt
   on date = MIN_first_user_activity_date
   and ccfca.customer_id = gesamt.customer_id
   left outer join dm_dom_customer.customer c
    on  ccfca.customer_id = c.customer_id
    Where  first_user_activity_date between @startdate and getdate()


------ Month ------------

delete from #PB_month where KPI like 'Neukund%' and  MONTH_id >= @MONTH_ID_START  
insert into #PB_month
select 'Neukunden' KPI
   , month_id
   , month_short_desc_de month
   , count(distinct case when is_new_customer_ind = 1 then customer_id end) gesamt
   , count(distinct case when is_new_customer_ind = 1 then customer_id end) web
   , count(distinct case when is_new_customer_ind = 1 then customer_id end) app
   , 30 order_id
   , getdate()
from #order_month
group by month_id, month_short_desc_de
order by month_id

     set @log_message = N'Neukunden monthly KPIs Created '
      exec etl.log_event @proc, @arg_job , @log_message

delete from #PB_month where KPI like 'NVK%' and  MONTH_id >= @MONTH_ID_START  
insert into #PB_month
select 'NVK' KPI
   , month_id
   , month_short_desc_de month
   , count(distinct case when is_new_customer_ind = 0 then customer_id end) gesamt
   , count(distinct case when is_new_customer_ind = 0 then customer_id end) web
   , count(distinct case when is_new_customer_ind = 0 then customer_id end) app
   , 33 order_id
   , getdate()
from #order_month
group by month_id, month_short_desc_de
order by month_id

          set @log_message = N'NVK monthly KPIs Created '
        exec etl.log_event @proc, @arg_job , @log_message


delete from #PB_month where KPI like 'Erst%' and  MONTH_id >= @MONTH_ID_START  
insert into #PB_month
select 'Erstbesucher' KPI
   , month_id
   , month_short_desc_de month
   , count(distinct customer_id_gesamt)
   , count(distinct case when [Control Center] = 'web' then  ccfca.customer_id end )
   , count(distinct case when [Control Center] = 'app' then  ccfca.customer_id end)
   ,  40 order_id
   , getdate()
   from #Erstbesucher ccfca
Where  month_id >= @month_ID_START  
group by month_id, month_short_desc_de
order by month_id

       set @log_message = N'Erstbesucher monthly KPIs Created '
     exec etl.log_event @proc, @arg_job , @log_message

insert into #PB_month
select 'Erstbesucher ' + Kundentyp  KPI
   , month_id
   , month_short_desc_de month
   , count(distinct  customer_id_gesamt  )
   , count(distinct case when [Control Center] = 'web' then  customer_id end )
   , count(distinct case when [Control Center] = 'app' then  customer_id end)
   , case when Kundentyp = 'NK' then 41 else 42 end order_id
   , getdate()
   from #Erstbesucher
    Where  month_id >= @month_ID_START  
    group by month_id, month_short_desc_de, Kundentyp
   order by month_id

    set @log_message = N'Erstbesucher + Kundentyp monthly KPIs Created '
    exec etl.log_event @proc, @arg_job , @log_message


delete from #PB_month_prozentual where KPI like '%Onboard%' and  MONTH_id >= @MONTH_ID_START  
insert into #PB_month_prozentual
select
   'Quote Onboarding 30T' KPI
   , next_month.month_id
   , next_month.month_short_desc_de
   , COUNT (distinct first_user_activity_gesamt_30) FA_gesamt
   , COUNT (distinct customer_id) NK
   , cast(COUNT (distinct first_user_activity_gesamt_30) as dec(12,2))/ COUNT (distinct customer_id )
   , COUNT (distinct first_user_activity_web_30) FA_web
   , COUNT (distinct customer_id) NK
   , cast(COUNT (distinct first_user_activity_web_30) as dec(12,2))/ COUNT (distinct customer_id )
   , COUNT (distinct first_user_activity_app_30) FA_app
   , COUNT (distinct customer_id) NK
   , cast(COUNT (distinct first_user_activity_app_30) as dec(12,2))/ COUNT (distinct customer_id)
   , 10 [order_id]
   ,GETDATE() [Aktualisierungsdatum]                     
from #Onboarding o
left outer join (
   select distinct month_id, previous_month_id, month_short_desc_de from dm_dom_calender.date
   ) next_month
on next_month.previous_month_id = o.month_id
Where  o.month_id >= @month_ID_START  
group by
       next_month.month_id
       , next_month.month_short_desc_de
order by
       next_month.month_id
       , next_month.month_short_desc_de

  set @log_message = N'Quote Onboarding 30T monthly KPIs Created '
  exec etl.log_event @proc, @arg_job , @log_message


---- woche
drop table if exists #order_week
select *
into  #order_week
   from (
   select     week_id
       , [week_in_year_id]
       , contract_creation_date
       , registered_since_date
       , customer_id
       , customer_id_order
       , customer_id_contract
       , contract_id
       , is_new_customer_ind_order
       , is_new_customer_ind_reg_date
       , is_new_customer_ind
       , ROW_NUMBER() over(partition by week_id, customer_id order by contract_creation_date, coalesce(order_datetime, '2099-01-01')) as [ROW_NUMBER]
   from  #NV_order nv
       where  week_id >= @week_ID_START  
) o
where [ROW_NUMBER] = 1




delete from #PB_week where KPI like 'Neukund%' and  week_id >= @week_ID_START  
insert into #PB_week
select 'Neukunden' KPI
   , week_id
   , [week_in_year_id]
   , count(distinct case when is_new_customer_ind = 1 then customer_id end) gesamt
   , count(distinct case when is_new_customer_ind = 1 then customer_id end) web
   , count(distinct case when is_new_customer_ind = 1 then customer_id end) app
   , 30 order_id
   , getdate()
from #order_week
group by week_id, [week_in_year_id]
order by week_id

  set @log_message = N'Neukunden weekly KPIs Created '
  exec etl.log_event @proc, @arg_job , @log_message

delete from #PB_week where KPI like 'NVK%' and  week_id >= @week_ID_START  
insert into #PB_week
select 'NVK' KPI
   , week_id
   , [week_in_year_id]
   , count(distinct case when is_new_customer_ind = 0 then customer_id end) gesamt
   , count(distinct case when is_new_customer_ind = 0 then customer_id end) web
   , count(distinct case when is_new_customer_ind = 0 then customer_id end) app
   , 33 order_id
   , getdate()
from #order_week
group by week_id, [week_in_year_id]
order by week_id

  set @log_message = N'NVK weekly KPIs Created '
  exec etl.log_event @proc, @arg_job , @log_message

delete from #PB_week where KPI like 'erst%' and  week_id >= @week_ID_START  
insert into #PB_week
select 'Erstbesucher' KPI
   , week_id
   , [week_in_year_id]
   , count(distinct customer_id_gesamt)
   , count(distinct case when [Control Center] = 'web' then  ccfca.customer_id end )
   , count(distinct case when [Control Center] = 'app' then  ccfca.customer_id end)
   ,  40 order_id
   , getdate()
   from #Erstbesucher ccfca
Where  week_id >= @week_ID_START
group by week_id, [week_in_year_id]
order by week_id

   set @log_message = N'Erstbesucher weekly KPIs Created '
   exec etl.log_event @proc, @arg_job , @log_message

insert into #PB_week
select 'Erstbesucher ' + Kundentyp  KPI
   , week_id
   , [week_in_year_id]
   , count(distinct  customer_id_gesamt  )
   , count(distinct case when [Control Center] = 'web' then  customer_id end )
   , count(distinct case when [Control Center] = 'app' then  customer_id end)
   , case when Kundentyp = 'NK' then 41 else 42 end order_id
   , getdate()
   from #Erstbesucher
Where  week_id >= @week_ID_START
group by week_id, [week_in_year_id], Kundentyp
order by week_id

  set @log_message = N'Erstbesucher + Kundentyp weekly KPIs Created '
  exec etl.log_event @proc, @arg_job , @log_message

-- - TAG
drop table if exists #order_day
select *
into  #order_day
   from (
   select     
       date_id    
       , [date]
       , contract_creation_date
       , registered_since_date
       , customer_id
       , customer_id_order
       , customer_id_contract
       , contract_id
       , is_new_customer_ind_order
       , is_new_customer_ind_reg_date
       , is_new_customer_ind
       , ROW_NUMBER() over(partition by date_id, customer_id  order by contract_creation_date, coalesce(order_datetime, '2099-01-01')) as [ROW_NUMBER]
from #NV_order nv
   where date_id >= @DAY_ID_START  
) o
where [ROW_NUMBER] = 1

delete from #PB_day where KPI like 'Neukund%' and  date_id >= @DAY_ID_START  
insert into #PB_day
select 'Neukunden' KPI
   , date_id
   , [date]
   , count(distinct case when is_new_customer_ind = 1 then customer_id end) gesamt
   , count(distinct case when is_new_customer_ind = 1 then customer_id end) web
   , count(distinct case when is_new_customer_ind = 1 then customer_id end) app
   , 30 order_id
   , getdate()
from #order_day
group by date_id
   , [date]
order by date_id
   , [date]

     set @log_message = N'Neukunden daily KPIs Created '
     exec etl.log_event @proc, @arg_job , @log_message

delete from #PB_day where KPI like 'NVK%' and  date_id >= @DAY_ID_START  
insert into #PB_day
select 'NVK' KPI
   , date_id
   , [date]
   , count(distinct case when is_new_customer_ind = 0 then customer_id end) gesamt
   , count(distinct case when is_new_customer_ind = 0 then customer_id end) web
   , count(distinct case when is_new_customer_ind = 0 then customer_id end) app
   , 33 order_id
   , getdate()
from #order_day
group by date_id
   , [date]
order by date_id
   , [date]

     set @log_message = N'NVK daily KPIs Created '
     exec etl.log_event @proc, @arg_job , @log_message

delete from #PB_day where KPI like 'Erst%' and  date_id >= @DAY_ID_START  
insert into #PB_day
select  
   'Erstbesucher' KPI
   , date_id
   , [date]
   , count(distinct customer_id_gesamt)
   , count(distinct case when [Control Center] = 'web' then  ccfca.customer_id end )
   , count(distinct case when [Control Center] = 'app' then  ccfca.customer_id end)
   ,  40 order_id
   , getdate()
   from #Erstbesucher ccfca
where date_id >= @DAY_ID_START
 group by date_id
   , date

     set @log_message = N'Erstbesucher daily KPIs Created '
     exec etl.log_event @proc, @arg_job , @log_message

insert into #PB_day
select 'Erstbesucher ' + Kundentyp  KPI
   , date_id
   , [date]
   , count(distinct  customer_id_gesamt  )
   , count(distinct case when [Control Center] = 'web' then  customer_id end )
   , count(distinct case when [Control Center] = 'app' then  customer_id end)
   , case when Kundentyp = 'NK' then 41 else 42 end order_id
   , getdate()
   from #Erstbesucher
where date_id >= @DAY_ID_START
 group by date_id, Kundentyp
   , date

     set @log_message = N'Erstbesucher  + Kundentyp KPIs Created '
     exec etl.log_event @proc, @arg_job , @log_message


drop table if exists #neuvertraege
drop table if exists #NV_order
drop table if exists #Onboarding
drop table if exists #Erstbesucher
drop table if exists #order_month
drop table if exists #order_week
drop table if exists #order_day


------------------------- 07 ----------------------------------
delete from #PB_month where KPI like 'Kundenbestand' and month_id >= @MONTH_ID
insert into #PB_month
select
   'Kundenbestand' KPI
   , month_id
   , month_short_desc_de month
   , count(distinct customer_id) gesamt
   , count(distinct customer_id) web
   , count(distinct customer_id) app
   ,90
   , getdate()
from rl_dom_contract.contract_stock_monthly csm
left outer join dm_dom_contract.contract c
on c.contract_id = csm.contract_id
left outer join dm_dom_contract.contract_stock_group csg
on csm.contract_stock_group_id = csg.contract_stock_group_id
left outer join  [dm_dom_calender].[date]
on date = stock_date
where is_effective_stock_ind = 1
and stock_date between @startdate_month and @enddate
group by  month_id
   , month_short_desc_de

     set @log_message = N'Kundenbestand KPI Created '
        exec etl.log_event @proc, @arg_job , @log_message

drop table if exists #customer_termination
   select distinct
       ct.customer_id
       , month_id
       , month_short_desc_de month
       --, termination_planned_effective_datetime
       into #customer_termination
   from dm_dom_termination.contract_termination ct
   left outer join dm_dom_contract.contract c
   on ct.contract_id = c.contract_id
   left outer join  [dm_dom_calender].[date]
   --fix EBIPB-10758: cast
   on date = cast(termination_planned_effective_datetime as date)
   where is_current_valid_termination_ind = 1
   and is_termination_effective_ind = 1
   --fix EBIPB-10758
   and termination_planned_effective_datetime between @startdate_month and @enddate


delete  from #PB_month where KPI like '%Kuendigungen%' and month_id >= @MONTH_ID
insert into #PB_month
select
   'Kuendigungen (Kunden)' KPI
   , t.month_id
   , t.month
   , count( t.customer_id) gesamt
   , count( t.customer_id) web
   , count( t.customer_id) app
   , 91
   , GETDATE()
   from #customer_termination t
left outer join (
   Select distinct customer_id, month_id
       from  rl_dom_contract.contract_stock_monthly csm
       left outer join dm_dom_contract.contract c
       on c.contract_id = csm.contract_id
       left outer join dm_dom_contract.contract_stock_group csg
       on csm.contract_stock_group_id = csg.contract_stock_group_id
       left outer join  [dm_dom_calender].[date]
       on date = stock_date
       where is_effective_stock_ind = 1
       --fix EBIPB-10758
       and stock_date between @startdate_month and @enddate ) stock
on stock.customer_id = t.customer_id
and stock.month_id = t.month_id
where stock.customer_id is null
group by t.month_id
   , t.month
   order by month_id

     set @log_message = N'    Kuendigungen (Kunden) KPI Created '
        exec etl.log_event @proc, @arg_job , @log_message
drop table if exists #customer_termination



------------------------ Aktivierungen Rechnungsversand START ------------------------
set @log_message = N'Computing KPI Aktivierungen Rechnungsversand'
exec etl.log_event @proc, @arg_job , @log_message;


drop table if exists #tmp_aktivierungen_rechnungsversand;
create table #tmp_aktivierungen_rechnungsversand
(
   [KPI_calculation_type] [nvarchar] (100) NULL,
   [KPI] [nvarchar] (100) NULL,
   [tag_calculation_time] [int] NULL,
   [tag_calculation_time_desc] [nvarchar] (30) NULL,
   [total_1] [int] NULL,
   [total_2] [int] NULL,
   [total_percentage] [decimal] (21, 13) NULL,
   [web_total_1] [int] NULL,
   [web_total_2] [int] NULL,
   [web_percentage] [decimal] (21, 13) NULL,
   [app_total_1] [int] NULL,
   [app_total_2] [int] NULL,
   [app_percentage] [decimal] (21, 13) NULL,
   [order_id] [int] NULL
);

declare @start_dt date, @end_dt date;
set @end_dt = dateadd(day,-1,cast(getdate() as date));

------------------------ daily -------------------
set @start_dt =  dateadd(day,-4,cast(getdate() as date));
while @start_dt <= @end_dt
begin

   drop table if exists #tmp_aktivierungen_rechnungsversand_base_daily;
   with FirstRow as (
       select customer_id,  changetype, cast(his_ts_init as date) his_ts_init,
           customerproperty_id,
           ROW_NUMBER() over(PARTITION by customer_id order by his_ts_init desc) as rn
       from common.ods_sybccd_ccd.his_rel_customer_custprop
       where customerproperty_id='6877'
           and cast(his_ts_init as date) <= @start_dt         
   )
   select customer_id,  changetype, his_ts_init, customerproperty_id, rn
       into #tmp_aktivierungen_rechnungsversand_base_daily
   from FirstRow  
   where rn = 1
       and changetype = 'I';

   drop table if exists #tmp_aktivierungen_rechnungsversand_daily;
   select 'daily' as KPI_calculation_type
       ,'Aktivierungen Rechnungsversand' as KPI
       ,d.date_id  as tag_calculation_time
       ,d.weekday_short_desc_de + ', '+ substring(d.date_short_desc_de, 1,3) + d.month_short_desc_de as tag_calculation_time_desc
       ,count(customer_id) total_1    
   into #tmp_aktivierungen_rechnungsversand_daily
   from  #tmp_aktivierungen_rechnungsversand_base_daily t
       left join [dm_dom_calendar].[date] d on date  = @start_dt
   group by d.date_id
           ,d.weekday_short_desc_de + ', '+ substring(d.date_short_desc_de, 1,3) + d.month_short_desc_de;

   insert into #tmp_aktivierungen_rechnungsversand
   select KPI_calculation_type
          ,KPI
          ,tag_calculation_time
          ,tag_calculation_time_desc
          ,total_1
          ,NULL as total_2
          ,NULL as total_percentage
           ,NULL as web_total_1
           ,NULL as web_total_2
           ,NULL as web_percentage
           ,NULL as app_total_1
           ,NULL as app_total_2
           ,NULL as app_percentage
           ,NULL as order_id
   from #tmp_aktivierungen_rechnungsversand_daily;

   SET @start_dt = DATEADD(DAY,1,@start_dt);
END;

------------------------ monthly -------------------
set @start_dt =  eomonth(dateadd(month,-2,@end_dt));
while @start_dt <= @end_dt
begin

   drop table if exists #tmp_aktivierungen_rechnungsversand_base_monthly;
   with FirstRow as (
       select customer_id,  changetype, cast(his_ts_init as date) his_ts_init,
           customerproperty_id,
           ROW_NUMBER() over(PARTITION by customer_id order by his_ts_init desc) as rn
       from common.ods_sybccd_ccd.his_rel_customer_custprop
       where customerproperty_id='6877'
           and cast(his_ts_init as date) <= @start_dt         
   )
   select customer_id,  changetype, his_ts_init, customerproperty_id, rn
       into #tmp_aktivierungen_rechnungsversand_base_monthly
   from FirstRow  
   where rn = 1
       and changetype = 'I';

   drop table if exists #tmp_aktivierungen_rechnungsversand_monthly;
   select 'monthly' as KPI_calculation_type
       ,'Aktivierungen Rechnungsversand' as KPI
       ,d.month_id as tag_calculation_time
       ,d.month_short_desc_de as tag_calculation_time_desc
       ,count(customer_id) total_1    
   into #tmp_aktivierungen_rechnungsversand_monthly
   from #tmp_aktivierungen_rechnungsversand_base_monthly t
       left join [dm_dom_calendar].[date] d on d.date = @start_dt
   group by d.month_id
       ,d.month_short_desc_de;

   insert into #tmp_aktivierungen_rechnungsversand
   select KPI_calculation_type
          ,KPI
          ,tag_calculation_time
          ,tag_calculation_time_desc
          ,total_1
          ,NULL as total_2
          ,NULL as total_percentage
           ,NULL as web_total_1
           ,NULL as web_total_2
           ,NULL as web_percentage
           ,NULL as app_total_1
           ,NULL as app_total_2
           ,NULL as app_percentage
           ,NULL as order_id
   from #tmp_aktivierungen_rechnungsversand_monthly;

   IF  EOMONTH(@end_dt) = EOMONTH(DATEADD(MONTH,1,@start_dt)) AND @start_dt <> @end_dt
       set @start_dt = @end_dt
   ELSE
       SET @start_dt = EOMONTH(DATEADD(MONTH,1,@start_dt));
END;

------------------------ weekly -------------------
set @start_dt = dateadd(week,-2,dateadd(day,7-datepart(weekday,dateadd(day,-1,@end_dt)), @end_dt));
while @start_dt <= @end_dt
begin

   drop table if exists #tmp_aktivierungen_rechnungsversand_base_weekly;
   with FirstRow as (
       select customer_id,  changetype, cast(his_ts_init as date) his_ts_init,
           customerproperty_id,
           ROW_NUMBER() over(PARTITION by customer_id order by his_ts_init desc) as rn
       from common.ods_sybccd_ccd.his_rel_customer_custprop
       where customerproperty_id='6877'
           and cast(his_ts_init as date) <= @start_dt         
   )
   select customer_id,  changetype, his_ts_init, customerproperty_id, rn
       into #tmp_aktivierungen_rechnungsversand_base_weekly
   from FirstRow  
   where rn = 1
       and changetype = 'I';

   drop table if exists #tmp_aktivierungen_rechnungsversand_weekly;
   select 'weekly' as KPI_calculation_type
           ,'Aktivierungen Rechnungsversand' as KPI
       ,d.week_id as tag_calculation_time
       ,cast(d.week_in_year_id as nvarchar(30)) as tag_calculation_time_desc
       ,count(customer_id) total_1
   into #tmp_aktivierungen_rechnungsversand_weekly
   from #tmp_aktivierungen_rechnungsversand_base_weekly t
       inner join [dm_dom_calendar].[date] d on date  = @start_dt
   group by week_id, d.week_in_year_id;

   insert into #tmp_aktivierungen_rechnungsversand
   select KPI_calculation_type
          ,KPI
          ,tag_calculation_time
          ,tag_calculation_time_desc
          ,total_1
          ,NULL as total_2
          ,NULL as total_percentage
           ,NULL as web_total_1
           ,NULL as web_total_2
           ,NULL as web_percentage
           ,NULL as app_total_1
           ,NULL as app_total_2
           ,NULL as app_percentage
           ,NULL as order_id
   from #tmp_aktivierungen_rechnungsversand_weekly;

   IF  DATEADD(DAY,7-DATEPART(WEEKDAY,DATEADD(DAY,-1,@end_dt)), @end_dt) = DATEADD(WEEK,1,@start_dt) AND @start_dt <> @end_dt
       set @start_dt = @end_dt
   ELSE
       SET @start_dt = DATEADD(WEEK,1,@start_dt);
END;

drop table if exists #tmp_aktivierungen_rechnungsversand_final;
with final_select as
(
select kpi_calculation_type
       , kpi
       , tag_calculation_time
       , tag_calculation_time_desc
       , total_1
       , total_1 - lag(total_1) over(partition by KPI_calculation_type order by tag_calculation_time) total_2
       , total_percentage
       , web_total_1
       , web_total_2
       , web_percentage
       , app_total_1
       , app_total_2
       , app_percentage
       , order_id
from #tmp_aktivierungen_rechnungsversand
)
select *
into #tmp_aktivierungen_rechnungsversand_final
from final_select
where total_2 is not NULL;

---------------------------------------------------------

drop table if exists #tmp_aktivierungen_rechnungsversand_base_daily;
drop table if exists #tmp_aktivierungen_rechnungsversand_daily;
drop table if exists #tmp_aktivierungen_rechnungsversand_base_monthly;
drop table if exists #tmp_aktivierungen_rechnungsversand_monthly;
drop table if exists #tmp_aktivierungen_rechnungsversand_base_weekly;
drop table if exists #tmp_aktivierungen_rechnungsversand_weekly;
drop table if exists #tmp_aktivierungen_rechnungsversand;

------------------------ Aktivierungen Rechnungsversand END ------------------------

--------- cc_sessions EBIPB-10564 start --------------------------------
set @log_message = N'Computing KPI cc_sessions and voice'
exec etl.log_event @proc, @arg_job , @log_message;

DECLARE @min int = 1800 -- Set CC session timeout to 30 minutes

DROP TABLE IF EXISTS #cc_sessions;
WITH function_calls AS (
   SELECT
       [customer_id],
       [control_center_desc],
       [function_call_date],
       [function_call_timestamp],
       scm_readonly_ind,
       coalesce(
           lag([function_call_timestamp]) OVER(PARTITION BY [function_call_date], [customer_id], [control_center_desc] ORDER BY [function_call_timestamp]),
           '00:00:00.000'
       ) as previous,
       datediff(
           second,
           lag([function_call_timestamp]) OVER(PARTITION BY [function_call_date], [customer_id], [control_center_desc] ORDER BY [function_call_timestamp]),
           [function_call_timestamp]
       ) as diff,
       case
           when datediff(second, lag([function_call_timestamp]) OVER(PARTITION BY [function_call_date], [customer_id], [control_center_desc] ORDER BY [function_call_timestamp]), [function_call_timestamp]) > @min then 1
           when datediff(second, lag([function_call_timestamp]) OVER(PARTITION BY [function_call_date], [customer_id], [control_center_desc] ORDER BY [function_call_timestamp]), [function_call_timestamp]) is Null then 1    
           else 0
       end as  new_session
           FROM  [dm_dom_self_care].[control_center_function_call]
   WHERE [function_call_date] between @startdate and @enddate
       and coalesce([customer_id], -1) <> -1
)
SELECT
   [customer_id],
   [control_center_desc],
   [function_call_date],
   [function_call_timestamp],
   previous
INTO #cc_sessions
FROM function_calls
WHERE new_session = 1;


DROP TABLE IF EXISTS #daily_sessions;

SELECT
   function_call_date,
   COUNT(customer_id) session_quantity
INTO #daily_sessions
FROM #cc_sessions
GROUP BY function_call_date
ORDER BY function_call_date;


drop table if exists #voice;

SELECT
   cast(cdr.call_incoming_datetime as date) call_date,
   COUNT(call_id) call_quantity
INTO #voice
FROM [access].[dm_dom_customer_care].[dialog] cdr
WHERE 1=1
   and direction_id = 8
   AND is_handled_ind = 1
   AND mandator_id = 2
   and cast(cdr.call_incoming_datetime as date) between @startdate and @enddate
GROUP BY cast(cdr.call_incoming_datetime as date);


DROP TABLE IF EXISTS #nvoice;

SELECT
   measure_date,
   entry_quantity
INTO #nvoice
FROM [rl_cube_cc_weekly_management].[Weekly NVoice Agg]
WHERE
   measure_date BETWEEN @startdate AND @enddate
   AND weekly_gruppe_id = 1000;


DROP TABLE IF EXISTS #cc_sessions_and_voice_temp;

CREATE TABLE #cc_sessions_and_voice_temp (
   [KPI_calculation_type] [nvarchar] (100) COLLATE Latin1_General_100_CI_AS_SC NULL,
   [KPI] [nvarchar] (100) COLLATE Latin1_General_100_CI_AS_SC NULL,
   [tag_calculation_time] [int] NULL,
   [tag_calculation_time_desc] [nvarchar] (30) COLLATE Latin1_General_100_CI_AS_SC NULL,
   [total_1] [int] NULL,
   [total_2] [int] NULL,
   [total_percentage] [decimal] (21, 13) NULL,
   [order_id] [int] NULL
);


INSERT INTO #cc_sessions_and_voice_temp
   SELECT
       'daily',
       'Calls',
       year(call_date) * 10000 + month(call_date) * 100 + day(call_date),
       weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de,
       sum(call_quantity),
       NULL,
       NULL,
       100
   FROM #voice voice
   INNER JOIN access.dm_dom_calendar.[date] dates
       ON voice.call_date = dates.date
   GROUP BY
       call_date,
       weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de
   UNION
   SELECT
       'weekly',
       'Calls',
       week_id,
       CAST(week_in_year_id AS nvarchar),
       SUM(call_quantity),
       NULL,
       NULL,
       100
   FROM #voice voice
   INNER JOIN access.dm_dom_calendar.date dates
       ON voice.call_date = dates.date  
   --fix EBIPB-10758
   WHERE call_date >= @startdate_week                        
   GROUP BY
       week_id,
       week_in_year_id
   UNION
   SELECT
       'monthly',
       'Calls',
       DATEPART(year, call_date) * 100 + DATEPART(month, call_date),
       month_short_desc_de tag_calculation_desc,
       SUM(call_quantity),
       NULL,
       NULL,
       100
   FROM #voice voice
   INNER JOIN access.dm_dom_calendar.[date] dates
       ON voice.call_date = dates.date
      --fix EBIPB-10758
    WHERE call_date >= @startdate_month   
   GROUP BY
       DATEPART(year, call_date),
       DATEPART(month, call_date),
       month_short_desc_de
   UNION
   SELECT
       'daily' KPI_calculation_type,
       'Non-Voice' KPI,
       year(measure_date) * 10000 + month(measure_date) * 100 + day(measure_date),
       weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de,
       sum(entry_quantity) total_1,
       NULL,
       NULL,
       101
   FROM #nvoice nvoice
   INNER JOIN access.dm_dom_calendar.[date] dates
       ON nvoice.measure_date = dates.date
   GROUP BY
       measure_date,
       weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de
   UNION
   SELECT
       'weekly',
       'Non-Voice',
       week_id,
       CAST(week_in_year_id AS nvarchar),
       SUM(entry_quantity),
       NULL,
       NULL,
       101
   FROM #nvoice nvoice
   INNER JOIN access.dm_dom_calendar.date dates
       ON nvoice.measure_date = dates.date
   --fix EBIPB-10758
   WHERE measure_date >= @startdate_week
   GROUP BY
       week_id,
       week_in_year_id                                    
   UNION
   SELECT
       'monthly' KPI_calculation_type,
       'Non-Voice' KPI,
       DATEPART(year, measure_date) * 100 + DATEPART(month, measure_date),
       month_short_desc_de tag_calculation_desc,
       SUM(entry_quantity),
       NULL,
       NULL,
       101
   FROM #nvoice nvoice
   INNER JOIN access.dm_dom_calendar.[date] dates
       ON nvoice.measure_date = dates.date
      --fix EBIPB-10758
   WHERE measure_date >= @startdate_month
   GROUP BY
       DATEPART(year, measure_date),
       DATEPART(month, measure_date),
       month_short_desc_de;


DROP TABLE IF EXISTS #contacts_agg;

SELECT
   KPI_calculation_type,
   tag_calculation_time,
   SUM(total_1) total_1
INTO #contacts_agg
FROM #cc_sessions_and_voice_temp
GROUP BY
   KPI_calculation_type,
   tag_calculation_time;


INSERT INTO #cc_sessions_and_voice_temp
   SELECT
       'daily',
       'Sessions',
       year(function_call_date) * 10000 + month(function_call_date) * 100 + day(function_call_date),
       weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de,
       sum(session_quantity),
       sum(session_quantity) + sum(contacts.total_1),
       CAST(CAST(sum(session_quantity) AS FLOAT) / (sum(session_quantity) + sum(contacts.total_1)) AS DECIMAL(12, 6)),
       28
   FROM #daily_sessions cc_sessions
   INNER JOIN access.dm_dom_calendar.[date] dates
       ON cc_sessions.function_call_date = dates.date
   LEFT JOIN #contacts_agg contacts
       ON contacts.KPI_calculation_type = 'daily'
       AND contacts.tag_calculation_time = year(function_call_date) * 10000 + month(function_call_date) * 100 + day(function_call_date)
   GROUP BY
       function_call_date,
       weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de
   UNION
   SELECT
       cc_sessions.*,
       cc_sessions.total_1 + contacts.total_1 total_2,
       CAST(CAST(cc_sessions.total_1 AS float) / (cc_sessions.total_1 + contacts.total_1) AS DECIMAL(12, 6)),
       28
   FROM (
       SELECT
           'weekly' KPI_calculation_type,
           'Sessions' KPI,
           week_id tag_calculation_time,
           CAST(week_in_year_id AS nvarchar) tag_calculation_time_desc,
           SUM(session_quantity) total_1
       FROM #daily_sessions cc_sessions INNER JOIN access.dm_dom_calendar.date dates
           ON cc_sessions.function_call_date = dates.date
           --fix EBIPB-10758
           WHERE cc_sessions.function_call_date >= @startdate_week
       GROUP BY
           week_id,
           week_in_year_id
   ) cc_sessions
   LEFT JOIN #contacts_agg contacts
       ON contacts.KPI_calculation_type = cc_sessions.KPI_calculation_type
       AND contacts.tag_calculation_time = cc_sessions.tag_calculation_time
   UNION
   SELECT
       cc_sessions.*,
       cc_sessions.total_1 + contacts.total_1 total_2,
       CAST(CAST(cc_sessions.total_1 AS float) / (cc_sessions.total_1 + contacts.total_1) AS DECIMAL(12, 6)),
       28
   FROM (
       SELECT
           'monthly' KPI_calculation_type,
           'Sessions' KPI,
           DATEPART(year, function_call_date) * 100 + DATEPART(month, function_call_date) tag_calculation_time,
           month_short_desc_de tag_calculation_time_desc,
           SUM(session_quantity) total_1
       FROM #daily_sessions cc_sessions
       INNER JOIN access.dm_dom_calendar.[date] dates
           ON cc_sessions.function_call_date = dates.date
           --fix EBIPB-10758
           where cc_sessions.function_call_date>= @startdate_month
       GROUP BY
           DATEPART(year, function_call_date),
           DATEPART(month, function_call_date),
           month_short_desc_de
   ) cc_sessions
   LEFT JOIN #contacts_agg contacts
       ON contacts.KPI_calculation_type = cc_sessions.KPI_calculation_type
       AND contacts.tag_calculation_time = cc_sessions.tag_calculation_time;

DROP TABLE IF EXISTS #cc_sessions_and_voice_final;

SELECT
   KPI_calculation_type,
   KPI,
   tag_calculation_time,
   tag_calculation_time_desc,
   total_1,
   total_2,
   total_percentage,
   NULL web_total_1,
   NULL web_total_2,
   NULL web_percentage,
   NULL app_total_1,
   NULL app_total_2,
   NULL app_percentage,
   order_id
INTO #cc_sessions_and_voice_final
FROM #cc_sessions_and_voice_temp;
---------------------------------------


CREATE TABLE #help_center_visits
(
[KPI_calculation_type] [nvarchar] (100),
[KPI] [nvarchar] (100),
[tag_calculation_time] [int] ,
[tag_calculation_time_desc] [nvarchar] (30),
[total_1] [int] ,
[total_2] [int] ,
[total_percentage] [decimal] (21, 13) ,
[web_total_1] [int] ,
[web_total_2] [int] ,
[web_percentage] [decimal] (21, 13) ,
[app_total_1] [int] ,
[app_total_2] [int] ,
[app_percentage] [decimal] (21, 13) ,
[order_id] [int] ,
[rl_load_datetime] [datetime2] (3) ,
[rl_load_job_id] [nvarchar] (255)
);


INSERT INTO #help_center_visits
(
   KPI_calculation_type,
   KPI,
   tag_calculation_time,
   tag_calculation_time_desc,
   total_1,
   order_id,
   rl_load_datetime,
   rl_load_job_id
)
SELECT
'daily' AS KPI_calculation_type,
'help center unique visitors' AS KPI,
b.date_id as tag_calculation_time,
weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de AS tag_calculation_time_desc,
unique_visitors AS total_1,
102 AS order_id,
GETDATE() AS rl_load_datetime,
@arg_job  as rl_load_job_id
FROM ods_adobe_omniture.help_center_daily_visits_adobe a INNER JOIN dm_dom_calendar.date b ON a.date=b.date

UNION all

SELECT
'daily' AS KPI_calculation_type,
'help center filtered unique visitors' AS KPI,
b.date_id as tag_calculation_time,
weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + month_short_desc_de AS tag_calculation_time_desc,
unique_visitors AS total_1,
103 AS order_id,
GETDATE() AS rl_load_datetime,
@arg_job  as rl_load_job_id
FROM ods_adobe_omniture.help_center_daily_filtered_visits_adobe a INNER JOIN dm_dom_calendar.date b ON a.date=b.date

UNION all

SELECT a.KPI_calculation_type,
      a.KPI,
      a.tag_calculation_time,
      a.tag_calculation_time_desc,
      a.total_1,
      104 AS order_id,
      GETDATE() AS rl_load_datetime,
       @arg_job  as rl_load_job_id
FROM
(
   SELECT 'weekly' AS KPI_calculation_type,
          'help center unique visitors' AS KPI,
          a.date,
          ROW_NUMBER() OVER (PARTITION BY b.week_id ORDER BY a.date DESC) AS wk_rn,
          week_id tag_calculation_time,
          CAST(week_in_year_id AS nvarchar) AS tag_calculation_time_desc,
          unique_visitors AS total_1
   FROM ods_adobe_omniture.help_center_weekly_visits_adobe a
       INNER JOIN dm_dom_calendar.date b
           ON a.date = b.date
) AS a
WHERE wk_rn = 1

UNION ALL

SELECT a.KPI_calculation_type,
      a.KPI,
      a.tag_calculation_time,
      a.tag_calculation_time_desc,
      a.total_1,
      105 AS order_id,
      GETDATE() AS rl_load_datetime,
       @arg_job  as rl_load_job_id
FROM
(
   SELECT 'weekly' AS KPI_calculation_type,
          'help center filtered unique visitors' AS KPI,
          a.date,
          ROW_NUMBER() OVER (PARTITION BY b.week_id ORDER BY a.date DESC) AS wk_rn,
          week_id tag_calculation_time,
          CAST(week_in_year_id AS nvarchar) AS tag_calculation_time_desc,
          unique_visitors AS total_1
   FROM ods_adobe_omniture.help_center_weekly_filtered_visits_adobe a
       INNER JOIN dm_dom_calendar.date b
           ON a.date = b.date
) AS a
WHERE wk_rn = 1

UNION all


SELECT a.KPI_calculation_type,
      a.KPI,
      a.tag_calculation_time,
      a.tag_calculation_time_desc,
      a.total_1,
      106 AS order_id,
      GETDATE() AS rl_load_datetime,
       @arg_job  as rl_load_job_id
FROM
(
   SELECT 'monthly' AS KPI_calculation_type,
          'help center filtered unique visitors' AS KPI,
          a.month,
          ROW_NUMBER() OVER (PARTITION BY b.month_id ORDER BY a.month DESC) AS mnth_rn,
          b.month_id AS tag_calculation_time,
          b.month_short_desc_de AS tag_calculation_time_desc,
          unique_visitors AS total_1
   FROM ods_adobe_omniture.help_center_monthly_filtered_visits_adobe a
       INNER JOIN dm_dom_calendar.date b
           ON a.month = b.date
) AS a
WHERE mnth_rn = 1

UNION ALL

SELECT a.KPI_calculation_type,
      a.KPI,
      a.tag_calculation_time,
      a.tag_calculation_time_desc,
      a.total_1,
      107 AS order_id,
      GETDATE() AS rl_load_datetime,
       @arg_job  as rl_load_job_id
FROM
(
     SELECT 'monthly' AS KPI_calculation_type,
          'help center unique visitors' AS KPI,
          a.month,
          ROW_NUMBER() OVER (PARTITION BY b.month_id ORDER BY a.month DESC) AS mnth_rn,
          b.month_id AS tag_calculation_time,
          b.month_short_desc_de AS tag_calculation_time_desc,
          unique_visitors AS total_1
   FROM
   (
       SELECT month,
              unique_visitors
       FROM ods_adobe_omniture.help_center_monthly_visits_adobe
       WHERE ods_load_date >= '2023-10-05'
   ) a
       INNER JOIN dm_dom_calendar.date b
           ON month = b.date
) AS a
WHERE mnth_rn = 1;


------------------------ EBIPB-11151 -----------------------------------
----------------- Call KPI - daily dashboard ---------------------------

set @log_message = N'compute Call KPI - daily dashboard'
exec etl.log_event @proc, @arg_job , @log_message;	   


drop table if exists #calls_v2
select
  s.customer_id
  , case when min_function_call_app is not null then s.customer_id end customer_id_app
  , case when min_function_call_web is not null then s.customer_id end customer_id_web
  , function_call_date
  , t.date_id as tag_calculation_time
  , t.weekday_short_desc_de + ', '+ substring(t.date_short_desc_de, 1,3) + t.month_short_desc_de as tag_calculation_time_desc
  , t.month_id
  , t.month_short_desc_de
  , min_function_call
  , min_function_call_app
  , min_function_call_web
  , CAST (call_incoming_datetime as date) as call_date
  , wt.week_id
  , wt.week_in_year_id
  , wt.start_week
  , wt.end_week

  , case WHEN function_call_date = CAST(d.call_incoming_datetime AS DATE) and min_function_call <=  call_incoming_datetime then 1 else 0 end call_JN
  , case when function_call_date = CAST(d.call_incoming_datetime AS DATE) AND min_function_call_app <=  call_incoming_datetime then 1 else 0 end call_app_JN
  , case when function_call_date = CAST(d.call_incoming_datetime AS DATE) AND min_function_call_web <=  call_incoming_datetime then 1 else 0 end call_web_JN
 
  , call_incoming_datetime
  , call_id
  , dialog_id
  , dialog_incoming_datetime
  , first_queue_hist_id
  , first_queue_id
  , last_queue_hist_id
  , last_queue_id
  , mandator_id
  , d.source_forecast_designation_id
  , fd.forecast_designation_desc
	, case when fd.forecast_designation_desc ='DE_1u1_RT_Access_1st'  then 'Retention DSL'
			when fd.forecast_designation_desc = 'DE_1u1_RT_Mobile_1st' then 'Retention Mobile'
			when fd.forecast_designation_desc in ('1&1 Business Service Kfm', '1&1 Business Service Technik') then 'Business Service'
			when fd.forecast_designation_desc = '1&1 PTB Gesamt' then 'PTB Gesamt'
			when fd.forecast_designation_desc like '%1&1 Bereitstellung Mobile_%' then  'Bereitstellung Mobile'
			when fd.forecast_designation_desc = '1&1 BSD Team I' then 'Bereitstellung DSL I'
			when fd.forecast_designation_desc = '1&1 BSD Team II' then 'Bereitstellung DSL II'
			when fd.forecast_designation_desc = '1&1_RT_Storno_Online' then 'CT Storno Widerruf'
			when fd.forecast_designation_desc like '%1&1 Concierge%' then 'Concierge'
			when fd.forecast_designation_desc like '%1&1 Technik%' then '1&1 Technik'
			when fd.forecast_designation_desc ='Telesales_Gesamt_FC_Mi_u_DSL' then 'Telesales'
			when fd.forecast_designation_desc ='1&1 5g Kundenmigration_voice' then '5G'
			when fd.forecast_designation_desc ='DRI 5g Kundenmigration_voice' then 'Drillisch 5G'
			else 'Call NULL Daily ' end as call_desc_detail_daily /* gemäßg OPSBI Daily: https://access-confluence.1and1.org/pages/viewpage.action?pageId=295124411 */
	, case when fd.forecast_designation_desc ='DE_1u1_RT_Access_1st'  then 58
			when fd.forecast_designation_desc = 'DE_1u1_RT_Mobile_1st' then 57
			when fd.forecast_designation_desc in ('1&1 Business Service Kfm', '1&1 Business Service Technik') then 60
			when fd.forecast_designation_desc = '1&1 PTB Gesamt' then 52
			when fd.forecast_designation_desc like '%1&1 Bereitstellung Mobile_%' then  53
			when fd.forecast_designation_desc = '1&1 BSD Team I' then 54
			when fd.forecast_designation_desc = '1&1 BSD Team II' then 55
			when fd.forecast_designation_desc = '1&1_RT_Storno_Online' then 61
			when fd.forecast_designation_desc like '%1&1 Concierge%' then 51
			when fd.forecast_designation_desc like '%1&1 Technik%' then 56
			when fd.forecast_designation_desc ='Telesales_Gesamt_FC_Mi_u_DSL' then 59
			when fd.forecast_designation_desc ='1&1 5g Kundenmigration_voice' then 62
			when fd.forecast_designation_desc ='DRI 5g Kundenmigration_voice' then 63
			else 65 end as order_id
  , d.tracking_item_1_hist_id
  , d.tracking_item_2_hist_id
  , tih_1.tracking_item_desc tracking_item_1_desc
  , tih_1.tracking_mgmt_category_desc tracking_mgmt_category_1_desc
  , tih_2.tracking_item_desc tracking_item_2_desc
  , tih_2.tracking_mgmt_category_desc tracking_mgmt_category_2_desc
into #calls_v2
from #function_calls_FCR s
left outer join dm_dom_customer_care.dialog d
on d.customer_id = s.customer_id
      and direction_id='8' /*Incoming*/
      and is_offered_ind=1 /*wurde nicht vor IVR abgeborchen*/
      --and mandator_id = 2 /*wird im OPS Daily nicht verwendet*/
      and CAST(d.call_incoming_datetime AS DATE) between   @startdate and @enddate
	  and function_call_date = CAST(d.call_incoming_datetime AS DATE)
left outer join [dm_dom_calendar].[date] t ON s.function_call_date=t.date
left join dm_dom_customer_care.forecast_designation fd
on d.source_forecast_designation_id = fd.forecast_designation_id
left outer join [dm_dom_customer_care].[tracking_item_hist] tih_1
on d.tracking_item_1_hist_id = tih_1. [tracking_item_hist_id]
left outer join [dm_dom_customer_care].[tracking_item_hist] tih_2
on d.tracking_item_2_hist_id = tih_2.[tracking_item_hist_id]
left outer join #week_table wt
on s.week_id=wt.week_id

/*
select call_desc_detail_daily, forecast_designation_desc, count(distinct dialog_id) as anz
from #calls
group by call_desc_detail_daily, forecast_designation_desc
order by 1,anz desc
*/






--- use first dialog of each call after the first MSSA function call of a day
drop table if exists #first_dialog_v2;
WITH FirstRow as
      (select *, ROW_NUMBER () over (partition by customer_id, function_call_date, call_date, call_id  order by dialog_incoming_datetime) as [ROW_NUMBER]
      from #calls_v2
      )
select *
into #first_dialog_v2
from FirstRow
where [ROW_NUMBER]=1



DROP TABLE IF EXISTS #call_kpi_v2

--daily calculation
select 'daily' as kpi_calculation_type,
      call_desc_detail_daily as kpi,
      date_id as tag_calculation_time,  
      weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + d.month_short_desc_de as tag_calculation_time_desc
  , count(distinct case when call_JN=1  then dialog_id end) as total_1
  , NULL as total_2
  , NULL as total_percentage
  , count(distinct case when call_web_JN=1  then dialog_id end) as web_total_1
  , NULL as web_total_2
  , NULL as web_percentage
  , count(distinct case when call_app_JN=1  then dialog_id end) as app_total_1
  , NULL as app_total_2
  , NULL as app_percentage
 , order_id
 INTO #call_kpi_v2
from #first_dialog_v2
left outer join [dm_dom_calender].[date] d
  on date = function_call_date
  where dialog_id is not NULL 
 group by  date_id, weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + d.month_short_desc_de, call_desc_detail_daily, order_id

 UNION ALL

 select 'daily' as kpi_calculation_type,
      '# Aktive Nutzer mit Anruf' as kpi,
      date_id as tag_calculation_time,  
      weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + d.month_short_desc_de as tag_calculation_time_desc
  , count(distinct case when call_JN=1 and call_desc_detail_daily is not NULL and dialog_id is not NULL  then customer_id end) as total_1
  , count(distinct case when min_function_call is not NULL  then customer_id end)  as total_2
  , cast(count(distinct case when call_JN=1 and call_desc_detail_daily is not NULL and dialog_id is not NULL  then customer_id end) as dec(10,2)) / count(distinct case when min_function_call is not NULL  then customer_id end)  as total_percentage

  , count(distinct case when call_web_JN=1 and call_desc_detail_daily is not NULL and dialog_id is not NULL  then customer_id end) as web_total_1
  , count(distinct case when min_function_call_web is not NULL  then customer_id end) as web_total_2
  , cast(count(distinct case when call_web_JN=1 and call_desc_detail_daily is not NULL and dialog_id is not NULL  then customer_id end) as dec(10,2)) / count(distinct case when min_function_call_web is not NULL  then customer_id end) as web_percentage

  , count(distinct case when call_app_JN=1 and call_desc_detail_daily is not NULL and dialog_id is not NULL  then customer_id end) as app_total_1
  , count(distinct case when min_function_call_app is not NULL  then customer_id end) as app_total_2
  , cast(count(distinct case when call_app_JN=1 and call_desc_detail_daily is not NULL and dialog_id is not NULL  then customer_id end) as dec(10,2)) / count(distinct case when min_function_call_app is not NULL  then customer_id end)  as app_percentage
 , 50 as order_id
 from #calls_v2
 left outer join [dm_dom_calender].[date] d
  on date = function_call_date
 group by  date_id, weekday_short_desc_de + ', ' + substring(date_short_desc_de, 1,3) + d.month_short_desc_de

  UNION ALL

 -- weekly calculation
select 'weekly' as kpi_calculation_type,
      call_desc_detail_daily as kpi,
      d.week_id as tag_calculation_time,  
      CAST(d.week_in_year_id AS VARCHAR(255)) as tag_calculation_time_desc
  , count(distinct case when call_JN=1  then dialog_id end) as total_1
  , NULL as total_2
  , NULL as total_percentage
  , count(distinct case when call_web_JN=1  then dialog_id end) as web_total_1
  , NULL as web_total_2
  , NULL as web_percentage
  , count(distinct case when call_app_JN=1  then dialog_id end) as app_total_1
  , NULL as app_total_2
  , NULL as app_percentage
 , order_id
from #first_dialog_v2
left outer join [dm_dom_calender].[date] d
  on date = function_call_date
  where dialog_id is not NULL
	and function_call_date >= @startdate_week
 group by  d.week_id, d.week_in_year_id, call_desc_detail_daily, order_id

  UNION ALL

 --monthly calculation
select 'monthly' as kpi_calculation_type,
      call_desc_detail_daily as kpi,
      d.month_id as tag_calculation_time,  
      d.month_short_desc_de as tag_calculation_time_desc
  , count(distinct case when call_JN=1  then dialog_id end) as total_1
  , NULL as total_2
  , NULL as total_percentage
  , count(distinct case when call_web_JN=1  then dialog_id end) as web_total_1
  , NULL as web_total_2
  , NULL as web_percentage
  , count(distinct case when call_app_JN=1  then dialog_id end) as app_total_1
  , NULL as app_total_2
  , NULL as app_percentage
 , order_id
from #first_dialog_v2
left outer join [dm_dom_calender].[date] d
  on date = function_call_date
  where dialog_id is not NULL
	 and function_call_date > = @startdate_month
 group by  d.month_id, d.month_short_desc_de, call_desc_detail_daily, order_id
 order by 3, order_id



---------------------------------------
     set @log_message = N'    start filling  #final_temp'
        exec etl.log_event @proc, @arg_job , @log_message

drop table if exists #final_temp
select    'daily' as kpi_calculation_type,
       KPI as kpi_desc,
       date_id as tag_calculation_time ,
       cast(date as nvarchar(20)) as tag_calculation_time_desc,
       gesamt as total_1 ,
       null as total_2,
       null as total,  
       web as web_total_1,
       null as web_total_2,
       null as web,
       app as app_total_1,
       null as app_total_2,
       null as app,
       order_id,
       aktualisierungsdatum,
       @arg_job  as rl_load_job_id
into #final_temp
from #PB_day
union
select    'monthly' ,
       KPI,
       month_id,
       cast(month as nvarchar(20)),
       gesamt,
       null,
       null,
       web,
       null,
       null,
       app,
       null  ,
       null,
       order_id,
       aktualisierungsdatum,
       @arg_job 
from #PB_month
union
select    'weekly' ,
       KPI,
       week_id,
       cast(week_in_year_id as nvarchar(10)),
       gesamt,
       null,
       null,
       web,
       null,
       null,
       app,
       null ,
       null,
       case when KPI = 'WAU Festnetzersatz' then null else order_id end as order_id,
       aktualisierungsdatum,
       @arg_job 
from #PB_week
union
select    'daily',
       KPI,
       date_id,
       date,
       gesamt_Anz_1,
       gesamt_Anz_2,
       gesamt,
       web_Anz_1,
       web_Anz_2,
       web,
       app_Anz_1,
       app_Anz_2,
       app,
       order_id,
       Aktualisierungsdatum,
       @arg_job 
from #PB_day_prozentual
union
select    'weekly',
       KPI,
       week_id,
       week_in_year_id,
       gesamt_Anz_1,
       gesamt_Anz_2,
       gesamt,
       web_Anz_1,
       web_Anz_2,
       web,
       app_Anz_1,
       app_Anz_2,
       app,
       case when KPI = 'WAU Festnetzersatz' then null else order_id end as order_id,
       Aktualisierungsdatum,
       @arg_job 
from #PB_week_prozentual
union
select    'monthly',
       KPI,
       month_id,
       month,
       gesamt_Anz_1,
       gesamt_Anz_2,
       gesamt,
       web_Anz_1,
       web_Anz_2,
       web,
       app_Anz_1,
       app_Anz_2,
       app,
       order_id,
       Aktualisierungsdatum,
       @arg_job 
from #PB_month_prozentual
UNION
SELECT KPI_calculation_type,
      KPI,
      tag_calculation_time,
      tag_calculation_time_desc,
      total_1,
      total_2,
      total_percentage,
      web_total_1,
      web_total_2,
      web_percentage,
      app_total_1,
      app_total_2,
      app_percentage,
      order_id,
      getdate() AS Aktualisierungsdatum,
      @arg_job 
FROM #CC_Nutzer_mit_Call
UNION
SELECT KPI_calculation_type,
      KPI,
      tag_calculation_time,
      tag_calculation_time_desc,
      total_1,
      total_2,
      total_percentage,
      web_total_1,
      web_total_2,
      web_percentage,
      app_total_1,
      app_total_2,
      app_percentage,
      order_id,
      getdate() AS Aktualisierungsdatum,
      @arg_job 
FROM #tmp_aktivierungen_rechnungsversand_final
UNION
SELECT kpi_calculation_type,
      kpi,
      tag_calculation_time,
      tag_calculation_time_desc,
      total_1,
      NULL,
      NULL,
      total_web AS web_total_1,
      NULL,
      NULL,
      total_app AS app_total_1,
      NULL,
      NULL,
      order_id,
      getdate() AS Aktualisierungsdatum,
      @arg_job 
FROM #service_and_sales_calls WHERE total_1 <> 0
UNION
SELECT KPI_calculation_type,
      KPI,
      tag_calculation_time,
      tag_calculation_time_desc,
      total_1,
      total_2,
      total_percentage,
      web_total_1,
      web_total_2,
      web_percentage,
      app_total_1,
      app_total_2,
      app_percentage,
      order_id,
      getdate() AS Aktualisierungsdatum,
      @arg_job 
      FROM #cc_sessions_and_voice_final
UNION
SELECT KPI_calculation_type,
      KPI,
      tag_calculation_time,
      tag_calculation_time_desc,
      total_1,
      total_2,
      total_percentage,
      web_total_1,
      web_total_2,
      web_percentage,
      app_total_1,
      app_total_2,
      app_percentage,
      order_id,
      rl_load_datetime,
      rl_load_job_id
FROM #help_center_visits
UNION
SELECT KPI_calculation_type,
      KPI,
      tag_calculation_time,
      tag_calculation_time_desc,
      total_1,
      total_2,
      total_percentage,
      web_total_1,
      web_total_2,
      web_percentage,
      app_total_1,
      app_total_2,
      app_percentage,
      order_id,
      getdate() AS Aktualisierungsdatum,
      @arg_job 
FROM #call_kpi_v2


---------------- MERGE --------------------------------
merge  rl_dom_self_care.tagesbericht as TARGET
using #final_temp as SOURCE
on (   TARGET.kpi_calculation_type = SOURCE.kpi_calculation_type
  and TARGET.KPI = SOURCE.kpi_desc
  and TARGET.tag_calculation_time = SOURCE.tag_calculation_time
  )
--When records are matched, update the records if there is any change
when matched and TARGET.total_1 <> SOURCE.total_1
             or TARGET.total_2 <> SOURCE.total_2
             or TARGET.total_percentage = SOURCE.total
             or TARGET.web_total_1 <> SOURCE.web_total_1
             or TARGET.web_total_2 <> SOURCE.web_total_2
             or TARGET.web_percentage <> SOURCE.web
             or TARGET.app_total_1 <> SOURCE.app_total_1
             or TARGET.app_total_2 <> SOURCE.app_total_2
             or TARGET.app_percentage <> SOURCE.app
            or TARGET.order_id = SOURCE.order_id
          or TARGET.rl_load_datetime = SOURCE.Aktualisierungsdatum
          
   then update set
            TARGET.total_1 = SOURCE.total_1
          , TARGET.total_2 = SOURCE.total_2
          , TARGET.total_percentage = SOURCE.total
          , TARGET.web_total_1 = SOURCE.web_total_1
          , TARGET.web_total_2 = SOURCE.web_total_2
          , TARGET.web_percentage = SOURCE.web
          , TARGET.app_total_1 = SOURCE.app_total_1
          , TARGET.app_total_2 = SOURCE.app_total_2
          , TARGET.app_percentage = SOURCE.app
          , TARGET.order_id = SOURCE.order_id
          , TARGET.rl_load_datetime = SOURCE.Aktualisierungsdatum
          
--When no records are matched, insert the incoming records from source table to target table
when not matched by target
   then insert
        (   kpi_calculation_type
          , kpi
          , tag_calculation_time
          , tag_calculation_time_desc
          , total_1
          , total_2
          , total_percentage
          , web_total_1
          , web_total_2
          , web_percentage
          , app_total_1
          , app_total_2
          , app_percentage
          , order_id
          , rl_load_datetime
          , rl_load_job_id
        )
        values
        (
            SOURCE.kpi_calculation_type,
            SOURCE.kpi_desc,
            SOURCE.tag_calculation_time,
            SOURCE.tag_calculation_time_desc,
            SOURCE.total_1,
            SOURCE.total_2,
            SOURCE.total,
            SOURCE.web_total_1,
            SOURCE.web_total_2,
            source.web ,
            SOURCE.app_total_1,
            SOURCE.app_total_2,
            SOURCE.app,
            SOURCE.order_id,
            source.Aktualisierungsdatum,
            source.rl_load_job_id
            
        );


        -----------------
   set @log_message = 'start computing call_serivce_sales_tracking_items' + @arg_job 
   exec etl.log_event @proc, @arg_job , @log_message

DROP TABLE IF EXISTS #call_serivce_sales_tracking_items
SELECT 'daily' AS kpi_calculation_type,
      date,
      date_id AS tag_calculation_time,
      weekday_short_desc_de + ', ' + SUBSTRING(date_short_desc_de, 1, 3) + d.month_short_desc_de AS tag_calculation_time_desc,
      call_desc,
      call_desc_detail,
      tracking_item_1_desc,
      tracking_item_2_desc,
      COUNT(DISTINCT CASE
                         WHEN call_JN = 1 THEN
                             dialog_id
                     END
           ) AS total_1,
      COUNT(DISTINCT CASE
                         WHEN call_app_JN = 1 THEN
                             dialog_id
                     END
           ) AS total_app,
      COUNT(DISTINCT CASE
                         WHEN call_web_JN = 1 THEN
                             dialog_id
                     END
           ) AS total_web,
      GETDATE() aktualisierungsdatum
INTO #call_serivce_sales_tracking_items
FROM #last_dialog
   LEFT OUTER JOIN [dm_dom_calender].[date] d
       ON date = function_call_date
WHERE dialog_id IS NOT NULL
GROUP BY date,
        date_id,
        weekday_short_desc_de + ', ' + SUBSTRING(date_short_desc_de, 1, 3) + d.month_short_desc_de,
        call_desc,
        call_desc_detail,
        tracking_item_1_desc,
        tracking_item_2_desc
ORDER BY 2,
         call_desc,
         call_desc_detail,
         total_1 DESC
  

 update a SET	a.total_1=b.total_1, 
				a.total_app=b.total_app, 
				a.total_web=b.total_web, 
				a.aktualisierungsdatum=b.aktualisierungsdatum
   FROM rl_dom_self_care.call_serivce_sales_tracking_items a INNER JOIN #call_serivce_sales_tracking_items b ON a.date=b.date AND 
																											a.call_desc=b.call_desc AND 
																											a.call_desc_detail=b.call_desc_detail AND
                                                                                                            a.tracking_item_1_desc=b.tracking_item_1_desc AND
                                                                                                            a.tracking_item_2_desc=b.tracking_item_2_desc
	WHERE	(b.total_1 <> 0 and a.total_1 <> b.total_1) OR 
			(b.total_web <> 0 and a.total_web<>b.total_web) OR 
			(b.total_app <> 0 and a.total_app<>b.total_app)

   set @log_message = 'updated '+CAST(@@ROWCOUNT AS VARCHAR(255))+ ' rows in rl_dom_self_care.call_serivce_sales_tracking_items ' + @arg_job 
   exec etl.log_event @proc, @arg_job , @log_message

INSERT INTO rl_dom_self_care.call_serivce_sales_tracking_items
(
   kpi_calculation_type,
   date,
   tag_calculation_time,
   tag_calculation_time_desc,
   call_desc,
   call_desc_detail,
   tracking_item_1_desc,
   tracking_item_2_desc,
   total_1,
   total_app,
   total_web,
   aktualisierungsdatum
)
SELECT a.kpi_calculation_type,
      a.date,
      a.tag_calculation_time,
      a.tag_calculation_time_desc,
      a.call_desc,
      a.call_desc_detail,
      a.tracking_item_1_desc,
      a.tracking_item_2_desc,
      a.total_1,
      a.total_app,
      a.total_web,
      a.aktualisierungsdatum
FROM #call_serivce_sales_tracking_items a LEFT JOIN rl_dom_self_care.call_serivce_sales_tracking_items b ON a.date=b.date AND 
																											a.call_desc=b.call_desc AND 
																											a.call_desc_detail=b.call_desc_detail AND
                                                                                                            a.tracking_item_1_desc=b.tracking_item_1_desc AND
                                                                                                            a.tracking_item_2_desc=b.tracking_item_2_desc
WHERE (a.total_1 <> 0 or a.total_app <> 0 or a.total_web <> 0)
AND b.total_1 IS NULL

 set @log_message = 'inserted '+CAST(@@ROWCOUNT AS VARCHAR(255))+ ' rows in rl_dom_self_care.call_serivce_sales_tracking_items ' + @arg_job 
   exec etl.log_event @proc, @arg_job , @log_message

  

 set @log_message = 'Finished Job ' + @arg_job 
   exec etl.log_event @proc, @arg_job , @log_message

  RETURN @resultcode
END TRY
BEGIN CATCH

  DECLARE @error_number INT
  DECLARE @error_severity INT
  DECLARE @error_state INT
  DECLARE @error_line INT
  DECLARE @error_message NVARCHAR(MAX)

  SET @error_number = ERROR_NUMBER()
  SET @error_severity = ERROR_SEVERITY()
  SET @error_state = ERROR_STATE()
  SET @error_line = ERROR_LINE()
  SET @error_message = ERROR_MESSAGE()

  exec etl.log_exception
      @proc
    , @arg_job 
    , @error_number
    , @error_severity
    , @error_state
    , @error_line
    , @error_message
  ;

  throw
end catch
end
go
