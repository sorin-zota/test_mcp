set quoted_identifier on;
go

set ansi_nulls on;
go

create or alter procedure rl_dom_home_access.load_ftth_availability_dtag_pilot @arg_job nvarchar(255)
with execute as owner
as
begin
    set nocount on;

    declare
        @log_message    nvarchar(max)
      , @proc           nvarchar(255)
      , @resultcode     int
      , @default_string nvarchar(3) = N'n/a'
      , @default_int    integer     = -1
      , @default_date   date        = '1900-01-01'
      , @default_ind    tinyint     = 0;

    if @arg_job is null
        set @arg_job = user_name() + '#' + cast(newid() as nvarchar(255));

    set @resultcode = 0;
    set @proc = etl.get_proc_name(@@procid);

    begin try
        exec etl.log_revision
            @proc
          , @arg_job
          , '$URL: https://bitbucket.united-internet.org/projects/ebi-mssql/repos/dwh-access/browse/Stored%20Procedures/rl_dom_home_access.load_ftth_availability_dtag_pilot.sql $'
          , '$Revision: 621a9e040751102de30791eb4f91c93713bd2bcb $'
          , '$Author: Daniel Harder $'
          , '$Date: 2025-03-17 16:27:52 $';

        set @log_message = N'Started Job ' + @arg_job;

        exec etl.log_event @proc, @arg_job, @log_message;

        begin
            declare @last_file nvarchar(255);
            declare @import_date date;

            set @log_message = N'Create #tmp table';

            exec etl.log_event @proc, @arg_job, @log_message;

            create table #ftth_availability_dtag_pilot (
                kls_id                            int           not null
              , strasse                           nvarchar(50)  null
              , hausnummer                        nvarchar(50)  null
              , hausnummernzusatz                 nvarchar(50)  null
              , plz                               int           null
              , ort                               nvarchar(50)  null
              , ortsteil                          nvarchar(50)  null
              , ortsnetz                          nvarchar(50)  null
              , onkz                              int           null
              , asb                               nvarchar(50)  null
              , ortsnetzgroesse                   nvarchar(50)  null
              , ortsnetzgroesse_berechnet         nvarchar(50)  null
              , ausbaustatus                      nvarchar(100) null
              , ausbaustatus_kurzform             nvarchar(50)  null
              , ausbauzeitraum_von                datetime2(7)  null
              , ausbauzeitraum_bis                datetime2(7)  null
              , lead_ausbauzeitraum_bis           datetime2(7)  null
              , bng_endsz                         nvarchar(50)  null
              , bng_vpsz                          nvarchar(50)  null
              , bng_vpsz_berechnet                nvarchar(50)  null
              , anzahl_hh_usto                    nvarchar(50)  null
              , reason_for_not_planned            nvarchar(50)  null
              , access_variante                   nvarchar(50)  null
              , aenderungsdatum                   datetime2(7)  null
              , gebaeudeteil_hinweis              nvarchar(1)   null
              , is_versatel_area_ind              tinyint       not null default 0
              , gebiet_id                         nvarchar(255) null
              , gebiet_name                       nvarchar(255) null
              , ausbauentscheidung                nvarchar(255) null
              , vermarktungsphase                 nvarchar(255) null
              , alter_standard                    nvarchar(255) null
              , [bulk]                            nvarchar(255) null
              , eigentuemerzustimmung             nvarchar(255) null
              , kooperationspartnername           nvarchar(255) null
              , eigentuemerdaten_notwendig        nvarchar(255) null
              , neubau                            nvarchar(255) null
              , protokoll                         nvarchar(255) null
              , rl_load_filename                  nvarchar(255) not null
              , rl_load_file_date                 nvarchar(100) not null
              , is_last_kls_id_entry_ind          tinyint       not null default 0
              , is_kls_id_in_realm_master_ind     tinyint       not null default 0
              , is_kls_tcdb_dtag_ftth_ind         tinyint       not null default 0
              , is_kls_id_dismantled_ind          tinyint       not null default 0
              , is_kls_id_in_last_file_ind        tinyint       not null default 0
              , is_first_file_of_month_ind        tinyint       not null default 0
              , planned_expansion_change_duration int           null
              , is_last_file_ind                  tinyint       not null default 0
              , is_ftth_1_7_migration_ind         tinyint       not null default 0
              , last_locked_file_date             date          null
              , contract_quantity                 int           null
              , ausbaustatus_sort_id              int           null
              , is_becu_ind                       tinyint       not null default 0
            );

            create table #distinct_kls_id (
                kls_id int not null
            );

            create table #distinct_filename (
                sl_load_filename           nvarchar(255) not null
              , sl_load_file_date          nvarchar(100) not null
              , is_first_file_of_month_ind tinyint       not null default 0
            );

            create table #base_set (
                kls_id                        int           not null
              , sl_load_filename              nvarchar(255) not null
              , sl_load_file_date             nvarchar(100) not null
              , expansion_status_sort_id      int           null
              , is_last_kls_id_entry_ind      tinyint       not null default 0
              , is_kls_id_dismantled_ind      tinyint       not null default 0
              , is_kls_id_in_last_file_ind    tinyint       not null default 0
              , is_kls_id_in_realm_master_ind tinyint       not null default 0
              , is_kls_tcdb_dtag_ftth_ind     tinyint       not null default 0
              , is_first_file_of_month_ind    tinyint       not null default 0
              , is_last_file_ind              tinyint       not null default 0
            );

            create table #base_set_clear (
                kls_id                        int           not null
              , sl_load_filename              nvarchar(255) not null
              , sl_load_file_date             nvarchar(100) not null
              , expansion_status_sort_id      int           null
              , is_last_kls_id_entry_ind      tinyint       not null default 0
              , is_kls_id_dismantled_ind      tinyint       not null default 0
              , is_kls_id_in_last_file_ind    tinyint       not null default 0
              , is_kls_id_in_realm_master_ind tinyint       not null default 0
              , is_kls_tcdb_dtag_ftth_ind     tinyint       not null default 0
              , is_first_file_of_month_ind    tinyint       not null default 0
              , is_last_file_ind              tinyint       not null default 0
            );

            create table #dismantle (
                l_kls_id        int           not null
              , l_load_filename nvarchar(255) not null
              , a_kls_id        int           not null
              , a_load_filename nvarchar(255) not null
            );

            begin
                begin
                    set @log_message = N'Set @last_file to ';

                    exec etl.log_event @proc, @arg_job, @log_message;

                    set @last_file = (
                        select max(o.sl_load_filename)
                        from ods_dslprocess_versatel.fb_mvd_tdg o
                    );
                    set @log_message = N'  ---> ' + convert(varchar(255), +@last_file);

                    exec etl.log_event @proc, @arg_job, @log_message;

                    set @import_date = (
                        select d.previous_year_date
                        from dm_dom_calendar.date d
                        where d.date = convert(date, current_timestamp)
                    );
                    set @log_message = N'  ---> ' + convert(varchar(255), +@last_file);

                    exec etl.log_event @proc, @arg_job, @log_message;
                end;

                set @log_message = N'Insert into #base_set';

                exec etl.log_event @proc, @arg_job, @log_message;

                insert into #distinct_kls_id with (tablock) (
                    kls_id
                )
                select distinct
                       kls_id
                from ods_dslprocess_versatel.fb_mvd_tdg o
                where o.sl_load_date > @import_date;

                set @log_message = N'  ---> Inserted ' + convert(varchar(11), @@rowcount) + N' row(s) into #distinct_kls_id';

                exec etl.log_event @proc, @arg_job, @log_message;

                insert into #distinct_filename (
                    sl_load_filename
                  , sl_load_file_date
                )
                select
                    sub.sl_load_filename
                  , substring(left(sub.sl_load_filename, patindex('%.csv%', sub.sl_load_filename) - 1), patindex('%20%', sub.sl_load_filename), 255) as sl_load_file_date
                from (
                    select distinct
                           o.sl_load_filename
                    from ods_dslprocess_versatel.fb_mvd_tdg o
                ) sub;

                set @log_message = N'  ---> Inserted ' + convert(varchar(11), @@rowcount) + N' row(s) into #distinct_filename';

                exec etl.log_event @proc, @arg_job, @log_message;

                update df
                set is_first_file_of_month_ind = 1
                from #distinct_filename as df
                join (
                    select min(fn.sl_load_file_date) as rl_load_file_date
                    from #distinct_filename as fn
                    group by year(fn.sl_load_file_date) * 100 + month(fn.sl_load_file_date)
                )                       f_file
                    on df.sl_load_file_date = f_file.rl_load_file_date;

                set @log_message = N'  ---> Updated ' + convert(varchar(11), @@rowcount) + N' row(s) into is_first_file_of_month_ind';

                exec etl.log_event @proc, @arg_job, @log_message;

                insert into #base_set with (tablock) (
                    kls_id
                  , sl_load_filename
                  , sl_load_file_date
                  , expansion_status_sort_id
                  , is_kls_id_in_realm_master_ind
                  , is_kls_tcdb_dtag_ftth_ind
                  , is_first_file_of_month_ind
                  , is_last_file_ind
                )
                select
                    base.kls_id
                  , base.sl_load_filename
                  , base.sl_load_file_date
                  , map.sort_id
                  , iif(ad.kls_id is not null, 1, 0)              as is_kls_id_in_realm_master_ind
                  , iif(ad.place_id is not null, 1, 0)            as is_kls_tcdb_dtag_ftth_ind
                  , base.is_first_file_of_month_ind
                  , iif(base.sl_load_filename = @last_file, 1, 0) as is_last_file_ind
                from (
                    select
                        k.kls_id
                      , f.sl_load_filename
                      , f.sl_load_file_date
                      , f.is_first_file_of_month_ind
                    from #distinct_kls_id        k
                   cross join #distinct_filename f
                )                                                           as base
                left join ods_dslprocess_versatel.fb_mvd_tdg                as fmt
                    on base.kls_id                                      = fmt.kls_id
                   and base.sl_load_filename                            = fmt.sl_load_filename
                join dm_dom_home_access.planned_broadband_expansion_mapping as map
                    on coalesce(fmt.ausbaustatus_kurzform, 'notinfile') = map.broadband_expansion_status_short_desc
                left join (
                    select
                        a.kls_id
                      , max(tcdb.place_id) as place_id
                    from rl_sec_dom_address.addressmaster                as a
                    left join ods_dslprocess_tcdb.availability_ngab_dump as tcdb
                        on a.place_id             = tcdb.place_id
                       and tcdb.carrier_code      = 'DTAG'
                       and tcdb.access_technology = 'FTTH'
                    where a.kls_id <> -1
                    group by a.kls_id
                )                                                           ad
                    on base.kls_id                                      = ad.kls_id;

                set @log_message = N'  ---> Inserted ' + convert(varchar(11), @@rowcount) + N' row(s) into #base_set';

                exec etl.log_event @proc, @arg_job, @log_message;

                set @log_message = N'Update is_last_kls_id_entry_ind';

                exec etl.log_event @proc, @arg_job, @log_message;

                update #base_set
                set is_last_kls_id_entry_ind = 1
                from #base_set as b
                join (
                    select
                        o.kls_id
                      , max(o.sl_load_filename) as last_sl_load_filename
                    from ods_dslprocess_versatel.fb_mvd_tdg o
                    group by o.kls_id
                )              as ile
                    on b.kls_id           = ile.kls_id
                   and b.sl_load_filename = ile.last_sl_load_filename;

                set @log_message = N'  ---> Updated ' + convert(varchar(11), @@rowcount) + N' row(s)';

                exec etl.log_event @proc, @arg_job, @log_message;

                set @log_message = N'Update is_kls_id_in_last_file_ind';

                exec etl.log_event @proc, @arg_job, @log_message;

                update #base_set
                set is_kls_id_in_last_file_ind = 1
                from #base_set as b
                where b.sl_load_filename         = @last_file
                  and b.is_last_kls_id_entry_ind = 1;

                set @log_message = N'  ---> Updated ' + convert(varchar(11), @@rowcount) + N' row(s)';

                exec etl.log_event @proc, @arg_job, @log_message;

                set @log_message = N'Update is_kls_id_dismantled_ind';

                exec etl.log_event @proc, @arg_job, @log_message;

                insert into #dismantle (
                    l_kls_id
                  , l_load_filename
                  , a_kls_id
                  , a_load_filename
                )
                select
                    l_bs.kls_id           as l_kls_id
                  , l_bs.sl_load_filename as l_load_filename
                  , a_bs.kls_id           as a_kls_id
                  , a_bs.sl_load_filename as a_load_filename
                from #base_set as l_bs
                join #base_set as a_bs
                    on l_bs.kls_id                     = a_bs.kls_id
                   and a_bs.is_kls_id_in_last_file_ind = 0
                   and l_bs.is_kls_id_in_last_file_ind = 1
                where a_bs.expansion_status_sort_id > l_bs.expansion_status_sort_id;

                set @log_message = N'  ---> Inserted ' + convert(varchar(11), @@rowcount) + N' row(s)';

                exec etl.log_event @proc, @arg_job, @log_message;

                create clustered columnstore index ccidx_dismantle on #dismantle;

                update bs
                set bs.is_kls_id_dismantled_ind = 1
                from #base_set       as bs
                left join #dismantle as l_dis
                    on bs.kls_id           = l_dis.l_kls_id
                   and bs.sl_load_filename = l_dis.l_load_filename
                left join #dismantle as a_dis
                    on bs.kls_id           = a_dis.a_kls_id
                   and bs.sl_load_filename = a_dis.a_load_filename
                where l_dis.l_kls_id is not null
                   or a_dis.a_kls_id is not null;

                set @log_message = N'  ---> Updated ' + convert(varchar(11), @@rowcount) + N' row(s)';

                exec etl.log_event @proc, @arg_job, @log_message;

                set @log_message = N'INSERT INTO: #base_set_clear';

                exec etl.log_event @proc, @arg_job, @log_message;

                insert into #base_set_clear (
                    kls_id
                  , sl_load_filename
                  , sl_load_file_date
                  , expansion_status_sort_id
                  , is_last_kls_id_entry_ind
                  , is_kls_id_dismantled_ind
                  , is_kls_id_in_last_file_ind
                  , is_kls_id_in_realm_master_ind
                  , is_kls_tcdb_dtag_ftth_ind
                  , is_first_file_of_month_ind
                  , is_last_file_ind
                )
                select
                    bs.kls_id
                  , bs.sl_load_filename
                  , bs.sl_load_file_date
                  , bs.expansion_status_sort_id
                  , bs.is_last_kls_id_entry_ind
                  , bs.is_kls_id_dismantled_ind
                  , bs.is_kls_id_in_last_file_ind
                  , bs.is_kls_id_in_realm_master_ind
                  , bs.is_kls_tcdb_dtag_ftth_ind
                  , bs.is_first_file_of_month_ind
                  , bs.is_last_file_ind
                from #base_set                                            bs
                left join rl_dom_home_access.ftth_availability_dtag_pilot dp
                    on bs.kls_id                        = dp.kls_id
                   and bs.sl_load_filename              = dp.rl_load_filename
                   and bs.is_last_kls_id_entry_ind      = dp.is_last_kls_id_entry_ind
                   and bs.is_kls_id_dismantled_ind      = dp.is_kls_id_dismantled_ind
                   and bs.is_kls_id_in_last_file_ind    = dp.is_kls_id_in_last_file_ind
                   and bs.is_kls_id_in_realm_master_ind = dp.is_kls_id_in_realm_master_ind
                   and bs.is_kls_tcdb_dtag_ftth_ind     = dp.is_kls_tcdb_dtag_ftth_ind
                   and bs.is_first_file_of_month_ind    = dp.is_first_file_of_month_ind
                   and bs.is_last_file_ind              = dp.is_last_file_ind
                where dp.kls_id is null;

                set @log_message = N'  ---> Inserted ' + convert(varchar(11), @@rowcount) + N' row(s)';

                exec etl.log_event @proc, @arg_job, @log_message;

                set @log_message = N'Insert into #ftth_availability_dtag_pilot ';

                exec etl.log_event @proc, @arg_job, @log_message;

                insert into #ftth_availability_dtag_pilot with (tablock) (
                    kls_id
                  , strasse
                  , hausnummer
                  , hausnummernzusatz
                  , plz
                  , ort
                  , ortsteil
                  , ortsnetz
                  , onkz
                  , asb
                  , ortsnetzgroesse
                  , ortsnetzgroesse_berechnet
                  , ausbaustatus
                  , ausbaustatus_kurzform
                  , ausbauzeitraum_von
                  , ausbauzeitraum_bis
                  , lead_ausbauzeitraum_bis
                  , bng_endsz
                  , bng_vpsz
                  , bng_vpsz_berechnet
                  , anzahl_hh_usto
                  , reason_for_not_planned
                  , access_variante
                  , aenderungsdatum
                  , gebaeudeteil_hinweis
                  , is_versatel_area_ind
                  , gebiet_id
                  , gebiet_name
                  , ausbauentscheidung
                  , vermarktungsphase
                  , alter_standard
                  , [bulk]
                  , eigentuemerzustimmung
                  , kooperationspartnername
                  , eigentuemerdaten_notwendig
                  , neubau
                  , protokoll
                  , rl_load_filename
                  , rl_load_file_date
                  , is_last_kls_id_entry_ind
                  , is_kls_id_dismantled_ind
                  , is_kls_id_in_last_file_ind
                  , is_kls_id_in_realm_master_ind
                  , is_kls_tcdb_dtag_ftth_ind
                  , is_first_file_of_month_ind
                  , is_last_file_ind
                )
                select
                    b.kls_id
                  , o.strasse
                  , o.hausnummer
                  , o.hausnummernzusatz
                  , o.plz
                  , o.ort
                  , o.ortsteil
                  , o.ortsnetz
                  , o.onkz
                  , o.asb
                  , o.ortsnetzgroesse
                  , o.ortsnetzgroesse                               as ortsnetzgroesse_berechnet
                  , o.ausbaustatus
                  , o.ausbaustatus_kurzform
                  , o.ausbauzeitraum_von
                  , o.ausbauzeitraum_bis
                  , lead(o.ausbauzeitraum_bis) over (partition by b.kls_id
                                                     order by b.sl_load_filename desc
                                               )                    as lead_ausbauzeitraum_bis
                  , o.bng_endsz
                  , o.bng_vpsz
                  , bvh.bng_vpsz                                    as bng_vpsz_berechnet
                  , o.anzahl_hh_usto
                  , o.reason_for_not_planned
                  , o.access_variante
                  , o.aenderungsdatum
                  , o.gebaeudeteil_hinweis
                  , coalesce(bs.is_versatel_area_ind, @default_ind) as is_versatel_area_ind
                  , o.gebiet_id
                  , o.gebiet_name
                  , o.ausbauentscheidung
                  , o.vermarktungsphase
                  , o.alter_standard
                  , [o].[bulk]
                  , o.eigentuemerzustimmung
                  , o.kooperationspartnername
                  , o.eigentuemerdaten_notwendig
                  , o.neubau
                  , o.protokoll
                  , b.sl_load_filename                              as rl_load_filename
                  , b.sl_load_file_date                             as rl_load_file_date
                  , b.is_last_kls_id_entry_ind
                  , b.is_kls_id_dismantled_ind
                  , b.is_kls_id_in_last_file_ind
                  , b.is_kls_id_in_realm_master_ind
                  , b.is_kls_tcdb_dtag_ftth_ind
                  , b.is_first_file_of_month_ind
                  , b.is_last_file_ind
                from #base_set_clear                          b
                join ods_dslprocess_versatel.fb_mvd_tdg       o
                    on b.kls_id                             = o.kls_id
                   and b.sl_load_filename                   = o.sl_load_filename
                left join rl_dom_home_access.rel_bng_vpsz_hvt as bvh
                    on convert(varchar(50), o.onkz) + o.asb = bvh.hvt
                left join (
                    select distinct
                           bs.bng_vpsz
                         , 1 as is_versatel_area_ind
                    from ods_dslprocess_bis.bng_standort        as bs
                    join ods_dslprocess_bis.uebergabe_anschluss as ua
                        on bs.id                                     = ua.bng_standort_id
                       and ua.deleted                                = 'f'
                       and ua.migration_moeglich                     = 't'
                       and coalesce(ua.grund_fuer_uea_sperre, 'n/a') <> 'Rückbau abgestimmt'
                )                                             as bs
                    on bvh.bng_vpsz                         = bs.bng_vpsz;

                set @log_message = N'  ---> Inserted ' + convert(varchar(11), @@rowcount) + N' row(s)';

                exec etl.log_event @proc, @arg_job, @log_message;

                insert into #ftth_availability_dtag_pilot with (tablock) (
                    kls_id
                  , strasse
                  , hausnummer
                  , hausnummernzusatz
                  , plz
                  , ort
                  , ortsteil
                  , ortsnetz
                  , onkz
                  , asb
                  , ortsnetzgroesse
                  , ortsnetzgroesse_berechnet
                  , ausbaustatus
                  , ausbaustatus_kurzform
                  , ausbauzeitraum_von
                  , ausbauzeitraum_bis
                  , lead_ausbauzeitraum_bis
                  , bng_endsz
                  , bng_vpsz
                  , bng_vpsz_berechnet
                  , anzahl_hh_usto
                  , reason_for_not_planned
                  , access_variante
                  , aenderungsdatum
                  , gebaeudeteil_hinweis
                  , is_versatel_area_ind
                  , gebiet_id
                  , gebiet_name
                  , ausbauentscheidung
                  , vermarktungsphase
                  , alter_standard
                  , [bulk]
                  , eigentuemerzustimmung
                  , kooperationspartnername
                  , eigentuemerdaten_notwendig
                  , neubau
                  , protokoll
                  , rl_load_filename
                  , rl_load_file_date
                  , is_last_kls_id_entry_ind
                  , is_kls_id_dismantled_ind
                  , is_kls_id_in_last_file_ind
                  , is_kls_id_in_realm_master_ind
                  , is_kls_tcdb_dtag_ftth_ind
                  , is_first_file_of_month_ind
                  , is_last_file_ind
                  , is_ftth_1_7_migration_ind
                  , last_locked_file_date
                )
                select
                    b.kls_id
                  , o.strasse
                  , o.hausnummer
                  , o.hausnummernzusatz
                  , o.plz
                  , o.ort
                  , o.ortsteil
                  , o.ortsnetz
                  , o.onkz
                  , o.asb
                  , o.ortsnetzgroesse
                  , o.ortsnetzgroesse                               as ortsnetzgroesse_berechnet
                  , case
                        when o.kls_id is null
                            then 'notInFile: nicht im File enthalten'
                    end                                             as ausbaustatus
                  , case
                        when o.kls_id is null
                            then 'notInFile'
                    end                                             as ausbaustatus_kurzform
                  , o.ausbauzeitraum_von
                  , o.ausbauzeitraum_bis
                  , lead(o.ausbauzeitraum_bis) over (partition by b.kls_id
                                                     order by b.sl_load_filename desc
                                               )                    as lead_ausbauzeitraum_bis
                  , o.bng_endsz
                  , o.bng_vpsz
                  , bvh.bng_vpsz                                    as bng_vpsz_berechnet
                  , o.anzahl_hh_usto
                  , o.reason_for_not_planned
                  , o.access_variante
                  , o.aenderungsdatum
                  , o.gebaeudeteil_hinweis
                  , coalesce(bs.is_versatel_area_ind, @default_ind) as is_versatel_area_ind
                  , o.gebiet_id
                  , o.gebiet_name
                  , o.ausbauentscheidung
                  , o.vermarktungsphase
                  , o.alter_standard
                  , [o].[bulk]
                  , o.eigentuemerzustimmung
                  , o.kooperationspartnername
                  , o.eigentuemerdaten_notwendig
                  , o.neubau
                  , o.protokoll
                  , b.sl_load_filename                              as rl_load_filename
                  , b.sl_load_file_date                             as rl_load_file_date
                  , b.is_last_kls_id_entry_ind
                  , b.is_kls_id_dismantled_ind
                  , b.is_kls_id_in_last_file_ind
                  , b.is_kls_id_in_realm_master_ind
                  , b.is_kls_tcdb_dtag_ftth_ind
                  , b.is_first_file_of_month_ind
                  , b.is_last_file_ind
                  , iif(o.kls_id is null, 0, 1)                     as is_ftth_1_7_migration_ind
                  , o.sl_load_file_date                             as last_locked_file_date
                from #base_set_clear                          b
                left join ods_dslprocess_versatel.fb_mvd_tdg  f
                    on b.kls_id                             = f.kls_id
                   and b.sl_load_filename                   = f.sl_load_filename
                left join (
                    select
                        o.kls_id
                      , o.strasse
                      , o.hausnummer
                      , o.hausnummernzusatz
                      , o.plz
                      , o.ort
                      , o.ortsteil
                      , o.ortsnetz
                      , o.onkz
                      , o.asb
                      , o.ortsnetzgroesse
                      , o.ausbauzeitraum_von
                      , o.ausbauzeitraum_bis
                      , o.bng_endsz
                      , o.bng_vpsz
                      , o.anzahl_hh_usto
                      , o.reason_for_not_planned
                      , o.access_variante
                      , o.aenderungsdatum
                      , o.gebaeudeteil_hinweis
                      , o.gebiet_id
                      , o.gebiet_name
                      , o.ausbauentscheidung
                      , o.vermarktungsphase
                      , o.alter_standard
                      , [o].[bulk]
                      , o.eigentuemerzustimmung
                      , o.kooperationspartnername
                      , o.eigentuemerdaten_notwendig
                      , o.neubau
                      , o.protokoll
                      , substring(left(o.sl_load_filename, patindex('%.csv%', o.sl_load_filename) - 1), patindex('%20%', o.sl_load_filename), 255) as sl_load_file_date
                      , row_number() over (partition by o.kls_id
                                           order by o.sl_load_filename desc
                                     )                                                                                                             as locked_file_row_number
                    from ods_dslprocess_versatel.fb_mvd_tdg o
                    where o.access_variante = 'locked'
                )                                             as o
                    on b.kls_id                             = o.kls_id
                   and o.locked_file_row_number             = 1
                   and b.sl_load_file_date                  > o.sl_load_file_date
                left join rl_dom_home_access.rel_bng_vpsz_hvt as bvh
                    on convert(varchar(50), o.onkz) + o.asb = bvh.hvt
                left join (
                    select distinct
                           bs.bng_vpsz
                         , 1 as is_versatel_area_ind
                    from ods_dslprocess_bis.bng_standort        as bs
                    join ods_dslprocess_bis.uebergabe_anschluss as ua
                        on bs.id                                     = ua.bng_standort_id
                       and ua.deleted                                = 'f'
                       and ua.migration_moeglich                     = 't'
                       and coalesce(ua.grund_fuer_uea_sperre, 'n/a') <> 'Rückbau abgestimmt'
                )                                             as bs
                    on bvh.bng_vpsz                         = bs.bng_vpsz
                where f.kls_id is null;

                set @log_message = N'  ---> Inserted ' + convert(varchar(11), @@rowcount) + N' row(s) with NULL or locked';

                exec etl.log_event @proc, @arg_job, @log_message;

                create clustered columnstore index ccix_ftth_availability_dtag_pilot on #ftth_availability_dtag_pilot;

                set @log_message = N'  ---> clustered columnstore index for #ftth_availability_dtag_pilot';

                exec etl.log_event @proc, @arg_job, @log_message;
            end;

            begin
                set @log_message = N'UPDATE: sort and metrik attributes';

                exec etl.log_event @proc, @arg_job, @log_message;

                update #ftth_availability_dtag_pilot
                set
                    contract_quantity = a.contract_quantity
                  , ausbaustatus_sort_id = a.sort_id
                  , is_becu_ind = 1
                from #ftth_availability_dtag_pilot t
                join (
                    select
                        t.kls_id
                      , t.rl_load_filename
                      , count(distinct r.contract_id)  as contract_quantity
                      , max(coalesce(map.sort_id, -1)) as sort_id
                    from #ftth_availability_dtag_pilot                               t
                    left join dm_dom_home_access.planned_broadband_expansion_mapping as map
                        on t.ausbaustatus_kurzform = map.broadband_expansion_status_short_desc
                    left join rl_dom_home_access.rel_hist_contract_kls_id            r
                        on t.kls_id                = r.kls_id
                       and t.rl_load_file_date between r.contract_to_kls_valid_from and r.contract_to_kls_valid_to
                    where t.is_first_file_of_month_ind = 1
                       or t.rl_load_file_date          > @import_date
                    group by t.kls_id
                           , t.rl_load_filename
                )                                  a
                    on t.kls_id           = a.kls_id
                   and t.rl_load_filename = a.rl_load_filename;

                set @log_message = N'  ---> Updated ' + convert(varchar(11), @@rowcount) + N' row(s)';

                exec etl.log_event @proc, @arg_job, @log_message;
            end;

            begin
                set @log_message = N'DELETE: rl_dom_home_access.ftth_availability_dtag_pilot';

                exec etl.log_event @proc, @arg_job, @log_message;

                delete from rl_dom_home_access.ftth_availability_dtag_pilot
                from rl_dom_home_access.ftth_availability_dtag_pilot f
                join #base_set_clear                                 b
                    on f.kls_id           = b.kls_id
                   and f.rl_load_filename = b.sl_load_filename;

                set @log_message = N'  ---> deleted ' + convert(varchar(11), @@rowcount) + N' row(s)';

                exec etl.log_event @proc, @arg_job, @log_message;

                set @log_message = N'INSERT INTO: rl_dom_home_access.ftth_availability_dtag_pilot';

                exec etl.log_event @proc, @arg_job, @log_message;

                insert into rl_dom_home_access.ftth_availability_dtag_pilot (
                    kls_id
                  , strasse
                  , hausnummer
                  , hausnummernzusatz
                  , plz
                  , ort
                  , ortsteil
                  , ortsnetz
                  , onkz
                  , asb
                  , ortsnetzgroesse
                  , ortsnetzgroesse_berechnet
                  , ausbaustatus
                  , ausbaustatus_kurzform
                  , ausbauzeitraum_von
                  , ausbauzeitraum_bis
                  , planned_expansion_change_duration
                  , bng_endsz
                  , bng_vpsz
                  , bng_vpsz_berechnet
                  , anzahl_hh_usto
                  , reason_for_not_planned
                  , access_variante
                  , aenderungsdatum
                  , gebaeudeteil_hinweis
                  , is_versatel_area_ind
                  , gebiet_id
                  , gebiet_name
                  , ausbauentscheidung
                  , vermarktungsphase
                  , alter_standard
                  , [bulk]
                  , eigentuemerzustimmung
                  , kooperationspartnername
                  , eigentuemerdaten_notwendig
                  , neubau
                  , protokoll
                  , rl_load_filename
                  , rl_load_file_date
                  , is_last_kls_id_entry_ind
                  , is_kls_id_dismantled_ind
                  , is_kls_id_in_last_file_ind
                  , is_kls_id_in_realm_master_ind
                  , is_kls_tcdb_dtag_ftth_ind
                  , is_first_file_of_month_ind
                  , is_last_file_ind
                  , is_ftth_1_7_migration_ind
                  , last_locked_file_date
                  , contract_quantity
                  , ausbaustatus_sort_id
                  , is_becu_ind
                  , rl_load_date
                  , rl_load_job_id
                )
                select
                    t.kls_id
                  , coalesce(t.strasse, @default_string)                                        as strasse
                  , coalesce(t.hausnummer, @default_string)                                     as hausnummer
                  , t.hausnummernzusatz
                  , coalesce(t.plz, @default_int)                                               as plz
                  , coalesce(t.ort, @default_string)                                            as ort
                  , t.ortsteil
                  , t.ortsnetz
                  , coalesce(t.onkz, @default_int)                                              as onkz
                  , coalesce(t.asb, @default_string)                                            as asb
                  , t.ortsnetzgroesse
                  , t.ortsnetzgroesse_berechnet
                  , t.ausbaustatus
                  , t.ausbaustatus_kurzform
                  , t.ausbauzeitraum_von
                  , t.ausbauzeitraum_bis
                  , coalesce(datediff(day, t.lead_ausbauzeitraum_bis, t.ausbauzeitraum_bis), 0) as planned_expansion_change_duration
                  , t.bng_endsz
                  , t.bng_vpsz
                  , t.bng_vpsz_berechnet
                  , coalesce(t.anzahl_hh_usto, @default_int)                                    as anzahl_hh_usto
                  , t.reason_for_not_planned
                  , t.access_variante
                  , coalesce(t.aenderungsdatum, @default_date)                                  as aenderungsdatum
                  , t.gebaeudeteil_hinweis
                  , t.is_versatel_area_ind
                  , t.gebiet_id
                  , t.gebiet_name
                  , t.ausbauentscheidung
                  , t.vermarktungsphase
                  , t.alter_standard
                  , t.[bulk]
                  , t.eigentuemerzustimmung
                  , t.kooperationspartnername
                  , t.eigentuemerdaten_notwendig
                  , t.neubau
                  , t.protokoll
                  , lower(t.rl_load_filename)                                                   as rl_load_filename
                  , cast(t.rl_load_file_date as date)                                           as rl_load_file_date
                  , t.is_last_kls_id_entry_ind
                  , t.is_kls_id_dismantled_ind
                  , t.is_kls_id_in_last_file_ind
                  , t.is_kls_id_in_realm_master_ind
                  , t.is_kls_tcdb_dtag_ftth_ind
                  , t.is_first_file_of_month_ind
                  , t.is_last_file_ind                                                          as is_last_file_ind
                  , coalesce(t.is_ftth_1_7_migration_ind, @default_ind)                         as is_ftth_1_7_migration_ind
                  , coalesce(t.last_locked_file_date, @default_date)                            as last_locked_file_date
                  , coalesce(t.contract_quantity, @default_int)                                 as contract_quantity
                  , coalesce(t.ausbaustatus_sort_id, @default_int)                              as ausbaustatus_sort_id
                  , coalesce(t.is_becu_ind, @default_ind)                                       as is_becu_ind
                  , getdate()                                                                   as rl_load_date
                  , @arg_job                                                                    as rl_load_job_id
                from #ftth_availability_dtag_pilot t;

                set @log_message = N'  ---> Inserted ' + convert(varchar(11), @@rowcount) + N' row(s)';

                exec etl.log_event @proc, @arg_job, @log_message;

                set @log_message = N'UPDATE: is_becu_ind = 0';

                exec etl.log_event @proc, @arg_job, @log_message;

                update rl_dom_home_access.ftth_availability_dtag_pilot
                set is_becu_ind = 0
                from rl_dom_home_access.ftth_availability_dtag_pilot t
                where t.is_becu_ind                = 1
                  and t.is_first_file_of_month_ind = 0
                  and t.rl_load_file_date          < @import_date;

                set @log_message = N'  ---> Updated ' + convert(varchar(11), @@rowcount) + N' row(s)';

                exec etl.log_event @proc, @arg_job, @log_message;
            end;
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
--exec rl_dom_home_access.load_ftth_availability_dtag_pilot 'dev_qa'