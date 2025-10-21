use access;
go

set quoted_identifier on;

set ansi_nulls on;
go

create or alter procedure cl_dom_mobile_access.load_entry_communication_event @arg_job nvarchar(255)
with execute as owner
as
begin
    set nocount on;

    declare @log_message nvarchar(max);
    declare @proc nvarchar(255);
    declare @resultcode int;
    declare @arg_load_date datetime;

    if @arg_job is null
        set @arg_job = user_name() + '#' + cast(newid() as nvarchar(255));

    set @resultcode = 0;
    set @proc = etl.get_proc_name(@@procid);
    set @arg_load_date = getdate();

    begin try
        exec etl.log_revision
            @proc
          , @arg_job
          , '$URL: https://svn.1and1.org/svn/ebi_mssql_access/access/trunk/access/Layers/cl-layer/cl_dom_mobile_access/Programmability/load_roaming_location_data.sql $'
          , '$Revision: 6289 $'
          , '$Author: ajaber $'
          , '$Date: 2021-10-25 09:11:44 +0200 (Di, 27 Aug 2019) $';

        set @log_message = N'Started Job ' + @arg_job;

        exec etl.log_event @proc, @arg_job, @log_message;

        declare @offset_datetime date;

        set @offset_datetime = '2022-01-31';

        declare @var_max_load_datetime datetime = (
                    select coalesce(max(cl_load_date), '1900-01-01')
                    from cl_dom_mobile_access.entry_communication_event ece
                );

        drop table if exists #tmp_communication_template;

        create table #tmp_communication_template (
            communication_template_id   int           not null
          , communication_template_desc nvarchar(255) not null
        );

        insert into #tmp_communication_template (
            communication_template_id
          , communication_template_desc
        )
-- SQL Prompt formatting off

		values 
			 (1,'fast track access mobile roaming entry sms ac')
			,(2,'access mobile roaming add data volume ac')
			,(3,'access mobile roaming pay as you go ac')
			,(4,'access mobile roaming data volume offer ac')
			,(5,'access mobile roaming data volume order confirmation ac')

-- SQL Prompt formatting on
        if @var_max_load_datetime = '1900-01-01'
        begin
            set @log_message = N'Start full load since ' + convert(nvarchar, @offset_datetime, 23);

            exec etl.log_event @proc, @arg_job, @log_message;

            with relevant_communication_event as (
                select
                    customer_id = try_convert(bigint, ce.customer_id)
                  , contract_id = try_convert(bigint, ce.contract_id)
                  , ce.communication_contact_date
                  , tct.communication_template_id
                  , ce.world_zone
                  , ce.ods_load_date
                from ods_operationprocess_chs.communication_event ce
                join #tmp_communication_template                  tct
                    on tct.communication_template_desc = ce.communication_template_id
            )
               , rlu as (
                select
                    a.roaming_location_data_id
                  , a.external_subscriber_id
                  , a.incoming_datetime
                  , outcoming_datetime = coalesce(dateadd(millisecond, -10, lead(a.incoming_datetime) over (partition by a.external_subscriber_id
                                                                                                            order by a.incoming_datetime
                                                                                                      )
                                                  ), '9999-12-31'
                                         )
                  , a.mobile_access_provider_id
                  , a.multicard_quantity
                  , a.rlu_rn
                  , a.rn_by_wz
                  , a.is_entry_ind
                  , a.country
                  , a.network
                  , a.cl_load_date
                  , a.world_zone
                from (
                    select
                        roaming_location_data_id  = lrlu.id
                      , external_subscriber_id    = lrlu.subscriber_id
                      , incoming_datetime         = lrlu.rlu_date
                      , mobile_access_provider_id = coalesce(p.mobile_access_provider_id, -1)
                      , multicard_quantity        = count(lrlu.imsi) over (partition by
                                                                               lrlu.subscriber_id
                                                                             , lrlu.rlu_date
                                                                             , lrlu.country
                                                                     )
                      , rlu_rn                    = row_number() over (partition by
                                                                           lrlu.subscriber_id
                                                                         , lrlu.rlu_date
                                                                       --, rlu.country
                                                                       order by lrlu.rlu_date
                                                                              , lrlu.id desc
                                                                 )
                      , rn_by_wz                  = row_number() over (partition by
                                                                           lrlu.subscriber_id
                                                                         , cast(lrlu.rlu_date as date)
                                                                         , coalesce(wz.zone, 'n/a')
                                                                       order by lrlu.rlu_date
                                                                 )
                      , is_entry_ind              = case
                                                        when lrlu.network <> '26207'
                                                            then 1
                                                        else 0
                                                    end
                      , lrlu.country
                      , lrlu.network
                      , lrlu.cl_load_date
                      , world_zone                = coalesce(wz.zone, 'n/a')
                    from cl_dom_mobile_access.log_roaming_location_update    lrlu
                    left join ods_mobileservices_mobileeventhub.mcc_mnc_zone mnz
                        on (
                            mnz.mcc                = try_convert(int, left(lrlu.network, 3))
                        and mnz.mnc                = try_convert(int, right(lrlu.network, 2))
                        )
                    left join ods_mobileservices_mobileeventhub.mcc_mnc_zone mnz_2
                        on (
                            mnz_2.mcc              = try_convert(int, left(lrlu.network, 3))
                        and mnz_2.mnc is null
                        )
                    left join ods_mobileservices_mobileeventhub.world_zone   wz
                        on wz.id                   = coalesce(mnz.world_zone_id, mnz_2.world_zone_id)
                    left join dm_dom_mobile_access.provider                  p
                        on p.network_provider_desc = lrlu.provider
                    where lrlu.subscriber_id is not null
                      and lrlu.rlu_date >= @offset_datetime
                ) a
                where a.rlu_rn = 1
            )
            insert into cl_dom_mobile_access.entry_communication_event (
                entry_communication_event_id
              , external_subscriber_id
              , incoming_datetime
              , outcoming_datetime
              , mobile_access_provider_id
              , entry_quantity
              , welcome_sms_quantity
              , expired_sms_quantity
              , offer_sms_quantity
              , confirmation_sms_for_package_ordered_quantity
              , confirmation_sms_for_roaming_activation_quantity
              , multicard_quantity
              , country_desc
              , world_zone_desc
              , cl_load_job_id
              , cl_load_date
            )
            select
                b.roaming_location_data_id
              , b.external_subscriber_id
              , b.incoming_datetime
              , b.outcoming_datetime
              , b.mobile_access_provider_id
              , b.entry_quantity
              , b.welcome_sms_quantity
              , b.expired_sms_quantity
              , b.offer_sms_quantity
              , b.confirmation_sms_for_package_ordered_quantity
              , b.confirmation_sms_for_roaming_activation_quantity
              , b.multicard_quantity
              , b.country_desc
              , b.world_zone_desc
              , @arg_job
              , @arg_load_date
            from (
                select
                    a.roaming_location_data_id
                  , a.external_subscriber_id
                  , a.incoming_datetime
                  , a.outcoming_datetime
                  , a.mobile_access_provider_id
                  , a.entry_quantity
                  , welcome_sms_quantity                             = sum(case
                                                                               when rn_contacts = 1
                                                                                and a.welcome_sms_quantity > 0
                                                                                   then a.welcome_sms_quantity
                                                                               else 0
                                                                           end
                                                                       )
                  , expired_sms_quantity                             = sum(case
                                                                               when rn_contacts = 1
                                                                                and a.expired_sms_quantity > 0
                                                                                   then a.expired_sms_quantity
                                                                               else 0
                                                                           end
                                                                       )
                  , offer_sms_quantity                               = sum(case
                                                                               when rn_contacts = 1
                                                                                and a.offer_sms_quantity > 0
                                                                                   then a.offer_sms_quantity
                                                                               else 0
                                                                           end
                                                                       )
                  , confirmation_sms_for_package_ordered_quantity    = sum(case
                                                                               when rn_contacts = 1
                                                                                and a.confirmation_sms_for_package_ordered_quantity > 0
                                                                                   then a.confirmation_sms_for_package_ordered_quantity
                                                                               else 0
                                                                           end
                                                                       )
                  , confirmation_sms_for_roaming_activation_quantity = sum(case
                                                                               when rn_contacts = 1
                                                                                and a.confirmation_sms_for_roaming_activation_quantity > 0
                                                                                   then a.confirmation_sms_for_roaming_activation_quantity
                                                                               else 0
                                                                           end
                                                                       )
                  , a.multicard_quantity
                  , a.country_desc
                  , a.world_zone_desc
                from (
                    select
                        rlu.roaming_location_data_id
                      , rlu.external_subscriber_id
                      , ce.communication_contact_date
                      , rlu.incoming_datetime
                      , rlu.outcoming_datetime
                      , rlu.mobile_access_provider_id
                      , entry_quantity                                   = 1
                      , welcome_sms_quantity                             = sum(case
                                                                                   when ce.communication_template_id = 1 --'fast track access mobile roaming entry sms ac'
                                                                                       then 1
                                                                                   else 0
                                                                               end
                                                                           )
                      , expired_sms_quantity                             = sum(case
                                                                                   when ce.communication_template_id = 2 --'access mobile roaming add data volume ac'
                                                                                       then 1
                                                                                   else 0
                                                                               end
                                                                           )
                      , offer_sms_quantity                               = sum(case
                                                                                   when ce.communication_template_id = 4 -- 'access mobile roaming data volume offer ac'
                                                                                       then 1
                                                                                   else 0
                                                                               end
                                                                           )
                      , confirmation_sms_for_package_ordered_quantity    = sum(case
                                                                                   when ce.communication_template_id = 5 --'access mobile roaming data volume order confirmation ac' and ........
                                                                                       then 1
                                                                                   else 0
                                                                               end
                                                                           )
                      , confirmation_sms_for_roaming_activation_quantity = sum(case
                                                                                   when ce.communication_template_id = 3 --'access mobile roaming pay as you go ac'
                                                                                       then 1
                                                                                   else 0
                                                                               end
                                                                           )
                      , rlu.multicard_quantity
                      , country_desc                                     = rlu.country
                      , world_zone_desc                                  = rlu.world_zone
                      , rlu.is_entry_ind
                      , rn_contacts                                      = row_number() over (partition by
                                                                                                  ce.customer_id
                                                                                                , ce.communication_contact_date
                                                                                              order by ce.communication_contact_date
                                                                                        )
                    from rlu                                                           rlu
                    left join cl_dom_mobile_access.his_rel_roaming_subscriber_contract hrrsc
                        on hrrsc.external_subscriber_id         = rlu.external_subscriber_id
                       and rlu.incoming_datetime between hrrsc.valid_from and hrrsc.valid_to
                    left join relevant_communication_event                             ce
                        on ce.customer_id                       = hrrsc.customer_id
                       and (
                           (
                               ce.communication_contact_date between rlu.incoming_datetime and rlu.outcoming_datetime
                           and ce.world_zone                    = rlu.world_zone
                           )
                        or (
                            ce.world_zone                       = rlu.world_zone
                        and cast(rlu.incoming_datetime as date) = cast(ce.communication_contact_date as date)
                        and ce.communication_contact_date       >= rlu.incoming_datetime
                        and rlu.rn_by_wz                        = 1
                        )
                       )
                    group by rlu.roaming_location_data_id
                           , rlu.is_entry_ind
                           , rlu.outcoming_datetime
                           , ce.communication_contact_date
                           , rlu.mobile_access_provider_id
                           , rlu.incoming_datetime
                           , rlu.external_subscriber_id
                           , rlu.multicard_quantity
                           , rlu.country
                           , rlu.is_entry_ind
                           , rlu.world_zone
                           , ce.customer_id
                ) a
                where a.is_entry_ind = 1
                group by a.roaming_location_data_id
                       , a.external_subscriber_id
                       , a.incoming_datetime
                       , a.outcoming_datetime
                       , a.mobile_access_provider_id
                       , a.entry_quantity
                       , a.multicard_quantity
                       , a.country_desc
                       , a.world_zone_desc
            ) b;

            set @log_message = N'--> Affected rows: ' + convert(varchar, coalesce(@@rowcount, 0));

            exec etl.log_event @proc, @arg_job, @log_message;
        end;
        else
        begin
            set @log_message = N'Determine changed data since ' + convert(nvarchar, @var_max_load_datetime, 23);

            exec etl.log_event @proc, @arg_job, @log_message;

            drop table if exists #relevant_dataset;

            create table #relevant_dataset (
                external_subscriber_id bigint not null
            );

            create clustered columnstore index ccidx_relevant_dataset on #relevant_dataset;

            drop table if exists #tmp_entry;

            create table #tmp_entry (
                roaming_location_data_id                         bigint        not null --cl_dom_mobile_access.log_roaming_location_update.id
              , external_subscriber_id                           bigint        not null
              , incoming_datetime                                datetime      null
              , outcoming_datetime                               datetime      null
              , mobile_access_provider_id                        int           null
              , entry_quantity                                   int           null     --Anzahl Einreisen
              , welcome_sms_quantity                             int           null     --Willkomens-SMS pro Auslandsaufenthalt
              , expired_sms_quantity                             int           null     --Anzahl Angebote-SMS aus der Ablauf-SMS 
              , offer_sms_quantity                               int           null     --Anzahl Angebote-SMS Gesamt
              , confirmation_sms_for_package_ordered_quantity    int           null     --Anzahl Bestätigungs-SMS für gebuchte Pakete
              , confirmation_sms_for_roaming_activation_quantity int           null     --Anzahl Bestätigungs-SMS für Änderung der 
              , multicard_quantity                               int           null     --Wenn der Kunde mehrere Sim Karten hat
              , country_desc                                     nvarchar(255) null
              , world_zone_desc                                  nvarchar(255) null
            );

            create clustered columnstore index ccidx_tmp_entry
            on #tmp_entry;

            -- ###################################################################################################################################################### --
            ;

            with relevant_communication_event as (
                select
                    customer_id = try_convert(bigint, ce.customer_id)
                  , contract_id = try_convert(bigint, ce.contract_id)
                  , ce.communication_contact_date
                  , tct.communication_template_id
                  , ce.world_zone
                  , ce.ods_load_date
                from ods_operationprocess_chs.communication_event ce
                join #tmp_communication_template                  tct
                    on tct.communication_template_desc = ce.communication_template_id
                   and ce.communication_contact_date   >= @offset_datetime
            )
               , rlu as (
                select
                    a.roaming_location_data_id
                  , a.external_subscriber_id
                  , a.incoming_datetime
                  , outcoming_datetime = coalesce(dateadd(millisecond, -10, lead(a.incoming_datetime) over (partition by a.external_subscriber_id
                                                                                                            order by a.incoming_datetime
                                                                                                      )
                                                  ), '9999-12-31'
                                         )
                  , a.mobile_access_provider_id
                  , a.multicard_quantity
                  , a.rlu_rn
                  , a.rn_by_wz
                  , a.is_entry_ind
                  , a.country
                  , a.network
                  , a.cl_load_date
                  , a.world_zone
                from (
                    select
                        roaming_location_data_id  = lrlu.id
                      , external_subscriber_id    = lrlu.subscriber_id
                      , incoming_datetime         = lrlu.rlu_date
                      , mobile_access_provider_id = coalesce(p.mobile_access_provider_id, -1)
                      , multicard_quantity        = count(lrlu.imsi) over (partition by
                                                                               lrlu.subscriber_id
                                                                             , lrlu.rlu_date
                                                                             , lrlu.country
                                                                     )
                      , rlu_rn                    = row_number() over (partition by
                                                                           lrlu.subscriber_id
                                                                         , lrlu.rlu_date
                                                                       --, rlu.country
                                                                       order by lrlu.rlu_date
                                                                              , lrlu.id desc
                                                                 )
                      , rn_by_wz                  = row_number() over (partition by
                                                                           lrlu.subscriber_id
                                                                         , cast(lrlu.rlu_date as date)
                                                                         , coalesce(wz.zone, 'n/a')
                                                                       order by lrlu.rlu_date
                                                                 )
                      , is_entry_ind              = case
                                                        when lrlu.network <> '26207'
                                                            then 1
                                                        else 0
                                                    end
                      , lrlu.country
                      , lrlu.network
                      , lrlu.cl_load_date
                      , world_zone                = coalesce(wz.zone, 'n/a')
                    from cl_dom_mobile_access.log_roaming_location_update    lrlu
                    left join ods_mobileservices_mobileeventhub.mcc_mnc_zone mnz
                        on (
                            mnz.mcc                = try_convert(int, left(lrlu.network, 3))
                        and mnz.mnc                = try_convert(int, right(lrlu.network, 2))
                        )
                    left join ods_mobileservices_mobileeventhub.mcc_mnc_zone mnz_2
                        on (
                            mnz_2.mcc              = try_convert(int, left(lrlu.network, 3))
                        and mnz_2.mnc is null
                        )
                    left join ods_mobileservices_mobileeventhub.world_zone   wz
                        on wz.id                   = coalesce(mnz.world_zone_id, mnz_2.world_zone_id)
                    left join dm_dom_mobile_access.provider                  p
                        on p.network_provider_desc = lrlu.provider
                    where lrlu.subscriber_id is not null
                      and lrlu.rlu_date >= @offset_datetime
                ) a
                where a.rlu_rn = 1
            )
            insert into #relevant_dataset (
                external_subscriber_id
            )
            select rlu.external_subscriber_id
            from rlu
            left join cl_dom_mobile_access.his_rel_roaming_subscriber_contract hrrsc
                on hrrsc.external_subscriber_id         = rlu.external_subscriber_id
               and rlu.incoming_datetime between hrrsc.valid_from and hrrsc.valid_to
            left join relevant_communication_event                             ce
                on ce.customer_id                       = hrrsc.customer_id
               and (
                   (
                       ce.communication_contact_date between rlu.incoming_datetime and rlu.outcoming_datetime
                   and ce.world_zone                    = rlu.world_zone
                   )
                or (
                    ce.world_zone                       = rlu.world_zone
                and cast(rlu.incoming_datetime as date) = cast(ce.communication_contact_date as date)
                and ce.communication_contact_date       >= rlu.incoming_datetime
                and rlu.rn_by_wz                        = 1
                )
               )
            where (
                rlu.cl_load_date >= @var_max_load_datetime
             or hrrsc.cl_load_date >= @var_max_load_datetime
             or ce.ods_load_date >= @var_max_load_datetime
            );

            set @log_message = N'--> Affected rows: ' + convert(varchar, coalesce(@@rowcount, 0));

            exec etl.log_event @proc, @arg_job, @log_message;

            set @log_message = N'insert into #tmp_entry...';

            exec etl.log_event @proc, @arg_job, @log_message;

            with relevant_communication_event as (
                select
                    customer_id = try_convert(bigint, ce.customer_id)
                  , contract_id = try_convert(bigint, ce.contract_id)
                  , ce.communication_contact_date
                  , tct.communication_template_id
                  , ce.world_zone
                  , ce.ods_load_date
                from ods_operationprocess_chs.communication_event ce
                join #tmp_communication_template                  tct
                    on tct.communication_template_desc = ce.communication_template_id
                   and ce.communication_contact_date   >= @offset_datetime
            )
               , rlu as (
                select
                    a.roaming_location_data_id
                  , a.external_subscriber_id
                  , a.incoming_datetime
                  , outcoming_datetime = coalesce(dateadd(millisecond, -10, lead(a.incoming_datetime) over (partition by a.external_subscriber_id
                                                                                                            order by a.incoming_datetime
                                                                                                      )
                                                  ), '9999-12-31'
                                         )
                  , a.mobile_access_provider_id
                  , a.multicard_quantity
                  , a.rlu_rn
                  , a.rn_by_wz
                  , a.is_entry_ind
                  , a.country
                  , a.network
                  , a.cl_load_date
                  , a.world_zone
                from (
                    select
                        roaming_location_data_id  = lrlu.id
                      , external_subscriber_id    = lrlu.subscriber_id
                      , incoming_datetime         = lrlu.rlu_date
                      , mobile_access_provider_id = coalesce(p.mobile_access_provider_id, -1)
                      , multicard_quantity        = count(lrlu.imsi) over (partition by
                                                                               lrlu.subscriber_id
                                                                             , lrlu.rlu_date
                                                                             , lrlu.country
                                                                     )
                      , rlu_rn                    = row_number() over (partition by
                                                                           lrlu.subscriber_id
                                                                         , lrlu.rlu_date
                                                                       --, rlu.country
                                                                       order by lrlu.rlu_date
                                                                              , lrlu.id desc
                                                                 )
                      , rn_by_wz                  = row_number() over (partition by
                                                                           lrlu.subscriber_id
                                                                         , cast(lrlu.rlu_date as date)
                                                                         , coalesce(wz.zone, 'n/a')
                                                                       order by lrlu.rlu_date
                                                                 )
                      , is_entry_ind              = case
                                                        when lrlu.network <> '26207'
                                                            then 1
                                                        else 0
                                                    end
                      , lrlu.country
                      , lrlu.network
                      , lrlu.cl_load_date
                      , world_zone                = coalesce(wz.zone, 'n/a')
                    from cl_dom_mobile_access.log_roaming_location_update    lrlu
                    left join ods_mobileservices_mobileeventhub.mcc_mnc_zone mnz
                        on (
                            mnz.mcc                = try_convert(int, left(lrlu.network, 3))
                        and mnz.mnc                = try_convert(int, right(lrlu.network, 2))
                        )
                    left join ods_mobileservices_mobileeventhub.mcc_mnc_zone mnz_2
                        on (
                            mnz_2.mcc              = try_convert(int, left(lrlu.network, 3))
                        and mnz_2.mnc is null
                        )
                    left join ods_mobileservices_mobileeventhub.world_zone   wz
                        on wz.id                   = coalesce(mnz.world_zone_id, mnz_2.world_zone_id)
                    left join dm_dom_mobile_access.provider                  p
                        on p.network_provider_desc = lrlu.provider
                    where lrlu.subscriber_id is not null
                      and lrlu.rlu_date >= @offset_datetime
                      and exists (
                        select 1
                        from #relevant_dataset rd
                        where rd.external_subscriber_id = lrlu.subscriber_id
                    )
                ) a
                where a.rlu_rn = 1
            )
            insert into #tmp_entry (
                roaming_location_data_id
              , external_subscriber_id
              , incoming_datetime
              , outcoming_datetime
              , mobile_access_provider_id
              , entry_quantity
              , welcome_sms_quantity
              , expired_sms_quantity
              , offer_sms_quantity
              , confirmation_sms_for_package_ordered_quantity
              , confirmation_sms_for_roaming_activation_quantity
              , multicard_quantity
              , country_desc
              , world_zone_desc
            )
            select
                b.roaming_location_data_id
              , b.external_subscriber_id
              , b.incoming_datetime
              , b.outcoming_datetime
              , b.mobile_access_provider_id
              , b.entry_quantity
              , b.welcome_sms_quantity
              , b.expired_sms_quantity
              , b.offer_sms_quantity
              , b.confirmation_sms_for_package_ordered_quantity
              , b.confirmation_sms_for_roaming_activation_quantity
              , b.multicard_quantity
              , b.country_desc
              , b.world_zone_desc
            from (
                select
                    a.roaming_location_data_id
                  , a.external_subscriber_id
                  , a.incoming_datetime
                  , a.outcoming_datetime
                  , a.mobile_access_provider_id
                  , a.entry_quantity
                  , welcome_sms_quantity                             = sum(case
                                                                               when rn_contacts = 1
                                                                                and a.welcome_sms_quantity > 0
                                                                                   then a.welcome_sms_quantity
                                                                               else 0
                                                                           end
                                                                       )
                  , expired_sms_quantity                             = sum(case
                                                                               when rn_contacts = 1
                                                                                and a.expired_sms_quantity > 0
                                                                                   then a.expired_sms_quantity
                                                                               else 0
                                                                           end
                                                                       )
                  , offer_sms_quantity                               = sum(case
                                                                               when rn_contacts = 1
                                                                                and a.offer_sms_quantity > 0
                                                                                   then a.offer_sms_quantity
                                                                               else 0
                                                                           end
                                                                       )
                  , confirmation_sms_for_package_ordered_quantity    = sum(case
                                                                               when rn_contacts = 1
                                                                                and a.confirmation_sms_for_package_ordered_quantity > 0
                                                                                   then a.confirmation_sms_for_package_ordered_quantity
                                                                               else 0
                                                                           end
                                                                       )
                  , confirmation_sms_for_roaming_activation_quantity = sum(case
                                                                               when rn_contacts = 1
                                                                                and a.confirmation_sms_for_roaming_activation_quantity > 0
                                                                                   then a.confirmation_sms_for_roaming_activation_quantity
                                                                               else 0
                                                                           end
                                                                       )
                  , a.multicard_quantity
                  , a.country_desc
                  , a.world_zone_desc
                from (
                    select
                        rlu.roaming_location_data_id
                      , rlu.external_subscriber_id
                      , ce.communication_contact_date
                      , rlu.incoming_datetime
                      , rlu.outcoming_datetime
                      , rlu.mobile_access_provider_id
                      , entry_quantity                                   = 1
                      , welcome_sms_quantity                             = sum(case
                                                                                   when ce.communication_template_id = 1 --'fast track access mobile roaming entry sms ac'
                                                                                       then 1
                                                                                   else 0
                                                                               end
                                                                           )
                      , expired_sms_quantity                             = sum(case
                                                                                   when ce.communication_template_id = 2 --'access mobile roaming add data volume ac'
                                                                                       then 1
                                                                                   else 0
                                                                               end
                                                                           )
                      , offer_sms_quantity                               = sum(case
                                                                                   when ce.communication_template_id = 4 -- 'access mobile roaming data volume offer ac'
                                                                                       then 1
                                                                                   else 0
                                                                               end
                                                                           )
                      , confirmation_sms_for_package_ordered_quantity    = sum(case
                                                                                   when ce.communication_template_id = 5 --'access mobile roaming data volume order confirmation ac' and ........
                                                                                       then 1
                                                                                   else 0
                                                                               end
                                                                           )
                      , confirmation_sms_for_roaming_activation_quantity = sum(case
                                                                                   when ce.communication_template_id = 3 --'access mobile roaming pay as you go ac'
                                                                                       then 1
                                                                                   else 0
                                                                               end
                                                                           )
                      , rlu.multicard_quantity
                      , country_desc                                     = rlu.country
                      , world_zone_desc                                  = rlu.world_zone
                      , rlu.is_entry_ind
                      , rn_contacts                                      = row_number() over (partition by
                                                                                                  ce.customer_id
                                                                                                , ce.communication_contact_date
                                                                                              order by ce.communication_contact_date
                                                                                        )
                    from rlu                                                           rlu
                    left join cl_dom_mobile_access.his_rel_roaming_subscriber_contract hrrsc
                        on hrrsc.external_subscriber_id         = rlu.external_subscriber_id
                       and rlu.incoming_datetime between hrrsc.valid_from and hrrsc.valid_to
                    left join relevant_communication_event                             ce
                        on ce.customer_id                       = hrrsc.customer_id
                       and (
                           (
                               ce.communication_contact_date between rlu.incoming_datetime and rlu.outcoming_datetime
                           and ce.world_zone                    = rlu.world_zone
                           )
                        or (
                            ce.world_zone                       = rlu.world_zone
                        and cast(rlu.incoming_datetime as date) = cast(ce.communication_contact_date as date)
                        and ce.communication_contact_date       >= rlu.incoming_datetime
                        and rlu.rn_by_wz                        = 1
                        )
                       )
                    group by rlu.roaming_location_data_id
                           , rlu.is_entry_ind
                           , rlu.outcoming_datetime
                           , ce.communication_contact_date
                           , rlu.mobile_access_provider_id
                           , rlu.incoming_datetime
                           , rlu.external_subscriber_id
                           , rlu.multicard_quantity
                           , rlu.country
                           , rlu.is_entry_ind
                           , rlu.world_zone
                           , ce.customer_id
                ) a
                where a.is_entry_ind = 1
                group by a.roaming_location_data_id
                       , a.external_subscriber_id
                       , a.incoming_datetime
                       , a.outcoming_datetime
                       , a.mobile_access_provider_id
                       , a.entry_quantity
                       , a.multicard_quantity
                       , a.country_desc
                       , a.world_zone_desc
            ) b;

            set @log_message = N'--> Affected rows: ' + convert(varchar, coalesce(@@rowcount, 0));

            exec etl.log_event @proc, @arg_job, @log_message;

            -- ###################################################################################################################################################### --
            begin transaction;

            set @log_message = N'Delete changed datasets...';

            exec etl.log_event @proc, @arg_job, @log_message;

            delete rld
            from cl_dom_mobile_access.entry_communication_event rld
            join #relevant_dataset                              rd
                on rd.external_subscriber_id = rld.external_subscriber_id;

            set @log_message = N'--> Deleted rows: ' + convert(varchar, coalesce(@@rowcount, 0));

            exec etl.log_event @proc, @arg_job, @log_message;

            set @log_message = N'Insert new entries in target table';

            exec etl.log_event @proc, @arg_job, @log_message;

            insert into cl_dom_mobile_access.entry_communication_event (
                entry_communication_event_id
              , external_subscriber_id
              , incoming_datetime
              , outcoming_datetime
              , mobile_access_provider_id
              , entry_quantity
              , welcome_sms_quantity
              , expired_sms_quantity
              , offer_sms_quantity
              , confirmation_sms_for_package_ordered_quantity
              , confirmation_sms_for_roaming_activation_quantity
              , multicard_quantity
              , country_desc
              , world_zone_desc
              , cl_load_job_id
              , cl_load_date
            )
            select
                roaming_location_data_id
              , external_subscriber_id
              , incoming_datetime
              , outcoming_datetime
              , mobile_access_provider_id
              , entry_quantity
              , welcome_sms_quantity
              , expired_sms_quantity
              , offer_sms_quantity
              , confirmation_sms_for_package_ordered_quantity
              , confirmation_sms_for_roaming_activation_quantity
              , multicard_quantity
              , country_desc
              , world_zone_desc
              , @arg_job
              , @arg_load_date
            from #tmp_entry;

            set @log_message = N'--> Affected rows: ' + convert(varchar, coalesce(@@rowcount, 0));

            exec etl.log_event @proc, @arg_job, @log_message;

            commit transaction;

            -- ###################################################################################################################################################### --
            drop table if exists #tmp_entry;
        end;

        set @log_message = N'Finished Job ' + @arg_job;

        exec etl.log_event @proc, @arg_job, @log_message;

        return @resultcode;
    end try
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
end;
go