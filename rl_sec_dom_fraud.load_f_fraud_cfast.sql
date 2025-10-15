SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO


CREATE PROCEDURE rl_sec_dom_fraud.load_f_fraud_cfast @arg_job NVARCHAR(255)
WITH EXECUTE AS OWNER
AS
BEGIN
	SET NOCOUNT ON;
    
	DECLARE @log_message NVARCHAR(MAX);
	declare @proc nvarchar(255);
	declare @resultcode int;
	declare @arg_load_date datetime;


	if @arg_job is null
		set @arg_job = user_name() + '#' + cast(newid() as nvarchar(255));
	set @resultcode = 0;
	set @proc = etl.get_proc_name(@@procid);
	set @arg_load_date = getdate();
	

	BEGIN TRY
		SET @log_message = N'STARTED JOB ' + @arg_job;
        exec etl.log_event @proc, @arg_job, @log_message;

	BEGIN
		DROP TABLE IF EXISTS #tmp_cfast;
		DROP TABLE IF exists #tmp_mobile_daten;
		DROP TABLE IF EXISTS #tmp_kunde_id;
		DROP table if exists #tmp_rk;
		drop table if exists #tmp_mr;
		DROP TABLE IF EXISTS #tmp_rps;
		DROP TABLE IF EXISTS #tmp_letzte_bill_access;
		DROP TABLE IF EXISTS #tmp_letzte_bill_mam;

		DROP TABLE IF EXISTS #tmp_all_voip;
		DROP TABLE IF EXISTS #tmp_active_voip;
		DROP TABLE IF EXISTS #tmp_gmx_sms;

		DROP TABLE IF EXISTS #tmp_new;
		DROP TABLE IF EXISTS #tmp_re_new;
		DROP TABLE IF EXISTS #tmp_update;
		DROP TABLE IF EXISTS #tmp_del;


		CREATE TABLE #tmp_cfast (
		  delta CHAR(1) NULL
		, id BIGINT NULL
		, msisdn  VARCHAR(100) NULL
		, activation_date DATETIME2 NULL
		, kunde_id INT NULL
		, teilnehmer_id INT NULL
		, produkt_id INT NULL
		, kunde_anlage DATETIME2 NULL
		, vertrag_id INT NULL
		, vertrag_datum DATETIME2 NULL
		, letzt_billing DATETIME2 NULL
		, erste_nutzung DATETIME2 NULL
		, fraud_clientid INT NULL
		, kunde_gebdat DATE NULL
		, rls_30 BIT NULL
		, anz_simcard INT NULL
		, service_id INT NULL
		, erstlimit INT NULL
		, produkt_bez NVARCHAR(255) NULL
		, scoreclass INT NULL
		, techauftrag_id INT NULL
		, max_rechnung MONEY NULL
		, vertrag_akt DATETIME2 NULL
		, kunde_erstnutz DATETIME2 NULL
		, cc_high INT NULL
		, imsi BIGINT NULL
		, highest_finrisk INT NULL
		, kundenscore INT NULL
		, adress_attribut INT NULL
		, contact_city NVARCHAR(100) NULL
		, customertype NVARCHAR(100) NULL
		, liefer_city NVARCHAR(100) NULL
		, schufa_ki BIT NULL
		, aeltester_vertrag INT NULL
		, monitoring_szenario INT NULL
		, limit_class INT NULL
		, mehrfach_rls BIT NULL
		, nonpayer_flag BIT NULL
		, lauf INT NULL
  			) ;

		CREATE TABLE #tmp_kunde_id	(
		kunde_id INT NULL
		);
	
		CREATE TABLE #tmp_rk (
			  kunde_id INT NULL 
			, rechnung BIGINT NULL
			, bruttosumme MONEY NULL
		);


		CREATE TABLE #tmp_mr (
		  didi INT NULL 
		, max_rech MONEY NULL
		);


		CREATE TABLE #tmp_rps(
		  contract_id int null 
		, fraudclientid int null 
		, ir_scoreclass int null 
		, customertype char(8) null
		, erstlimit int null 
		, schufaki int null 
		, addressattribute int null 
		, contact_city nvarchar(100) null 
		, liefer_city nvarchar(100) null 
		, aeltester_vertrag int null 
		);

		CREATE TABLE #tmp_letzte_bill_access(
		customer_id INT NULL,
		contract_id int NULL,
		product_id int NULL,
		letzte_bill_stop_date DATETIME2 null
		);
		CREATE TABLE #tmp_letzte_bill_mam(
		customer_id INT NULL,
		contract_id int NULL,
		product_id int NULL,
		letzte_bill_stop_date DATETIME2 null
		);

		CREATE TABLE #tmp_all_voip(
		msisdn VARCHAR(100),
		customer_id BIGINT,
		contract_id BIGINT,
		product_id BIGINT,
		product_desc NVARCHAR(255),
		valid_from DATETIME2,
		valid_to DATETIME2,
		contract_status_desc NVARCHAR(100),
		product_cluster_id INT,
		product_line_desc NVARCHAR(100)
		);

		CREATE TABLE #tmp_active_voip(
		msisdn VARCHAR(100),
		customer_id BIGINT,
		contract_id BIGINT,
		product_id BIGINT,
		product_desc NVARCHAR(255),
		valid_from DATETIME2,
		valid_to DATETIME2,
		contract_status_desc NVARCHAR(100),
		product_cluster_id INT,
		product_line_desc NVARCHAR(100)
		);

		CREATE TABLE #tmp_gmx_sms(
		contract_id BIGINT,
		activation_date DATETIME2,
		contractposition_id BIGINT,
		productposition_id BIGINT,
		fee_group_id INT

		);

		CREATE TABLE #tmp_mobile_daten(
				 id BIGINT NULL
				, msisdn  VARCHAR(100) NULL
				, teilnehmer_id INT NULL
				, imsi BIGINT NULL
				, activation_date DATETIME2 NULL
		);

		CREATE TABLE #tmp_new (new_msisdn_id VARCHAR(100));
		CREATE TABLE #tmp_re_new (re_new_msisdn_id VARCHAR(100));
		CREATE TABLE #tmp_update (update_msisdn_id varchar(100));
		CREATE TABLE #tmp_del (del_msisdn_id varchar(100));


		create clustered columnstore index ccix_tmp on  #tmp_cfast;
		create clustered columnstore index idx_tmp on #tmp_kunde_id;
		create clustered columnstore index idx_tmp on #tmp_rk;
		create clustered columnstore index idx_tmp on #tmp_mr;
		create clustered columnstore index idx_tmp on #tmp_rps;
		create clustered columnstore index idx_tmp on #tmp_letzte_bill_access;
		create clustered columnstore index idx_tmp on #tmp_letzte_bill_mam;
		create clustered columnstore index idx_tmp on #tmp_all_voip;
		create clustered columnstore index idx_tmp on #tmp_active_voip;
		create clustered columnstore index idx_tmp on #tmp_gmx_sms;
		create clustered columnstore index idx_tmp on #tmp_new;
		create clustered columnstore index idx_tmp on #tmp_re_new;
		create clustered columnstore index idx_tmp on #tmp_update;
		create clustered columnstore index idx_tmp on #tmp_del;
		create clustered columnstore index idx_tmp on #tmp_mobile_daten;

		--MOBILE TEIL

		set @log_message = N'Start to insert mobile daten';
		exec etl.log_event @proc, @arg_job, @log_message;
		-- MSS +IMSI produktiv
		INSERT INTO #tmp_mobile_daten(id,msisdn,teilnehmer_id,imsi,activation_date)
		select distinct s.id as id
					, trim(s.msisdn) as mobilnr
					, s.external_subscriber_id as teilnehmer_id
					, coalesce(s.imsi, ss.imsi, ds.IMSi) as imsi
					, s.activation_date
		from ods_mobileprocess_mss.subscribers s
		left join [access].[cl_dom_mobile_access].[ref_simserial_subscriber] ss on ss.simserial = s.sim_serial
		left join access.ods_mobileservices_drillisch.v_msisdn_imei_1und1 ds on ds.MSISDN = s.msisdn and ds.ods_load_delta <>'D'
		where s.state='ACTIVE' and s.ods_load_delta <> 'D' 
		;
		-- take the msisdn_id based on lastest_activation_date
		INSERT INTO #tmp_cfast (id, msisdn, teilnehmer_id, imsi, activation_date)
		SELECT a.id, a.msisdn, a.teilnehmer_id, a.imsi, a.activation_date
		FROM #tmp_mobile_daten a
		JOIN (
				SELECT msisdn, MAX(activation_date) AS lastest_activation_Date
				FROM #tmp_mobile_daten
				GROUP BY msisdn
		) b ON b.msisdn=a.msisdn AND b.lastest_activation_Date=a.activation_date
		;

		set @log_message = N'inserted mobile daten: ' + cast(@@rowcount as nvarchar(100));
		exec etl.log_event @proc, @arg_job, @log_message;

		UPDATE c
		SET   c.kunde_id=co.customer_id
			, c.produkt_id=co.product_id
			, c.vertrag_id=co.contract_id
			, c.techauftrag_id=co.tech_order_id
			, c.vertrag_datum=co.contract_creation_date
			, c.vertrag_akt=co.contract_activation_date
			, c.service_id=pp.fee_group_id
			, c.produkt_bez=p.product_desc
			, c.cc_high=cc.customer_care_attribute_id
			, c.highest_finrisk=fr.financial_risk_priority
			, c.kunde_anlage = cus.registered_since_datetime
			, c.kunde_gebdat= cus.birth_date
			, c.rls_30= CASE WHEN rls.kunde_id IS NOT NULL THEN '1' ELSE '0' END
			, c.mehrfach_rls = CASE WHEN rls2.anzahl IS NOT NULL AND rls2.anzahl > 1 THEN '1' ELSE '0' END
			, c.lauf = CAST(CONVERT(CHAR(8), GETDATE(), 112) AS INT)

		FROM #tmp_cfast c
		LEFT JOIN access.dm_dom_contract.mobile_contract_hist hist ON hist.subscriber_id= c.id
		LEFT JOIN access.dm_dom_contract.contract co ON co.contract_id=hist.contract_id
		LEFT JOIN access.dm_dom_product.product p ON p.product_id = co.product_id
		LEFT JOIN access.cl_product.mobile_product mp ON p.product_id = mp.product_id
		LEFT JOIN access.dm_dom_product.productposition pp ON pp.productposition_id = mp.productposition_id
		LEFT JOIN access.cl_dom_fraud.lu_fraud_rel_cc_attribute cc ON cc.kunde_id=c.kunde_id
		LEFT JOIN access.cl_dom_fraud.lu_fraud_rel_cc_financialrisk fr ON fr.kunde_id = c.kunde_id
		LEFT JOIN access.dm_dom_customer.customer cus ON cus.customer_id = co.customer_id
		LEFT JOIN  (SELECT DISTINCT lg.kunde_id FROM access.ods_maps_sse.history_action_log lg 
					JOIN access.dm_dom_contract.contract ko ON ko.contract_id=lg.vertrag_id
					WHERE lg.action_id=331 AND DATEDIFF (DAY, ko.contract_activation_date, lg.ts_init) <=30
					) AS rls ON rls.kunde_id = co.customer_id

		LEFT JOIN (SELECT lg.kunde_id , COUNT(lg.history_action_id) AS anzahl
					FROM access.ods_maps_sse.history_action_log lg 
					JOIN dm_dom_contract.contract ko ON ko.contract_id=lg.vertrag_id
					WHERE lg.action_id=331 GROUP BY lg.kunde_id
					) AS rls2 ON rls2.kunde_id=co.customer_id
		;

		set @log_message = N'updated basis mobile daten: ' + cast(@@rowcount as nvarchar(100));
		exec etl.log_event @proc, @arg_job, @log_message;

		----VOIP TEIL

		set @log_message = N'Start to insert active VOIP Daten';
		EXEC etl.log_event @proc, @arg_job, @log_message;

		INSERT INTO #tmp_all_voip(msisdn
									,customer_id
									, contract_id
									, product_id
									, product_desc
									, valid_from
									, valid_to 
									, contract_status_desc
									, product_cluster_id
									, product_line_desc
		)
		SELECT replace(h.phone_number,'+','') as msisdn, c.customer_id, h.contract_id, c.product_id, p.product_desc, h.valid_from, h.valid_to , c.contract_status_desc,  c.product_cluster_id, p.product_line_desc
		from access.rl_sec_dom_contract.rel_contract_phone_number_hist h
		join access.dm_dom_contract.contract c on c.contract_id=h.contract_id
		join access.dm_dom_product.product p on p.product_id=c.product_id
		where p.product_line_id=22
		and h.valid_from < getdate() and h.valid_to > getdate()
		AND c.contract_status_desc NOT IN ('terminated', 'preactive')
		;


		INSERT INTO #tmp_active_voip(msisdn
									,customer_id
									, contract_id
									, product_id
									, product_desc
									, valid_from
									, valid_to 
									, contract_status_desc
									, product_cluster_id
									, product_line_desc
		)


		SELECT a.msisdn
			, a.customer_id
			, a.contract_id
			, a.product_id
			, a.product_desc
			, a.valid_from
			, a.valid_to 
			, a.contract_status_desc
			, a.product_cluster_id
			, a.product_line_desc
		FROM #tmp_all_voip a
		JOIN (
				SELECT msisdn, MAX(valid_from) AS max_valid_from
				FROM #tmp_all_voip
				GROUP BY msisdn
		) b ON b.msisdn=a.msisdn AND b.max_valid_from=a.valid_from
		;


		set @log_message = N'inserted active VOIP daten: ' + cast(@@rowcount as nvarchar(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;


		 insert into #tmp_cfast (
				 id     
				, msisdn 
				, kunde_id 
				, vertrag_id 
				, service_id --set default 29
				, vertrag_datum
				, vertrag_akt
				, produkt_id
				, produkt_bez
				, techauftrag_id
				, activation_date
				) 


		SELECT DISTINCT vp.contract_id + 200000000 AS [id]
			, vp.msisdn
			, vp.customer_id
			, vp.contract_id
			, 29
			, co.contract_creation_date
			, co.contract_activation_date
			, vp.product_id
			, vp.product_desc
			, co.tech_order_id
			, vp.valid_from AS activation_date
		FROM #tmp_active_voip vp
		LEFT JOIN access.dm_dom_contract.contract co ON co.contract_id = vp.contract_id
		;

		UPDATE c 
		SET c.cc_high=cc.customer_care_attribute_id
		  , c.highest_finrisk=fr.financial_risk_priority
		  , c.kunde_anlage = cus.registered_since_datetime
		  , c.kunde_gebdat= cus.birth_date
		  , c.rls_30= case when rls.kunde_id is not null then '1' else '0' end
		  , c.mehrfach_rls = case when rls2.anzahl is not null and rls2.anzahl > 1 then '1' else '0' end
		  , c.lauf = cast(CONVERT(char(8), getdate(), 112) as int)
		FROM #tmp_cfast c
		LEFT JOIN access.cl_dom_fraud.lu_fraud_rel_cc_attribute cc ON cc.kunde_id=c.kunde_id
		LEFT JOIN access.cl_dom_fraud.lu_fraud_rel_cc_financialrisk fr ON fr.kunde_id = c.kunde_id
		LEFT JOIN access.dm_dom_customer.customer cus ON cus.customer_id = c.kunde_id
		LEFT JOIN  (select distinct lg.kunde_id from ods_maps_sse.history_action_log lg 
					join access.dm_dom_contract.contract ko on ko.contract_id=lg.vertrag_id
					where lg.action_id=331 and datediff (day, ko.contract_activation_date, lg.ts_init) <=30
					) AS rls ON rls.kunde_id = c.kunde_id

		LEFT join (select lg.kunde_id , count(lg.history_action_id) as anzahl
					from ods_maps_sse.history_action_log lg 
					join dm_dom_contract.contract ko on ko.contract_id=lg.vertrag_id
					where lg.action_id=331 group by lg.kunde_id
					) AS rls2 on rls2.kunde_id=c.kunde_id
		;

		set @log_message = N'updated basis VOIP daten: ' + cast(@@rowcount as nvarchar(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;
		
		
		-- update last_bill date for access part
		set @log_message = N'Start to update last_billing_date for access';
		EXEC etl.log_event @proc, @arg_job, @log_message;

		INSERT INTO #tmp_letzte_bill_access(customer_id,contract_id,product_id,letzte_bill_stop_date)
		SELECT inv.customer_id, inv.contract_id, inv.product_id, inv.stop_date
		FROM access.dm_dom_billing.contract_invoice inv
		JOIN (
		 SELECT contract_id, customer_id, product_id, MAX(inv.invoice_print_date) AS max_inv_print_date
		 FROM access.dm_dom_billing.contract_invoice inv
		 JOIN #tmp_cfast c ON c.kunde_id=inv.customer_id AND c.produkt_id=inv.product_id AND c.vertrag_id=inv.contract_id
		 GROUP BY contract_id, customer_id, product_id

		) AS max_inv_date ON max_inv_date.contract_id = inv.contract_id 
		 AND max_inv_date.customer_id = inv.customer_id 
		 AND max_inv_date.product_id = inv.product_id
		 AND max_inv_date.max_inv_print_date=inv.invoice_print_date
		;


		UPDATE c 
		SET c.letzt_billing = lb.letzte_bill_stop_date
		FROM #tmp_cfast c
		JOIN #tmp_letzte_bill_access lb ON lb.contract_id = c.vertrag_id AND lb.customer_id = c.kunde_id AND lb.product_id = c.produkt_id
		;
		
		set @log_message = N'updated last_bill_date for access: ' + cast(@@rowcount as nvarchar(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;

		--GMX TEIL

		set @log_message = N'Start to insert GMX daten';
		EXEC etl.log_event @proc, @arg_job, @log_message;

		INSERT INTO #tmp_gmx_sms
		(
			contract_id,
			activation_date,
			contractposition_id,
			productposition_id,
			fee_group_id
		)

		SELECT  DISTINCT cp.contract_id
				, cp.activation_datetime
				, cp.contractposition_id
				, cp.productposition_id
				, pp.fee_group_id
		from mam.dm_dom_contract.contractposition cp
		join mam.dm_dom_product.productposition pp
		on pp.productposition_id = cp.productposition_id
		and fee_group_id = 12
		where cp.contractposition_status_id = 4
		;
		set @log_message = N'inserted GMX daten: ' + cast(@@rowcount as nvarchar(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;

		INSERT INTO #tmp_cfast
		(
			id,
			msisdn,
			vertrag_id,
			service_id,
			produkt_id,
			produkt_bez,
			vertrag_datum,
			vertrag_akt,
			techauftrag_id,
			kunde_id,
			kunde_anlage,
			kunde_gebdat,
			activation_date
		)
		SELECT  DISTINCT sms.contract_id + 200000000 AS [id]
				, CAST(sms.contract_id AS VARCHAR) AS msisdn
				, sms.contract_id
				, sms.fee_group_id
				, co.product_id
				, p.product_desc
				, co.contract_creation_date
				, co.contract_activation_date
				, co.tech_order_id
				, cus.customer_id
				, cus.registered_since_date
				, cus.birth_date
				, sms.activation_date
		FROM #tmp_gmx_sms sms
		LEFT JOIN mam.dm_dom_contract.contract co ON co.contract_id = sms.contract_id 
		LEFT JOIN mam.dm_dom_customer.customer cus ON cus.customer_id = co.customer_id
		LEFT JOIN mam.dm_dom_product.product p ON p.product_id = co.product_id;

		set @log_message = N'inserted basis GMX daten: ' + cast(@@rowcount as nvarchar(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;

		UPDATE  c
		SET c.cc_high=cc.customer_care_attribute_id
		  , c.highest_finrisk=fr.financial_risk_priority
		  , c.rls_30= case when rls.kunde_id is not null then '1' else '0' end
		  , c.mehrfach_rls = case when rls2.anzahl is not null and rls2.anzahl > 1 then '1' else '0' end
		  , c.lauf = cast(CONVERT(char(8), getdate(), 112) as int)
		FROM #tmp_cfast c
		LEFT JOIN access.cl_dom_fraud.lu_fraud_rel_cc_attribute cc ON cc.kunde_id=c.kunde_id
		LEFT JOIN access.cl_dom_fraud.lu_fraud_rel_cc_financialrisk fr ON fr.kunde_id = c.kunde_id
		LEFT JOIN  (select distinct lg.kunde_id from ods_maps_sse.history_action_log lg 
					join mam.dm_dom_contract.contract ko on ko.contract_id=lg.vertrag_id
					where lg.action_id=331 and datediff (day, ko.contract_activation_date, lg.ts_init) <=30
					) AS rls ON rls.kunde_id = c.kunde_id

		LEFT join (select lg.kunde_id , count(lg.history_action_id) as anzahl
					from ods_maps_sse.history_action_log lg 
					join mam.dm_dom_contract.contract ko on ko.contract_id=lg.vertrag_id
					where lg.action_id=331 group by lg.kunde_id
					) AS rls2 on rls2.kunde_id=c.kunde_id
		;

		set @log_message = N'updated basis GMX daten: ' + cast(@@rowcount as nvarchar(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;
		
		
		-- update last bill part for gmx part
		set @log_message = N'Start to update last_billing_date for access';
		EXEC etl.log_event @proc, @arg_job, @log_message;

		INSERT INTO #tmp_letzte_bill_mam(customer_id,contract_id,product_id,letzte_bill_stop_date)
		SELECT inv.customer_id, inv.contract_id, inv.product_id, inv.stop_date
		FROM mam.dm_dom_billing.contract_invoice inv
		JOIN (
		 SELECT contract_id, customer_id, product_id, MAX(inv.invoice_print_date) AS max_inv_print_date
		 FROM mam.dm_dom_billing.contract_invoice inv
		 JOIN #tmp_cfast c ON c.kunde_id=inv.customer_id AND c.produkt_id=inv.product_id AND c.vertrag_id=inv.contract_id
		 GROUP BY contract_id, customer_id, product_id

		) AS max_inv_date ON max_inv_date.contract_id = inv.contract_id 
		 AND max_inv_date.customer_id = inv.customer_id 
		 AND max_inv_date.product_id = inv.product_id
		 AND max_inv_date.max_inv_print_date=inv.invoice_print_date
		;


		UPDATE c 
		SET c.letzt_billing = lb.letzte_bill_stop_date
		FROM #tmp_cfast c
		JOIN #tmp_letzte_bill_mam lb ON lb.contract_id = c.vertrag_id AND lb.customer_id = c.kunde_id AND lb.product_id = c.produkt_id
		;

		set @log_message = N'updated last_bill_date for GMX: ' + cast(@@rowcount as nvarchar(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;

		-- access
		set @log_message = N'Start to insert RPS daten for access';
		EXEC etl.log_event @proc, @arg_job, @log_message;
		
		INSERT INTO #tmp_rps
		select distinct 
			  d.contract_id AS  contract_id
			, h.fraudclientid
			, h.ir_scoreclass
			, h.kundentyp
			, try_convert(int, b2.value_x) as erstlimit
			, h.schufaki
			, try_convert(int, h.addressattribute) AS addressattribute
			, co.city as contact_city
			, qq.city as liefer_city
			, try_convert(int, b5.value_x) as aeltester_vertrag
		from access.dm_dom_fraud.f_rps_detail d
		join access.dm_dom_fraud.f_rps_header h on h.request_id=d.request_id
		left join access.cl_dom_fraud.detailv_final_decision_ruleset_answer_bi b5 on b5.request_id=d.request_id and b5.key_x= 'intern.oldestContractAge'
		left join access.cl_dom_fraud.detailv_final_decision_ruleset_answer_bi b2 on b2.request_id=d.request_id and b2.key_x= 'intern.firstLimitClass'
		left join access.cl_dom_fraud.detailv_customer_contact co on co.request_id=d.request_id 
		left join access.cl_dom_fraud.detailv_query_contact qq on qq.request_id=d.request_id and qq.type_x='7'
		where h.business_case in ('NEW_ORDER','PRODUCT_CHANGE') AND  d.contract_id IN (select vertrag_id FROM #tmp_cfast)
		;

		set @log_message = N'inserted RPS daten [access]: ' + cast(@@rowcount as nvarchar(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;

		-- mam
		set @log_message = N'Start to insert RPS daten [mam]';
		EXEC etl.log_event @proc, @arg_job, @log_message;

		INSERT INTO #tmp_rps
		select distinct 
			  d.contract_id AS  contract_id
			, h.fraudclientid
			, h.ir_scoreclass
			, h.kundentyp
			, try_convert(int, b2.value_x) as erstlimit
			, h.schufaki
			, try_convert(int, h.addressattribute) AS addressattribute
			, co.city as contact_city
			, NULL 
			, try_convert(int, b5.value_x) as aeltester_vertrag
		from mam.dm_dom_fraud.f_rps_detail d
		join mam.dm_dom_fraud.f_rps_header h on h.request_id=d.request_id
		left join mam.cl_dom_fraud.detailv_final_decision_ruleset_answer_bi b5 on b5.request_id=d.request_id and b5.key_x= 'intern.oldestContractAge'
		left join mam.cl_dom_fraud.detailv_final_decision_ruleset_answer_bi b2 on b2.request_id=d.request_id and b2.key_x= 'intern.firstLimitClass'
		left join mam.cl_dom_fraud.detailv_customer_contact co on co.request_id=d.request_id 
		where h.business_case in ('NEW_ORDER','PRODUCT_CHANGE') AND  d.contract_id IN (select vertrag_id FROM #tmp_cfast)
		;

		set @log_message = N'inserted RPS daten [mam]: ' + cast(@@rowcount as nvarchar(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;

		update c
		set c.fraud_clientid=bas.fraudclientid
		  , c.scoreclass=bas.ir_scoreclass
		  , c.customertype= bas.customertype
		  , c.erstlimit = bas.erstlimit
		  , c.schufa_ki= case when bas.schufaki= 1 then 1 else 0 end 
		  , c.adress_attribut = bas.addressattribute
		  , c.contact_city=bas.contact_city
		  , c.liefer_city=bas.liefer_city
		  , c.aeltester_vertrag = bas.aeltester_vertrag
		from #tmp_cfast c
		join #tmp_rps bas on bas.contract_id=c.vertrag_id
		;

		set @log_message = N'updated RPS daten: ' + cast(@@rowcount as nvarchar(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;


		set @log_message = N'Start erste_nutzung daten';
		EXEC etl.log_event @proc, @arg_job, @log_message;

		UPDATE c 
		SET c.erste_nutzung=t2.contract_first_use
		FROM #tmp_cfast c
		LEFT JOIN (
			SELECT contract_id, MIN(first_usage_datetime) AS contract_first_use
			FROM  access.dm_dom_contract.contractposition 
			WHERE contract_id IN (SELECT vertrag_id FROM #tmp_cfast)
			GROUP BY contract_id
			UNION
			SELECT contract_id, MIN(first_usage_datetime) AS contract_first_use
			FROM  mam.dm_dom_contract.contractposition 
			WHERE contract_id IN (SELECT vertrag_id FROM #tmp_cfast)
			GROUP BY contract_id
		) AS t2 ON t2.contract_id=c.vertrag_id;

		set @log_message = N'updated erste_nutzung daten: ' + cast(@@rowcount as nvarchar(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;

		set @log_message = N'Start kunde_erstnutz daten';
		EXEC etl.log_event @proc, @arg_job, @log_message;

		UPDATE c 
		SET c.kunde_erstnutz=t2.kunden_first_use
		FROM #tmp_cfast c
		LEFT JOIN (
			SELECT c.customer_id, MIN(cp.first_usage_datetime) AS kunden_first_use
			FROM access.dm_dom_customer.customer c
			JOIN access.dm_dom_contract.contract con ON c.customer_id = con.customer_id
			JOIN access.dm_dom_contract.contractposition  cp ON cp.contract_id = con.contract_id
			WHERE c.customer_id IN (SELECT kunde_id FROM #tmp_cfast)
			AND cp.first_usage_datetime IS NOT NULL
			GROUP BY c.customer_id
			UNION
			SELECT c.customer_id, MIN(cp.first_usage_datetime) AS kunden_first_use
			FROM mam.dm_dom_customer.customer c
			JOIN mam.dm_dom_contract.contract con ON c.customer_id = con.customer_id
			JOIN mam.dm_dom_contract.contractposition  cp ON cp.contract_id = con.contract_id
			WHERE c.customer_id IN (SELECT kunde_id FROM #tmp_cfast)
			AND cp.first_usage_datetime IS NOT NULL
			GROUP BY c.customer_id		
		) AS t2 ON t2.customer_id=c.kunde_id;
		SET @log_message = N'updated kunde_erstnutz daten: ' + CAST(@@rowcount AS NVARCHAR(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;

		SET @log_message = N'Start Anzahl aktive SIM pro Kunde';
		EXEC etl.log_event @proc, @arg_job, @log_message;

		UPDATE c
				SET c.anz_simcard = sims.anzahl
		FROM #tmp_cfast c    
		JOIN(   SELECT con_inv.customer_id, COUNT(DISTINCT ss.external_subscriber_id) AS anzahl
				FROM access.dm_dom_billing.contract_invoice con_inv
				JOIN access.dm_dom_contract.mobile_contract_hist hist ON hist.contract_id = con_inv.contract_id -- get subscriber_id
				JOIN access.ods_mobileprocess_mss.subscribers ss ON ss.id = hist.subscriber_id AND ss.state IN ('ACTIVE', 'CREATED')
				WHERE ss.cancellation_date IS NULL 
				AND (hist.valid_to IS NULL OR hist.valid_to > GETDATE())
				AND con_inv.customer_id IN (SELECT kunde_id FROM #tmp_cfast)
				GROUP BY con_inv.customer_id

			) AS sims ON sims.customer_id = c.kunde_id
		;
		SET @log_message = N'updated Anzahl aktive SIM pro Kunde daten: ' + CAST(@@rowcount AS NVARCHAR(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;

		SET @log_message = N'Start maximale Rechnung Kunde';
		EXEC etl.log_event @proc, @arg_job, @log_message;

		INSERT INTO #tmp_kunde_id(kunde_id)
		SELECT DISTINCT kunde_id FROM #tmp_cfast;

		INSERT INTO #tmp_rk(kunde_id,rechnung,bruttosumme)
		SELECT customer_id, case when summary_invoice_id > 0 then summary_invoice_id else contract_invoice_id end as invoice_id, SUM(gross_amount) AS brutto
		FROM access.dm_dom_billing.contract_invoice
		WHERE sap_export_datetime < DATEADD(DAY, -60, GETDATE())
		AND cancelled_type_id = 0
		AND customer_id IN (SELECT kunde_id FROM #tmp_cfast)
		GROUP BY customer_id, case when summary_invoice_id > 0 then summary_invoice_id else contract_invoice_id end
		;
		set @log_message = N'inserted #tmp_rk: ' + cast(@@rowcount as nvarchar(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;

		INSERT  INTO #tmp_mr(didi,max_rech)

		SELECT a.kunde_id, max(maxo_sum)
		FROM
			(select tmp.kunde_id as kunde_id,
						tmp.rechnung,
						max(tmp.bruttosumme) as maxo_sum 
				from #tmp_rk as tmp
				group by tmp.kunde_id,tmp.rechnung
			) a
		group by a.kunde_id;

		set @log_message = N'inserted #tmp_mr (max_rechnung): ' + cast(@@rowcount as nvarchar(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;

		UPDATE  c
		SET c.max_rechnung = maxi.max_rech 
		FROM #tmp_cfast c    
		JOIN #tmp_mr as maxi on maxi.didi = c.kunde_id;

		set @log_message = N'updated max_rechnung: ' + cast(@@rowcount as nvarchar(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;

		set @log_message = N'Start delta berechnung';
		EXEC etl.log_event @proc, @arg_job, @log_message;

		set @log_message = N'Start new_msisdn_id identifizieren';
		EXEC etl.log_event @proc, @arg_job, @log_message;

		INSERT INTO #tmp_new(new_msisdn_id)
		SELECT c.msisdn
		FROM #tmp_cfast c 
		LEFT JOIN rl_sec_dom_fraud.f_fraud_cfast a ON a.msisdn = c.msisdn
		WHERE c.vertrag_id IS NOT NULL AND c.service_id IS NOT NULL 
		AND a.msisdn is null;

		set @log_message = N'inserted new_msisdn_id in temp table: ' + cast(@@rowcount as nvarchar(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;

		-- find re_new ids (newly activated msisdn ids)
		INSERT INTO #tmp_re_new(re_new_msisdn_id)
		SELECT c.msisdn
		FROM #tmp_cfast c 
		LEFT JOIN rl_sec_dom_fraud.f_fraud_cfast a ON a.msisdn = c.msisdn
		WHERE c.vertrag_id IS NOT NULL AND c.service_id IS NOT NULL 
		AND a.delta = 'D';

		set @log_message = N'inserted re_new_msisdn_id in temp table: ' + cast(@@rowcount as nvarchar(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;

		set @log_message = N'Start updated_msisdn_id identifizieren';
		EXEC etl.log_event @proc, @arg_job, @log_message;

		INSERT INTO #tmp_update(update_msisdn_id)
		SELECT updated.msisdn
		FROM (
				SELECT    c.msisdn,
						  c.activation_date,
						  c.adress_attribut,
						  c.aeltester_vertrag,
						  c.anz_simcard,
						  c.cc_high,
						  c.contact_city,
						  c.customertype,
						  c.erste_nutzung,
						  c.erstlimit,
						  c.fraud_clientid,
						  c.highest_finrisk,
						  c.imsi,
						  c.kunde_anlage,
						  c.kunde_erstnutz,
						  c.kunde_gebdat,
						  c.kunde_id,
						  c.kundenscore,
						  c.letzt_billing,
						  c.liefer_city,
						  c.limit_class,
						  c.max_rechnung,
						  c.mehrfach_rls,
						  c.monitoring_szenario,
						  c.nonpayer_flag,
						  c.produkt_bez,
						  c.produkt_id,
						  c.rls_30,
						  c.schufa_ki,
						  c.scoreclass,
						  c.service_id,
						  c.techauftrag_id,
						  c.teilnehmer_id,
						  c.vertrag_akt,
						  c.vertrag_datum,
						  c.vertrag_id

				FROM #tmp_cfast c
				WHERE c.msisdn NOT IN (SELECT new_msisdn_id FROM #tmp_new)
				EXCEPT
				SELECT    a.msisdn,
						  a.activation_date,
						  a.adress_attribut,
						  a.aeltester_vertrag,
						  a.anz_simcard,
						  a.cc_high,
						  a.contact_city,
						  a.customertype,
						  a.erste_nutzung,
						  a.erstlimit,
						  a.fraud_clientid,
						  a.highest_finrisk,
						  a.imsi,
						  a.kunde_anlage,
						  a.kunde_erstnutz,
						  a.kunde_gebdat,
						  a.kunde_id,
						  a.kundenscore,
						  a.letzt_billing,
						  a.liefer_city,
						  a.limit_class,
						  a.max_rechnung,
						  a.mehrfach_rls,
						  a.monitoring_szenario,
						  a.nonpayer_flag,
						  a.produkt_bez,
						  a.produkt_id,
						  a.rls_30,
						  a.schufa_ki,
						  a.scoreclass,
						  a.service_id,
						  a.techauftrag_id,
						  a.teilnehmer_id,
						  a.vertrag_akt,
						  a.vertrag_datum,
						  a.vertrag_id

				FROM access.rl_sec_dom_fraud.f_fraud_cfast a
				)  updated
		;
		set @log_message = N'inserted update_msisdn_id in #tmp_update: ' + cast(@@rowcount as nvarchar(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;


		UPDATE c 
		SET c.delta = 'I'
		FROM #tmp_cfast c
		LEFT JOIN access.rl_sec_dom_fraud.f_fraud_cfast a ON a.msisdn = c.msisdn 
		WHERE c.vertrag_id IS NOT NULL AND c.service_id IS NOT NULL 
		AND a.msisdn IS NULL
		;

		set @log_message = N'updated delta-I daten in #tmp_cfast table: ' + cast(@@rowcount as nvarchar(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;

		UPDATE c
		SET c.delta='U'
		FROM #tmp_cfast c 
		WHERE c.msisdn IN (SELECT update_msisdn_id FROM #tmp_update)

		set @log_message = N'updated delta-U daten #tmp_cfast table: ' + cast(@@rowcount as nvarchar(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;


		--start to work on main table f_fraud_cfast: modifying: updating

		UPDATE a
		SET a.delta = 'D',
			lauf= cast(CONVERT(char(8), getdate(), 112) as int),
			export_id = NULL,
			rl_load_date = GETDATE(),
			rl_load_job_id = @arg_job
		FROM access.rl_sec_dom_fraud.f_fraud_cfast a
		LEFT JOIN #tmp_cfast b on b.msisdn=a.msisdn
		WHERE b.msisdn is null;

		set @log_message = N'updated delta-D daten in f_fraud_cfast table: ' + cast(@@rowcount as nvarchar(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;

		--insert new items
		set @log_message = N'start to  insert delta-I daten in f_fraud_cfast tabelle';
		EXEC etl.log_event @proc, @arg_job, @log_message;

		INSERT INTO access.rl_sec_dom_fraud.f_fraud_cfast (
					 delta
					,id 
					,msisdn 
					,activation_date 
					,kunde_id
					,teilnehmer_id
					,produkt_id 
					,kunde_anlage 
					,vertrag_id
					,vertrag_datum 
					,letzt_billing 
					,erste_nutzung 
					,fraud_clientid 
					,kunde_gebdat
					,rls_30 
					,anz_simcard
					,service_id
					,erstlimit
					,produkt_bez
					,scoreclass
					,techauftrag_id
					,max_rechnung
					,vertrag_akt
					,kunde_erstnutz
					,cc_high
					,imsi
					,highest_finrisk
					,kundenscore
					,adress_attribut
					,contact_city
					,customertype
					,liefer_city
					,schufa_ki
					,aeltester_vertrag
					,monitoring_szenario
					,limit_class
					,mehrfach_rls 
					,nonpayer_flag 
					,lauf 
					,export_id 
					,rl_load_date 
					,rl_load_job_id        
		)
   

		SELECT       delta
					,id 
					,msisdn 
					,activation_date 
					,kunde_id
					,teilnehmer_id
					,produkt_id 
					,kunde_anlage 
					,vertrag_id
					,vertrag_datum 
					,letzt_billing 
					,erste_nutzung 
					,fraud_clientid 
					,kunde_gebdat
					,rls_30 
					,anz_simcard
					,service_id
					,erstlimit
					,produkt_bez
					,scoreclass
					,techauftrag_id
					,max_rechnung
					,vertrag_akt
					,kunde_erstnutz
					,cc_high
					,imsi
					,highest_finrisk
					,kundenscore
					,adress_attribut
					,contact_city
					,customertype
					,liefer_city
					,schufa_ki
					,aeltester_vertrag
					,monitoring_szenario
					,limit_class
					,mehrfach_rls 
					,nonpayer_flag 
					,lauf 
					,null
					,GETDATE() 
					,@arg_job
		FROM #tmp_cfast c
		WHERE c.vertrag_id IS NOT NULL AND c.service_id IS NOT NULL 
		AND c.delta = 'I'
		;
		set @log_message = N'inserted delta-I daten in f_fraud_cfast tabelle: ' + cast(@@rowcount as nvarchar(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;

		--insert updated items

		UPDATE a
		SET    a.delta = c.delta
			  ,a.id = c.id
			  ,a.msisdn = c.msisdn
			  ,a.activation_date = c.activation_date
			  ,a.kunde_id = c.kunde_id
			  ,a.teilnehmer_id = c.teilnehmer_id
			  ,a.produkt_id = c.produkt_id
			  ,a.kunde_anlage = c.kunde_anlage
			  ,a.vertrag_id = c.vertrag_id
			  ,a.vertrag_datum = c.vertrag_datum 
			  ,a.letzt_billing = c.letzt_billing
			  ,a.erste_nutzung = c.erste_nutzung
			  ,a.fraud_clientid = c.fraud_clientid
			  ,a.kunde_gebdat = c.kunde_gebdat
			  ,a.rls_30 = c.rls_30
			  ,a.anz_simcard = c.anz_simcard
			  ,a.service_id = c.service_id
			  ,a.erstlimit = c.erstlimit
			  ,a.produkt_bez = c.produkt_bez
			  ,a.scoreclass = c.scoreclass
			  ,a.techauftrag_id = c.techauftrag_id
			  ,a.max_rechnung = c.max_rechnung
			  ,a.vertrag_akt = c.vertrag_akt
			  ,a.kunde_erstnutz = c.kunde_erstnutz
			  ,a.cc_high = c.cc_high
			  ,a.imsi = c.imsi
			  ,a.highest_finrisk = c.highest_finrisk
			  ,a.kundenscore = c.kundenscore
			  ,a.adress_attribut = c.adress_attribut
			  ,a.contact_city = c.contact_city
			  ,a.customertype = c.customertype
			  ,a.liefer_city = c.liefer_city
			  ,a.schufa_ki = c.schufa_ki
			  ,a.aeltester_vertrag = c.aeltester_vertrag
			  ,a.monitoring_szenario = c.monitoring_szenario
			  ,a.limit_class = c.limit_class
			  ,a.mehrfach_rls = c.mehrfach_rls
			  ,a.nonpayer_flag = c.nonpayer_flag
			  ,a.lauf = c.lauf
			  ,a.export_id = NULL
              ,a.rl_load_date = GETDATE()
			  ,a.rl_load_job_id = @arg_job 
		FROM access.rl_sec_dom_fraud.f_fraud_cfast a
		JOIN #tmp_cfast c ON a.msisdn=c.msisdn
		WHERE c.delta='U'
		;

		set @log_message = N'set delta-U in f_fraud_cfast tabelle: ' + cast(@@rowcount as nvarchar(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;

		-- Set I to re_new msisdn ids
		UPDATE a
		SET a.delta = 'I',
			lauf= cast(CONVERT(char(8), getdate(), 112) as int),
			export_id = NULL,
			rl_load_date = GETDATE(),
			rl_load_job_id = @arg_job
		FROM access.rl_sec_dom_fraud.f_fraud_cfast a
		WHERE a.msisdn IN (SELECT re_new_msisdn_id FROM #tmp_re_new);

		set @log_message = N'updated delta-D to delta- I (re_new) in f_fraud_cfast table: ' + cast(@@rowcount as nvarchar(100));
		EXEC etl.log_event @proc, @arg_job, @log_message;


	END

	set @log_message = 'Finished Job ' + @arg_job
	exec etl.log_event @proc, @arg_job, @log_message

	return @resultcode 

	END TRY
    
	begin catch
		declare @error_number int;
		declare @error_severity int;
		declare @error_state int;
		declare @error_line int;
		declare @error_message nvarchar(max);
		set @error_number = error_number();
		set @error_severity = error_severity();
		set @error_state = error_state();
		set @error_line = error_line();
		set @error_message = error_message();
		exec etl.log_exception @proc, @arg_job, @error_number, @error_severity, @error_state, @error_line, @error_message;
		throw;
	end catch;

END;
go