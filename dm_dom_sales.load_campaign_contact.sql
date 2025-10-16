SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

create   procedure [dm_dom_sales].[load_campaign_contact] @arg_job nvarchar(255)
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
          , '$URL: https://svn.1and1.org/svn/ebi_mssql_access/access/trunk/access/Layers/dm-layer/dm_dom_sales/Programmability/load_campaign_contact.sql $'
          , '$Revision: 16607 $'
          , '$Author: butiryaki $'
          , '$Date: 2020-10-26 16:35:43 +0100 (Mo, 26 Okt 2020) $';

        set @log_message = N'Started Job ' + @arg_job;

        exec etl.log_event @proc, @arg_job, @log_message;

        set @log_message = N'insert new Data with customer_contact into dm_dom_sales.campaign_contact';

        exec etl.log_event @proc, @arg_job, @log_message;

        insert into dm_dom_sales.campaign_contact with (tablock) (
            campaign_id
          , communication_id
          , cell_package_id
          , contact_type_id
          , contract_id
          , customer_id
          , contact_datetime
          , response_tracking_cd
          , dm_load_date
          , dm_load_job_id
        )
        select
            convert(int, c.campaign_id)
          , convert(int, comm.communication_id)
          , convert(int, cp.cell_package_id)
          , 1             as contact_type_id --1 for customer
          , -1            as contract_id
          , convert(int, occu.customer_id)
          , occu.contact_datetime
          , occu.response_tracking_cd
          , @arg_load_date
          , @arg_job
        from dm_dom_campaign.campaign                          c
        join dm_dom_campaign.communication                     comm
            on comm.campaign_id               = c.campaign_id
           and c.business_context_desc        = 'CSAccess'
           and c.is_current_version_ind       = '1' --aktuelleste Version der Kampagne
           and comm.communication_desc not like '%blacklist%'
        join dm_dom_campaign.cell_package                      cp
            on cp.communication_id            = comm.communication_id
        join dm_dom_customer_contact.outgoing_contact_customer occu
            on occu.cell_package_id           = cp.cell_package_id
           and occu.contact_history_status_cd = '_11' --nur ausgefuehrte
        left join dm_dom_sales.campaign_contact                cc
            on cc.campaign_id                 = c.campaign_id
           and cc.communication_id            = comm.communication_id
           and cc.cell_package_id             = cp.cell_package_id
           and cc.customer_id                 = occu.customer_id
           and cc.contact_datetime            = occu.contact_datetime
           and cc.response_tracking_cd        = occu.response_tracking_cd
           and cc.contact_type_id             = 1
        where cc.campaign_contact_id is null;

        set @log_message = N'New Data inserted: ' + convert(varchar(50), @@rowcount);

        exec etl.log_event @proc, @arg_job, @log_message;

        set @log_message = N'insert new Data with contract_contact into dm_dom_sales.campaign_contact';

        exec etl.log_event @proc, @arg_job, @log_message;

        insert into dm_dom_sales.campaign_contact with (tablock) (
            campaign_id
          , communication_id
          , cell_package_id
          , contact_type_id
          , customer_id
          , contract_id
          , contact_datetime
          , response_tracking_cd
          , dm_load_date
          , dm_load_job_id
        )
        select
            convert(int, c.campaign_id)
          , convert(int, comm.communication_id)
          , convert(int, cp.cell_package_id)
          , 2             as contact_type_id --2 for contract
          , convert(int, con.customer_id)
          , convert(int, occo.contract_id)
          , occo.contact_datetime
          , occo.response_tracking_cd
          , @arg_load_date
          , @arg_job
        from dm_dom_campaign.campaign                          c
        join dm_dom_campaign.communication                     comm
            on comm.campaign_id               = c.campaign_id
           and c.business_context_desc        = 'CSAccess'
           and c.is_current_version_ind       = '1' --aktuelleste Version der Kampagne
           and comm.communication_desc not like '%blacklist%'
        join dm_dom_campaign.cell_package                      cp
            on cp.communication_id            = comm.communication_id
        join dm_dom_customer_contact.outgoing_contact_contract occo
            on occo.cell_package_id           = cp.cell_package_id
           and occo.contact_history_status_cd <> '_11'
        join dm_dom_contract.contract                          con
            on occo.contract_id               = con.contract_id
        left join dm_dom_sales.campaign_contact                cc
            on cc.campaign_id                 = c.campaign_id
           and cc.communication_id            = comm.communication_id
           and cc.cell_package_id             = cp.cell_package_id
           and cc.customer_id                 = con.customer_id
           and cc.contract_id                 = occo.contract_id
           and cc.contact_datetime            = occo.contact_datetime
           and cc.response_tracking_cd        = occo.response_tracking_cd
           and cc.contact_type_id             = 2
        where cc.campaign_contact_id is null;

        set @log_message = N'New Data inserted: ' + convert(varchar(50), @@rowcount);

        exec etl.log_event @proc, @arg_job, @log_message;

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
GO