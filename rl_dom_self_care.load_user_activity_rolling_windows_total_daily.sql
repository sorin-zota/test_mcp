set quoted_identifier on;
go

set ansi_nulls on;
go

--rl_dom_self_care.load_user_activity_rolling_windows_total_daily 'test'
create procedure [rl_dom_self_care].[load_user_activity_rolling_windows_total_daily] @arg_job nvarchar(255)
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
          , '$URL: https://svn.1and1.org/svn/ebi_mssql_access/access/trunk/access/Layers/rl-layer/rl_scm_tagesreport/Programmability/Stored%20Procedures/load_user_activity_rolling_windows_total_daily.sql $'
          , '$Revision: $'
          , '$Author: genuta $'
          , '$Date: 2023-03-14 $';

        set @log_message = N'Started Job ' + @arg_job;

        exec etl.log_event @proc, @arg_job, @log_message;

        begin
            set datefirst 1;

            drop table if exists #delta_detection;

            create table #delta_detection (
                [function_call_date] [date] null
            );

            create clustered columnstore index ccidx_delta_detection on #delta_detection;

            drop table if exists #rolling_window_numbers_total;

            create table #rolling_window_numbers_total (
                function_call_date                          date
              , start_of_week_date                          date
              , end_of_week_date                            date
              , start_of_month_date                         date
              , end_of_month_date                           date
              , user_count_week_daily_amount                int
              , first_timer_count_daily_amount              int not null default 0
              , user_count_week_daily_rolling_window_amount int
              , user_count_monthly_amount                   int
            );

            create clustered columnstore index ccix_temp_rolling_window_numbers_total on #rolling_window_numbers_total;

            set @log_message = formatmessage(N'Done...') + @arg_job;

            exec etl.log_event @proc, @arg_job, @log_message;

            declare @var_max_load_date datetime = (
                        select coalesce(max(rl_load_date), '1900-01-01')
                        from access.rl_dom_self_care.user_activity_daily_hist
                    );

            set @log_message = formatmessage('Max load_date in RL is %s ...', convert(varchar(23), @var_max_load_date, 121));

            exec etl.log_event @proc, @arg_job, @log_message;

            set @log_message = N'Insert function_call_date-s in delta_detection table';

            exec etl.log_event @proc, @arg_job, @log_message;

            insert into #delta_detection (
                function_call_date
            )
            select distinct
                   uadh.function_call_date as function_call_date
            from access.rl_dom_self_care.user_activity_daily_hist uadh
            where uadh.rl_load_date >= @var_max_load_date;

            set @log_message = N'---> ' + cast(@@rowcount as varchar(20)) + N' Inserted rows';

            exec etl.log_event @proc, @arg_job, @log_message;

            set @log_message = formatmessage(N'Insert Dates and control_center_desc to get fitting granularity...') + @arg_job;

            exec etl.log_event @proc, @arg_job, @log_message;

            insert into #rolling_window_numbers_total (
                function_call_date
              , start_of_week_date
              , end_of_week_date
              , start_of_month_date
              , end_of_month_date
            )
            select
                uad.function_call_date
              , dateadd(day, 1 - d.weekday_id_de, uad.function_call_date)                     as start_of_week_date
              , dateadd(day, 7 - d.weekday_id_de, uad.function_call_date)                     as end_of_week_date
              , datefromparts(year(uad.function_call_date), month(uad.function_call_date), 1) as start_of_month_date
              , eomonth(uad.function_call_date)                                               as end_ofm_nonth_date
            from (
                select uadh.function_call_date
                from rl_dom_self_care.user_activity_daily_hist uadh
                join #delta_detection                          delta
                    on uadh.function_call_date = delta.function_call_date
                group by uadh.function_call_date
            )                         as uad
            join dm_dom_calendar.date d
                on d.date = uad.function_call_date
            group by dateadd(day, 1 - d.weekday_id_de, uad.function_call_date)
                   , dateadd(day, 7 - d.weekday_id_de, uad.function_call_date)
                   , datefromparts(year(uad.function_call_date), month(uad.function_call_date), 1)
                   , eomonth(uad.function_call_date)
                   , uad.function_call_date;

            set @log_message = formatmessage(N'Inserted %i rows...', @@rowcount) + @arg_job;

            exec etl.log_event @proc, @arg_job, @log_message;

            set @log_message = formatmessage(N'Update count for daily active users per day...') + @arg_job;

            exec etl.log_event @proc, @arg_job, @log_message;

            update rwd
            set rwd.user_count_week_daily_amount = number_agg.user_count_week_daily_amount
            --, rwd.first_timer_count_daily_amount = number_agg.first_timer_count_daily_amount
            from #rolling_window_numbers_total rwd
            left join (
                select
                    customer_grouping.function_call_date
                  , count(*) as user_count_week_daily_amount
                from (
                    select
                        rwd_inner.function_call_date
                      , uad.customer_id
                    --, (uad.is_first_timer_ind)     as first_timer_count_daily_amount
                    from #rolling_window_numbers_total             rwd_inner
                    join rl_dom_self_care.user_activity_daily_hist uad
                        on uad.function_call_date = rwd_inner.function_call_date
                    group by rwd_inner.function_call_date
                           , uad.customer_id
                ) as customer_grouping
                group by customer_grouping.function_call_date
            )                                  as number_agg
                on number_agg.function_call_date = rwd.function_call_date;

            set @log_message = formatmessage(N'Updated %i rows...', @@rowcount) + @arg_job;

            exec etl.log_event @proc, @arg_job, @log_message;

            set @log_message = formatmessage(N'Update count for first timers per day...') + @arg_job;

            exec etl.log_event @proc, @arg_job, @log_message;

            update rwd
            set rwd.first_timer_count_daily_amount = isnull(number_agg.first_timer_count_daily_amount, 0)
            from #rolling_window_numbers_total rwd
            left join (
                select
                    customer_grouping.function_call_date
                  , count(*) as first_timer_count_daily_amount
                from (
                    select
                        rwd_inner.function_call_date
                      , uad.customer_id
                    --, (uad.is_first_timer_ind)     as first_timer_count_daily_amount
                    from #rolling_window_numbers_total             rwd_inner
                    join rl_dom_self_care.user_activity_daily_hist uad
                        on uad.function_call_date = rwd_inner.function_call_date
                       and uad.is_first_timer_ind = 1
                    group by rwd_inner.function_call_date
                           , uad.customer_id
                ) as customer_grouping
                group by customer_grouping.function_call_date
            )                                  as number_agg
                on number_agg.function_call_date = rwd.function_call_date;

            set @log_message = formatmessage(N'Updated %i rows...', @@rowcount) + @arg_job;

            exec etl.log_event @proc, @arg_job, @log_message;

            set @log_message = formatmessage(N'Update daily active user count as sliding window per week...') + @arg_job;

            exec etl.log_event @proc, @arg_job, @log_message;

            update rwd
            set rwd.user_count_week_daily_rolling_window_amount = number_agg.user_count_week_daily_rolling_window_amount
            from #rolling_window_numbers_total rwd
            left join (
                select
                    customer_grouping.function_call_date
                  , count(*) as user_count_week_daily_rolling_window_amount
                from (
                    select
                        rwd_inner.function_call_date
                      , uad.customer_id
                    from #rolling_window_numbers_total             rwd_inner
                    join rl_dom_self_care.user_activity_daily_hist uad
                        on rwd_inner.function_call_date >= uad.function_call_date
                       and uad.function_call_date between rwd_inner.start_of_week_date and rwd_inner.end_of_week_date
                    group by rwd_inner.function_call_date
                           , uad.customer_id
                ) as customer_grouping
                group by customer_grouping.function_call_date
            )                                  as number_agg
                on number_agg.function_call_date = rwd.function_call_date;

            set @log_message = formatmessage(N'Updated %i rows...', @@rowcount) + @arg_job;

            exec etl.log_event @proc, @arg_job, @log_message;

            set @log_message = formatmessage(N'Update daily active user count as sliding window per month...') + @arg_job;

            exec etl.log_event @proc, @arg_job, @log_message;

            update rwd
            set rwd.user_count_monthly_amount = number_agg.user_count_monthly_amount
            from #rolling_window_numbers_total rwd
            left join (
                select
                    customer_grouping.function_call_date
                  , count(*) as user_count_monthly_amount
                from (
                    select
                        rwd.function_call_date
                      , customer_id
                    from #rolling_window_numbers_total             as rwd
                    join rl_dom_self_care.user_activity_daily_hist uad
                        on uad.function_call_date <= rwd.function_call_date
                       and uad.function_call_date between rwd.start_of_month_date and rwd.end_of_month_date
                    group by rwd.function_call_date
                           , uad.customer_id
                ) as customer_grouping
                group by customer_grouping.function_call_date
            )                                  as number_agg
                on number_agg.function_call_date = rwd.function_call_date;

            set @log_message = formatmessage(N'Updated %i rows...', @@rowcount) + @arg_job;

            exec etl.log_event @proc, @arg_job, @log_message;

            set @log_message = N'Delete hist for new id from target table ';

            exec etl.log_event @proc, @arg_job, @log_message;

            delete uarwt
            from rl_dom_self_care.user_activity_rolling_windows_total_daily uarwt
            join #rolling_window_numbers_total                              rwt
                on rwt.[function_call_date] = uarwt.function_call_date;

            set @log_message = N'---> ' + cast(@@rowcount as varchar(20)) + N' deleted rows';

            exec etl.log_event @proc, @arg_job, @log_message;

            set @log_message = formatmessage(N'Insert from stage table #rolling_window_numbers_total into rl_dom_self_care.user_activity_rolling_windows_total_daily...') + @arg_job;

            exec etl.log_event @proc, @arg_job, @log_message;

            insert into rl_dom_self_care.user_activity_rolling_windows_total_daily (
                rl_load_date
              , rl_load_job_id
              , function_call_date
              , user_count_week_daily_amount
              , first_timer_count_daily_amount
              , user_count_week_daily_rolling_window_amount
              , user_count_monthly_amount
            )
            select
                @arg_load_date
              , @arg_job
              , rwd.function_call_date
              , rwd.user_count_week_daily_amount
              , first_timer_count_daily_amount
              , rwd.user_count_week_daily_rolling_window_amount
              , rwd.user_count_monthly_amount
            from #rolling_window_numbers_total as rwd;

            set @log_message = formatmessage(N'Inserted %i rows...', @@rowcount) + @arg_job;

            exec etl.log_event @proc, @arg_job, @log_message;
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

exec sp_addextendedproperty
    N'MS_Description'
  , N'Load procedure for the table rl_dom_self_care.user_activity_rolling_windows_total_daily'
  , 'SCHEMA'
  , N'rl_dom_self_care'
  , 'PROCEDURE'
  , N'load_user_activity_rolling_windows_total_daily'
  , null
  , null;
go

exec sp_addextendedproperty
    N'MS_Description'
  , N'Job ID, is set by automic'
  , 'SCHEMA'
  , N'rl_dom_self_care'
  , 'PROCEDURE'
  , N'load_user_activity_rolling_windows_total_daily'
  , 'PARAMETER'
  , N'@arg_job';
go