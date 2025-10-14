set quoted_identifier on;

set ansi_nulls on;
go

create procedure dm_dom_network_usage.load_itm_rel_network_provider_worldzone @arg_job nvarchar(255)
with execute as owner
as
begin
    set nocount on;

    declare @log_message nvarchar(max);
    declare @proc nvarchar(255);
    declare @resultcode int;
    declare @arg_load_date datetime;

    if @arg_job is null
    or trim(@arg_job) = ''
        set @arg_job = user_name() + '#' + cast(newid() as nvarchar(255));

    set @resultcode = 0;
    set @proc = etl.get_proc_name(@@procid);
    set @arg_load_date = getdate();

    exec etl.log_revision
        @proc
      , @arg_job
      , '$URL: https://bitbucket.united-internet.org/projects/ebi-mssql/repos/dwh-access/browse/Stored%20Procedures/dm_dom_network_usage.load_itm_rel_network_provider_worldzone.sql $'
      , '$Revision: 105bb457b4e914a256c7fb789d268646ebcd7e00 $'
      , '$Author: Jens Huesmann $'
      , '$Date: 2024-07-17 10:29:29 $';

    begin try
        set @log_message = N'Started Job ' + @arg_job;

        exec etl.log_event @proc, @arg_job, @log_message;

        begin
            set @log_message = N'Insert easy ones ';

            exec etl.log_event @proc, @arg_job, @log_message;

            delete from dm_dom_network_usage.itm_rel_network_provider_worldzone;

            insert into dm_dom_network_usage.itm_rel_network_provider_worldzone (
                country_cd
              , country_desc
              , network_provider_id
              , mcc
              , mnc
              , brand
              , operator
              , basic_service
              , worldzone_id
              , worldzone_desc
              , dm_load_date
              , dm_load_job_id
            )
            values (
                N'GR', N'Greece', N'20201', N'202', N'01', N'Cosmote', N'COSMOTE - Mobile Telecommunications S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GR', N'Greece', N'20202', N'202', N'02', N'Cosmote', N'COSMOTE - Mobile Telecommunications S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GR', N'Greece', N'20203', N'202', N'03', null, N'OTE', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GR', N'Greece', N'20204', N'202', N'04', null, N'OSE', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GR', N'Greece', N'20205', N'202', N'05', N'Vodafone', N'Vodafone Greece', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GR', N'Greece', N'20206', N'202', N'06', null, N'Cosmoline', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GR', N'Greece', N'20207', N'202', N'07', null, N'AMD Telecom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GR', N'Greece', N'20209', N'202', N'09', N'NOVA', N'NOVA', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GR', N'Greece', N'20210', N'202', N'10', N'NOVA', N'NOVA', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GR', N'Greece', N'20211', N'202', N'11', null, N'interConnect', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GR', N'Greece', N'20212', N'202', N'12', null, N'Yuboto', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GR', N'Greece', N'20213', N'202', N'13', null, N'Compatel Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GR', N'Greece', N'20214', N'202', N'14', N'Cyta Hellas', N'CYTA', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GR', N'Greece', N'20215', N'202', N'15', null, N'BWS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GR', N'Greece', N'20216', N'202', N'16', null, N'Inter Telecom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20400', N'204', N'00', null, N'Intovoice B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20401', N'204', N'01', null, N'RadioAccess Network Services', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20402', N'204', N'02', N'Tele2', N'T-Mobile Netherlands B.V', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20403', N'204', N'03', N'Enreach', N'Enreach Netherlands B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20404', N'204', N'04', N'Vodafone', N'Vodafone Libertel B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20405', N'204', N'05', null, N'Elephant Talk Communications Premium Rate Services', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20406', N'204', N'06', N'Vectone Mobile', N'Mundio Mobile (Netherlands) Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20407', N'204', N'07', N'Teleena', N'Tata Communications MOVE B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20408', N'204', N'08', N'KPN', N'KPN Mobile The Netherlands B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20409', N'204', N'09', N'Lycamobile', N'Lycamobile Netherlands Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20410', N'204', N'10', N'KPN', N'KPN B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20411', N'204', N'11', null, N'Greenet Netwerk B.V', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20412', N'204', N'12', N'Telfort', N'KPN Mobile The Netherlands B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20413', N'204', N'13', null, N'Unica Installatietechniek B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20414', N'204', N'14', null, N'Venus & Mercury Telecom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20415', N'204', N'15', N'Ziggo', N'Ziggo B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20416', N'204', N'16', N'T-Mobile (BEN)', N'T-Mobile Netherlands B.V', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20417', N'204', N'17', null, N'Lebara Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20418', N'204', N'18', N'Ziggo', N'Ziggo Services B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20419', N'204', N'19', null, N'Mixe Communication Solutions B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20420', N'204', N'20', N'T-Mobile', N'T-Mobile Netherlands B.V', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20421', N'204', N'21', null, N'ProRail B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20422', N'204', N'22', null, N'Ministerie van Defensie', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20423', N'204', N'23', null, N'KORE Wireless Nederland B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20424', N'204', N'24', null, N'PM Factory B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20425', N'204', N'25', null, N'CapX B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20426', N'204', N'26', null, N'SpeakUp B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20427', N'204', N'27', N'L-mobi', N'L-Mobi Mobile B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20428', N'204', N'28', null, N'Lancelot B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20429', N'204', N'29', null, N'Tismi B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20430', N'204', N'30', null, N'ASpider Solutions Nederland B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20432', N'204', N'32', null, N'Cubic Telecom Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20433', N'204', N'33', null, N'Truphone B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20460', N'204', N'60', null, N'Nextgen Mobile Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20461', N'204', N'61', null, N'Alcadis B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20462', N'204', N'62', N'RGTN', N'RGTN Wholesale Netherlands B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20463', N'204', N'63', null, N'Messagebird BV', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20464', N'204', N'64', null, N'Zetacom B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20465', N'204', N'65', null, N'AGMS Netherlands B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20466', N'204', N'66', null, N'Utility Connect B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20467', N'204', N'67', null, N'Koning en Hartman B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20468', N'204', N'68', null, N'Roamware (Netherlands) B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20469', N'204', N'69', null, N'KPN Mobile The Netherlands B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NL', N'Netherlands', N'20491', N'204', N'91', null, N'Enexis Netbeheer B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20600', N'206', N'00', N'Proximus', N'Proximus SA', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20601', N'206', N'01', N'Proximus', N'Proximus SA', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20602', N'206', N'02', null, N'Infrabel', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20603', N'206', N'03', N'Citymesh Connect', N'Citymesh NV', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20604', N'206', N'04', N'MWingz', N'Proximus SA', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20605', N'206', N'05', N'Telenet', N'Telenet', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20606', N'206', N'06', N'Lycamobile', N'Lycamobile sprl', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20607', N'206', N'07', N'Vectone Mobile', N'Mundio Mobile Belgium nv', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20608', N'206', N'08', N'VOO', N'Nethys', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20609', N'206', N'09', null, N'Proximus SA', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20610', N'206', N'10', N'Orange Belgium', N'Orange S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20611', N'206', N'11', N'L-mobi', N'L-Mobi Mobile', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20615', N'206', N'15', null, N'Elephant Talk Communications Schweiz GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20616', N'206', N'16', null, N'NextGen Mobile Ltd.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20620', N'206', N'20', N'Base', N'Telenet', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20622', N'206', N'22', N'Febo.mobi', N'FEBO Telecom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20623', N'206', N'23', null, N'Dust Mobile', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20625', N'206', N'25', null, N'Dense Air Belgium SPRL', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20628', N'206', N'28', null, N'BICS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20629', N'206', N'29', null, N'TISMI', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20630', N'206', N'30', N'Mobile Vikings', N'Unleashed NV', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20633', N'206', N'33', null, N'Ericsson NV', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20634', N'206', N'34', null, N'ONOFFAPP OÜ', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20640', N'206', N'40', N'JOIN', N'JOIN Experience (Belgium)', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20648', N'206', N'48', null, N'Network Research Belgium', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20650', N'206', N'50', null, N'IP Nexia', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20671', N'206', N'71', null, N'test', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20672', N'206', N'72', null, N'test', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20673', N'206', N'73', null, N'test', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20674', N'206', N'74', null, N'test', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BE', N'Belgium', N'20699', N'206', N'99', null, N'e-BO Enterprises', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20801', N'208', N'01', N'Orange', N'Orange S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20802', N'208', N'02', N'Orange', N'Orange S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20803', N'208', N'03', N'MobiquiThings', N'MobiquiThings', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20804', N'208', N'04', N'Sisteer', N'Societe d''ingenierie systeme telecom et reseaux', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20805', N'208', N'05', null, N'Globalstar Europe', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20806', N'208', N'06', null, N'Globalstar Europe', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20807', N'208', N'07', null, N'Globalstar Europe', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20808', N'208', N'08', N'SFR', N'Altice', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20809', N'208', N'09', N'SFR', N'Altice', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20810', N'208', N'10', N'SFR', N'Altice', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20811', N'208', N'11', N'SFR', N'Altice', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20812', N'208', N'12', N'Truphone', N'Truphone France', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20813', N'208', N'13', N'SFR', N'Altice', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20814', N'208', N'14', N'SNCF Réseau', N'SNCF Réseau', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20815', N'208', N'15', N'Free', N'Free Mobile', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20816', N'208', N'16', N'Free', N'Free Mobile', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20817', N'208', N'17', N'LEGOS', N'Local Exchange Global Operation Services', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20818', N'208', N'18', N'Voxbone', N'Voxbone mobile', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20819', N'208', N'19', null, N'Haute-Garonne numérique', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20820', N'208', N'20', N'Bouygues', N'Bouygues Telecom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20821', N'208', N'21', N'Bouygues', N'Bouygues Telecom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20822', N'208', N'22', N'Transatel Mobile', N'Transatel', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20823', N'208', N'23', null, N'Syndicat mixte ouvert Charente Numérique', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20824', N'208', N'24', N'Sierra Wireless', N'Sierra Wireless', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20825', N'208', N'25', N'LycaMobile', N'LycaMobile', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20826', N'208', N'26', N'NRJ Mobile', N'Bouygues Telecom - Distribution', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20827', N'208', N'27', null, N'Coriolis Telecom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20828', N'208', N'28', N'AIF', N'Airmob Infra Full', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20829', N'208', N'29', null, N'Cubic télécom France', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20830', N'208', N'30', null, N'Syma Mobile', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20831', N'208', N'31', N'Vectone Mobile', N'Mundio Mobile', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20832', N'208', N'32', N'Orange', N'Orange S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20833', N'208', N'33', N'Fibre64', N'Département des Pyrénées-Atlantiques', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20834', N'208', N'34', null, N'Cellhire France', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20835', N'208', N'35', N'Free', N'Free Mobile', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20836', N'208', N'36', N'Free', N'Free Mobile', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20837', N'208', N'37', null, N'IP Directions', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20838', N'208', N'38', null, N'Lebara France Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20839', N'208', N'39', null, N'Netwo', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'208500', N'208', N'500', null, N'EDF', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20850144', N'208', N'50144', null, N'TotalEnergies Global Information Technology services', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20850164', N'208', N'50164', null, N'TotalEnergies Global Information Technology services', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20850168', N'208', N'50168', null, N'Butachimie', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20850169', N'208', N'50169', null, N'SNEF telecom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20850176', N'208', N'50176', null, N'Grand port fluvio-maritime de l''axe Seine', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20850194', N'208', N'50194', null, N'Société du Grand Paris', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'208502', N'208', N'502', null, N'EDF', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'208504', N'208', N'504', null, N'Centre à l''énergie atomique et aux énergies alternatives', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'208700', N'208', N'700', null, N'Weaccess group', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'208701', N'208', N'701', null, N'GIP Vendée numérique', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'208702', N'208', N'702', null, N'17-Numerique', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'208703', N'208', N'703', null, N'Nivertel', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'208704', N'208', N'704', null, N'Axione Limousin', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'208705', N'208', N'705', null, N'Hautes-Pyrénées Numérique', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'208706', N'208', N'706', null, N'Tours Métropole Numérique', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'208707', N'208', N'707', null, N'Sartel THD', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'208708', N'208', N'708', null, N'Melis@ territoires ruraux', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'208709', N'208', N'709', null, N'Quimper communauté télécom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'208710', N'208', N'710', null, N'Losange', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'208711', N'208', N'711', null, N'Nomotech', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'208712', N'208', N'712', null, N'Syndicat Audois d''énergies et du Numérique', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'208713', N'208', N'713', null, N'SD NUM SAS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'208714', N'208', N'714', null, N'Département de l''Isère', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20886', N'208', N'86', null, N'SEM@FOR77', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20887', N'208', N'87', null, N'Airbus defence and space SAS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20888', N'208', N'88', N'Bouygues', N'Bouygues Telecom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20889', N'208', N'89', null, N'Hub One', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20890', N'208', N'90', null, N'Images & Réseaux', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20891', N'208', N'91', null, N'Orange S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20892', N'208', N'92', N'Com4Innov', N'Association Plate-forme Télécom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20893', N'208', N'93', null, N'Thales Communications & Security SAS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20894', N'208', N'94', null, N'Halys', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20895', N'208', N'95', null, N'Orange S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20896', N'208', N'96', null, N'Région Bourgogne-Franche-Comté', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20897', N'208', N'97', null, N'Thales Communications & Security SAS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FR', N'France', N'20898', N'208', N'98', null, N'Société Air France', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'MC', N'Monaco', N'21210', N'212', N'10', N'Office des Telephones', N'Monaco Telecom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'AD', N'Andorra', N'21303', N'213', N'03', N'Som, Mobiland', N'Andorra Telecom', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21401', N'214', N'01', N'Vodafone', N'Vodafone Spain', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21402', N'214', N'02', N'Fibracat', N'Fibracat Telecom SLU', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21403', N'214', N'03', N'Orange', N'Orange Espagne S.A.U', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21404', N'214', N'04', N'Yoigo', N'Xfera Moviles SA', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21405', N'214', N'05', N'Movistar', N'Telefónica Móviles España', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21406', N'214', N'06', N'Vodafone', N'Vodafone Spain', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21407', N'214', N'07', N'Movistar', N'Telefónica Móviles España', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21408', N'214', N'08', N'Euskaltel', null, 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21409', N'214', N'09', N'Orange', N'Orange Espagne S.A.U', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21410', N'214', N'10', null, N'ZINNIA TELECOMUNICACIONES, S.L.U.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21411', N'214', N'11', null, N'TELECOM CASTILLA-LA MANCHA, S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21412', N'214', N'12', null, N'VENUS MOVIL, S.L. UNIPERSONAL', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21413', N'214', N'13', null, N'SYMA MOBILE ESPAÑA, S.L.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21414', N'214', N'14', null, N'AVATEL MÓVIL, S.L.U.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21415', N'214', N'15', N'BT', N'BT Group España Compañia de Servicios Globales de Telecomunicaciones S.A.U.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21416', N'214', N'16', N'TeleCable', N'R Cable y Telecomunicaciones Galicia S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21417', N'214', N'17', N'Móbil R', N'R Cable y Telecomunicaciones Galicia S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21418', N'214', N'18', N'ONO', N'Vodafone Spain', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21419', N'214', N'19', N'Simyo', N'Orange España Virtual Sl.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21420', N'214', N'20', N'Fonyou', N'Fonyou Telecom S.L.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21421', N'214', N'21', N'Jazztel', N'Orange Espagne S.A.U.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21422', N'214', N'22', N'DIGI mobil', N'Best Spain Telecom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21423', N'214', N'23', null, N'Xfera Moviles S.A.U.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21424', N'214', N'24', null, N'VODAFONE ESPAÑA, S.A.U.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21425', N'214', N'25', null, N'Xfera Moviles S.A.U.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21426', N'214', N'26', null, N'Lleida Networks Serveis Telemátics, SL', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21427', N'214', N'27', N'Truphone', N'SCN Truphone, S.L.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21428', N'214', N'28', N'Murcia4G', N'Consorcio de Telecomunicaciones Avanzadas, S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21429', N'214', N'29', null, N'Xfera Moviles S.A.U.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21430', N'214', N'30', null, N'Compatel Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21431', N'214', N'31', null, N'Red Digital De Telecomunicaciones de las Islas Baleares, S.L.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21432', N'214', N'32', N'Tuenti', N'Telefónica Móviles España', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21433', N'214', N'33', null, N'Xfera Móviles, S.A.U.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21434', N'214', N'34', null, N'Aire Networks del Mediterráneo, S.L.U.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21435', N'214', N'35', null, N'INGENIUM OUTSOURCING SERVICES, S.L.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21436', N'214', N'36', null, N'ALAI OPERADOR DE TELECOMUNICACIONES, S.L', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21437', N'214', N'37', null, N'Vodafone Spain', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21438', N'214', N'38', null, N'Telefónica Móviles España, S.A.U.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'21451', N'214', N'51', N'ADIF', N'Administrador de Infraestructuras Ferroviarias', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'214700', N'214', N'700', null, N'Iberdrola', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ES', N'Spain', N'214701', N'214', N'701', null, N'Endesa', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'HU', N'Hungary', N'21601', N'216', N'01', N'Yettel Hungary', N'Telenor Magyarország Zrt.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'HU', N'Hungary', N'21602', N'216', N'02', null, N'MVM Net Ltd.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'HU', N'Hungary', N'21603', N'216', N'03', N'DIGI', N'DIGI Telecommunication Ltd.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'HU', N'Hungary', N'21604', N'216', N'04', null, N'Invitech ICT Services Ltd.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'HU', N'Hungary', N'21620', N'216', N'20', N'Yettel Hungary', N'Telenor Magyarország Zrt.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'HU', N'Hungary', N'21630', N'216', N'30', N'Telekom', N'Magyar Telekom Plc', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'HU', N'Hungary', N'21670', N'216', N'70', N'Vodafone', N'Vodafone Magyarország Zrt.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'HU', N'Hungary', N'21671', N'216', N'71', N'upc', N'Vodafone Magyarország Zrt.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'HU', N'Hungary', N'21699', N'216', N'99', N'MAV GSM-R', N'Magyar Államvasutak', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BA', N'Bosnia and Herzegovina', N'21803', N'218', N'03', N'HT-ERONET', N'Public Enterprise Croatian Telecom Ltd.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'BA', N'Bosnia and Herzegovina', N'21805', N'218', N'05', N'm:tel', N'RS Telecommunications JSC Banja Luka', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'BA', N'Bosnia and Herzegovina', N'21890', N'218', N'90', N'BH Mobile', N'BH Telecom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'HR', N'Croatia', N'21901', N'219', N'01', N'HT HR', N'T-Hrvatski Telekom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'HR', N'Croatia', N'21902', N'219', N'02', null, N'Telemach', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'HR', N'Croatia', N'21903', N'219', N'03', null, N'ALTAVOX d.o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'HR', N'Croatia', N'21904', N'219', N'04', null, N'NTH Mobile d.o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'HR', N'Croatia', N'21910', N'219', N'10', N'A1 HR', N'A1 Hrvatska', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'HR', N'Croatia', N'21912', N'219', N'12', null, N'TELE FOCUS d.o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'HR', N'Croatia', N'21920', N'219', N'20', N'T-Mobile HR', N'T-Hrvatski Telekom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'HR', N'Croatia', N'21922', N'219', N'22', N'Mobile One', N'Mobile One Ltd.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'HR', N'Croatia', N'21930', N'219', N'30', null, N'INNOVACOM OÜ', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'RS', N'Serbia', N'22001', N'220', N'01', N'Yettel', N'Telenor Serbia', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RS', N'Serbia', N'22002', N'220', N'02', N'One', N'Telenor Montenegro', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RS', N'Serbia', N'22003', N'220', N'03', N'mt:s', N'Telekom Srbija', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RS', N'Serbia', N'22004', N'220', N'04', N'T-Mobile CG', N'T-Mobile Montenegro LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RS', N'Serbia', N'22005', N'220', N'05', N'A1 SRB', N'A1 Srbija d.o.o.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RS', N'Serbia', N'22007', N'220', N'07', N'Orion', N'Orion Telekom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RS', N'Serbia', N'22009', N'220', N'09', N'Vectone Mobile', N'MUNDIO MOBILE d.o.o.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RS', N'Serbia', N'22011', N'220', N'11', N'Globaltel', N'GLOBALTEL d.o.o.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RS', N'Serbia', N'22020', N'220', N'20', N'A1 SRB', N'A1 Srbija d.o.o.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RS', N'Serbia', N'22021', N'220', N'21', null, N'Infrastruktura železnice Srbije a.d.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'XK', N'Kosovo', N'22101', N'221', N'01', N'Vala', N'Telecom of Kosovo J.S.C.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'XK', N'Kosovo', N'22102', N'221', N'02', N'IPKO', N'IPKO', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'XK', N'Kosovo', N'22106', N'221', N'06', N'Z Mobile', N'Dardaphone.Net LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'XK', N'Kosovo', N'22107', N'221', N'07', N'D3 Mobile', N'Dukagjini Telecommunications LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22201', N'222', N'01', N'TIM', N'Telecom Italia S.p.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22202', N'222', N'02', N'Elsacom', null, 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22204', N'222', N'04', N'Intermatica', null, 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22205', N'222', N'05', N'Telespazio', null, 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22206', N'222', N'06', N'Vodafone', N'Vodafone Italia S.p.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22207', N'222', N'07', N'Kena Mobile', N'Noverca', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22208', N'222', N'08', N'Fastweb', N'Fastweb S.p.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22210', N'222', N'10', N'Vodafone', N'Vodafone Italia S.p.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22230', N'222', N'30', N'RFI', N'Rete Ferroviaria Italiana', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22233', N'222', N'33', N'Poste Mobile', N'Poste Mobile S.p.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22234', N'222', N'34', N'BT Italia', N'BT Italia', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22235', N'222', N'35', N'Lycamobile', N'Lycamobile', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22236', N'222', N'36', N'Digi Mobil', N'Digi Italy S.r.l.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22237', N'222', N'37', N'WINDTRE', N'Wind Tre', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22238', N'222', N'38', N'LINKEM', N'OpNet S.p.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22239', N'222', N'39', N'SMS Italia', N'SMS Italia S.r.l.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22241', N'222', N'41', N'GO internet', N'GO internet S.p.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22243', N'222', N'43', N'TIM', N'Telecom Italia S.p.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22247', N'222', N'47', N'Fastweb', N'Fastweb S.p.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22248', N'222', N'48', N'TIM', N'Telecom Italia S.p.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22249', N'222', N'49', N'Vianova', N'Welcome Italia S.p.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22250', N'222', N'50', N'Iliad', N'Iliad Italia', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22253', N'222', N'53', N'COOP Voce', N'COOP Voce', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22254', N'222', N'54', N'Plintron', null, 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22256', N'222', N'56', N'Spusu', N'Mass Response GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22277', N'222', N'77', N'IPSE 2000', null, 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22288', N'222', N'88', N'WINDTRE', N'Wind Tre', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22298', N'222', N'98', N'BLU', N'BLU S.p.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IT', N'Italy', N'22299', N'222', N'99', N'WINDTRE', N'Wind Tre', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'RO', N'Romania', N'22601', N'226', N'01', N'Vodafone', N'Vodafone România', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'RO', N'Romania', N'22602', N'226', N'02', N'Clicknet Mobile', N'Telekom Romania', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'RO', N'Romania', N'22603', N'226', N'03', N'Telekom', N'Telekom Romania', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'RO', N'Romania', N'22604', N'226', N'04', N'Cosmote/Zapp', N'Telekom Romania', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'RO', N'Romania', N'22605', N'226', N'05', N'Digi.Mobil', N'RCS&RDS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'RO', N'Romania', N'22606', N'226', N'06', N'Telekom', N'Telekom Romania', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'RO', N'Romania', N'22610', N'226', N'10', N'Orange', N'Orange România', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'RO', N'Romania', N'22611', N'226', N'11', null, N'Enigma-System', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'RO', N'Romania', N'22615', N'226', N'15', N'Idilis', N'Idilis', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'RO', N'Romania', N'22616', N'226', N'16', N'Lycamobile', N'Lycamobile Romania', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'RO', N'Romania', N'22619', N'226', N'19', N'CFR', N'Căile Ferate Române', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22801', N'228', N'01', N'Swisscom', N'Swisscom AG', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22802', N'228', N'02', N'Sunrise', N'Sunrise UPC', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22803', N'228', N'03', N'Salt', N'Salt Mobile SA', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22805', N'228', N'05', null, N'Comfone AG', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22806', N'228', N'06', N'SBB-CFF-FFS', N'SBB AG', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22807', N'228', N'07', N'IN&Phone', N'IN&Phone SA', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22808', N'228', N'08', N'Tele4u', N'Sunrise Communications AG', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22809', N'228', N'09', null, N'Comfone AG', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22810', N'228', N'10', null, N'Stadt Polizei Zürich', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22811', N'228', N'11', null, N'Swisscom Broadcast AG', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22812', N'228', N'12', N'Sunrise', N'Sunrise Communications AG', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22850', N'228', N'50', null, N'3G Mobile AG', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22851', N'228', N'51', null, N'relario AG', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22852', N'228', N'52', N'Barablu', N'Barablu', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22853', N'228', N'53', N'upc cablecom', N'Sunrise UPC GmbH', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22854', N'228', N'54', N'Lycamobile', N'Lycamobile AG', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22855', N'228', N'55', null, N'WeMobile SA', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22856', N'228', N'56', null, N'SMSRelay AG', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22857', N'228', N'57', null, N'Mitto AG', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22858', N'228', N'58', N'beeone', N'Beeone Communications SA', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22859', N'228', N'59', N'Vectone', N'Mundio Mobile Limited', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22860', N'228', N'60', N'Sunrise', N'Sunrise Communications AG', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22861', N'228', N'61', null, N'Compatel Ltd.', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22862', N'228', N'62', null, N'Telecom26 AG', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22863', N'228', N'63', N'FTS', N'Fink Telecom Services', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22864', N'228', N'64', null, N'Nth AG', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22865', N'228', N'65', null, N'Nexphone AG', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22866', N'228', N'66', null, N'Inovia Services SA', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22867', N'228', N'67', null, N'Datatrade Managed AG', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22868', N'228', N'68', null, N'Intellico AG', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22869', N'228', N'69', null, N'MTEL Schweiz GmbH', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22870', N'228', N'70', null, N'Tismi BV', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22898', N'228', N'98', null, N'Etablissement Cantonal d''Assurance', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CH', N'Switzerland', N'22899', N'228', N'99', null, N'Swisscom Broadcast AG', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'CZ', N'Czech Republic', N'23001', N'230', N'01', N'T-Mobile', N'T-Mobile Czech Republic', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'CZ', N'Czech Republic', N'23002', N'230', N'02', N'O2', N'O2 Czech Republic', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'CZ', N'Czech Republic', N'23003', N'230', N'03', N'Vodafone', N'Vodafone Czech Republic', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'CZ', N'Czech Republic', N'23004', N'230', N'04', null, N'Nordic Telecom Regional s.r.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'CZ', N'Czech Republic', N'23005', N'230', N'05', null, N'PODA a.s.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'CZ', N'Czech Republic', N'23006', N'230', N'06', null, N'Nordic Telecom 5G a.s.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'CZ', N'Czech Republic', N'23007', N'230', N'07', N'T-Mobile', N'T-Mobile Czech Republic', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'CZ', N'Czech Republic', N'23008', N'230', N'08', null, N'Compatel s.r.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'CZ', N'Czech Republic', N'23009', N'230', N'09', N'Unimobile', N'Uniphone, s.r.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'CZ', N'Czech Republic', N'23011', N'230', N'11', null, N'incrate s.r.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'CZ', N'Czech Republic', N'23098', N'230', N'98', null, N'Správa železniční dopravní cesty, s.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'CZ', N'Czech Republic', N'23099', N'230', N'99', N'Vodafone', N'Vodafone Czech Republic', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SK', N'Slovakia', N'23101', N'231', N'01', N'Orange', N'Orange Slovensko', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SK', N'Slovakia', N'23102', N'231', N'02', N'Telekom', N'Slovak Telekom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SK', N'Slovakia', N'23103', N'231', N'03', N'4ka', N'SWAN Mobile, a.s.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SK', N'Slovakia', N'23104', N'231', N'04', N'Telekom', N'Slovak Telekom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SK', N'Slovakia', N'23105', N'231', N'05', N'Orange', N'Orange Slovensko', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SK', N'Slovakia', N'23106', N'231', N'06', N'O2', N'O2 Slovakia', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SK', N'Slovakia', N'23107', N'231', N'07', N'Orange', N'Orange Slovensko', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SK', N'Slovakia', N'23108', N'231', N'08', N'Unimobile', N'Uniphone, s.r.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SK', N'Slovakia', N'23109', N'231', N'09', null, N'DSI DATA, a.s.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SK', N'Slovakia', N'23110', N'231', N'10', null, N'HMZ RÁDIOKOMUNIKÁCIE, spol. s r.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SK', N'Slovakia', N'23150', N'231', N'50', N'Telekom', N'Slovak Telekom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SK', N'Slovakia', N'23199', N'231', N'99', N'ŽSR', N'Železnice Slovenskej Republiky', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23201', N'232', N'01', N'A1.net', N'A1 Telekom Austria', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23202', N'232', N'02', null, N'A1 Telekom Austria', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23203', N'232', N'03', N'Magenta', N'T-Mobile Austria GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23204', N'232', N'04', N'Magenta', N'T-Mobile Austria GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23205', N'232', N'05', N'3', N'Hutchison Drei Austria', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23206', N'232', N'06', N'Orange AT', N'Orange Austria GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23207', N'232', N'07', N'Hofer Telekom', N'T-Mobile Austria', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23208', N'232', N'08', N'Lycamobile', N'Lycamobile Austria', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23209', N'232', N'09', N'Tele2Mobil', N'A1 Telekom Austria', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23210', N'232', N'10', N'3', N'Hutchison Drei Austria', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23211', N'232', N'11', N'bob', N'A1 Telekom Austria', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23212', N'232', N'12', N'yesss!', N'A1 Telekom Austria', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23213', N'232', N'13', N'Magenta', N'T-Mobile Austria GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23214', N'232', N'14', null, N'Hutchison Drei Austria', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23215', N'232', N'15', N'Vectone Mobile', N'Mundio Mobile Austria', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23216', N'232', N'16', null, N'Hutchison Drei Austria', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23217', N'232', N'17', N'spusu', N'MASS Response Service GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23218', N'232', N'18', null, N'smartspace GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23219', N'232', N'19', null, N'Hutchison Drei Austria', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23220', N'232', N'20', N'm:tel', N'MTEL Austrija GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23221', N'232', N'21', null, N'Salzburg AG für Energie, Verkehr und Telekommunikation', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23222', N'232', N'22', null, N'Plintron Austria Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23223', N'232', N'23', N'Magenta', N'T-Mobile Austria GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23224', N'232', N'24', null, N'Smartel Services GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23225', N'232', N'25', null, N'Holding Graz Kommunale Dienstleistungen GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23226', N'232', N'26', null, N'LIWEST Kabelmedien GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23227', N'232', N'27', null, N'TISMI B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23291', N'232', N'91', N'GSM-R A', N'ÖBB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AT', N'Austria', N'23292', N'232', N'92', N'ArgoNET', N'ArgoNET GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23400', N'234', N'00', N'BT', N'BT Group', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23401', N'234', N'01', N'Vectone Mobile', N'Mundio Mobile Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23402', N'234', N'02', N'O2 (UK)', N'Telefónica Europe', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23404', N'234', N'04', N'FMS Solutions Ltd', N'FMS Solutions Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23405', N'234', N'05', null, N'Spitfire Network Services Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23406', N'234', N'06', null, N'Internet Computer Bureau Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23407', N'234', N'07', N'Vodafone UK', N'Vodafone', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23408', N'234', N'08', N'BT OnePhone', N'BT OnePhone (UK) Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23409', N'234', N'09', null, N'Tismi BV', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23410', N'234', N'10', N'O2 (UK)', N'Telefónica Europe', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23411', N'234', N'11', N'O2 (UK)', N'Telefónica Europe', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23412', N'234', N'12', N'Railtrack', N'Network Rail Infrastructure Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23413', N'234', N'13', N'Railtrack', N'Network Rail Infrastructure Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23414', N'234', N'14', null, N'Link Mobility UK Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23415', N'234', N'15', N'Vodafone UK', N'Vodafone', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23416', N'234', N'16', N'Talk Talk', N'TalkTalk Communications Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23417', N'234', N'17', null, N'FleXtel Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23419', N'234', N'19', N'PMN', N'Teleware plc', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23420', N'234', N'20', N'3', N'Hutchison 3G UK Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23421', N'234', N'21', null, N'LogicStar Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23422', N'234', N'22', null, N'Telesign Mobile Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23423', N'234', N'23', null, N'Icron Network Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23424', N'234', N'24', N'Greenfone', N'Stour Marine Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23425', N'234', N'25', N'Truphone', N'Truphone', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23426', N'234', N'26', N'Lycamobile', N'Lycamobile UK Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23427', N'234', N'27', N'Teleena', N'Tata Communications Move UK Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23429', N'234', N'29', N'aql', N'(aq) Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23430', N'234', N'30', N'EE', N'EE', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23431', N'234', N'31', N'EE', N'EE', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23432', N'234', N'32', N'EE', N'EE', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23433', N'234', N'33', N'EE', N'EE', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23434', N'234', N'34', N'EE', N'EE', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23435', N'234', N'35', null, N'JSC Ingenium (UK) Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23437', N'234', N'37', null, N'Synectiv Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23438', N'234', N'38', N'Virgin Mobile', N'Virgin Media', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23439', N'234', N'39', null, N'Gamma Telecom Holdings Ltd.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23440', N'234', N'40', null, N'Mass Response Service GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23451', N'234', N'51', N'Relish', N'UK Broadband Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23452', N'234', N'52', null, N'Shyam Telecom UK Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23453', N'234', N'53', N'Mobile-X', N'Tango Networks UK Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23454', N'234', N'54', N'iD Mobile', N'The Carphone Warehouse Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23456', N'234', N'56', null, N'National Cyber Security Centre', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23457', N'234', N'57', null, N'Sky UK Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23459', N'234', N'59', null, N'Limitless Mobile Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23470', N'234', N'70', null, N'AMSUK Ltd.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23471', N'234', N'71', null, N'Home Office', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23472', N'234', N'72', N'Hanhaa Mobile', N'Hanhaa Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23474', N'234', N'74', null, N'Pareteum Europe B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23475', N'234', N'75', null, N'Mass Response Service GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23476', N'234', N'76', N'BT', N'BT Group', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23477', N'234', N'77', N'Vodafone UK', N'Vodafone United Kingdom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23478', N'234', N'78', N'Airwave', N'Airwave Solutions Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23479', N'234', N'79', N'UKTL', N'UK Telecoms Lab', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23486', N'234', N'86', null, N'EE', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23488', N'234', N'88', N'telet', N'Telet Research (N.I.) Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23500', N'235', N'00', N'Vectone Mobile', N'Mundio Mobile Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23501', N'235', N'01', null, N'EE', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23502', N'235', N'02', null, N'EE', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23503', N'235', N'03', N'Relish', N'UK Broadband Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23504', N'235', N'04', null, N'University of Strathclyde', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23506', N'235', N'06', null, N'University of Strathclyde', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23507', N'235', N'07', null, N'University of Strathclyde', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23508', N'235', N'08', null, N'Spitfire Network Services Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23577', N'235', N'77', N'BT', N'BT Group', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23588', N'235', N'88', N'telet', N'Telet Research (N.I.) Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23591', N'235', N'91', N'Vodafone UK', N'Vodafone United Kingdom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23592', N'235', N'92', N'Vodafone UK', N'Vodafone United Kingdom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23594', N'235', N'94', null, N'Hutchison 3G UK Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23595', N'235', N'95', null, N'Network Rail Infrastructure Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23801', N'238', N'01', N'TDC', N'TDC A/S', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23802', N'238', N'02', N'Telenor', N'Telenor Denmark', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23803', N'238', N'03', null, N'Syniverse Technologies', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23804', N'238', N'04', null, N'Nexcon.io ApS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23805', N'238', N'05', N'TetraNet', N'Dansk Beredskabskommunikation A/S', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23806', N'238', N'06', N'3', N'Hi3G Denmark ApS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23807', N'238', N'07', N'Vectone Mobile', N'Mundio Mobile (Denmark) Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23808', N'238', N'08', N'Voxbone', N'Voxbone mobile', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23809', N'238', N'09', N'SINE', N'Dansk Beredskabskommunikation A/S', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23810', N'238', N'10', N'TDC', N'TDC A/S', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23811', N'238', N'11', N'SINE', N'Dansk Beredskabskommunikation A/S', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23812', N'238', N'12', N'Lycamobile', N'Lycamobile Denmark Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23813', N'238', N'13', null, N'Compatel Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23814', N'238', N'14', null, N'Monty UK Global Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23815', N'238', N'15', N'Net 1', N'Cibicom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23816', N'238', N'16', null, N'Tismi B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23817', N'238', N'17', null, N'Gotanet AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23818', N'238', N'18', null, N'Cubic Telecom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23820', N'238', N'20', N'Telia', N'Telia', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23823', N'238', N'23', N'GSM-R DK', N'Banedanmark', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23825', N'238', N'25', N'Viahub', N'SMS Provider Corp.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23828', N'238', N'28', null, N'LINK Mobile A/S', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23830', N'238', N'30', null, N'Interactive digital media GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23840', N'238', N'40', null, N'Ericsson Danmark A/S', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23842', N'238', N'42', N'Wavely', N'Greenwave Mobile IoT ApS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23843', N'238', N'43', null, N'MobiWeb Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23866', N'238', N'66', null, N'TT-Netværket P/S', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23873', N'238', N'73', N'Onomondo', N'Onomondo ApS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23877', N'238', N'77', N'Telenor', N'Telenor Denmark', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23888', N'238', N'88', null, N'Cobira ApS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DK', N'Denmark', N'23896', N'238', N'96', N'Telia', N'Telia Danmark', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24001', N'240', N'01', N'Telia', N'Telia Sverige AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24002', N'240', N'02', N'3', N'HI3G Access AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24003', N'240', N'03', N'Net 1', N'Teracom AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24004', N'240', N'04', N'SWEDEN', N'3G Infrastructure Services AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24005', N'240', N'05', N'Sweden 3G', N'Svenska UMTS-Nät AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24006', N'240', N'06', N'Telenor', N'Telenor Sverige AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24007', N'240', N'07', N'Tele2', N'Tele2 Sverige AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24008', N'240', N'08', N'Telenor', N'Telenor Sverige AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24009', N'240', N'09', N'Com4', N'Communication for Devices in Sweden AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24010', N'240', N'10', N'Spring Mobil', N'Tele2 Sverige AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24011', N'240', N'11', null, N'ComHem AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24012', N'240', N'12', N'Lycamobile', N'Lycamobile Sweden Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24013', N'240', N'13', null, N'Bredband2 Företag AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24014', N'240', N'14', null, N'Tele2 Sverige AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24015', N'240', N'15', null, N'Sierra Wireless Sweden AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24016', N'240', N'16', null, N'42 Telecom AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24017', N'240', N'17', N'Gotanet', N'Götalandsnätet AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24018', N'240', N'18', null, N'Generic Mobile Systems Sweden AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24019', N'240', N'19', N'Vectone Mobile', N'Mundio Mobile (Sweden) Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24020', N'240', N'20', null, N'Sierra Wireless Messaging AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24021', N'240', N'21', N'MobiSir', N'Trafikverket ICT', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24022', N'240', N'22', null, N'EuTel AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24023', N'240', N'23', null, N'Infobip Limited (UK)', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24024', N'240', N'24', N'Sweden 2G', N'Net4Mobility HB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24025', N'240', N'25', null, N'Monty UK Global Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24026', N'240', N'26', null, N'Twilio Sweden AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24027', N'240', N'27', null, N'GlobeTouch AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24028', N'240', N'28', null, N'LINK Mobile A/S', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24029', N'240', N'29', null, N'Mercury International Carrier Services AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24030', N'240', N'30', null, N'NextGen Mobile Ltd.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24031', N'240', N'31', null, N'RebTel Network AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24032', N'240', N'32', null, N'Compatel Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24033', N'240', N'33', null, N'Mobile Arts AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24034', N'240', N'34', null, N'Trafikverket centralfunktion IT', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24035', N'240', N'35', null, N'42 Telecom LTD', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24036', N'240', N'36', null, N'interactive digital media GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24037', N'240', N'37', null, N'Sinch Sweden AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24038', N'240', N'38', N'Voxbone', N'Voxbone mobile', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24039', N'240', N'39', null, N'Primlight AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24040', N'240', N'40', null, N'Netmore Group AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24041', N'240', N'41', null, N'Telenor Sverige AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24042', N'240', N'42', null, N'Telenor Connexion AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24043', N'240', N'43', null, N'MobiWeb Ltd.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24044', N'240', N'44', null, N'Telenabler AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24045', N'240', N'45', null, N'Spirius AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24046', N'240', N'46', N'Viahub', N'SMS Provider Corp.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24047', N'240', N'47', null, N'Viatel Sweden AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24048', N'240', N'48', null, N'Tismi BV', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24049', N'240', N'49', null, N'Telia Sverige AB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24060', N'240', N'60', null, N'Västra Götalandsregionen', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24061', N'240', N'61', null, N'MessageBird B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SE', N'Sweden', N'24063', N'240', N'63', N'FTS', N'Fink Telecom Services', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24201', N'242', N'01', N'Telenor', N'Telenor Norge AS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24202', N'242', N'02', N'Telia', N'Telia Norge AS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24203', N'242', N'03', null, N'Televerket AS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24204', N'242', N'04', N'Tele2', N'Tele2 (Mobile Norway AS)', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24205', N'242', N'05', N'Telia', N'Telia Norge AS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24206', N'242', N'06', N'ice', N'ICE Norge AS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24207', N'242', N'07', N'Phonero', N'Phonero AS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24208', N'242', N'08', N'Telia', N'Telia Norge AS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24209', N'242', N'09', N'Com4', N'Com4 AS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24210', N'242', N'10', null, N'Norwegian Communications Authority', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24211', N'242', N'11', N'SystemNet', N'SystemNet AS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24212', N'242', N'12', N'Telenor', N'Telenor Norge AS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24214', N'242', N'14', N'ice', N'ICE Communication Norge AS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24215', N'242', N'15', null, N'eRate Norway AS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24216', N'242', N'16', null, N'Iristel Norway AS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24217', N'242', N'17', N'Telenor', N'Telenor Norge AS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24220', N'242', N'20', null, N'Jernbaneverket AS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24221', N'242', N'21', null, N'Jernbaneverket AS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24222', N'242', N'22', null, N'Altibox AS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24223', N'242', N'23', N'Lycamobile', N'Lyca Mobile Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24224', N'242', N'24', null, N'Mobile Norway AS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24225', N'242', N'25', null, N'Forsvarets kompetansesenter KKIS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24270', N'242', N'70', null, N'test networks', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24271', N'242', N'71', null, N'private networks', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24272', N'242', N'72', null, N'private networks', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24273', N'242', N'73', null, N'private networks', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24274', N'242', N'74', null, N'private networks', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24275', N'242', N'75', null, N'private networks', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24290', N'242', N'90', null, N'Nokia Solutions and Networks Norge AS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'NO', N'Norway', N'24299', N'242', N'99', null, N'TampNet AS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24403', N'244', N'03', N'DNA', N'DNA Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24404', N'244', N'04', N'DNA', N'DNA Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24405', N'244', N'05', N'Elisa', N'Elisa Oyj', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24406', N'244', N'06', N'Elisa', N'Elisa Oyj', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24407', N'244', N'07', N'Nokia', N'Nokia Solutions and Networks Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24408', N'244', N'08', N'Nokia', N'Nokia Solutions and Networks Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24409', N'244', N'09', null, N'Nokia Solutions and Networks Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24410', N'244', N'10', null, N'Traficom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24411', N'244', N'11', null, N'Traficom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24412', N'244', N'12', N'DNA', N'DNA Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24413', N'244', N'13', N'DNA', N'DNA Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24414', N'244', N'14', N'Ålcom', N'Ålands Telekommunikation Ab', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24415', N'244', N'15', null, N'Telit Wireless Solutions GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24416', N'244', N'16', null, N'Digita Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24417', N'244', N'17', null, N'Liikennevirasto', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24419', N'244', N'19', null, N'Nettia Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24420', N'244', N'20', null, N'Elisa Oyj', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24421', N'244', N'21', N'Elisa- Saunalahti', N'Elisa Oyj', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24422', N'244', N'22', null, N'EXFO Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24423', N'244', N'23', null, N'EXFO Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24424', N'244', N'24', null, N'Nord Connect UAB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24425', N'244', N'25', null, N'Fortum Power and Heat Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24426', N'244', N'26', N'Compatel', N'Compatel Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24427', N'244', N'27', null, N'Teknologian tutkimuskeskus VTT Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24428', N'244', N'28', null, N'Teknologian tutkimuskeskus VTT Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24429', N'244', N'29', null, N'Teknologian tutkimuskeskus VTT Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24430', N'244', N'30', null, N'Teknologian tutkimuskeskus VTT Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24431', N'244', N'31', null, N'Teknologian tutkimuskeskus VTT Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24432', N'244', N'32', N'Voxbone', N'Voxbone SA', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24433', N'244', N'33', N'VIRVE', N'Suomen Turvallisuusverkko Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24434', N'244', N'34', N'Bittium Wireless', N'Bittium Wireless Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24435', N'244', N'35', null, N'Edzcom Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24436', N'244', N'36', N'Telia / DNA', N'Telia Finland Oyj / Suomen Yhteisverkko Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24437', N'244', N'37', N'Tismi', N'Tismi BV', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24438', N'244', N'38', null, N'Nokia Solutions and Networks Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24439', N'244', N'39', null, N'Nokia Solutions and Networks Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24440', N'244', N'40', null, N'Nokia Solutions and Networks Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24441', N'244', N'41', null, N'Nokia Solutions and Networks Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24442', N'244', N'42', null, N'SMS Provider Corp.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24443', N'244', N'43', null, N'Telavox AB / Telavox Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24444', N'244', N'44', null, N'Turun ammattikorkeakoulu Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24445', N'244', N'45', null, N'Suomen Turvallisuusverkko Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24446', N'244', N'46', null, N'Suomen Turvallisuusverkko Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24447', N'244', N'47', null, N'Suomen Turvallisuusverkko Oy', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24450', N'244', N'50', null, N'Aalto-korkeakoulusäätiö sr', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24451', N'244', N'51', null, N'Aalto-korkeakoulusäätiö sr', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24452', N'244', N'52', null, N'Aalto-korkeakoulusäätiö sr', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24453', N'244', N'53', null, N'Aalto-korkeakoulusäätiö sr', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24454', N'244', N'54', null, N'Aalto-korkeakoulusäätiö sr', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24455', N'244', N'55', null, N'Aalto-korkeakoulusäätiö sr', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24456', N'244', N'56', null, N'Aalto-korkeakoulusäätiö sr', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24457', N'244', N'57', null, N'Aalto-korkeakoulusäätiö sr', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24458', N'244', N'58', null, N'Aalto-korkeakoulusäätiö sr', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24459', N'244', N'59', null, N'Aalto-korkeakoulusäätiö sr', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24491', N'244', N'91', N'Telia', N'Telia Finland Oyj', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24492', N'244', N'92', N'Sonera', N'TeliaSonera Finland Oyj', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24495', N'244', N'95', null, N'Säteilyturvakeskus', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'FI', N'Finland', N'24499', N'244', N'99', null, N'Oy L M Ericsson Ab', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LT', N'Lithuania', N'24601', N'246', N'01', N'Telia', N'Telia Lietuva', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LT', N'Lithuania', N'24602', N'246', N'02', N'BITĖ', N'UAB Bitė Lietuva', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LT', N'Lithuania', N'24603', N'246', N'03', N'Tele2', N'UAB Tele2 (Tele2 AB, Sweden)', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LT', N'Lithuania', N'24604', N'246', N'04', null, N'LR vidaus reikalų ministerija (Ministry of the Interior)', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LT', N'Lithuania', N'24605', N'246', N'05', N'LitRail', N'Lietuvos geležinkeliai (Lithuanian Railways)', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LT', N'Lithuania', N'24606', N'246', N'06', N'Mediafon', N'UAB Mediafon', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LT', N'Lithuania', N'24607', N'246', N'07', null, N'Compatel Ltd.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LT', N'Lithuania', N'24608', N'246', N'08', N'MEZON', N'Lietuvos radijo ir televizijos centras', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LT', N'Lithuania', N'24609', N'246', N'09', null, N'Interactive Digital Media GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LT', N'Lithuania', N'24611', N'246', N'11', null, N'DATASIM OU', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LT', N'Lithuania', N'24612', N'246', N'12', null, N'Nord connect OU', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LT', N'Lithuania', N'24613', N'246', N'13', null, N'Travel Communication SIA', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LT', N'Lithuania', N'24614', N'246', N'14', null, N'Tismi BV', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LT', N'Lithuania', N'24615', N'246', N'15', null, N'Esim telecom, UAB', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LT', N'Lithuania', N'24616', N'246', N'16', null, N'Annecto Telecom Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LV', N'Latvia', N'24701', N'247', N'01', N'LMT', N'Latvian Mobile Telephone', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LV', N'Latvia', N'24702', N'247', N'02', N'Tele2', N'Tele2', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LV', N'Latvia', N'24703', N'247', N'03', N'TRIATEL', N'Telekom Baltija', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LV', N'Latvia', N'24704', N'247', N'04', null, N'Beta Telecom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LV', N'Latvia', N'24705', N'247', N'05', N'Bite', N'Bite Latvija', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LV', N'Latvia', N'24706', N'247', N'06', null, N'SIA "UNISTARS"', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LV', N'Latvia', N'24707', N'247', N'07', null, N'SIA "MEGATEL"', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LV', N'Latvia', N'24708', N'247', N'08', N'VMT', N'SIA "VENTAmobile"', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LV', N'Latvia', N'24709', N'247', N'09', N'Xomobile', N'Camel Mobile', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LV', N'Latvia', N'24710', N'247', N'10', N'LMT', N'Latvian Mobile Telephone', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24801', N'248', N'01', N'Telia', N'Telia Eesti', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24802', N'248', N'02', N'Elisa', N'Elisa Eesti', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24803', N'248', N'03', N'Tele2', N'Tele2 Eesti', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24804', N'248', N'04', N'Top Connect', N'OY Top Connect', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24805', N'248', N'05', N'CSC Telecom', N'CSC Telecom Estonia OÜ', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24806', N'248', N'06', null, N'Progroup Holding', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24807', N'248', N'07', N'Kou', N'Televõrgu AS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24808', N'248', N'08', N'VIVEX', N'VIVEX OU', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24809', N'248', N'09', null, N'Bravo Telecom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24810', N'248', N'10', null, N'Telcotrade OÜ', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24811', N'248', N'11', null, N'UAB Raystorm Eesti filiaal', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24812', N'248', N'12', null, N'Ntel Solutions OÜ', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24813', N'248', N'13', null, N'Telia Eesti AS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24814', N'248', N'14', null, N'Estonian Crafts OÜ', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24815', N'248', N'15', null, N'Premium Net International S.R.L. Eesti filiaal', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24816', N'248', N'16', N'dzinga', N'SmartTel Plus OÜ', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24817', N'248', N'17', null, N'Baltergo OÜ', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24818', N'248', N'18', null, N'Cloud Communications OÜ', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24819', N'248', N'19', null, N'OkTelecom OÜ', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24820', N'248', N'20', null, N'DOTT Telecom OÜ', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24821', N'248', N'21', null, N'Tismi B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24822', N'248', N'22', null, N'M2MConnect OÜ', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24824', N'248', N'24', null, N'Novametro OÜ', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24825', N'248', N'25', null, N'Eurofed OÜ', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24826', N'248', N'26', null, N'IT-Decision Telecom OÜ', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24828', N'248', N'28', null, N'Nord Connect OÜ', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24829', N'248', N'29', null, N'SkyTel OÜ', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'EE', N'Estonia', N'24871', N'248', N'71', null, N'Siseministeerium (Ministry of Interior)', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25001', N'250', N'01', N'MTS', N'Mobile TeleSystems', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25002', N'250', N'02', N'MegaFon', N'MegaFon PJSC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25003', N'250', N'03', N'NCC', N'Nizhegorodskaya Cellular Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25004', N'250', N'04', N'Sibchallenge', N'Sibchallenge', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25005', N'250', N'05', N'ETK', N'Yeniseytelecom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25006', N'250', N'06', N'Skylink', N'CJSC Saratov System of Cellular Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25007', N'250', N'07', N'SMARTS', N'Zao SMARTS', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25008', N'250', N'08', N'Vainah Telecom', N'CS "VainahTelecom"', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25009', N'250', N'09', N'Skylink', N'Khabarovsky Cellular Phone', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25010', N'250', N'10', N'DTC', N'Dontelekom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25011', N'250', N'11', N'Yota', N'Scartel', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25013', N'250', N'13', N'KUGSM', N'Kuban GSM', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25014', N'250', N'14', N'MegaFon', N'MegaFon OJSC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25015', N'250', N'15', N'SMARTS', N'SMARTS Ufa, SMARTS Uljanovsk', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25016', N'250', N'16', N'Miatel', N'Miatel', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25017', N'250', N'17', N'Utel', N'JSC Uralsvyazinform', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25018', N'250', N'18', N'Osnova Telecom', null, 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25019', N'250', N'19', N'INDIGO', N'INDIGO', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25020', N'250', N'20', N'Tele2', N'Tele2', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25021', N'250', N'21', N'GlobalTel', N'JSC "GlobalTel"', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25022', N'250', N'22', null, N'Vainakh Telecom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25023', N'250', N'23', N'Thuraya', N'GTNT', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25026', N'250', N'26', N'VTB Mobile', N'VTB Mobile', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25027', N'250', N'27', N'Letai', N'Tattelecom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25028', N'250', N'28', N'Beeline', N'Beeline', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25029', N'250', N'29', N'Iridium', N'Iridium Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25032', N'250', N'32', N'Win Mobile', N'K-Telecom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25033', N'250', N'33', N'Sevmobile', N'Sevtelekom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25034', N'250', N'34', N'Krymtelekom', N'Krymtelekom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25035', N'250', N'35', N'MOTIV', N'EKATERINBURG-2000', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25038', N'250', N'38', N'Tambov GSM', N'Central Telecommunication Company', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25039', N'250', N'39', N'Rostelecom', N'ROSTELECOM', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25040', N'250', N'40', N'VTC Mobile', N'Voentelecom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25044', N'250', N'44', null, N'Stavtelesot / North Caucasian GSM', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25045', N'250', N'45', N'Gazprombank Mobile', N'PJSC New Mobile Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25050', N'250', N'50', N'SberMobile', N'Sberbank-Telecom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25054', N'250', N'54', N'TTK', N'Tattelecom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25059', N'250', N'59', N'WireFire', N'NetbyNet', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25060', N'250', N'60', N'Volna mobile', N'KTK Telecom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25061', N'250', N'61', N'Intertelecom', N'Intertelecom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25062', N'250', N'62', N'Tinkoff Mobile', N'Tinkoff Mobile', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'250811', N'250', N'811', null, N'Votek Mobile', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25091', N'250', N'91', N'Sonic Duo', N'Sonic Duo CJSC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25092', N'250', N'92', null, N'Primtelefon', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25093', N'250', N'93', null, N'Telecom XXI', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25096', N'250', N'96', N'+7Telecom', N'K-Telecom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25097', N'250', N'97', N'Phoenix', N'State Unitary Enterprise of DPR "Republican Telecommunications Operator"', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25099', N'250', N'99', N'Beeline', N'OJSC Vimpel-Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'MD', N'Moldova', N'25500', N'255', N'00', N'IDC', N'Interdnestrcom', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'UA', N'Ukraine', N'25501', N'255', N'01', N'Vodafone', N'PRJSC "VF Ukraine"', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'UA', N'Ukraine', N'25502', N'255', N'02', N'Kyivstar', N'PRJSC "Kyivstar"', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'UA', N'Ukraine', N'25503', N'255', N'03', N'Kyivstar', N'PRJSC "Kyivstar"', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'UA', N'Ukraine', N'25504', N'255', N'04', N'Intertelecom', N'Intertelecom LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'UA', N'Ukraine', N'25505', N'255', N'05', N'Kyivstar', N'PRJSC "Kyivstar"', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'UA', N'Ukraine', N'25506', N'255', N'06', N'lifecell', N'lifecell LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'UA', N'Ukraine', N'25507', N'255', N'07', N'3Mob; Lycamobile', N'Trimob LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'UA', N'Ukraine', N'25508', N'255', N'08', null, N'JSC Ukrtelecom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'UA', N'Ukraine', N'25509', N'255', N'09', null, N'PRJSC "Farlep-Invest"', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'UA', N'Ukraine', N'25510', N'255', N'10', null, N'Atlantis Telecom LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'UA', N'Ukraine', N'25521', N'255', N'21', N'PEOPLEnet', N'PRJSC "Telesystems of Ukraine"', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'UA', N'Ukraine', N'25523', N'255', N'23', N'CDMA Ukraine', N'Intertelecom LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'UA', N'Ukraine', N'25525', N'255', N'25', N'NEWTONE', N'PRJSC "Telesystems of Ukraine"', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'UA', N'Ukraine', N'255701', N'255', N'701', null, N'Ukrainian Special Systems', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25598', N'255', N'98', N'MKS (ex. Lugacom)', N'OOO "MKS"', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'UA', N'Ukraine', N'25599', N'255', N'99', N'Phoenix; MKS (ex. Lugacom)', N'State Unitary Enterprise of DPR "Republican Telecommunications Operator"; OOO "MKS"', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'BY', N'Belarus', N'25701', N'257', N'01', N'A1', N'A1 Belarus', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'BY', N'Belarus', N'25702', N'257', N'02', N'MTS', N'Mobile TeleSystems', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'BY', N'Belarus', N'25703', N'257', N'03', N'DIALLOG', N'BelCel', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'BY', N'Belarus', N'25704', N'257', N'04', N'life:)', N'Belarusian Telecommunications Network', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'BY', N'Belarus', N'25705', N'257', N'05', N'byfly', N'Beltelecom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'BY', N'Belarus', N'25706', N'257', N'06', N'beCloud', N'Belorussian Cloud Technologies', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'MD', N'Moldova', N'25901', N'259', N'01', N'Orange', N'Orange Moldova', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'MD', N'Moldova', N'25902', N'259', N'02', N'Moldcell', N'Moldcell', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'MD', N'Moldova', N'25903', N'259', N'03', N'Moldtelecom', N'Moldtelecom', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'MD', N'Moldova', N'25904', N'259', N'04', N'Eventis', N'Eventis Telecom', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'MD', N'Moldova', N'25905', N'259', N'05', N'Moldtelecom', N'Moldtelecom', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'MD', N'Moldova', N'25915', N'259', N'15', N'IDC', N'Interdnestrcom', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'MD', N'Moldova', N'25999', N'259', N'99', N'Moldtelecom', N'Moldtelecom', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26001', N'260', N'01', N'Plus', N'Polkomtel Sp. z o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26002', N'260', N'02', N'T-Mobile', N'T-Mobile Polska S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26003', N'260', N'03', N'Orange', N'Orange Polska S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26004', N'260', N'04', N'Plus', N'Polkomtel Sp. z o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26005', N'260', N'05', N'Orange', N'Orange Polska S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26006', N'260', N'06', N'Play', N'P4 Sp. z o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26007', N'260', N'07', N'Netia', N'Netia S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26008', N'260', N'08', null, N'EXATEL S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26009', N'260', N'09', N'Lycamobile', N'Lycamobile Sp. z o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26010', N'260', N'10', N'T-Mobile', N'T-Mobile Polska S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26011', N'260', N'11', N'Plus', N'Polkomtel Sp. z o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26012', N'260', N'12', N'Cyfrowy Polsat', N'Cyfrowy Polsat S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26013', N'260', N'13', null, N'Move Telecom S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26014', N'260', N'14', null, N'Telco Leaders Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26015', N'260', N'15', N'Plus', N'Polkomtel Sp. z o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26016', N'260', N'16', N'Plus', N'Polkomtel Sp. z o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26017', N'260', N'17', N'Plus', N'Polkomtel Sp. z o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26018', N'260', N'18', N'AMD Telecom', N'AMD Telecom S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26019', N'260', N'19', null, N'SIA NetBalt', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26020', N'260', N'20', null, N'TISMI B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26021', N'260', N'21', null, N'private networks', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26022', N'260', N'22', null, N'Twilio Ireland Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26023', N'260', N'23', null, N'PGE Systemy S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26024', N'260', N'24', null, N'IT Partners Telco Sp. z o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26025', N'260', N'25', N'TeleCube.PL', N'Claude ICT Poland Sp. z o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26026', N'260', N'26', null, N'Vonage B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26027', N'260', N'27', null, N'SIA Ntel Solutions', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26028', N'260', N'28', null, N'CrossMobile Sp. z o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26029', N'260', N'29', null, N'SMSWIZARD POLSKA Sp. z o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26030', N'260', N'30', null, N'HXG Sp. z o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26031', N'260', N'31', N'Phone IT', N'Phone IT Sp. z o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26032', N'260', N'32', null, N'Compatel Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26033', N'260', N'33', N'Truphone', N'Truphone Poland Sp. z o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26034', N'260', N'34', N'NetWorkS!', N'T-Mobile Polska S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26035', N'260', N'35', null, N'PKP Polskie Linie Kolejowe S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26036', N'260', N'36', N'Vectone Mobile', N'Mundio Mobile', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26037', N'260', N'37', null, N'NEXTGEN MOBILE LTD', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26038', N'260', N'38', null, N'CALLFREEDOM Sp. z o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26039', N'260', N'39', N'Voxbone', N'VOXBONE SA', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26040', N'260', N'40', null, N'Interactive Digital Media GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26041', N'260', N'41', null, N'EZ PHONE MOBILE Sp. z o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26042', N'260', N'42', null, N'MobiWeb Telecom Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26043', N'260', N'43', null, N'Smart Idea International Sp. z o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26044', N'260', N'44', null, N'Rebtel Poland Sp. z o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26045', N'260', N'45', N'Virgin Mobile', N'P4 Sp. z o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26046', N'260', N'46', null, N'Terra Telekom Sp. z o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26047', N'260', N'47', null, N'SMShighway Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26048', N'260', N'48', null, N'AGILE TELECOM S.P.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26049', N'260', N'49', null, N'Messagebird B.V.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26090', N'260', N'90', null, N'Polska Spółka Gazownictwa Sp. z o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26097', N'260', N'97', null, N'Politechnika Łódzka Uczelniane Centrum Informatyczne', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PL', N'Poland', N'26098', N'260', N'98', N'Play', N'P4 Sp. z o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26201', N'262', N'01', N'Telekom', N'Telekom Deutschland GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26202', N'262', N'02', N'Vodafone', N'Vodafone D2 GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26203', N'262', N'03', N'O2', N'Telefónica Germany GmbH & Co. oHG', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26204', N'262', N'04', N'Vodafone', N'Vodafone D2 GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26205', N'262', N'05', N'O2', N'Telefónica Germany GmbH & Co. oHG', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26206', N'262', N'06', N'Telekom', N'Telekom Deutschland GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26207', N'262', N'07', N'O2', N'Telefónica Germany GmbH & Co. oHG', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26208', N'262', N'08', N'O2', N'Telefónica Germany GmbH & Co. oHG', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26209', N'262', N'09', N'Vodafone', N'Vodafone D2 GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26210', N'262', N'10', null, N'DB Netz AG', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26211', N'262', N'11', N'O2', N'Telefónica Germany GmbH & Co. oHG', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26212', N'262', N'12', N'Simquadrat', N'sipgate GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26213', N'262', N'13', N'BAAINBw', N'Bundesamt für Ausrüstung, Informationstechnik und Nutzung der Bundeswehr', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26214', N'262', N'14', null, N'Lebara Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26215', N'262', N'15', N'Airdata', null, 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26216', N'262', N'16', null, N'Telogic Germany GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26217', N'262', N'17', N'O2', N'Telefónica Germany GmbH & Co. oHG', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26218', N'262', N'18', null, N'NetCologne', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26219', N'262', N'19', N'450connect', N'Alliander AG', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26220', N'262', N'20', N'Enreach', N'Enreach Germany GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26221', N'262', N'21', null, N'Multiconnect GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26222', N'262', N'22', null, N'sipgate Wireless GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26223', N'262', N'23', N'1&1', N'Drillisch Online AG', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26224', N'262', N'24', null, N'TelcoVillage GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26225', N'262', N'25', null, N'MTEL Deutschland GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26233', N'262', N'33', N'simquadrat', N'sipgate GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26241', N'262', N'41', null, N'First Telecom GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26242', N'262', N'42', N'CCC Event', N'Chaos Computer Club', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26243', N'262', N'43', N'Lycamobile', N'Lycamobile', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26260', N'262', N'60', null, N'DB Telematik', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26270', N'262', N'70', null, N'BDBOS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26271', N'262', N'71', null, N'GSMK', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26272', N'262', N'72', null, N'Ericsson GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26273', N'262', N'73', null, N'Nokia', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26274', N'262', N'74', null, N'Ericsson GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26275', N'262', N'75', null, N'Core Network Dynamics GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26276', N'262', N'76', null, N'BDBOS', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26277', N'262', N'77', N'O2', N'Telefónica Germany GmbH & Co. oHG', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26278', N'262', N'78', N'Telekom', N'Telekom Deutschland GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26279', N'262', N'79', null, N'ng4T GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26292', N'262', N'92', null, N'Nash Technologies', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'26298', N'262', N'98', null, N'private networks', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GI', N'Gibraltar', N'26601', N'266', N'01', N'GibTel', N'Gibtelecom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GI', N'Gibraltar', N'26603', N'266', N'03', N'Gibfibrespeed', N'GibFibre Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GI', N'Gibraltar', N'26606', N'266', N'06', N'CTS Mobile', N'CTS Gibraltar', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GI', N'Gibraltar', N'26609', N'266', N'09', N'Shine', N'Eazitelecom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PT', N'Portugal', N'26801', N'268', N'01', N'Vodafone', N'Vodafone Portugal', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PT', N'Portugal', N'26802', N'268', N'02', null, N'Digi Portugal, Lda.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PT', N'Portugal', N'26803', N'268', N'03', N'NOS', N'NOS Comunicações', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PT', N'Portugal', N'26804', N'268', N'04', N'LycaMobile', N'LycaMobile', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PT', N'Portugal', N'26805', N'268', N'05', null, N'Oniway - Inforcomunicaçôes, S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PT', N'Portugal', N'26806', N'268', N'06', N'MEO', N'MEO - Serviços de Comunicações e Multimédia, S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PT', N'Portugal', N'26807', N'268', N'07', null, N'Sumamovil Portugal, S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PT', N'Portugal', N'26808', N'268', N'08', N'MEO', N'MEO - Serviços de Comunicações e Multimédia, S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PT', N'Portugal', N'26811', N'268', N'11', null, N'Compatel, Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PT', N'Portugal', N'26812', N'268', N'12', null, N'Infraestruturas de Portugal, S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PT', N'Portugal', N'26813', N'268', N'13', null, N'G9Telecom, S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PT', N'Portugal', N'26821', N'268', N'21', N'Zapp', N'Zapp Portugal', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PT', N'Portugal', N'26880', N'268', N'80', N'MEO', N'MEO - Serviços de Comunicações e Multimédia, S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PT', N'Portugal', N'26891', N'268', N'91', N'Vodafone', N'Vodafone Portugal', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PT', N'Portugal', N'26893', N'268', N'93', N'NOS', N'NOS Comunicações', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LU', N'Luxembourg', N'27001', N'270', N'01', N'POST', N'POST Luxembourg', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LU', N'Luxembourg', N'27002', N'270', N'02', null, N'MTX Connect S.a.r.l.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LU', N'Luxembourg', N'27005', N'270', N'05', null, N'Luxembourg Online S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LU', N'Luxembourg', N'27007', N'270', N'07', null, N'Bouygues Telecom S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LU', N'Luxembourg', N'27010', N'270', N'10', null, N'Blue Communications', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LU', N'Luxembourg', N'27071', N'270', N'71', N'CFL', N'Société Nationale des Chemins de Fer Luxembourgeois', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LU', N'Luxembourg', N'27078', N'270', N'78', null, N'Interactive digital media GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LU', N'Luxembourg', N'27079', N'270', N'79', null, N'Mitto AG', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LU', N'Luxembourg', N'27080', N'270', N'80', null, N'Syniverse Technologies S.à r.l.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LU', N'Luxembourg', N'27081', N'270', N'81', null, N'E-Lux Mobile Telecommunication S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IE', N'Ireland', N'27201', N'272', N'01', N'Vodafone', N'Vodafone Ireland', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IE', N'Ireland', N'27202', N'272', N'02', N'3', N'Hutchison 3G Ireland limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IE', N'Ireland', N'27203', N'272', N'03', N'Eir', N'Eir Group plc', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IE', N'Ireland', N'27204', N'272', N'04', null, N'Access Telecom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IE', N'Ireland', N'27205', N'272', N'05', N'3', N'Hutchison 3G Ireland limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IE', N'Ireland', N'27207', N'272', N'07', N'Eir', N'Eir Group plc', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IE', N'Ireland', N'27208', N'272', N'08', N'Eir', N'Eir Group plc', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IE', N'Ireland', N'27209', N'272', N'09', null, N'Clever Communications Ltd.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IE', N'Ireland', N'27211', N'272', N'11', N'Tesco Mobile', N'Liffey Telecom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IE', N'Ireland', N'27213', N'272', N'13', N'Lycamobile', N'Lycamobile', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IE', N'Ireland', N'27215', N'272', N'15', N'Virgin Mobile', N'UPC', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IE', N'Ireland', N'27216', N'272', N'16', N'Carphone Warehouse', N'Carphone Warehouse', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IE', N'Ireland', N'27217', N'272', N'17', N'3', N'Hutchison 3G Ireland limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IE', N'Ireland', N'27218', N'272', N'18', null, N'Cubic Telecom Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IE', N'Ireland', N'27221', N'272', N'21', null, N'Net Feasa Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IE', N'Ireland', N'27268', N'272', N'68', null, N'Office of the Government Chief Information Officer', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IS', N'Iceland', N'27401', N'274', N'01', N'Síminn', N'Iceland Telecom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IS', N'Iceland', N'27402', N'274', N'02', N'Vodafone', N'Sýn', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IS', N'Iceland', N'27403', N'274', N'03', N'Vodafone', N'Sýn', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IS', N'Iceland', N'27404', N'274', N'04', N'Viking', N'IMC Island ehf', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IS', N'Iceland', N'27405', N'274', N'05', null, N'Halló Frjáls fjarskipti hf.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IS', N'Iceland', N'27406', N'274', N'06', null, N'Núll níu ehf', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IS', N'Iceland', N'27407', N'274', N'07', N'IceCell', N'IceCell ehf', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IS', N'Iceland', N'27408', N'274', N'08', N'On-waves', N'Iceland Telecom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IS', N'Iceland', N'27411', N'274', N'11', N'Nova', N'Nova ehf', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IS', N'Iceland', N'27412', N'274', N'12', N'Tal', N'IP fjarskipti', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IS', N'Iceland', N'27416', N'274', N'16', null, N'Tismi BV', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IS', N'Iceland', N'27422', N'274', N'22', null, N'Landhelgisgæslan (Icelandic Coast Guard)', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IS', N'Iceland', N'27431', N'274', N'31', N'Síminn', N'Iceland Telecom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IS', N'Iceland', N'27491', N'274', N'91', null, N'Neyðarlínan', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'AL', N'Albania', N'27601', N'276', N'01', N'ONE', N'One Telecommunications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'AL', N'Albania', N'27602', N'276', N'02', N'Vodafone', N'Vodafone Albania', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'AL', N'Albania', N'27603', N'276', N'03', N'ALBtelecom', N'Albtelecom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'AL', N'Albania', N'27604', N'276', N'04', N'Plus Communication', N'Plus Communication', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'MT', N'Malta', N'27801', N'278', N'01', N'Epic', N'Epic', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'MT', N'Malta', N'27811', N'278', N'11', null, N'YOM Ltd.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'MT', N'Malta', N'27821', N'278', N'21', N'GO', N'Mobile Communications Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'MT', N'Malta', N'27830', N'278', N'30', N'GO', N'Mobile Communications Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'MT', N'Malta', N'27877', N'278', N'77', N'Melita', N'Melita', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'CY', N'Cyprus', N'28001', N'280', N'01', N'Cytamobile-Vodafone', N'Cyprus Telecommunications Authority', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'CY', N'Cyprus', N'28002', N'280', N'02', N'Cytamobile-Vodafone', N'Cyprus Telecommunications Authority', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'CY', N'Cyprus', N'28010', N'280', N'10', N'Epic', N'Monaco Telecom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'CY', N'Cyprus', N'28020', N'280', N'20', N'PrimeTel', N'PrimeTel PLC', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'CY', N'Cyprus', N'28022', N'280', N'22', N'lemontel', N'Lemontel Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'CY', N'Cyprus', N'28023', N'280', N'23', N'Vectone Mobile', N'Mundio Mobile Cyprus Ltd.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GE', N'Georgia', N'28201', N'282', N'01', N'Geocell', N'Silknet', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GE', N'Georgia', N'28202', N'282', N'02', N'Magti', N'MagtiCom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GE', N'Georgia', N'28203', N'282', N'03', N'MagtiFix', N'MagtiCom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GE', N'Georgia', N'28204', N'282', N'04', N'Beeline', N'Mobitel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GE', N'Georgia', N'28205', N'282', N'05', N'S1', N'Silknet', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GE', N'Georgia', N'28206', N'282', N'06', null, N'JSC Compatel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GE', N'Georgia', N'28207', N'282', N'07', N'GlobalCell', N'GlobalCell', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GE', N'Georgia', N'28208', N'282', N'08', N'Silk LTE', N'Silknet', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GE', N'Georgia', N'28209', N'282', N'09', null, N'Gmobile', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GE', N'Georgia', N'28210', N'282', N'10', null, N'Premium Net International SRL', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GE', N'Georgia', N'28211', N'282', N'11', null, N'Mobilive', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GE', N'Georgia', N'28212', N'282', N'12', null, N'Telecom1 Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GE', N'Georgia', N'28213', N'282', N'13', null, N'Asanet Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GE', N'Georgia', N'28214', N'282', N'14', N'DataCell', N'DataHouse Global', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GE', N'Georgia', N'28215', N'282', N'15', null, N'Servicebox Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GE', N'Georgia', N'28222', N'282', N'22', N'Myphone', N'Myphone Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AM', N'Armenia', N'28301', N'283', N'01', N'Beeline', N'Veon Armenia CJSC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AM', N'Armenia', N'28304', N'283', N'04', N'Karabakh Telecom', N'Karabakh Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AM', N'Armenia', N'28305', N'283', N'05', N'VivaCell-MTS', N'K Telecom CJSC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AM', N'Armenia', N'28310', N'283', N'10', N'Ucom', N'Ucom LLC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BG', N'Bulgaria', N'28401', N'284', N'01', N'A1 BG', N'A1 Bulgaria', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BG', N'Bulgaria', N'28403', N'284', N'03', N'Vivacom', N'BTC', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BG', N'Bulgaria', N'28405', N'284', N'05', N'Yettel', N'Yettel Bulgaria', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BG', N'Bulgaria', N'28407', N'284', N'07', N'НКЖИ', N'НАЦИОНАЛНА КОМПАНИЯ ЖЕЛЕЗОПЪТНА ИНФРАСТРУКТУРА', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BG', N'Bulgaria', N'28409', N'284', N'09', null, N'COMPATEL LIMITED', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BG', N'Bulgaria', N'28411', N'284', N'11', null, N'Bulsatcom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BG', N'Bulgaria', N'28413', N'284', N'13', N'Ти.ком', N'Ti.com JSC', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'TR', N'Turkey', N'28601', N'286', N'01', N'Turkcell', N'Turkcell Iletisim Hizmetleri A.S.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'TR', N'Turkey', N'28602', N'286', N'02', N'Vodafone', N'Vodafone Turkey', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'TR', N'Turkey', N'28603', N'286', N'03', N'Türk Telekom', N'Türk Telekom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'TR', N'Turkey', N'28604', N'286', N'04', N'Aycell', N'Aycell', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'FO', N'Faeroe Islands', N'28801', N'288', N'01', N'Føroya Tele', N'Føroya Tele', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'FO', N'Faeroe Islands', N'28802', N'288', N'02', N'Nema', N'Nema', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'FO', N'Faeroe Islands', N'28803', N'288', N'03', N'TOSA', N'Tosa Sp/F', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'GL', N'Greenland', N'29001', N'290', N'01', N'tusass', N'Tusass A/S', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'GL', N'Greenland', N'29002', N'290', N'02', N'Nanoq Media', N'inu:it a/s', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'GL', N'Greenland', N'29003', N'290', N'03', null, N'GTV Greenland', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'SM', N'San Marino', N'29201', N'292', N'01', N'PRIMA', N'San Marino Telecom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SI', N'Slovenia', N'29310', N'293', N'10', null, N'SŽ - Infrastruktura, d.o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SI', N'Slovenia', N'29311', N'293', N'11', null, N'BeeIN d.o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SI', N'Slovenia', N'29320', N'293', N'20', null, N'COMPATEL Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SI', N'Slovenia', N'29321', N'293', N'21', null, N'NOVATEL d.o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SI', N'Slovenia', N'29322', N'293', N'22', null, N'Mobile One Ltd.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SI', N'Slovenia', N'29340', N'293', N'40', N'A1 SI', N'A1 Slovenija', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SI', N'Slovenia', N'29341', N'293', N'41', N'Mobitel', N'Telekom Slovenije', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SI', N'Slovenia', N'29364', N'293', N'64', N'T-2', N'T-2 d.o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SI', N'Slovenia', N'29370', N'293', N'70', N'Telemach', N'Tušmobil d.o.o.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'SI', N'Slovenia', N'29386', N'293', N'86', null, N'ELEKTRO GORENJSKA, d.d', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'MK', N'Former Yugoslav Republic of Macedonia', N'29401', N'294', N'01', N'Telekom.mk', N'Makedonski Telekom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'MK', N'Former Yugoslav Republic of Macedonia', N'29402', N'294', N'02', N'one', N'one', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'MK', N'Former Yugoslav Republic of Macedonia', N'29403', N'294', N'03', N'A1 MK', N'A1 Macedonia DOOEL', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'MK', N'Former Yugoslav Republic of Macedonia', N'29404', N'294', N'04', N'Lycamobile', N'Lycamobile LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'MK', N'Former Yugoslav Republic of Macedonia', N'29410', N'294', N'10', null, N'WTI Macedonia', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'MK', N'Former Yugoslav Republic of Macedonia', N'29411', N'294', N'11', null, N'MOBIK TELEKOMUNIKACII DOOEL Skopje', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'MK', N'Former Yugoslav Republic of Macedonia', N'29412', N'294', N'12', null, N'MTEL DOOEL Skopje', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'LI', N'Liechtenstein', N'29501', N'295', N'01', N'Swisscom', N'Swisscom Schweiz AG', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LI', N'Liechtenstein', N'29502', N'295', N'02', N'7acht', N'Salt Liechtenstein AG', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LI', N'Liechtenstein', N'29505', N'295', N'05', N'FL1', N'Telecom Liechtenstein AG', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LI', N'Liechtenstein', N'29506', N'295', N'06', N'Cubic Telecom', N'Cubic Telecom AG', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LI', N'Liechtenstein', N'29507', N'295', N'07', null, N'First Mobile AG', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LI', N'Liechtenstein', N'29509', N'295', N'09', null, N'EMnify GmbH', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LI', N'Liechtenstein', N'29510', N'295', N'10', null, N'Soracom LI Ltd.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LI', N'Liechtenstein', N'29511', N'295', N'11', null, N'DIMOCO Messaging AG', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LI', N'Liechtenstein', N'29577', N'295', N'77', N'Alpmobil', N'Alpcom AG', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'ME', N'Montenegro', N'29701', N'297', N'01', N'One', N'Telenor Montenegro', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'ME', N'Montenegro', N'29702', N'297', N'02', N'telekom.me', N'Crnogorski Telekom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'ME', N'Montenegro', N'29703', N'297', N'03', N'm:tel', N'm:tel Crna Gora', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302100', N'302', N'100', N'dotmobile', N'Data on Tap Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302130', N'302', N'130', N'Xplore', N'Xplore Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302131', N'302', N'131', N'Xplore', N'Xplore Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302140', N'302', N'140', N'Fibernetics', N'Fibernetics Corp.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302150', N'302', N'150', null, N'Cogeco Connexion Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302151', N'302', N'151', null, N'Cogeco Connexion Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302152', N'302', N'152', null, N'Cogeco Connexion Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302220', N'302', N'220', N'Telus Mobility, Koodo Mobile, Public Mobile', N'Telus Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302221', N'302', N'221', N'Telus', N'Telus Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302222', N'302', N'222', N'Telus', N'Telus Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302230', N'302', N'230', null, N'ISP Telecom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302250', N'302', N'250', N'ALO', N'ALO Mobile Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302270', N'302', N'270', N'EastLink', N'Bragg Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302290', N'302', N'290', N'Airtel Wireless', N'Airtel Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302300', N'302', N'300', N'ECOTEL', N'Ecotel inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302310', N'302', N'310', N'ECOTEL', N'Ecotel inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302320', N'302', N'320', N'Rogers Wireless', N'Rogers Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302330', N'302', N'330', null, N'Blue Canada Wireless Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302340', N'302', N'340', N'Execulink', N'Execulink', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302350', N'302', N'350', null, N'Naskapi Imuun Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302360', N'302', N'360', N'MiKe', N'Telus Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302361', N'302', N'361', N'Telus', N'Telus Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302370', N'302', N'370', N'Fido', N'Fido Solutions (Rogers Wireless)', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            );

            insert into dm_dom_network_usage.itm_rel_network_provider_worldzone (
                country_cd
              , country_desc
              , network_provider_id
              , mcc
              , mnc
              , brand
              , operator
              , basic_service
              , worldzone_id
              , worldzone_desc
              , dm_load_date
              , dm_load_job_id
            )
            values (
                N'CA', N'Canada', N'302380', N'302', N'380', N'Keewaytinook Mobile', N'Keewaytinook Okimakanak Mobile', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302390', N'302', N'390', N'DMTS', N'Dryden Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302420', N'302', N'420', N'ABC', N'A.B.C. Allen Business Communications Ltd.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302480', N'302', N'480', N'Qiniq', N'SSi Connexions', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302490', N'302', N'490', N'Freedom Mobile', N'Shaw Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302491', N'302', N'491', N'Freedom Mobile', N'Shaw Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302500', N'302', N'500', N'Videotron', N'Videotron', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302510', N'302', N'510', N'Videotron', N'Videotron', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302520', N'302', N'520', N'Rogers (Vidéotron MOCN)', N'Videotron', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302530', N'302', N'530', N'Keewaytinook Mobile', N'Keewaytinook Okimakanak Mobile', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302540', N'302', N'540', null, N'Rovvr Communications Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302550', N'302', N'550', null, N'Star Solutions International Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302560', N'302', N'560', N'Lynx Mobility', N'Lynx Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302570', N'302', N'570', null, N'Ligado Networks Corp.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302590', N'302', N'590', N'Quadro Mobility', N'Quadro Communications Co-op', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302600', N'302', N'600', null, N'Iristel', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302610', N'302', N'610', N'Bell Mobility', N'Bell Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302620', N'302', N'620', N'ICE Wireless', N'ICE Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302630', N'302', N'630', N'Aliant Mobility', N'Bell Aliant', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302640', N'302', N'640', N'Bell', N'Bell Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302650', N'302', N'650', N'TBaytel', N'Thunder Bay Telephone', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302652', N'302', N'652', null, N'BC Tel Mobility (Telus)', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302653', N'302', N'653', N'Telus', N'Telus Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302655', N'302', N'655', N'MTS', N'Bell MTS', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302656', N'302', N'656', N'TBay', N'Thunder Bay Telephone Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302657', N'302', N'657', N'Telus', N'Telus Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302660', N'302', N'660', N'MTS', N'Bell MTS', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302670', N'302', N'670', N'CityTel Mobility', N'CityWest', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302680', N'302', N'680', N'SaskTel', N'SaskTel Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302681', N'302', N'681', N'SaskTel', N'SaskTel Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302690', N'302', N'690', N'Bell', N'Bell Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302701', N'302', N'701', null, N'MB Tel Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302702', N'302', N'702', null, N'MT&T Mobility (Aliant)', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302703', N'302', N'703', null, N'New Tel Mobility (Aliant)', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302710', N'302', N'710', N'Globalstar', null, 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302720', N'302', N'720', N'Rogers Wireless', N'Rogers Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302721', N'302', N'721', N'Rogers Wireless', N'Rogers Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302730', N'302', N'730', N'TerreStar Solutions', N'TerreStar Networks', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302740', N'302', N'740', N'Shaw Telecom', N'Shaw Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302750', N'302', N'750', N'SaskTel', N'SaskTel Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302760', N'302', N'760', N'Public Mobile', N'Telus Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302770', N'302', N'770', N'TNW Wireless', N'TNW Wireless Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302780', N'302', N'780', N'SaskTel', N'SaskTel Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302781', N'302', N'781', N'SaskTel', N'SaskTel Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302790', N'302', N'790', null, N'NetSet Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302820', N'302', N'820', N'Rogers Wireless', N'Rogers Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302848', N'302', N'848', null, N'Vocom International Telecommunications, Inc', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302860', N'302', N'860', N'Telus', N'Telus Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302880', N'302', N'880', N'Bell / Telus / SaskTel', N'Shared Telus, Bell, and SaskTel', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302910', N'302', N'910', null, N'Halton Regional Police Service', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302920', N'302', N'920', N'Rogers Wireless', N'Rogers Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302940', N'302', N'940', N'Wightman Mobility', N'Wightman Telecom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302990', N'302', N'990', null, N'Ericsson Canada', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302991', N'302', N'991', null, N'Halton Regional Police Service', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302996', N'302', N'996', null, N'Powertech Labs', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302997', N'302', N'997', null, N'Powertech Labs', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'CA', N'Canada', N'302998', N'302', N'998', null, N'Institut de Recherche d’Hydro-Québec', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'PM', N'Saint Pierre and Miquelon', N'30801', N'308', N'01', N'Ameris', N'St. Pierre-et-Miquelon Télécom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PM', N'Saint Pierre and Miquelon', N'30802', N'308', N'02', N'GLOBALTEL', N'GLOBALTEL', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PM', N'Saint Pierre and Miquelon', N'30803', N'308', N'03', N'Ameris', N'St. Pierre-et-Miquelon Télécom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310004', N'310', N'004', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310005', N'310', N'005', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310006', N'310', N'006', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310010', N'310', N'010', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310012', N'310', N'012', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310013', N'310', N'013', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310014', N'310', N'014', null, null, 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310015', N'310', N'015', N'Southern LINC', N'Southern Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310016', N'310', N'016', N'AT&T', N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310020', N'310', N'020', N'Union Wireless', N'Union Telephone Company', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310030', N'310', N'030', N'AT&T', N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310034', N'310', N'034', N'Airpeak', N'Airpeak', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310035', N'310', N'035', N'ETEX Wireless', N'ETEX Communications, LP', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310040', N'310', N'040', N'MTA', N'Matanuska Telephone Association, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310050', N'310', N'050', N'GCI', N'Alaska Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310053', N'310', N'053', N'Virgin Mobile', N'T-Mobile US', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310054', N'310', N'054', null, N'Alltel US', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310060', N'310', N'060', null, N'Consolidated Telcom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310066', N'310', N'066', N'U.S. Cellular', N'U.S. Cellular', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310070', N'310', N'070', N'AT&T', N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310080', N'310', N'080', N'AT&T', N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310090', N'310', N'090', N'AT&T', N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310100', N'310', N'100', N'Plateau Wireless', N'New Mexico RSA 4 East LP', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310130', N'310', N'130', N'Carolina West Wireless', N'Carolina West Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310150', N'310', N'150', N'AT&T', N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310160', N'310', N'160', N'T-Mobile', N'T-Mobile US', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310170', N'310', N'170', N'AT&T', N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310180', N'310', N'180', N'West Central', N'West Central Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310190', N'310', N'190', N'GCI', N'Alaska Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310200', N'310', N'200', null, N'T-Mobile', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310210', N'310', N'210', null, N'T-Mobile', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310220', N'310', N'220', null, N'T-Mobile', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310230', N'310', N'230', null, N'T-Mobile', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310240', N'310', N'240', null, N'T-Mobile', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310250', N'310', N'250', null, N'T-Mobile', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310270', N'310', N'270', null, N'T-Mobile', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310290', N'310', N'290', N'nep', N'NEP Cellcorp Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310300', N'310', N'300', N'Big Sky Mobile', N'iSmart Mobile, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310310', N'310', N'310', null, N'T-Mobile', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310311', N'310', N'311', null, N'Farmers Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310320', N'310', N'320', N'Cellular One', N'Smith Bagley, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310330', N'310', N'330', null, N'Wireless Partners, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310340', N'310', N'340', N'Limitless Mobile', N'Limitless Mobile, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310350', N'310', N'350', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310360', N'310', N'360', N'Pioneer Cellular', N'Cellular Network Partnership', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310380', N'310', N'380', N'AT&T', N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310390', N'310', N'390', N'Cellular One of East Texas', N'TX-11 Acquisition, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310420', N'310', N'420', N'Cincinnati Bell', N'Cincinnati Bell Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310430', N'310', N'430', N'GCI', N'GCI Communications Corp.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310440', N'310', N'440', null, N'Numerex', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310450', N'310', N'450', N'Viaero', N'Viaero Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310460', N'310', N'460', N'Conecto', N'NewCore Wireless LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310490', N'310', N'490', null, N'T-Mobile', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310500', N'310', N'500', N'Alltel', N'Public Service Cellular Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310510', N'310', N'510', N'Cellcom', N'Nsight', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310520', N'310', N'520', N'TNS', N'Transaction Network Services', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310530', N'310', N'530', null, N'T-Mobile', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310540', N'310', N'540', N'Phoenix', N'Hilliary Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310550', N'310', N'550', null, N'Syniverse Technologies', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310560', N'310', N'560', N'AT&T', N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310570', N'310', N'570', null, N'Broadpoint, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310580', N'310', N'580', null, N'Inland Cellular Telephone Company', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'BM', N'Bermuda', N'31059', N'310', N'59', N'Cellular One', null, 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310590', N'310', N'590', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310591', N'310', N'591', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310592', N'310', N'592', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310593', N'310', N'593', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310594', N'310', N'594', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310595', N'310', N'595', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310596', N'310', N'596', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310597', N'310', N'597', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310598', N'310', N'598', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310599', N'310', N'599', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310600', N'310', N'600', N'Cellcom', N'NewCell Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310610', N'310', N'610', null, N'Mavenir Systems Inc', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310620', N'310', N'620', N'Cellcom', N'Nsighttel Wireless LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310630', N'310', N'630', N'Choice Wireless', N'Commnet Wireless LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310640', N'310', N'640', null, N'Numerex', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310650', N'310', N'650', N'Jasper', N'Jasper Technologies', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310660', N'310', N'660', N'T-Mobile', null, 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310670', N'310', N'670', N'AT&T', N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310680', N'310', N'680', N'AT&T', N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310690', N'310', N'690', N'Limitless Mobile', N'Limitless Mobile, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310700', N'310', N'700', N'Bigfoot Cellular', N'Cross Valiant Cellular Partnership', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310710', N'310', N'710', N'ASTAC', N'Arctic Slope Telephone Association Cooperative', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310720', N'310', N'720', null, N'Syniverse Technologies', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310730', N'310', N'730', N'U.S. Cellular', N'U.S. Cellular', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310740', N'310', N'740', N'Viaero', N'Viaero Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310750', N'310', N'750', N'Appalachian Wireless', N'East Kentucky Network, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310760', N'310', N'760', null, N'Lynch 3G Communications Corporation', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310770', N'310', N'770', null, N'T-Mobile', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310780', N'310', N'780', N'Dispatch Direct', N'D. D. Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310790', N'310', N'790', N'BLAZE', N'PinPoint Communications Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310800', N'310', N'800', null, N'T-Mobile', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310810', N'310', N'810', null, N'Pacific Lightwave Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310820', N'310', N'820', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310830', N'310', N'830', N'T-Mobile', N'T-Mobile US', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310840', N'310', N'840', N'telna Mobile', N'Telecom North America Mobile, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310850', N'310', N'850', N'Aeris', N'Aeris Communications, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310860', N'310', N'860', N'Five Star Wireless', N'TX RSA 15B2, LP', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310870', N'310', N'870', N'PACE', N'Kaplan Telephone Company', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310880', N'310', N'880', N'DTC Wireless', N'Advantage Cellular Systems, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310890', N'310', N'890', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310891', N'310', N'891', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310892', N'310', N'892', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310893', N'310', N'893', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310894', N'310', N'894', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310895', N'310', N'895', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310896', N'310', N'896', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310897', N'310', N'897', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310898', N'310', N'898', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310899', N'310', N'899', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310900', N'310', N'900', N'Mid-Rivers Wireless', N'Cable & Communications Corporation', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310910', N'310', N'910', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310920', N'310', N'920', null, N'James Valley Wireless, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310930', N'310', N'930', null, N'Copper Valley Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310940', N'310', N'940', null, N'Tyntec Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310950', N'310', N'950', N'AT&T', N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310960', N'310', N'960', N'STRATA', N'UBET Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310970', N'310', N'970', null, N'Globalstar', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310980', N'310', N'980', N'Peoples Telephone', N'Texas RSA 7B3', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310990', N'310', N'990', N'Evolve Broadband', N'Evolve Cellular Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311000', N'311', N'000', N'West Central Wireless', N'Mid-Tex Cellular Ltd.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311010', N'311', N'010', N'Chariton Valley', N'Chariton Valley Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311012', N'311', N'012', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311020', N'311', N'020', N'Chariton Valley', N'Missouri RSA 5 Partnership', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311030', N'311', N'030', N'Indigo Wireless', N'Americell PA 3 Partnership', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311040', N'311', N'040', N'Choice Wireless', N'Commnet Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311050', N'311', N'050', null, N'Thumb Cellular LP', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311060', N'311', N'060', null, N'Space Data Corporation', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311070', N'311', N'070', N'AT&T', N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311080', N'311', N'080', N'Pine Cellular', N'Pine Telephone Company', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311090', N'311', N'090', N'AT&T', N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311100', N'311', N'100', null, N'Nex-Tech Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311110', N'311', N'110', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311130', N'311', N'130', null, N'Black & Veatch', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311140', N'311', N'140', N'Bravado Wireless', N'Cross Telephone Company', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311150', N'311', N'150', null, N'Wilkes Cellular', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311160', N'311', N'160', null, N'Lightsquared L.P.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311170', N'311', N'170', null, N'Tampnet', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311180', N'311', N'180', N'AT&T', N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311190', N'311', N'190', N'AT&T', N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311200', N'311', N'200', null, N'Dish Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311210', N'311', N'210', null, N'Telnyx LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311220', N'311', N'220', N'U.S. Cellular', N'U.S. Cellular', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311230', N'311', N'230', N'C Spire', N'Cellular South Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311240', N'311', N'240', null, N'Cordova Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311260', N'311', N'260', N'T-Mobile', N'T-Mobile US', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311270', N'311', N'270', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311271', N'311', N'271', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311272', N'311', N'272', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311273', N'311', N'273', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311274', N'311', N'274', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311275', N'311', N'275', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311276', N'311', N'276', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311277', N'311', N'277', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311278', N'311', N'278', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311279', N'311', N'279', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311280', N'311', N'280', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311281', N'311', N'281', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311282', N'311', N'282', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311283', N'311', N'283', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311284', N'311', N'284', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311285', N'311', N'285', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311286', N'311', N'286', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311287', N'311', N'287', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311288', N'311', N'288', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311289', N'311', N'289', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311290', N'311', N'290', N'BLAZE', N'PinPoint Communications Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311300', N'311', N'300', null, N'Nexus Communications, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311310', N'311', N'310', N'NMobile', N'Leaco Rural Telephone Company Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311320', N'311', N'320', N'Choice Wireless', N'Commnet Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311330', N'311', N'330', N'Bug Tussel Wireless', N'Bug Tussel Wireless LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311340', N'311', N'340', null, N'Illinois Valley Cellular', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311350', N'311', N'350', N'Nemont', N'Sagebrush Cellular, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311360', N'311', N'360', null, N'Stelera Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311370', N'311', N'370', N'GCI Wireless', N'General Communication Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311380', N'311', N'380', null, N'New Dimension Wireless Ltd.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311390', N'311', N'390', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311400', N'311', N'400', null, null, 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311410', N'311', N'410', N'Chat Mobility', N'Iowa RSA No. 2 LP', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311420', N'311', N'420', N'NorthwestCell', N'Northwest Missouri Cellular LP', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311430', N'311', N'430', N'Chat Mobility', N'RSA 1 LP', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311440', N'311', N'440', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311450', N'311', N'450', N'PTCI', N'Panhandle Telecommunication Systems Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311460', N'311', N'460', null, N'Electric Imp Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311480', N'311', N'480', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311481', N'311', N'481', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311482', N'311', N'482', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311483', N'311', N'483', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311484', N'311', N'484', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311485', N'311', N'485', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311486', N'311', N'486', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311487', N'311', N'487', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311488', N'311', N'488', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311489', N'311', N'489', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311490', N'311', N'490', N'T-Mobile', N'T-Mobile US', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311500', N'311', N'500', null, N'Mosaic Telecom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311510', N'311', N'510', null, N'Ligado Networks', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311520', N'311', N'520', null, N'Lightsquared L.P.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311530', N'311', N'530', N'NewCore', N'NewCore Wireless LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311540', N'311', N'540', null, N'Coeur Rochester, Inc', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311550', N'311', N'550', N'Choice Wireless', N'Commnet Wireless LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311560', N'311', N'560', N'OTZ Cellular', N'OTZ Communications, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311570', N'311', N'570', null, N'Mediacom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311580', N'311', N'580', N'U.S. Cellular', N'U.S. Cellular', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311590', N'311', N'590', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311600', N'311', N'600', N'Limitless Mobile', N'Limitless Mobile, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311610', N'311', N'610', N'SRT Communications', N'North Dakota Network Co.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311620', N'311', N'620', null, N'TerreStar Networks, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311630', N'311', N'630', N'C Spire', N'Cellular South Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311640', N'311', N'640', N'Rock Wireless', N'Standing Rock Telecommunications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311650', N'311', N'650', N'United Wireless', N'United Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311660', N'311', N'660', N'Metro', N'Metro by T-Mobile', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311670', N'311', N'670', N'Pine Belt Wireless', N'Pine Belt Cellular Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311680', N'311', N'680', null, N'GreenFly LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311690', N'311', N'690', null, N'TeleBEEPER of New Mexico', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311700', N'311', N'700', null, N'Midwest Network Solutions Hub LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311710', N'311', N'710', null, N'Northeast Wireless Networks LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311720', N'311', N'720', null, N'MainePCS LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311730', N'311', N'730', null, N'Proximiti Mobility Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311740', N'311', N'740', null, N'Telalaska Cellular', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311750', N'311', N'750', N'ClearTalk', N'Flat Wireless LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311760', N'311', N'760', null, N'Edigen Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311770', N'311', N'770', null, N'Altiostar Networks, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311790', N'311', N'790', null, N'Coleman County Telephone Cooperative, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311800', N'311', N'800', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311810', N'311', N'810', null, N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311820', N'311', N'820', null, N'Sonus Networks', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311830', N'311', N'830', null, N'Thumb Cellular LP', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311840', N'311', N'840', N'Cellcom', N'Nsight', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311850', N'311', N'850', N'Cellcom', N'Nsight', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311860', N'311', N'860', N'STRATA', N'Uintah Basin Electronic Telecommunications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311870', N'311', N'870', N'T-Mobile', N'T-Mobile US', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311880', N'311', N'880', N'T-Mobile', N'T-Mobile US', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311882', N'311', N'882', N'T-Mobile', N'T-Mobile US', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311890', N'311', N'890', null, N'Globecomm Network Services Corporation', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311900', N'311', N'900', null, N'GigSky', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311910', N'311', N'910', N'MobileNation', N'SI Wireless LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311920', N'311', N'920', N'Chariton Valley', N'Missouri RSA 5 Partnership', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311930', N'311', N'930', null, N'Cox Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311940', N'311', N'940', N'T-Mobile', N'T-Mobile US', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311950', N'311', N'950', N'ETC', N'Enhanced Telecommmunications Corp.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311960', N'311', N'960', N'Lycamobile', N'Lycamobile USA Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311970', N'311', N'970', N'Big River Broadband', N'Big River Broadband, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311980', N'311', N'980', null, N'LigTel Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'311990', N'311', N'990', null, N'VTel Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312010', N'312', N'010', N'Chariton Valley', N'Chariton Valley Communications Corporation, Inc', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312020', N'312', N'020', null, N'Infrastructure Networks, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312030', N'312', N'030', N'Bravado Wireless', N'Cross Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312040', N'312', N'040', null, N'Custer Telephone Co-op (CTCI)', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312050', N'312', N'050', null, N'Fuego Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312060', N'312', N'060', null, N'CoverageCo', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312070', N'312', N'070', null, N'Adams Networks Inc', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312080', N'312', N'080', N'SyncSouth', N'South Georgia Regional Information Technology Authority', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312090', N'312', N'090', N'AT&T', N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312100', N'312', N'100', null, N'ClearSky Technologies, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312110', N'312', N'110', null, N'Texas Energy Network LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312120', N'312', N'120', N'Appalachian Wireless', N'East Kentucky Network, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312130', N'312', N'130', N'Appalachian Wireless', N'East Kentucky Network, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312140', N'312', N'140', N'Revol Wireless', N'Cleveland Unlimited, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312150', N'312', N'150', N'NorthwestCell', N'Northwest Missouri Cellular LP', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312160', N'312', N'160', N'Chat Mobility', N'RSA1 Limited Partnership', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312170', N'312', N'170', N'Chat Mobility', N'Iowa RSA No. 2 LP', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312180', N'312', N'180', null, N'Limitless Mobile LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312190', N'312', N'190', N'T-Mobile', N'T-Mobile US', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312200', N'312', N'200', null, N'Voyager Mobility LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312210', N'312', N'210', null, N'Aspenta International, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312220', N'312', N'220', N'Chariton Valley', N'Chariton Valley Communications Corporation, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312230', N'312', N'230', N'SRT Communications', N'North Dakota Network Co.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312240', N'312', N'240', N'Sprint', N'Sprint Corporation', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312250', N'312', N'250', N'T-Mobile', N'T-Mobile US', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312260', N'312', N'260', null, N'WorldCell Solutions LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312270', N'312', N'270', N'Pioneer Cellular', N'Cellular Network Partnership', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312280', N'312', N'280', N'Pioneer Cellular', N'Cellular Network Partnership', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312290', N'312', N'290', N'STRATA', N'Uintah Basin Electronic Telecommunications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312300', N'312', N'300', N'telna Mobile', N'Telecom North America Mobile, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312310', N'312', N'310', null, N'Clear Stream Communications, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312320', N'312', N'320', null, N'RTC Communications LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312330', N'312', N'330', N'Nemont', N'Nemont Communications, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312340', N'312', N'340', N'MTA', N'Matanuska Telephone Association, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312350', N'312', N'350', null, N'Triangle Communication System Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312360', N'312', N'360', null, N'Wes-Tex Telecommunications, Ltd.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312370', N'312', N'370', N'Choice Wireless', N'Commnet Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312380', N'312', N'380', null, N'Copper Valley Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312390', N'312', N'390', N'FTC Wireless', N'FTC Communications LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312400', N'312', N'400', N'Mid-Rivers Wireless', N'Mid-Rivers Telephone Cooperative', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312410', N'312', N'410', null, N'Eltopia Communications, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312420', N'312', N'420', null, N'Nex-Tech Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312430', N'312', N'430', null, N'Silver Star Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312440', N'312', N'440', null, N'Kajeet, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312450', N'312', N'450', null, N'Cable & Communications Corporation', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312460', N'312', N'460', null, N'Ketchikan Public Utilities (KPU)', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312470', N'312', N'470', N'Carolina West Wireless', N'Carolina West Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312480', N'312', N'480', N'Nemont', N'Sagebrush Cellular, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312490', N'312', N'490', null, N'TrustComm, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312500', N'312', N'500', null, N'AB Spectrum LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312510', N'312', N'510', null, N'WUE Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312520', N'312', N'520', null, N'ANIN', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312530', N'312', N'530', N'T-Mobile', N'T-Mobile US', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312540', N'312', N'540', null, N'Broadband In Hand LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312550', N'312', N'550', null, N'Great Plains Communications, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312560', N'312', N'560', null, N'NHLT Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312570', N'312', N'570', N'Blue Wireless', N'Buffalo-Lake Erie Wireless Systems Co., LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312580', N'312', N'580', null, N'Google LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312590', N'312', N'590', N'NMU', N'Northern Michigan University', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312600', N'312', N'600', N'Nemont', N'Sagebrush Cellular, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312610', N'312', N'610', null, N'ShawnTech Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312620', N'312', N'620', null, N'GlobeTouch Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312630', N'312', N'630', null, N'NetGenuity, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312640', N'312', N'640', N'Nemont', N'Sagebrush Cellular, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312650', N'312', N'650', null, N'Brightlink', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312660', N'312', N'660', N'nTelos', N'nTelos Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312670', N'312', N'670', N'FirstNet', N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312680', N'312', N'680', N'AT&T', N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312690', N'312', N'690', null, N'TGS, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312700', N'312', N'700', null, N'Wireless Partners, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312710', N'312', N'710', null, N'Great North Woods Wireless LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312720', N'312', N'720', N'Southern LINC', N'Southern Communications Services', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312730', N'312', N'730', null, N'Triangle Communication System Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312740', N'312', N'740', N'Locus Telecommunications', N'KDDI America, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312750', N'312', N'750', null, N'Artemis Networks LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312760', N'312', N'760', N'ASTAC', N'Arctic Slope Telephone Association Cooperative', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312770', N'312', N'770', N'Verizon', N'Verizon Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312780', N'312', N'780', null, N'Redzone Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312790', N'312', N'790', null, N'Gila Electronics', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312800', N'312', N'800', null, N'Cirrus Core Networks', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312810', N'312', N'810', N'BBCP', N'Bristol Bay Telephone Cooperative', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312820', N'312', N'820', null, N'Santel Communications Cooperative, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312830', N'312', N'830', null, N'Kings County Office of Education', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312840', N'312', N'840', null, N'South Georgia Regional Information Technology Authority', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312850', N'312', N'850', null, N'Onvoy Spectrum, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312860', N'312', N'860', N'ClearTalk', N'Flat Wireless, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312870', N'312', N'870', null, N'GigSky Mobile, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312880', N'312', N'880', null, N'Albemarle County Public Schools', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312890', N'312', N'890', null, N'Circle Gx', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312900', N'312', N'900', N'ClearTalk', N'Flat West Wireless, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312910', N'312', N'910', N'Appalachian Wireless', N'East Kentucky Network, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312920', N'312', N'920', null, N'Northeast Wireless Networks LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312930', N'312', N'930', null, N'Hewlett-Packard Communication Services, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312940', N'312', N'940', null, N'Webformix', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312950', N'312', N'950', null, N'Custer Telephone Co-op (CTCI)', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312960', N'312', N'960', null, N'M&A Technology, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312970', N'312', N'970', null, N'IOSAZ Intellectual Property LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312980', N'312', N'980', null, N'Mark Twain Communications Company', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'312990', N'312', N'990', N'Premier Broadband', N'Premier Holdings LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313000', N'313', N'000', null, N'Tennessee Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313010', N'313', N'010', N'Bravado Wireless', N'Cross Wireless LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313020', N'313', N'020', N'CTC Wireless', N'Cambridge Telephone Company Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313030', N'313', N'030', null, N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313040', N'313', N'040', N'NNTC Wireless', N'Nucla-Naturita Telephone Company', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313050', N'313', N'050', N'Breakaway Wireless', N'Manti Tele Communications Company, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313060', N'313', N'060', null, N'Country Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313061', N'313', N'061', null, N'Country Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313070', N'313', N'070', null, N'Midwest Network Solutions Hub LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313080', N'313', N'080', null, N'Speedwavz LLP', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313090', N'313', N'090', null, N'Vivint Wireless, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313100', N'313', N'100', N'FirstNet', N'AT&T FirstNet', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313110', N'313', N'110', N'FirstNet', N'AT&T FirstNet', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313120', N'313', N'120', N'FirstNet', N'AT&T FirstNet', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313130', N'313', N'130', N'FirstNet', N'AT&T FirstNet', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313140', N'313', N'140', N'FirstNet', N'AT&T FirstNet', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313150', N'313', N'150', N'FirstNet', N'700 MHz Public Safety Broadband', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313160', N'313', N'160', N'FirstNet', N'700 MHz Public Safety Broadband', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313170', N'313', N'170', N'FirstNet', N'700 MHz Public Safety Broadband', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313180', N'313', N'180', N'FirstNet', N'700 MHz Public Safety Broadband', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313190', N'313', N'190', N'FirstNet', N'700 MHz Public Safety Broadband', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313200', N'313', N'200', null, N'Mercury Network Corporation', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313210', N'313', N'210', N'AT&T', N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313220', N'313', N'220', null, N'Custer Telephone Co-op (CTCI)', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313230', N'313', N'230', null, N'Velocity Communications Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313240', N'313', N'240', N'Peak Internet', N'Fundamental Holdings, Corp.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313250', N'313', N'250', null, N'Imperial County Office of Education', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313260', N'313', N'260', null, N'Expeto Wireless Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313270', N'313', N'270', null, N'Blackstar Management', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313280', N'313', N'280', null, N'King Street Wireless, LP', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313290', N'313', N'290', null, N'Gulf Coast Broadband LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313300', N'313', N'300', null, N'Cambio WiFi of Delmarva, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313310', N'313', N'310', null, N'CAL.NET, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313320', N'313', N'320', null, N'Paladin Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313330', N'313', N'330', null, N'CenturyTel Broadband Services LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313340', N'313', N'340', N'Dish', N'Dish Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313350', N'313', N'350', N'Dish', N'Dish Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313360', N'313', N'360', N'Dish', N'Dish Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313370', N'313', N'370', null, N'Red Truck Wireless, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313380', N'313', N'380', null, N'OptimERA Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313390', N'313', N'390', null, N'Altice USA Wireless, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313400', N'313', N'400', null, N'Texoma Communications, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313410', N'313', N'410', null, N'pdvWireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313420', N'313', N'420', null, N'Hudson Valley Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313440', N'313', N'440', null, N'Arvig Enterprises, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313450', N'313', N'450', null, N'Spectrum Wireless Holdings, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313460', N'313', N'460', N'Mobi', N'Mobi, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313470', N'313', N'470', null, N'San Diego Gas & Electric Company', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313480', N'313', N'480', null, N'Ready Wireless, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313490', N'313', N'490', null, N'Puloli, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313500', N'313', N'500', null, N'Shelcomm, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313520', N'313', N'520', null, N'Florida Broadband, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313540', N'313', N'540', null, N'Nokia Innovations US LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313550', N'313', N'550', null, N'Mile High Networks LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313560', N'313', N'560', null, N'Transit Wireless LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313570', N'313', N'570', N'Pioneer Cellular', N'Cellular Network Partnership', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313580', N'313', N'580', null, N'Telecall Telecommunications Corp.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313590', N'313', N'590', N'Southern LINC', N'Southern Communications Services, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313600', N'313', N'600', null, N'ST Engineering iDirect', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313610', N'313', N'610', null, N'Crystal Automation Systems, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313620', N'313', N'620', null, N'OmniProphis Corporation', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313630', N'313', N'630', null, N'LICT  Corporation', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313640', N'313', N'640', null, N'Geoverse LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313650', N'313', N'650', null, N'Chevron USA, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313660', N'313', N'660', null, N'Hudson Valley Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313670', N'313', N'670', null, N'Hudson Valley Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313680', N'313', N'680', null, N'Hudson Valley Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313690', N'313', N'690', null, N'Shenandoah Cable Television, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313700', N'313', N'700', null, N'Ameren Services Company', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313710', N'313', N'710', null, N'Extent Systems', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313720', N'313', N'720', null, N'1st Point Communications, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313730', N'313', N'730', null, N'TruAccess Networks', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313740', N'313', N'740', null, N'RTO Wireless, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313750', N'313', N'750', N'ZipLink', N'CellTex Networks, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313760', N'313', N'760', null, N'Hologram, Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313770', N'313', N'770', null, N'Tango Networks', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313780', N'313', N'780', null, N'Windstream Holdings', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313800', N'313', N'800', null, N'Wireless Technologies of Nebraska', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313810', N'313', N'810', null, N'Watch Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313820', N'313', N'820', null, N'Inland Cellular Telephone Company', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313830', N'313', N'830', null, N'360 Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313840', N'313', N'840', null, N'CellBlox Acquisitions', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313850', N'313', N'850', null, N'Softcom Internet Communications, Inc', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313860', N'313', N'860', N'Nextlink', N'AMG Technology Investment Group', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313870', N'313', N'870', null, N'ElektraFi LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313880', N'313', N'880', null, N'Shuttle wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313890', N'313', N'890', N'TCOE', N'Tulare County Office of Education', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313900', N'313', N'900', null, N'Tribal Networks', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313910', N'313', N'910', null, N'San Diego Gas & Electric', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313920', N'313', N'920', null, N'JCI', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313930', N'313', N'930', N'Rock Wireless', N'Standing Rock Telecom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313940', N'313', N'940', null, N'Motorola Solutions', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313950', N'313', N'950', null, N'Cheyenne and Arapaho Development Group', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313960', N'313', N'960', null, N'Townes 5G, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313970', N'313', N'970', null, N'Tycrhron', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313980', N'313', N'980', null, N'Next Generation Application LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'313990', N'313', N'990', null, N'Ericsson US', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314010', N'314', N'010', null, N'Boingo Wireless Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314020', N'314', N'020', null, N'Spectrum Wireless Holdings, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314030', N'314', N'030', null, N'Baicells Technologies North America Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314060', N'314', N'060', null, N'Texas A&M University', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314070', N'314', N'070', null, N'Texas A&M University', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314080', N'314', N'080', null, N'Texas A&M University', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314090', N'314', N'090', null, N'Southern LINC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314200', N'314', N'200', null, N'XF Wireless Investments, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314210', N'314', N'210', null, N'Telecom Resource Center', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314220', N'314', N'220', null, N'Securus Technologies', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314230', N'314', N'230', null, N'Trace-Tek LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314240', N'314', N'240', null, N'XF Wireless Investments, LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314260', N'314', N'260', null, N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314270', N'314', N'270', null, N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314280', N'314', N'280', null, N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314290', N'314', N'290', null, N'Wave', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314300', N'314', N'300', null, N'Southern California Edison', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314310', N'314', N'310', null, N'Terranet', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314320', N'314', N'320', null, N'Agri-Valley Communications, Inc', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314330', N'314', N'330', null, N'FreedomFi', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314340', N'314', N'340', N'e/marconi', N'E-Marconi LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'315010', N'315', N'010', N'CBRS', N'Citizens Broadband Radio Service', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'316010', N'316', N'010', N'Nextel', N'Nextel Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'316011', N'316', N'011', N'Southern LINC', N'Southern Communications Services', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'PR', N'Puerto Rico', N'330000', N'330', N'000', N'Open Mobile', N'PR Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'PR', N'Puerto Rico', N'330110', N'330', N'110', N'Claro Puerto Rico', N'América Móvil', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'PR', N'Puerto Rico', N'330120', N'330', N'120', N'Open Mobile', N'PR Wireless', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'MX', N'Mexico', N'334001', N'334', N'001', null, N'Comunicaciones Digitales Del Norte, S.A. de C.V.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MX', N'Mexico', N'334010', N'334', N'010', N'AT&T', N'AT&T Mexico', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MX', N'Mexico', N'334020', N'334', N'020', N'Telcel', N'América Móvil', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MX', N'Mexico', N'334030', N'334', N'030', N'Movistar', N'Telefónica', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MX', N'Mexico', N'334040', N'334', N'040', N'Unefon', N'AT&T Mexico', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MX', N'Mexico', N'334050', N'334', N'050', N'AT&T / Unefon', N'AT&T Mexico', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MX', N'Mexico', N'334060', N'334', N'060', null, N'Servicios de Acceso Inalambrico, S.A. de C.V.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MX', N'Mexico', N'334066', N'334', N'066', null, N'Telefonos de México, S.A.B. de C.V.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MX', N'Mexico', N'334070', N'334', N'070', N'Unefon', N'AT&T Mexico', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MX', N'Mexico', N'334080', N'334', N'080', N'Unefon', N'AT&T Mexico', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MX', N'Mexico', N'334090', N'334', N'090', N'AT&T', N'AT&T Mexico', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MX', N'Mexico', N'334100', N'334', N'100', null, N'Telecomunicaciones de México', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MX', N'Mexico', N'334110', N'334', N'110', null, N'Maxcom Telecomunicaciones, S.A.B. de C.V.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MX', N'Mexico', N'334120', N'334', N'120', null, N'Quickly Phone, S.A. de C.V.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MX', N'Mexico', N'334130', N'334', N'130', null, N'ALESTRA SERVICIOS MÓVILES, S.A. DE C.V.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MX', N'Mexico', N'334140', N'334', N'140', N'Red Compartida', N'Altán Redes S.A.P.I. de C.V.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MX', N'Mexico', N'334150', N'334', N'150', N'Ultranet', N'Ultravisión, S.A. de C.V.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MX', N'Mexico', N'334160', N'334', N'160', null, N'Cablevisión Red, S.A. de C.V.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MX', N'Mexico', N'334170', N'334', N'170', null, N'Oxio Mobile, S.A. de C.V.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MX', N'Mexico', N'334180', N'334', N'180', N'FreedomPop', N'FREEDOMPOP MÉXICO, S.A. DE C.V.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MX', N'Mexico', N'334190', N'334', N'190', N'Viasat', N'VIASAT TECNOLOGÍA, S.A. DE C.V.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JM', N'Jamaica', N'338020', N'338', N'020', N'FLOW', N'LIME (Cable & Wireless)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JM', N'Jamaica', N'338040', N'338', N'040', N'Caricel', N'Symbiote Investment Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JM', N'Jamaica', N'338070', N'338', N'070', N'Claro', N'Oceanic Digital Jamaica Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JM', N'Jamaica', N'338080', N'338', N'080', null, N'Rock Mobile Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JM', N'Jamaica', N'338110', N'338', N'110', N'FLOW', N'Cable & Wireless Communications', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JM', N'Jamaica', N'338180', N'338', N'180', N'FLOW', N'Cable & Wireless Communications', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GF', N'French Guiana', N'34001', N'340', N'01', N'Orange', N'Orange Caraïbe Mobiles', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GF', N'French Guiana', N'34002', N'340', N'02', N'SFR Caraïbe', N'Outremer Telecom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GF', N'French Guiana', N'34011', N'340', N'11', null, N'Guyane Téléphone Mobile', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GF', N'French Guiana', N'34020', N'340', N'20', N'Digicel', N'DIGICEL Antilles Française Guyane', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BB', N'Barbados', N'342600', N'342', N'600', N'FLOW', N'LIME (formerly known as Cable & Wireless)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BB', N'Barbados', N'342646', N'342', N'646', null, N'KW Telecommunications Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BB', N'Barbados', N'342750', N'342', N'750', N'Digicel', N'Digicel (Barbados) Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BB', N'Barbados', N'342800', N'342', N'800', N'Ozone', N'Ozone Wireless Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BB', N'Barbados', N'342820', N'342', N'820', null, N'Neptune Communications Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AG', N'Antigua and Barbuda', N'344030', N'344', N'030', N'APUA', N'Antigua Public Utilities Authority', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AG', N'Antigua and Barbuda', N'344050', N'344', N'050', N'Digicel', N'Antigua Wireless Ventures Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AG', N'Antigua and Barbuda', N'344920', N'344', N'920', N'FLOW', N'Cable & Wireless Caribbean Cellular (Antigua) Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AG', N'Antigua and Barbuda', N'344930', N'344', N'930', null, N'AT&T Wireless', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KY', N'Cayman Islands', N'346001', N'346', N'001', N'Logic', N'WestTel Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KY', N'Cayman Islands', N'346050', N'346', N'050', N'Digicel', N'Digicel Cayman Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KY', N'Cayman Islands', N'346140', N'346', N'140', N'FLOW', N'Cable & Wireless (Cayman Islands) Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VG', N'British Virgin Islands', N'348170', N'348', N'170', N'FLOW', N'Cable & Wireless', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VG', N'British Virgin Islands', N'348370', N'348', N'370', null, N'BVI Cable TV Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VG', N'British Virgin Islands', N'348570', N'348', N'570', N'CCT Boatphone', N'Caribbean Cellular Telephone', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VG', N'British Virgin Islands', N'348770', N'348', N'770', N'Digicel', N'Digicel (BVI) Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BM', N'Bermuda', N'35000', N'350', N'00', N'One', N'Bermuda Digital Communications Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BM', N'Bermuda', N'350007', N'350', N'007', null, N'Paradise Mobile', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BM', N'Bermuda', N'35001', N'350', N'01', N'Digicel Bermuda', N'Telecommunications (Bermuda & West Indies) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BM', N'Bermuda', N'35002', N'350', N'02', N'Mobility', N'M3 Wireless', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BM', N'Bermuda', N'35005', N'350', N'05', null, N'Telecom Networks', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BM', N'Bermuda', N'35011', N'350', N'11', null, N'Deltronics', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BM', N'Bermuda', N'35015', N'350', N'15', null, N'FKB Net Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GD', N'Grenada', N'352030', N'352', N'030', N'Digicel', N'Digicel Grenada Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GD', N'Grenada', N'352110', N'352', N'110', N'FLOW', N'Cable & Wireless Grenada Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MS', N'Montserrat', N'354860', N'354', N'860', N'FLOW', N'Cable & Wireless', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KN', N'Saint Kitts and Nevis', N'356050', N'356', N'050', N'Digicel', N'Wireless Ventures (St Kitts-Nevis) Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KN', N'Saint Kitts and Nevis', N'356070', N'356', N'070', N'FLOW', N'UTS', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KN', N'Saint Kitts and Nevis', N'356110', N'356', N'110', N'FLOW', N'Cable & Wireless St. Kitts & Nevis Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LC', N'Saint Lucia', N'358110', N'358', N'110', N'FLOW', N'Cable &  Wireless', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VC', N'Saint Vincent and the Grenadines', N'360050', N'360', N'050', N'Digicel', N'Digicel (St. Vincent and the Grenadines) Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VC', N'Saint Vincent and the Grenadines', N'360100', N'360', N'100', N'Cingular Wireless', null, 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VC', N'Saint Vincent and the Grenadines', N'360110', N'360', N'110', N'FLOW', N'Cable & Wireless (St. Vincent & the Grenadines) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AW', N'Aruba', N'36301', N'363', N'01', N'SETAR', N'Servicio di Telecomunicacion di Aruba', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AW', N'Aruba', N'36302', N'363', N'02', N'Digicel', N'Digicel Aruba', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BS', N'The Bahamas', N'36439', N'364', N'39', N'BTC', N'The Bahamas Telecommunications Company Ltd (BaTelCo)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BS', N'The Bahamas', N'36449', N'364', N'49', N'Aliv', N'Cable Bahamas Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AI', N'Anguilla', N'365010', N'365', N'010', null, N'Digicel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AI', N'Anguilla', N'365840', N'365', N'840', N'FLOW', N'Cable & Wireless', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'DM', N'Dominica', N'366020', N'366', N'020', N'Digicel', N'Digicel Group Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'DM', N'Dominica', N'366110', N'366', N'110', N'FLOW', N'Cable &  Wireless', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CU', N'Cuba', N'36801', N'368', N'01', N'CUBACEL', N'Empresa de Telecomunicaciones de Cuba, SA', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'DO', N'Dominican Republic', N'37001', N'370', N'01', N'Altice', N'Altice Group', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'DO', N'Dominican Republic', N'37002', N'370', N'02', N'Claro', N'Compañía Dominicana de Teléfonos', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'DO', N'Dominican Republic', N'37003', N'370', N'03', N'Altice', N'Altice Group', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'DO', N'Dominican Republic', N'37004', N'370', N'04', N'Viva', N'Trilogy Dominicana, S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'DO', N'Dominican Republic', N'37005', N'370', N'05', N'Wind', N'WIND Telecom, S.A', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HT', N'Haiti', N'37201', N'372', N'01', N'Voila', N'Communication Cellulaire d''Haiti S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HT', N'Haiti', N'37202', N'372', N'02', N'Digicel', N'Unigestion Holding S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HT', N'Haiti', N'37203', N'372', N'03', N'Natcom', N'NATCOM S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TT', N'Trinidad and Tobago', N'37401', N'374', N'01', N'bmobile', N'TSTT', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TT', N'Trinidad and Tobago', N'37412', N'374', N'12', N'bmobile', N'TSTT', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TT', N'Trinidad and Tobago', N'374120', N'374', N'120', N'bmobile', N'TSTT', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TT', N'Trinidad and Tobago', N'374129', N'374', N'129', N'bmobile', N'TSTT', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TT', N'Trinidad and Tobago', N'37413', N'374', N'13', N'Digicel', N'Digicel (Trinidad & Tobago) Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TT', N'Trinidad and Tobago', N'374130', N'374', N'130', N'Digicel', N'Digicel (Trinidad & Tobago) Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TT', N'Trinidad and Tobago', N'374140', N'374', N'140', N'Laqtel', N'LaqTel Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TT', N'Trinidad and Tobago', N'37420', N'374', N'20', N'bmobile', N'TSTT', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TC', N'Turks and Caicos Islands', N'376350', N'376', N'350', N'FLOW', N'Cable & Wireless West Indies Ltd (Turks & Caicos)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TC', N'Turks and Caicos Islands', N'376351', N'376', N'351', N'Digicel', N'Digicel (Turks & Caicos) Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TC', N'Turks and Caicos Islands', N'376352', N'376', N'352', N'FLOW', N'Cable & Wireless West Indies Ltd (Turks & Caicos)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TC', N'Turks and Caicos Islands', N'376360', N'376', N'360', N'Digicel', N'Digicel (Turks & Caicos) Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AZ', N'Azerbaijan', N'40001', N'400', N'01', N'Azercell', null, 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AZ', N'Azerbaijan', N'40002', N'400', N'02', N'Bakcell', null, 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AZ', N'Azerbaijan', N'40003', N'400', N'03', N'FONEX', N'CATEL', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AZ', N'Azerbaijan', N'40004', N'400', N'04', N'Nar Mobile', N'Azerfon', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AZ', N'Azerbaijan', N'40005', N'400', N'05', null, N'Special State Protection Service of the Republic of Azerbaijan', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AZ', N'Azerbaijan', N'40006', N'400', N'06', N'Naxtel', N'Nakhtel LLC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KZ', N'Kazakhstan', N'40101', N'401', N'01', N'Beeline', N'KaR-Tel LLP', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KZ', N'Kazakhstan', N'40102', N'401', N'02', N'Kcell', N'Kcell JSC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KZ', N'Kazakhstan', N'40107', N'401', N'07', N'Altel', N'Altel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KZ', N'Kazakhstan', N'40108', N'401', N'08', N'Kazakhtelecom', null, 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KZ', N'Kazakhstan', N'40177', N'401', N'77', N'Tele2.kz', N'MTS', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BT', N'Bhutan', N'40211', N'402', N'11', N'B-Mobile', N'Bhutan Telecom Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BT', N'Bhutan', N'40217', N'402', N'17', N'B-Mobile', N'Bhutan Telecom Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BT', N'Bhutan', N'40277', N'402', N'77', N'TashiCell', N'Tashi InfoComm Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40401', N'404', N'01', N'Vi India', N'Haryana', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40402', N'404', N'02', N'AirTel', N'Punjab', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40403', N'404', N'03', N'AirTel', N'Himachal Pradesh', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40404', N'404', N'04', N'Vi India', N'Delhi & NCR', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40405', N'404', N'05', N'Vi India', N'Gujarat', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40407', N'404', N'07', N'Vi India', N'Andhra Pradesh and Telangana', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40409', N'404', N'09', N'Reliance', N'Assam', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40410', N'404', N'10', N'AirTel', N'Delhi & NCR', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40411', N'404', N'11', N'Vi India', N'Delhi & NCR', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40412', N'404', N'12', N'Vi India', N'Haryana', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40413', N'404', N'13', N'Vi India', N'Andhra Pradesh and Telangana', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40414', N'404', N'14', N'Vi India', N'Punjab', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40415', N'404', N'15', N'Vi India', N'Uttar Pradesh (East)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40416', N'404', N'16', N'Airtel', N'North East', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40417', N'404', N'17', N'AIRCEL', N'West Bengal', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40418', N'404', N'18', N'Reliance', N'Himachal Pradesh', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40419', N'404', N'19', N'Vi India', N'Kerala', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40420', N'404', N'20', N'Vi India', N'Mumbai', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40421', N'404', N'21', N'Loop Mobile', N'Mumbai', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40422', N'404', N'22', N'Vi India', N'Maharashtra & Goa', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40423', N'404', N'23', N'Reliance', N'West Bengal', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40424', N'404', N'24', N'Vi India', N'Gujarat', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40425', N'404', N'25', N'AIRCEL', N'Bihar', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40427', N'404', N'27', N'Vi India', N'Maharashtra & Goa', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40428', N'404', N'28', N'AIRCEL', N'Odisha', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40429', N'404', N'29', N'AIRCEL', N'Assam', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40430', N'404', N'30', N'Vi India', N'Kolkata', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40431', N'404', N'31', N'AirTel', N'Kolkata', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40434', N'404', N'34', N'BSNL Mobile', N'Haryana', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40435', N'404', N'35', N'Aircel', N'Himachal Pradesh', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40436', N'404', N'36', N'Reliance', N'Bihar & Jharkhand', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40437', N'404', N'37', N'Aircel', N'Jammu & Kashmir', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40438', N'404', N'38', N'BSNL Mobile', N'Assam', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40440', N'404', N'40', N'AirTel', N'Chennai', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40441', N'404', N'41', N'Aircel', N'Chennai', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40442', N'404', N'42', N'Aircel', N'Tamil Nadu', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40443', N'404', N'43', N'Vi India', N'Tamil Nadu', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40444', N'404', N'44', N'Vi India', N'Karnataka', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40445', N'404', N'45', N'Airtel', N'Karnataka', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40446', N'404', N'46', N'Vi India', N'Kerala', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40448', N'404', N'48', N'Dishnet Wireless', N'Unknown', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40449', N'404', N'49', N'Airtel', N'Andhra Pradesh and Telangana', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40450', N'404', N'50', N'Reliance', N'North East', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40451', N'404', N'51', N'BSNL Mobile', N'Himachal Pradesh', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40452', N'404', N'52', N'Reliance', N'Odisha', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40453', N'404', N'53', N'BSNL Mobile', N'Punjab', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40454', N'404', N'54', N'BSNL Mobile', N'Uttar Pradesh (West)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40455', N'404', N'55', N'BSNL Mobile', N'Uttar Pradesh (East)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40456', N'404', N'56', N'Vi India', N'Uttar Pradesh (West)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40457', N'404', N'57', N'BSNL Mobile', N'Gujarat', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40458', N'404', N'58', N'BSNL Mobile', N'Madhya Pradesh & Chhattisgarh', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40459', N'404', N'59', N'BSNL Mobile', N'Rajasthan', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40460', N'404', N'60', N'Vi India', N'Rajasthan', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40462', N'404', N'62', N'BSNL Mobile', N'Jammu & Kashmir', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40464', N'404', N'64', N'BSNL Mobile', N'Chennai', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40466', N'404', N'66', N'BSNL Mobile', N'Maharashtra & Goa', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40467', N'404', N'67', N'Reliance', N'Madhya Pradesh & Chhattisgarh', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40468', N'404', N'68', N'MTNL', N'Delhi & NCR', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40469', N'404', N'69', N'MTNL', N'Mumbai', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40470', N'404', N'70', N'AirTel', N'Rajasthan', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40471', N'404', N'71', N'BSNL Mobile', N'Karnataka (Bangalore)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40472', N'404', N'72', N'BSNL Mobile', N'Kerala', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40473', N'404', N'73', N'BSNL Mobile', N'Andhra Pradesh and Telangana', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40474', N'404', N'74', N'BSNL Mobile', N'West Bengal', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40475', N'404', N'75', N'BSNL Mobile', N'Bihar', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40476', N'404', N'76', N'BSNL Mobile', N'Odisha', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40477', N'404', N'77', N'BSNL Mobile', N'North East', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40478', N'404', N'78', N'Vi India', N'Madhya Pradesh & Chattishgarh', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40479', N'404', N'79', N'BSNL Mobile', N'Andaman Nicobar', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40480', N'404', N'80', N'BSNL Mobile', N'Tamil Nadu', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40481', N'404', N'81', N'BSNL Mobile', N'Kolkata', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40482', N'404', N'82', N'Vi India', N'Himachal Pradesh', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40483', N'404', N'83', N'Reliance', N'Kolkata', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40484', N'404', N'84', N'Vi India', N'Chennai', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40485', N'404', N'85', N'Reliance', N'West Bengal', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40486', N'404', N'86', N'Vi India', N'Karnataka', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40487', N'404', N'87', N'Vi India', N'Rajasthan', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40488', N'404', N'88', N'Vi India', N'Punjab', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40489', N'404', N'89', N'Vi India', N'Uttar Pradesh (East)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40490', N'404', N'90', N'AirTel', N'Maharashtra', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40491', N'404', N'91', N'AIRCEL', N'Kolkata', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40492', N'404', N'92', N'AirTel', N'Mumbai', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40493', N'404', N'93', N'AirTel', N'Madhya Pradesh', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40494', N'404', N'94', N'AirTel', N'Tamil Nadu', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40495', N'404', N'95', N'AirTel', N'Kerala', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40496', N'404', N'96', N'AirTel', N'Haryana', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40497', N'404', N'97', N'AirTel', N'Uttar Pradesh (West)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40498', N'404', N'98', N'AirTel', N'Gujarat', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40501', N'405', N'01', N'Reliance', N'Andhra Pradesh and Telangana', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405025', N'405', N'025', N'TATA DOCOMO', N'Andhra Pradesh and Telangana', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405026', N'405', N'026', N'TATA DOCOMO', N'Assam', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405027', N'405', N'027', N'TATA DOCOMO', N'Bihar/Jharkhand', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405028', N'405', N'028', N'TATA DOCOMO', N'Chennai', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405029', N'405', N'029', N'TATA DOCOMO', N'Delhi', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40503', N'405', N'03', N'Reliance', N'Bihar', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405030', N'405', N'030', N'TATA DOCOMO', N'Gujarat', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405031', N'405', N'031', N'TATA DOCOMO', N'Haryana', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405032', N'405', N'032', N'TATA DOCOMO', N'Himachal Pradesh', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405033', N'405', N'033', N'TATA DOCOMO', N'Jammu & Kashmir', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405034', N'405', N'034', N'TATA DOCOMO', N'Karnataka', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405035', N'405', N'035', N'TATA DOCOMO', N'Kerala', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405036', N'405', N'036', N'TATA DOCOMO', N'Kolkata', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405037', N'405', N'037', N'TATA DOCOMO', N'Maharashtra & Goa', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405038', N'405', N'038', N'TATA DOCOMO', N'Madhya Pradesh', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405039', N'405', N'039', N'TATA DOCOMO', N'Mumbai', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40504', N'405', N'04', N'Reliance', N'Chennai', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405041', N'405', N'041', N'TATA DOCOMO', N'Odisha', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405042', N'405', N'042', N'TATA DOCOMO', N'Punjab', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405043', N'405', N'043', N'TATA DOCOMO', N'Rajasthan', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405044', N'405', N'044', N'TATA DOCOMO', N'Tamil Nadu including Chennai', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405045', N'405', N'045', N'TATA DOCOMO', N'Uttar Pradesh (East)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405046', N'405', N'046', N'TATA DOCOMO', N'Uttar Pradesh (West) & Uttarakhand', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405047', N'405', N'047', N'TATA DOCOMO', N'West Bengal', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40505', N'405', N'05', N'Reliance', N'Delhi & NCR', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40506', N'405', N'06', N'Reliance', N'Gujarat', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40507', N'405', N'07', N'Reliance', N'Haryana', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40508', N'405', N'08', N'Reliance', N'Himachal Pradesh', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40509', N'405', N'09', N'Reliance', N'Jammu & Kashmir', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40510', N'405', N'10', N'Reliance', N'Karnataka', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40511', N'405', N'11', N'Reliance', N'Kerala', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40512', N'405', N'12', N'Reliance', N'Kolkata', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40513', N'405', N'13', N'Reliance', N'Maharashtra & Goa', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40514', N'405', N'14', N'Reliance', N'Madhya Pradesh', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40515', N'405', N'15', N'Reliance', N'Mumbai', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40517', N'405', N'17', N'Reliance', N'Odisha', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40518', N'405', N'18', N'Reliance', N'Punjab', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40519', N'405', N'19', N'Reliance', N'Rajasthan', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40520', N'405', N'20', N'Reliance', N'Tamil Nadu', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40521', N'405', N'21', N'Reliance', N'Uttar Pradesh (East)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40522', N'405', N'22', N'Reliance', N'Uttar Pradesh (West)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40523', N'405', N'23', N'Reliance', N'West Bengal', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40551', N'405', N'51', N'AirTel', N'West Bengal', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40552', N'405', N'52', N'AirTel', N'Bihar & Jharkhand', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40553', N'405', N'53', N'AirTel', N'Odisha', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40554', N'405', N'54', N'AirTel', N'Uttar Pradesh (East)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40555', N'405', N'55', N'Airtel', N'Jammu & Kashmir', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40556', N'405', N'56', N'AirTel', N'Assam', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40566', N'405', N'66', N'Vi India', N'Uttar Pradesh (West)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40567', N'405', N'67', N'Vi India', N'West Bengal', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'40570', N'405', N'70', N'Vi India', N'Bihar & Jharkhand', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405750', N'405', N'750', N'Vi India', N'Jammu & Kashmir', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405751', N'405', N'751', N'Vi India', N'Assam', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405752', N'405', N'752', N'Vi India', N'Bihar & Jharkhand', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405753', N'405', N'753', N'Vi India', N'Odisha', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405754', N'405', N'754', N'Vi India', N'Himachal Pradesh', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405755', N'405', N'755', N'Vi India', N'North East', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405756', N'405', N'756', N'Vi India', N'Madhya Pradesh & Chhattisgarh', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405799', N'405', N'799', N'Vi India', N'Mumbai', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405800', N'405', N'800', N'AIRCEL', N'Delhi & NCR', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405801', N'405', N'801', N'AIRCEL', N'Andhra Pradesh and Telangana', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405802', N'405', N'802', N'AIRCEL', N'Gujarat', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405803', N'405', N'803', N'AIRCEL', N'Karnataka', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405804', N'405', N'804', N'AIRCEL', N'Maharashtra & Goa', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405805', N'405', N'805', N'AIRCEL', N'Mumbai', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405806', N'405', N'806', N'AIRCEL', N'Rajasthan', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405807', N'405', N'807', N'AIRCEL', N'Haryana', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405808', N'405', N'808', N'AIRCEL', N'Madhya Pradesh', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405809', N'405', N'809', N'AIRCEL', N'Kerala', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405810', N'405', N'810', N'AIRCEL', N'Uttar Pradesh (East)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405811', N'405', N'811', N'AIRCEL', N'Uttar Pradesh (West)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405812', N'405', N'812', N'AIRCEL', N'Punjab', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405818', N'405', N'818', N'Uninor', N'Uttar Pradesh (West)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405819', N'405', N'819', N'Uninor', N'Andhra Pradesh and Telangana', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405820', N'405', N'820', N'Uninor', N'Karnataka', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405821', N'405', N'821', N'Uninor', N'Kerala', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405822', N'405', N'822', N'Uninor', N'Kolkata', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405824', N'405', N'824', N'Videocon Telecom', N'Assam', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405827', N'405', N'827', N'Videocon Telecom', N'Gujarat', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405834', N'405', N'834', N'Videocon Telecom', N'Madhya Pradesh', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405840', N'405', N'840', N'Jio', N'West Bengal', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405844', N'405', N'844', N'Uninor', N'Delhi & NCR', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405845', N'405', N'845', N'Vi India', N'Assam', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405846', N'405', N'846', N'Vi India', N'Jammu & Kashmir', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405847', N'405', N'847', N'Vi India', N'Karnataka', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405848', N'405', N'848', N'Vi India', N'Kolkata', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405849', N'405', N'849', N'Vi India', N'North East', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405850', N'405', N'850', N'Vi India', N'Odisha', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405851', N'405', N'851', N'Vi India', N'Punjab', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405852', N'405', N'852', N'Vi India', N'Tamil Nadu', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405853', N'405', N'853', N'Vi India', N'West Bengal', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405854', N'405', N'854', N'Jio', N'Andhra Pradesh', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405855', N'405', N'855', N'Jio', N'Assam', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405856', N'405', N'856', N'Jio', N'Bihar', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405857', N'405', N'857', N'Jio', N'Gujarat', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405858', N'405', N'858', N'Jio', N'Haryana', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405859', N'405', N'859', N'Jio', N'Himachal Pradesh', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405860', N'405', N'860', N'Jio', N'Jammu & Kashmir', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405861', N'405', N'861', N'Jio', N'Karnataka', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405862', N'405', N'862', N'Jio', N'Kerala', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405863', N'405', N'863', N'Jio', N'Madhya Pradesh', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405864', N'405', N'864', N'Jio', N'Maharashtra', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405865', N'405', N'865', N'Jio', N'North East', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405866', N'405', N'866', N'Jio', N'Odisha', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405867', N'405', N'867', N'Jio', N'Punjab', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405868', N'405', N'868', N'Jio', N'Rajasthan', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405869', N'405', N'869', N'Jio', N'Tamil Nadu (incl. Chennai)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405870', N'405', N'870', N'Jio', N'Uttar Pradesh (West)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405871', N'405', N'871', N'Jio', N'Uttar Pradesh (East)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405872', N'405', N'872', N'Jio', N'Delhi', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405873', N'405', N'873', N'Jio', N'Kolkata', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405874', N'405', N'874', N'Jio', N'Mumbai', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405875', N'405', N'875', N'Uninor', N'Assam', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405880', N'405', N'880', N'Uninor', N'West Bengal', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405881', N'405', N'881', N'S Tel', N'Assam', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405908', N'405', N'908', N'Vi India', N'Andhra Pradesh and Telangana', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405909', N'405', N'909', N'Vi India', N'Delhi', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405910', N'405', N'910', N'Vi India', N'Haryana', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405911', N'405', N'911', N'Vi India', N'Maharashtra', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405912', N'405', N'912', N'Etisalat DB (cheers)', N'Andhra Pradesh and Telangana', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405913', N'405', N'913', N'Etisalat DB (cheers)', N'Delhi & NCR', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405914', N'405', N'914', N'Etisalat DB (cheers)', N'Gujarat', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405917', N'405', N'917', N'Etisalat DB (cheers)', N'Kerala', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405927', N'405', N'927', N'Uninor', N'Gujarat', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IN', N'India', N'405929', N'405', N'929', N'Uninor', N'Maharashtra', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PK', N'Pakistan', N'41001', N'410', N'01', N'Jazz', N'Mobilink-PMCL', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PK', N'Pakistan', N'41002', N'410', N'02', N'3G EVO / CharJi 4G', N'PTCL', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PK', N'Pakistan', N'41003', N'410', N'03', N'Ufone', N'Pakistan Telecommunication Mobile Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PK', N'Pakistan', N'41004', N'410', N'04', N'Zong', N'China Mobile', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PK', N'Pakistan', N'41005', N'410', N'05', N'SCO Mobile', N'SCO Mobile Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PK', N'Pakistan', N'41006', N'410', N'06', N'Telenor', N'Telenor Pakistan', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PK', N'Pakistan', N'41007', N'410', N'07', N'Jazz', N'WaridTel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PK', N'Pakistan', N'41008', N'410', N'08', N'SCO Mobile', N'SCO Mobile Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AF', N'Afghanistan', N'41201', N'412', N'01', N'AWCC', N'Afghan Wireless Communication Company', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AF', N'Afghanistan', N'41220', N'412', N'20', N'Roshan', N'Telecom Development Company Afghanistan Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AF', N'Afghanistan', N'41240', N'412', N'40', N'MTN', N'MTN Group Afghanistan', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AF', N'Afghanistan', N'41250', N'412', N'50', N'Etisalat', N'Etisalat Afghanistan', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AF', N'Afghanistan', N'41255', N'412', N'55', N'WASEL', N'WASEL Afghanistan', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AF', N'Afghanistan', N'41280', N'412', N'80', N'Salaam', N'Afghan Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AF', N'Afghanistan', N'41288', N'412', N'88', N'Salaam', N'Afghan Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LK', N'Sri Lanka', N'41301', N'413', N'01', N'SLTMobitel', N'Mobitel (Pvt) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LK', N'Sri Lanka', N'41302', N'413', N'02', N'Dialog', N'Dialog Axiata PLC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LK', N'Sri Lanka', N'41303', N'413', N'03', N'Hutch', N'Hutchison Telecommunications Lanka (Pvt) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LK', N'Sri Lanka', N'41304', N'413', N'04', N'Lanka Bell', N'Lanka Bell Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LK', N'Sri Lanka', N'41305', N'413', N'05', N'Airtel', N'Bharti Airtel Lanka (Pvt) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LK', N'Sri Lanka', N'41308', N'413', N'08', N'Hutch', N'Hutchison Telecommunications Lanka (Pvt) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LK', N'Sri Lanka', N'41309', N'413', N'09', N'Hutch', N'Hutchison Telecommunications Lanka (Pvt) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LK', N'Sri Lanka', N'41311', N'413', N'11', N'Dialog', N'Dialog Broadband Networks (Pvt) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LK', N'Sri Lanka', N'41312', N'413', N'12', N'SLTMobitel', N'Sri Lanka Telecom PLC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MM', N'Myanmar', N'41400', N'414', N'00', N'MPT', N'Myanmar Posts and Telecommunications', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MM', N'Myanmar', N'41401', N'414', N'01', N'MPT', N'Myanmar Posts and Telecommunications', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MM', N'Myanmar', N'41402', N'414', N'02', N'MPT', N'Myanmar Posts and Telecommunications', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MM', N'Myanmar', N'41403', N'414', N'03', N'CDMA800', N'Myanmar Economic Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MM', N'Myanmar', N'41404', N'414', N'04', N'MPT', N'Myanmar Posts and Telecommunications', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MM', N'Myanmar', N'41405', N'414', N'05', N'Ooredoo', N'Ooredoo Myanmar', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MM', N'Myanmar', N'41406', N'414', N'06', N'Telenor', N'Telenor Myanmar', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MM', N'Myanmar', N'41409', N'414', N'09', N'Mytel', N'Myanmar National Tele & Communication Co., Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MM', N'Myanmar', N'41420', N'414', N'20', N'ACS', N'Amara Communication Co., Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MM', N'Myanmar', N'41421', N'414', N'21', N'ACS', N'Amara Communication Co., Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MM', N'Myanmar', N'41422', N'414', N'22', null, N'Fortune Telecom Co., Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MM', N'Myanmar', N'41423', N'414', N'23', null, N'Global Technology Co., Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LB', N'Lebanon', N'41501', N'415', N'01', N'Alfa', N'MIC 1', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LB', N'Lebanon', N'41503', N'415', N'03', N'Touch', N'MIC 2', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LB', N'Lebanon', N'41505', N'415', N'05', N'Ogero Mobile', N'Ogero Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JO', N'Jordan', N'41601', N'416', N'01', N'zain JO', N'Jordan Mobile Telephone Services', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JO', N'Jordan', N'41602', N'416', N'02', N'XPress Telecom', N'XPress Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JO', N'Jordan', N'41603', N'416', N'03', N'Umniah', N'Umniah Mobile Company', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JO', N'Jordan', N'41677', N'416', N'77', N'Orange', N'Petra Jordanian Mobile Telecommunications Company (MobileCom)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SY', N'Syria', N'41701', N'417', N'01', N'Syriatel', N'Syriatel Mobile Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SY', N'Syria', N'41702', N'417', N'02', N'MTN', N'MTN Syria', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SY', N'Syria', N'41703', N'417', N'03', null, N'Wafa Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SY', N'Syria', N'41709', N'417', N'09', null, N'Syrian Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IQ', N'Iraq', N'41800', N'418', N'00', N'Asia Cell', N'Asia Cell Telecommunications Company', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IQ', N'Iraq', N'41805', N'418', N'05', N'Asia Cell', N'Asia Cell Telecommunications Company', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IQ', N'Iraq', N'41808', N'418', N'08', N'SanaTel', null, 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IQ', N'Iraq', N'41820', N'418', N'20', N'Zain', N'Zain Iraq', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IQ', N'Iraq', N'41830', N'418', N'30', N'Zain', N'Zain Iraq', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IQ', N'Iraq', N'41840', N'418', N'40', N'Korek', N'Telecom Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IQ', N'Iraq', N'41845', N'418', N'45', N'Mobitel', N'Mobitel Co. Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IQ', N'Iraq', N'41862', N'418', N'62', N'Itisaluna', N'Itisaluna Wireless CO.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IQ', N'Iraq', N'41892', N'418', N'92', N'Omnnea', N'Omnnea Wireless', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KW', N'Kuwait', N'41902', N'419', N'02', N'zain KW', N'Zain Kuwait', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KW', N'Kuwait', N'41903', N'419', N'03', N'Ooredoo', N'National Mobile Telecommunications', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KW', N'Kuwait', N'41904', N'419', N'04', N'STC', N'Saudi Telecom Company', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SA', N'Saudi Arabia', N'42001', N'420', N'01', N'Al Jawal (STC )', N'Saudi Telecom Company', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SA', N'Saudi Arabia', N'42003', N'420', N'03', N'Mobily', N'Etihad Etisalat Company', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SA', N'Saudi Arabia', N'42004', N'420', N'04', N'Zain SA', N'Zain Saudi Arabia', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SA', N'Saudi Arabia', N'42005', N'420', N'05', N'Virgin Mobile', N'Virgin Mobile Saudi Arabia', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SA', N'Saudi Arabia', N'42006', N'420', N'06', N'Lebara Mobile', N'Lebara Mobile', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SA', N'Saudi Arabia', N'42021', N'420', N'21', N'RGSM', N'Saudi Railways GSM', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'YE', N'Yemen', N'42101', N'421', N'01', N'SabaFon', N'SabaFon', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'YE', N'Yemen', N'42102', N'421', N'02', N'YOU', N'Yemen Oman United Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'YE', N'Yemen', N'42103', N'421', N'03', N'Yemen Mobile', N'Yemen Mobile', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'YE', N'Yemen', N'42104', N'421', N'04', N'Y', N'HiTS-UNITEL', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'YE', N'Yemen', N'42110', N'421', N'10', N'Yemen-4G', N'PTC/Yemen-Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'YE', N'Yemen', N'42111', N'421', N'11', N'Yemen Mobile', N'Yemen Mobile', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'OM', N'Oman', N'42202', N'422', N'02', N'Omantel', N'Oman Telecommunications Company', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'OM', N'Oman', N'42203', N'422', N'03', N'Ooredoo', N'Omani Qatari Telecommunications Company SAOC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'OM', N'Oman', N'42204', N'422', N'04', N'Omantel', N'Oman Telecommunications Company', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'OM', N'Oman', N'42206', N'422', N'06', N'Vodafone', N'Oman Future Telecommunications Company SAOC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AE', N'United Arab Emirates', N'42402', N'424', N'02', N'Etisalat', N'Emirates Telecom Corp', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AE', N'United Arab Emirates', N'42403', N'424', N'03', N'du', N'Emirates Integrated Telecommunications Company', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42501', N'425', N'01', N'Partner', N'Partner Communications Company Ltd.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42502', N'425', N'02', N'Cellcom', N'Cellcom Israel Ltd.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42503', N'425', N'03', N'Pelephone', N'Pelephone Communications Ltd.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42504', N'425', N'04', null, N'Globalsim Ltd', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42507', N'425', N'07', N'Hot Mobile', N'Hot Mobile Ltd.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42508', N'425', N'08', N'Golan Telecom', N'Golan Telecom Ltd.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42509', N'425', N'09', N'We4G', N'Marathon 018 Xphone Ltd.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42510', N'425', N'10', N'Partner', N'Partner Communications Company Ltd.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42511', N'425', N'11', null, N'365 Telecom', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42512', N'425', N'12', N'x2one', N'Widely Mobile', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42513', N'425', N'13', null, N'Ituran Cellular Communications', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42514', N'425', N'14', N'Youphone', N'Alon Cellular Ltd.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42515', N'425', N'15', N'Home Cellular', N'Home Cellular Ltd.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42516', N'425', N'16', N'Rami Levy', N'Rami Levy Communications Ltd.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42517', N'425', N'17', N'Sipme', N'Gale Phone', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42518', N'425', N'18', N'Cellact Communications', N'Cellact Communications Ltd.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42519', N'425', N'19', N'019 Mobile', N'019 Communication Services Ltd. / TELZAR', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42520', N'425', N'20', N'Bezeq', N'Bezeq The Israeli Telecommunication Corp Ltd.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42521', N'425', N'21', N'Bezeq International', N'B.I.P. Communications Ltd.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42522', N'425', N'22', null, N'Maskyoo Telephonia Ltd.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42523', N'425', N'23', null, N'Beezz Communication Solutions Ltd.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42524', N'425', N'24', N'012 Mobile', N'Partner Communications Company Ltd.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42525', N'425', N'25', N'IMOD', N'Israel Ministry of Defense', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42526', N'425', N'26', N'Annatel', N'LB Annatel Ltd.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42527', N'425', N'27', null, N'BITIT Ltd.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42528', N'425', N'28', null, N'PHI Networks', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'IL', N'Israel', N'42529', N'425', N'29', null, N'CG Networks', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'BH', N'Bahrain', N'42601', N'426', N'01', N'Batelco', N'Bahrain Telecommunications Company', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BH', N'Bahrain', N'42602', N'426', N'02', N'zain BH', N'Zain Bahrain', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BH', N'Bahrain', N'42603', N'426', N'03', null, N'Civil Aviation Authority', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BH', N'Bahrain', N'42604', N'426', N'04', N'stc', N'Stc Bahrain', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BH', N'Bahrain', N'42605', N'426', N'05', N'Batelco', N'Bahrain Telecommunications Company', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BH', N'Bahrain', N'42606', N'426', N'06', N'stc', N'Stc Bahrain', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BH', N'Bahrain', N'42607', N'426', N'07', null, N'TAIF', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'QA', N'Qatar', N'42701', N'427', N'01', N'Ooredoo', N'Ooredoo', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'QA', N'Qatar', N'42702', N'427', N'02', N'Vodafone', N'Vodafone Qatar', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'QA', N'Qatar', N'42705', N'427', N'05', N'Ministry of Interior', N'Ministry of Interior', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'QA', N'Qatar', N'42706', N'427', N'06', N'Ministry of Interior', N'Ministry of Interior', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MN', N'Mongolia', N'42888', N'428', N'88', N'Unitel', N'Unitel LLC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MN', N'Mongolia', N'42891', N'428', N'91', N'Skytel', N'Skytel LLC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MN', N'Mongolia', N'42898', N'428', N'98', N'G-Mobile', N'G-Mobile LLC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MN', N'Mongolia', N'42899', N'428', N'99', N'Mobicom', N'Mobicom Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NP', N'Nepal', N'42901', N'429', N'01', N'Namaste / NT Mobile / Sky Phone', N'Nepal Telecom (NDCL)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NP', N'Nepal', N'42902', N'429', N'02', N'Ncell', N'Ncell Pvt. Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NP', N'Nepal', N'42903', N'429', N'03', N'UTL', N'United Telecom Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NP', N'Nepal', N'42904', N'429', N'04', N'SmartCell', N'Smart Telecom Pvt. Ltd. (STPL)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43201', N'432', N'01', null, N'Kish Cell Pars', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43202', N'432', N'02', N'ApTel, AzarTel', N'Negin Ertebatat Ava', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43203', N'432', N'03', null, N'Parsian Hamrah Lotus', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43204', N'432', N'04', null, N'TOSE E FANAVARI ERTEBATAT NOVIN HAMRAH', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43205', N'432', N'05', N'Smart Comm', N'Hamrah Hooshmand Ayandeh', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43206', N'432', N'06', N'Arian-Tel', N'Ertebatat-e Arian Tel Co.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43207', N'432', N'07', null, N'Hooshmand Amin Mobile', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43208', N'432', N'08', N'Shatel Mobile', N'Shatel Group', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43209', N'432', N'09', N'HiWEB', N'Dadeh Dostar asr Novin PJSC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43210', N'432', N'10', N'Samantel', N'Samantel Mobile', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43211', N'432', N'11', N'IR-TCI (Hamrah-e-Avval)', N'Mobile Communications Company of Iran (MCI)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43212', N'432', N'12', N'Avacell (HiWEB)', N'Dadeh Dostar asr Novin PJSC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43213', N'432', N'13', N'HiWEB', N'Dadeh Dostar asr Novin PJSC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43214', N'432', N'14', N'TKC/KFZO', N'Kish Free Zone Organization', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43219', N'432', N'19', N'Espadan', N'Mobile Telecommunications Company of Esfahan', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43220', N'432', N'20', N'RighTel', N'Social Security Investment Co.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43221', N'432', N'21', N'RighTel', N'Social Security Investment Co.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43232', N'432', N'32', N'Taliya', N'Telecommunication Company of Iran (TCI)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43235', N'432', N'35', N'MTN Irancell', N'MTN Irancell Telecommunications Services Company', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43240', N'432', N'40', N'Mobinnet', N'Ertebatat Mobinnet', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43244', N'432', N'44', N'Mobinnet', N'Ertebatat Mobinnet', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43245', N'432', N'45', N'Zi-Tel', N'Farabord Dadeh Haye Iranian Co.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43246', N'432', N'46', N'HiWEB', N'Dadeh Dostar asr Novin PJSC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43249', N'432', N'49', null, N'Gostaresh Ertebatat Mabna', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43250', N'432', N'50', N'Shatel Mobile', N'Shatel Group', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            );

            insert into dm_dom_network_usage.itm_rel_network_provider_worldzone (
                country_cd
              , country_desc
              , network_provider_id
              , mcc
              , mnc
              , brand
              , operator
              , basic_service
              , worldzone_id
              , worldzone_desc
              , dm_load_date
              , dm_load_job_id
            )
            values (
                N'IR', N'Iran', N'43251', N'432', N'51', null, N'Pishgaman Tose''e Ertebatat', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43252', N'432', N'52', null, N'Asiatech', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43270', N'432', N'70', N'MTCE', N'Telecommunication Company of Iran (TCI)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43271', N'432', N'71', N'KOOHE NOOR', N'ERTEBATAT KOOHE NOOR', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43290', N'432', N'90', N'Iraphone', N'IRAPHONE GHESHM of Iran', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43299', N'432', N'99', N'TCI', N'TCI of Iran and Rightel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UZ', N'Uzbekistan', N'43401', N'434', N'01', null, N'Buztel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UZ', N'Uzbekistan', N'43402', N'434', N'02', null, N'Uzmacom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UZ', N'Uzbekistan', N'43403', N'434', N'03', N'UzMobile', N'Uzbektelekom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UZ', N'Uzbekistan', N'43404', N'434', N'04', N'Beeline', N'Unitel LLC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UZ', N'Uzbekistan', N'43405', N'434', N'05', N'Ucell', N'Coscom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UZ', N'Uzbekistan', N'43406', N'434', N'06', N'Perfectum Mobile', N'RUBICON WIRELESS COMMUNICATION', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UZ', N'Uzbekistan', N'43407', N'434', N'07', N'Mobiuz', N'Universal Mobile Systems (UMS)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UZ', N'Uzbekistan', N'43408', N'434', N'08', N'UzMobile', N'Uzbektelekom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UZ', N'Uzbekistan', N'43409', N'434', N'09', N'EVO', N'OOO «Super iMAX»', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TJ', N'Tajikistan', N'43601', N'436', N'01', N'Tcell', N'JV Somoncom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TJ', N'Tajikistan', N'43602', N'436', N'02', N'Tcell', N'Indigo Tajikistan', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TJ', N'Tajikistan', N'43603', N'436', N'03', N'MegaFon', N'TT Mobile', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TJ', N'Tajikistan', N'43604', N'436', N'04', N'Babilon-M', N'Babilon-Mobile', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TJ', N'Tajikistan', N'43605', N'436', N'05', N'ZET-Mobile', N'Tacom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TJ', N'Tajikistan', N'43610', N'436', N'10', N'Babilon-T', N'Babilon-T', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TJ', N'Tajikistan', N'43612', N'436', N'12', N'Tcell', N'Indigo', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KG', N'Kyrgyzstan', N'43701', N'437', N'01', N'Beeline', N'Sky Mobile LLC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KG', N'Kyrgyzstan', N'43703', N'437', N'03', null, N'7 Mobile', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KG', N'Kyrgyzstan', N'43705', N'437', N'05', N'MegaCom', N'Alfa Telecom CJSC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KG', N'Kyrgyzstan', N'43709', N'437', N'09', N'O!', N'NurTelecom LLC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KG', N'Kyrgyzstan', N'43710', N'437', N'10', null, N'Saima Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KG', N'Kyrgyzstan', N'43711', N'437', N'11', null, N'iTel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TM', N'Turkmenistan', N'43801', N'438', N'01', N'MTS', N'MTS Turkmenistan', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TM', N'Turkmenistan', N'43802', N'438', N'02', N'TM-Cell', N'Altyn Asyr', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TM', N'Turkmenistan', N'43803', N'438', N'03', N'AGTS CDMA', N'AŞTU', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44000', N'440', N'00', N'Y!Mobile', N'SoftBank Corp.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44001', N'440', N'01', null, N'KDDI Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44002', N'440', N'02', null, N'Hanshin Cable Engineering Co., Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44003', N'440', N'03', N'IIJmio', N'Internet Initiative Japan Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44004', N'440', N'04', null, N'Japan Radio Company, Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44005', N'440', N'05', null, N'Wireless City Planning Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44006', N'440', N'06', null, N'SAKURA Internet Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44007', N'440', N'07', null, N'closip, Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44008', N'440', N'08', null, N'Panasonic Connect Co., Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44009', N'440', N'09', null, N'Marubeni Network Solutions Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44010', N'440', N'10', N'NTT docomo', N'NTT DoCoMo, Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44011', N'440', N'11', N'Rakuten Mobile', N'Rakuten Mobile Network, Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44012', N'440', N'12', null, N'Cable media waiwai Co., Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44013', N'440', N'13', null, N'NTT Communications Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44014', N'440', N'14', null, N'Grape One Co., Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44015', N'440', N'15', null, N'BB Backbone Corp.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44016', N'440', N'16', null, N'Nokia Innovations Japan G.K.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44017', N'440', N'17', null, N'Osaka Gas Business Create Co., Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44018', N'440', N'18', null, N'Kintetsu Cable Network Co., Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44019', N'440', N'19', null, N'NEC Networks & System Integration Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44020', N'440', N'20', N'SoftBank', N'SoftBank Corp.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44021', N'440', N'21', N'SoftBank', N'SoftBank Corp.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44022', N'440', N'22', null, N'JTOWER Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44023', N'440', N'23', null, N'Fujitsu Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44050', N'440', N'50', N'au', N'KDDI Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44051', N'440', N'51', N'au', N'KDDI Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44052', N'440', N'52', N'au', N'KDDI Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44053', N'440', N'53', N'au', N'KDDI Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44054', N'440', N'54', N'au', N'KDDI Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44070', N'440', N'70', N'au', N'KDDI Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44071', N'440', N'71', N'au', N'KDDI Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44072', N'440', N'72', N'au', N'KDDI Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44073', N'440', N'73', N'au', N'KDDI Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44074', N'440', N'74', N'au', N'KDDI Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44075', N'440', N'75', N'au', N'KDDI Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44076', N'440', N'76', N'au', N'KDDI Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44078', N'440', N'78', N'au', N'Okinawa Cellular Telephone', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44100', N'441', N'00', null, N'Wireless City Planning Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44101', N'441', N'01', N'SoftBank', N'SoftBank Corp.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44110', N'441', N'10', N'UQ WiMAX', N'UQ Communications Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'441200', N'441', N'200', null, N'Soracom Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'441201', N'441', N'201', null, N'Aurens Co., Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'441202', N'441', N'202', null, N'Sony Wireless Communications Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'441203', N'441', N'203', null, N'Gujo City', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'441204', N'441', N'204', null, N'Wicom Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'441205', N'441', N'205', null, N'Katch Network Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'441206', N'441', N'206', null, N'Mitsubishi Electric Corp.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'441207', N'441', N'207', null, N'Mitsui Knowledge Industry Co., Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'441208', N'441', N'208', null, N'Chudenko Corp.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'441209', N'441', N'209', null, N'Cable Television Toyama Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'441210', N'441', N'210', null, N'Nippon Telegraph and Telephone East Corp.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'441211', N'441', N'211', null, N'Starcat Cable Network Co., Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'441212', N'441', N'212', null, N'I-TEC Solutions Co., Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'JP', N'Japan', N'44191', N'441', N'91', null, N'Tokyo Organising Committee of the Olympic and Paralympic Games', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KR', N'South Korea', N'45001', N'450', N'01', null, N'Globalstar Asia Pacific', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KR', N'South Korea', N'45002', N'450', N'02', N'KT', N'KT', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KR', N'South Korea', N'45003', N'450', N'03', N'Power 017', N'Shinsegi Telecom, Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KR', N'South Korea', N'45004', N'450', N'04', N'KT', N'KT', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KR', N'South Korea', N'45005', N'450', N'05', N'SKTelecom', N'SK Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KR', N'South Korea', N'45006', N'450', N'06', N'LG U+', N'LG Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KR', N'South Korea', N'45007', N'450', N'07', N'KT', N'KT', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KR', N'South Korea', N'45008', N'450', N'08', N'olleh', N'KT', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KR', N'South Korea', N'45011', N'450', N'11', N'Tplus', N'Korea Cable Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KR', N'South Korea', N'45012', N'450', N'12', N'SKTelecom', N'SK Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VN', N'Vietnam', N'45201', N'452', N'01', N'MobiFone', N'Vietnam Mobile Telecom Services Company', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VN', N'Vietnam', N'45202', N'452', N'02', N'Vinaphone', N'Vietnam Telecom Services Company', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VN', N'Vietnam', N'45203', N'452', N'03', N'S-Fone', N'S-Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VN', N'Vietnam', N'45204', N'452', N'04', N'Viettel Mobile', N'Viettel Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VN', N'Vietnam', N'45205', N'452', N'05', N'Vietnamobile', N'Hanoi Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VN', N'Vietnam', N'45206', N'452', N'06', N'EVNTelecom', N'EVN Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VN', N'Vietnam', N'45207', N'452', N'07', N'Gmobile', N'GTEL Mobile JSC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VN', N'Vietnam', N'45208', N'452', N'08', N'I-Telecom', N'Indochina Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VN', N'Vietnam', N'45209', N'452', N'09', N'REDDI', N'MOBICAST JSC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45400', N'454', N'00', N'1O1O / One2Free / New World Mobility / SUNMobile', N'CSL Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45401', N'454', N'01', null, N'CITIC Telecom 1616', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45402', N'454', N'02', null, N'CSL Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45403', N'454', N'03', N'3', N'Hutchison Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45404', N'454', N'04', N'3 (2G)', N'Hutchison Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45405', N'454', N'05', N'3 (CDMA)', N'Hutchison Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45406', N'454', N'06', N'SmarTone', N'SmarTone Mobile Communications Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45407', N'454', N'07', N'China Unicom', N'China Unicom (Hong Kong) Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45408', N'454', N'08', N'Truphone', N'Truphone Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45409', N'454', N'09', null, N'China Motion Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45410', N'454', N'10', N'New World Mobility', N'CSL Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45411', N'454', N'11', null, N'China-Hong Kong Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45412', N'454', N'12', N'CMCC HK', N'China Mobile Hong Kong Company Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45413', N'454', N'13', N'CMCC HK', N'China Mobile Hong Kong Company Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45414', N'454', N'14', null, N'Hutchison Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45415', N'454', N'15', null, N'SmarTone Mobile Communications Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45416', N'454', N'16', N'PCCW Mobile (2G)', N'PCCW', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45417', N'454', N'17', null, N'SmarTone Mobile Communications Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45418', N'454', N'18', null, N'CSL Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45419', N'454', N'19', N'PCCW Mobile (3G)', N'PCCW-HKT', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45420', N'454', N'20', N'PCCW Mobile (4G)', N'PCCW-HKT', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45421', N'454', N'21', null, N'21Vianet Mobile Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45422', N'454', N'22', null, N'263 Mobile Communications (HongKong) Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45423', N'454', N'23', N'Lycamobile', N'Lycamobile Hong Kong Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45424', N'454', N'24', null, N'Multibyte Info Technology Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45425', N'454', N'25', null, N'Hong Kong Government', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45426', N'454', N'26', null, N'Hong Kong Government', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45429', N'454', N'29', N'PCCW Mobile (CDMA)', N'PCCW-HKT', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45430', N'454', N'30', N'CMCC HK', N'China Mobile Hong Kong Company Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45431', N'454', N'31', N'CTExcel', N'China Telecom Global Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45432', N'454', N'32', null, N'Hong Kong Broadband Network Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45435', N'454', N'35', null, N'Webbing Hong Kong Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HK', N'Hong Kong', N'45436', N'454', N'36', null, N'Easco Telecommunications Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MO', N'Macau', N'45500', N'455', N'00', N'SmarTone', N'Smartone – Comunicações Móveis, S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MO', N'Macau', N'45501', N'455', N'01', N'CTM', N'Companhia de Telecomunicações de Macau, S.A.R.L.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MO', N'Macau', N'45502', N'455', N'02', N'China Telecom', N'China Telecom (Macau) Company Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MO', N'Macau', N'45503', N'455', N'03', N'3', N'Hutchison Telephone (Macau), Limitada', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MO', N'Macau', N'45504', N'455', N'04', N'CTM', N'Companhia de Telecomunicações de Macau, S.A.R.L.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MO', N'Macau', N'45505', N'455', N'05', N'3', N'Hutchison Telephone (Macau), Limitada', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MO', N'Macau', N'45506', N'455', N'06', N'SmarTone', N'Smartone – Comunicações Móveis, S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MO', N'Macau', N'45507', N'455', N'07', N'China Telecom', N'China Telecom (Macau) Limitada', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KH', N'Cambodia', N'45601', N'456', N'01', N'Cellcard', N'CamGSM / The Royal Group', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KH', N'Cambodia', N'45602', N'456', N'02', N'Smart', N'Smart Axiata Co. Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KH', N'Cambodia', N'45603', N'456', N'03', N'qb', N'Cambodia Advance Communications Co. Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KH', N'Cambodia', N'45604', N'456', N'04', N'qb', N'Cambodia Advance Communications Co. Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KH', N'Cambodia', N'45605', N'456', N'05', N'Smart', N'Smart Axiata Co. Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KH', N'Cambodia', N'45606', N'456', N'06', N'Smart', N'Smart Axiata Co. Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KH', N'Cambodia', N'45608', N'456', N'08', N'Metfone', N'Viettel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KH', N'Cambodia', N'45609', N'456', N'09', N'Metfone', N'Viettel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KH', N'Cambodia', N'45611', N'456', N'11', N'SEATEL', N'SEATEL Cambodia', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KH', N'Cambodia', N'45618', N'456', N'18', N'Cellcard', N'The Royal Group', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LA', N'Laos', N'45701', N'457', N'01', N'LaoTel', N'Lao Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LA', N'Laos', N'45702', N'457', N'02', N'ETL', N'Enterprise of Telecommunications Lao', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LA', N'Laos', N'45703', N'457', N'03', N'Unitel', N'Star Telecom Co., Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LA', N'Laos', N'45707', N'457', N'07', N'Best', N'Best Telecom Co., Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LA', N'Laos', N'45708', N'457', N'08', N'TPLUS', N'TPLUS Digital Sole Co., Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CN', N'China', N'46000', N'460', N'00', N'China Mobile', N'China Mobile', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CN', N'China', N'46001', N'460', N'01', N'China Unicom', N'China Unicom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CN', N'China', N'46002', N'460', N'02', N'China Mobile', N'China Mobile', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CN', N'China', N'46003', N'460', N'03', N'China Telecom', N'China Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CN', N'China', N'46004', N'460', N'04', N'China Mobile', N'Global Star Satellite', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CN', N'China', N'46005', N'460', N'05', N'China Telecom', N'China Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CN', N'China', N'46006', N'460', N'06', N'China Unicom', N'China Unicom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CN', N'China', N'46007', N'460', N'07', N'China Mobile', N'China Mobile', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CN', N'China', N'46008', N'460', N'08', N'China Mobile', N'China Mobile', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CN', N'China', N'46009', N'460', N'09', N'China Unicom', N'China Unicom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CN', N'China', N'46011', N'460', N'11', N'China Telecom', N'China Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CN', N'China', N'46015', N'460', N'15', N'China Broadnet', N'China Broadnet', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CN', N'China', N'46020', N'460', N'20', N'China Tietong', N'China Tietong', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TW', N'Taiwan', N'46601', N'466', N'01', N'FarEasTone', N'Far EasTone Telecommunications Co Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TW', N'Taiwan', N'46602', N'466', N'02', N'FarEasTone', N'Far EasTone Telecommunications Co Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TW', N'Taiwan', N'46603', N'466', N'03', N'FarEasTone', N'Far EasTone Telecommunications Co Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TW', N'Taiwan', N'46605', N'466', N'05', N'Gt', N'Asia Pacific Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TW', N'Taiwan', N'46606', N'466', N'06', N'FarEasTone', N'Far EasTone Telecommunications Co Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TW', N'Taiwan', N'46607', N'466', N'07', N'FarEasTone', N'Far EasTone Telecommunications Co Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TW', N'Taiwan', N'46609', N'466', N'09', N'VMAX', N'Vmax Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TW', N'Taiwan', N'46610', N'466', N'10', N'G1', N'Global Mobile Corp.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TW', N'Taiwan', N'46611', N'466', N'11', N'Chunghwa LDM', N'LDTA/Chunghwa Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TW', N'Taiwan', N'46612', N'466', N'12', null, N'Ambit Microsystems', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TW', N'Taiwan', N'46656', N'466', N'56', N'FITEL', N'First International Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TW', N'Taiwan', N'46668', N'466', N'68', null, N'Tatung InfoComm', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TW', N'Taiwan', N'46688', N'466', N'88', N'FarEasTone', N'Far EasTone Telecommunications Co Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TW', N'Taiwan', N'46689', N'466', N'89', N'T Star', N'Taiwan Star Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TW', N'Taiwan', N'46690', N'466', N'90', N'T Star', N'Taiwan Star Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TW', N'Taiwan', N'46692', N'466', N'92', N'Chunghwa', N'Chunghwa Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TW', N'Taiwan', N'46693', N'466', N'93', N'MobiTai', N'Mobitai Communications', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TW', N'Taiwan', N'46697', N'466', N'97', N'Taiwan Mobile', N'Taiwan Mobile Co. Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TW', N'Taiwan', N'46699', N'466', N'99', N'TransAsia', N'TransAsia Telecoms', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KP', N'North Korea', N'46705', N'467', N'05', N'Koryolink', N'Cheo Technology Jv Company', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KP', N'North Korea', N'46706', N'467', N'06', N'Kang Song NET', N'Korea Posts and Telecommunications Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KP', N'North Korea', N'467193', N'467', N'193', N'SunNet', N'Korea Posts and Telecommunications Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BD', N'Bangladesh', N'47001', N'470', N'01', N'Grameenphone', N'Grameenphone Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BD', N'Bangladesh', N'47002', N'470', N'02', N'Robi', N'Axiata Bangladesh Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BD', N'Bangladesh', N'47003', N'470', N'03', N'Banglalink', N'Banglalink Digital Communications Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BD', N'Bangladesh', N'47004', N'470', N'04', N'TeleTalk', N'Teletalk Bangladesh Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BD', N'Bangladesh', N'47005', N'470', N'05', N'Citycell', N'Pacific Bangladesh Telecom Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BD', N'Bangladesh', N'47007', N'470', N'07', N'Airtel', N'Bharti Airtel Bangladesh Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BD', N'Bangladesh', N'47009', N'470', N'09', N'ollo', N'Bangladesh Internet Exchange Limited (BIEL)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BD', N'Bangladesh', N'47010', N'470', N'10', N'Banglalion', N'Banglalion Communications Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MV', N'Maldives', N'47201', N'472', N'01', N'Dhiraagu', N'Dhivehi Raajjeyge Gulhun', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MV', N'Maldives', N'47202', N'472', N'02', N'Ooredoo', N'Ooredoo Maldives', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MY', N'Malaysia', N'50201', N'502', N'01', N'ATUR 450', N'Telekom Malaysia Bhd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MY', N'Malaysia', N'50210', N'502', N'10', null, N'Celcom, DiGi, Maxis, Tune Talk, U Mobile, Unifi, XOX, Yes', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MY', N'Malaysia', N'50211', N'502', N'11', N'TM Homeline', N'Telekom Malaysia Bhd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MY', N'Malaysia', N'50212', N'502', N'12', N'Maxis', N'Maxis Communications Berhad', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MY', N'Malaysia', N'50213', N'502', N'13', N'Celcom', N'Celcom Axiata Berhad', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MY', N'Malaysia', N'50214', N'502', N'14', null, N'Telekom Malaysia Berhad for PSTN SMS', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MY', N'Malaysia', N'502150', N'502', N'150', N'Tune Talk', N'Tune Talk Sdn Bhd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MY', N'Malaysia', N'502151', N'502', N'151', N'SalamFone', N'Baraka Telecom Sdn Bhd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MY', N'Malaysia', N'502152', N'502', N'152', N'Yes', N'YTL Communications Sdn Bhd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MY', N'Malaysia', N'502153', N'502', N'153', N'unifi', N'Webe Digital Sdn Bhd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MY', N'Malaysia', N'502154', N'502', N'154', N'Tron', N'Talk Focus Sdn Bhd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MY', N'Malaysia', N'502155', N'502', N'155', N'Clixster', N'Clixster Mobile Sdn Bhd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MY', N'Malaysia', N'502156', N'502', N'156', N'Altel', N'Altel Communications Sdn Bhd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MY', N'Malaysia', N'502157', N'502', N'157', N'Telin', N'Telekomunikasi Indonesia International (M) Sdn Bhd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MY', N'Malaysia', N'50216', N'502', N'16', N'DiGi', N'DiGi Telecommunications', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MY', N'Malaysia', N'50217', N'502', N'17', N'Maxis', N'Maxis Communications Berhad', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MY', N'Malaysia', N'50218', N'502', N'18', N'U Mobile', N'U Mobile Sdn Bhd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MY', N'Malaysia', N'50219', N'502', N'19', N'Celcom', N'Celcom Axiata Berhad', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MY', N'Malaysia', N'50220', N'502', N'20', N'Electcoms', N'Electcoms Berhad', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NF', N'Norfolk Island', N'50510', N'505', N'10', N'Norfolk Telecom', N'Norfolk Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ID', N'Indonesia', N'51000', N'510', N'00', N'PSN', N'PT Pasifik Satelit Nusantara', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ID', N'Indonesia', N'51001', N'510', N'01', N'Indosat Ooredoo Hutchison', N'PT Indosat Tbk', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ID', N'Indonesia', N'51003', N'510', N'03', N'StarOne', N'PT Indosat Tbk', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ID', N'Indonesia', N'51007', N'510', N'07', N'TelkomFlexi', N'PT Telkom Indonesia Tbk', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ID', N'Indonesia', N'51008', N'510', N'08', N'AXIS', N'PT Natrindo Telepon Seluler', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ID', N'Indonesia', N'51009', N'510', N'09', N'Smartfren', N'PT Smartfren Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ID', N'Indonesia', N'51010', N'510', N'10', N'Telkomsel', N'PT Telekomunikasi Selular', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ID', N'Indonesia', N'51011', N'510', N'11', N'XL', N'PT XL Axiata Tbk', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ID', N'Indonesia', N'51020', N'510', N'20', N'TELKOMMobile', N'PT Telkom Indonesia Tbk', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ID', N'Indonesia', N'51021', N'510', N'21', N'Indosat Ooredoo Hutchison', N'PT Indosat Tbk', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ID', N'Indonesia', N'51027', N'510', N'27', N'Net 1', N'PT Net Satu Indonesia', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ID', N'Indonesia', N'51028', N'510', N'28', N'Fren/Hepi', N'PT Mobile-8 Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ID', N'Indonesia', N'51078', N'510', N'78', N'Hinet', N'PT Berca Hardayaperkasa', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ID', N'Indonesia', N'51088', N'510', N'88', N'BOLT! 4G LTE', N'PT Internux', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ID', N'Indonesia', N'51089', N'510', N'89', N'3', N'PT Hutchison 3 Indonesia', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ID', N'Indonesia', N'51099', N'510', N'99', N'Esia', N'PT Bakrie Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TL', N'East Timor', N'51401', N'514', N'01', N'Telkomcel', N'PT Telekomunikasi Indonesia International', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TL', N'East Timor', N'51402', N'514', N'02', N'TT', N'Timor Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TL', N'East Timor', N'51403', N'514', N'03', N'Telemor', N'Viettel Timor-Leste', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PH', N'Philippines', N'51501', N'515', N'01', N'Islacom', N'Globe Telecom via Innove Communications', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PH', N'Philippines', N'51502', N'515', N'02', N'Globe', N'Globe Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PH', N'Philippines', N'51503', N'515', N'03', N'SMART', N'PLDT via Smart Communications', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PH', N'Philippines', N'51505', N'515', N'05', N'Sun Cellular', N'Digital Telecommunications Philippines', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PH', N'Philippines', N'51511', N'515', N'11', null, N'PLDT via ACeS Philippines', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PH', N'Philippines', N'51518', N'515', N'18', N'Cure', N'PLDT via Smart''s Connectivity Unlimited Resources Enterprise', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PH', N'Philippines', N'51524', N'515', N'24', N'ABS-CBN Mobile', N'ABS-CBN Convergence with Globe Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PH', N'Philippines', N'51566', N'515', N'66', N'DITO', N'Dito Telecommunity Corp.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PH', N'Philippines', N'51588', N'515', N'88', null, N'Next Mobile Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TH', N'Thailand', N'52000', N'520', N'00', N'TrueMove H / my by NT', N'National Telecom Public Company Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TH', N'Thailand', N'52001', N'520', N'01', N'AIS', N'Advanced Info Service', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TH', N'Thailand', N'52002', N'520', N'02', N'NT Mobile', N'National Telecom Public Company Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TH', N'Thailand', N'52003', N'520', N'03', N'AIS', N'Advanced Wireless Network Company Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TH', N'Thailand', N'52004', N'520', N'04', N'TrueMove H', N'True Move H Universal Communication Company Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TH', N'Thailand', N'52005', N'520', N'05', N'dtac', N'DTAC TriNet Company Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TH', N'Thailand', N'52009', N'520', N'09', null, N'Royal Thai Police', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TH', N'Thailand', N'52015', N'520', N'15', N'AIS-T / NT Mobile', N'National Telecom Public Company Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TH', N'Thailand', N'52017', N'520', N'17', N'NT Mobile', N'National Telecom Public Company Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TH', N'Thailand', N'52018', N'520', N'18', N'dtac', N'Total Access Communications Public Company Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TH', N'Thailand', N'52020', N'520', N'20', N'ACeS', N'ACeS', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TH', N'Thailand', N'52023', N'520', N'23', N'AIS GSM 1800', N'Digital Phone Company Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TH', N'Thailand', N'52025', N'520', N'25', N'WE PCT', N'True Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TH', N'Thailand', N'52047', N'520', N'47', N'dtac-T', N'National Telecom Public Company Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TH', N'Thailand', N'52099', N'520', N'99', N'TrueMove', N'True Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SG', N'Singapore', N'52501', N'525', N'01', N'SingTel', N'Singapore Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SG', N'Singapore', N'52502', N'525', N'02', N'SingTel-G18', N'Singapore Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SG', N'Singapore', N'52503', N'525', N'03', N'M1', N'M1 Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SG', N'Singapore', N'52505', N'525', N'05', N'StarHub', N'StarHub Mobile', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SG', N'Singapore', N'52506', N'525', N'06', N'StarHub', N'StarHub Mobile', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SG', N'Singapore', N'52507', N'525', N'07', N'SingTel', N'Singapore Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SG', N'Singapore', N'52508', N'525', N'08', N'StarHub', N'StarHub Mobile', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SG', N'Singapore', N'52509', N'525', N'09', N'Circles.Life', N'Liberty Wireless Pte Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SG', N'Singapore', N'52510', N'525', N'10', N'SIMBA', N'SIMBA Telecom Pte Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SG', N'Singapore', N'52511', N'525', N'11', N'M1', N'M1 Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SG', N'Singapore', N'52512', N'525', N'12', N'Grid', N'GRID Communications Pte Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BN', N'Brunei', N'52801', N'528', N'01', N'TelBru', N'Telekom Brunei Berhad', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BN', N'Brunei', N'52802', N'528', N'02', N'PCSB', N'Progresif Cellular Sdn Bhd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BN', N'Brunei', N'52803', N'528', N'03', N'UNN', N'Unified National Networks Sdn Bhd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BN', N'Brunei', N'52811', N'528', N'11', N'DST', N'Data Stream Technology Sdn Bhd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NZ', N'New Zealand', N'53000', N'530', N'00', N'Telecom', N'Spark New Zealand', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NZ', N'New Zealand', N'53001', N'530', N'01', N'Vodafone', N'Vodafone New Zealand', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NZ', N'New Zealand', N'53002', N'530', N'02', N'Telecom', N'Spark New Zealand', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NZ', N'New Zealand', N'53003', N'530', N'03', N'Woosh', N'Woosh Wireless', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NZ', N'New Zealand', N'53004', N'530', N'04', N'TelstraClear', N'TelstraClear', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NZ', N'New Zealand', N'53005', N'530', N'05', N'Spark', N'Spark New Zealand', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NZ', N'New Zealand', N'53006', N'530', N'06', null, N'FX Networks', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NZ', N'New Zealand', N'53007', N'530', N'07', null, N'Dense Air New Zealand', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NZ', N'New Zealand', N'53024', N'530', N'24', N'2degrees', N'2degrees', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NR', N'Nauru', N'53602', N'536', N'02', N'Digicel', N'Digicel (Nauru) Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PG', N'Papua New Guinea', N'53701', N'537', N'01', N'bmobile', N'Bemobile Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PG', N'Papua New Guinea', N'53702', N'537', N'02', N'citifon', N'Telikom PNG Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PG', N'Papua New Guinea', N'53703', N'537', N'03', N'Digicel', N'Digicel PNG', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PG', N'Papua New Guinea', N'53704', N'537', N'04', null, N'Digitec Communication Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TO', N'Tonga', N'53901', N'539', N'01', N'U-Call', N'Tonga Communications Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TO', N'Tonga', N'53943', N'539', N'43', null, N'Shoreline Communication', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TO', N'Tonga', N'53988', N'539', N'88', N'Digicel', N'Digicel (Tonga) Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SB', N'Solomon Islands', N'54001', N'540', N'01', N'BREEZE', N'Our Telekom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SB', N'Solomon Islands', N'54002', N'540', N'02', N'BeMobile', N'BMobile (SI) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VU', N'Vanuatu', N'54100', N'541', N'00', N'AIL', N'ACeS International (AIL)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VU', N'Vanuatu', N'54101', N'541', N'01', N'SMILE', N'Telecom Vanuatu Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VU', N'Vanuatu', N'54105', N'541', N'05', N'Digicel', N'Digicel Vanuatu Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VU', N'Vanuatu', N'54107', N'541', N'07', N'WanTok', N'WanTok Vanuatu Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'FJ', N'Fiji', N'54201', N'542', N'01', N'Vodafone', N'Vodafone Fiji', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'FJ', N'Fiji', N'54202', N'542', N'02', N'Digicel', N'Digicel Fiji', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'FJ', N'Fiji', N'54203', N'542', N'03', N'TFL', N'Telecom Fiji Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'WF', N'Wallis and Futuna', N'54301', N'543', N'01', N'Manuia', N'Service des Postes et Télécommunications des Îles Wallis et Futuna (SPT)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AS', N'American Samoa', N'54411', N'544', N'11', N'Bluesky', N'Bluesky', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KI', N'Kiribati', N'54501', N'545', N'01', N'Kiribati - ATH', N'Amalgamated Telecom Holdings Kiribati Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KI', N'Kiribati', N'54502', N'545', N'02', null, N'OceanLink', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KI', N'Kiribati', N'54509', N'545', N'09', N'Kiribati - Frigate Net', N'Amalgamated Telecom Holdings Kiribati Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NC', N'New Caledonia', N'54601', N'546', N'01', N'Mobilis', N'OPT New Caledonia', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PF', N'French Polynesia', N'54705', N'547', N'05', N'Ora', N'VITI', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PF', N'French Polynesia', N'54710', N'547', N'10', null, N'Mara Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PF', N'French Polynesia', N'54715', N'547', N'15', N'Vodafone', N'Pacific Mobile Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PF', N'French Polynesia', N'54720', N'547', N'20', N'Vini', N'Onati S.A.S.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CK', N'Cook Islands', N'54801', N'548', N'01', N'Vodafone', N'Telecom Cook Islands', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'WS', N'Samoa', N'54900', N'549', N'00', N'Digicel', N'Digicel Pacific Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'WS', N'Samoa', N'54901', N'549', N'01', N'Digicel', N'Digicel Pacific Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'WS', N'Samoa', N'54927', N'549', N'27', N'Vodafone', N'Vodafone Samoa Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'FM', N'Micronesia', N'55001', N'550', N'01', null, N'FSMTC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MH', N'Marshall Islands', N'55101', N'551', N'01', null, N'Marshall Islands National Telecommunications Authority (MINTA)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PW', N'Palau', N'55201', N'552', N'01', N'PNCC', N'Palau National Communications Corp.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PW', N'Palau', N'55202', N'552', N'02', N'PT Waves', N'Palau Equipment Company Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PW', N'Palau', N'55280', N'552', N'80', N'Palau Mobile', N'Palau Mobile Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PW', N'Palau', N'55299', N'552', N'99', N'PMCI', N'Palau Mobile Communications Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TV', N'Tuvalu', N'55301', N'553', N'01', N'TTC', N'Tuvalu Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TK', N'Tokelau', N'55401', N'554', N'01', null, N'Teletok', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NU', N'Niue', N'55501', N'555', N'01', N'Telecom Niue', N'Telecom Niue', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'EG', N'Egypt', N'60201', N'602', N'01', N'Orange', N'Orange Egypt', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'EG', N'Egypt', N'60202', N'602', N'02', N'Vodafone', N'Vodafone Egypt', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'EG', N'Egypt', N'60203', N'602', N'03', N'Etisalat', N'Etisalat Egypt', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'EG', N'Egypt', N'60204', N'602', N'04', N'WE', N'Telecom Egypt', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'DZ', N'Algeria', N'60301', N'603', N'01', N'Mobilis', N'Algérie Télécom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'DZ', N'Algeria', N'60302', N'603', N'02', N'Djezzy', N'Optimum Telecom Algérie Spa', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'DZ', N'Algeria', N'60303', N'603', N'03', N'Ooredoo', N'Wataniya Telecom Algérie', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'DZ', N'Algeria', N'60307', N'603', N'07', N'AT', N'Algérie Télécom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'DZ', N'Algeria', N'60309', N'603', N'09', N'AT', N'Algérie Télécom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'DZ', N'Algeria', N'60321', N'603', N'21', N'ANESRIF', N'Anesrif', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MA', N'Morocco', N'60400', N'604', N'00', N'Orange Morocco', N'Médi Télécom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MA', N'Morocco', N'60401', N'604', N'01', N'IAM', N'Ittissalat Al-Maghrib (Maroc Telecom)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MA', N'Morocco', N'60402', N'604', N'02', N'INWI', N'Wana Corporate', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MA', N'Morocco', N'60404', N'604', N'04', null, N'Al Houria Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MA', N'Morocco', N'60405', N'604', N'05', N'INWI', N'Wana Corporate', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MA', N'Morocco', N'60406', N'604', N'06', N'IAM', N'Ittissalat Al-Maghrib (Maroc Telecom)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MA', N'Morocco', N'60499', N'604', N'99', null, N'Al Houria Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TN', N'Tunisia', N'60501', N'605', N'01', N'Orange', N'Orange Tunisie', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TN', N'Tunisia', N'60502', N'605', N'02', N'Tunicell', N'Tunisie Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TN', N'Tunisia', N'60503', N'605', N'03', N'Ooredoo', N'Ooredoo Tunisiana', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LY', N'Libya', N'60600', N'606', N'00', N'Libyana', N'Libyana', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LY', N'Libya', N'60601', N'606', N'01', N'Madar', N'Al-Madar Al-Jadeed', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LY', N'Libya', N'60602', N'606', N'02', N'Al-Jeel Phone', N'Al-Jeel Al-Jadeed', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LY', N'Libya', N'60603', N'606', N'03', N'Libya Phone', N'Libya Telecom & Technology (LTT)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LY', N'Libya', N'60606', N'606', N'06', N'Hatef Libya', N'Hatef Libya', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GM', N'The Gambia', N'60701', N'607', N'01', N'Gamcel', N'Gamcel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GM', N'The Gambia', N'60702', N'607', N'02', N'Africell', N'Africell', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GM', N'The Gambia', N'60703', N'607', N'03', N'Comium', N'Comium', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GM', N'The Gambia', N'60704', N'607', N'04', N'QCell', N'QCell Gambia', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GM', N'The Gambia', N'60705', N'607', N'05', null, N'Gamtel-Ecowan', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GM', N'The Gambia', N'60706', N'607', N'06', null, N'NETPAGE', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SN', N'Senegal', N'60801', N'608', N'01', N'Orange', N'Sonatel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SN', N'Senegal', N'60802', N'608', N'02', N'Free', N'Saga Africa Holdings Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SN', N'Senegal', N'60803', N'608', N'03', N'Expresso', N'Expresso Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SN', N'Senegal', N'60804', N'608', N'04', null, N'CSU-SA', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MR', N'Mauritania', N'60901', N'609', N'01', N'Mattel', N'Mattel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MR', N'Mauritania', N'60902', N'609', N'02', N'Chinguitel', N'Chinguitel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MR', N'Mauritania', N'60910', N'609', N'10', N'Moov', N'Mauritel Mobiles', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ML', N'Mali', N'61001', N'610', N'01', N'Malitel', N'Malitel SA', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ML', N'Mali', N'61002', N'610', N'02', N'Orange', N'Orange Mali SA', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ML', N'Mali', N'61003', N'610', N'03', N'Telecel', N'Alpha Telecommunication Mali S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GN', N'Guinea', N'61101', N'611', N'01', N'Orange', N'Orange S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GN', N'Guinea', N'61102', N'611', N'02', N'Sotelgui', N'Sotelgui Lagui', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GN', N'Guinea', N'61103', N'611', N'03', N'Intercel', N'Intercel Guinée', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GN', N'Guinea', N'61104', N'611', N'04', N'MTN', N'Areeba Guinea', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GN', N'Guinea', N'61105', N'611', N'05', N'Cellcom', N'Cellcom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CI', N'Côte d''Ivoire', N'61201', N'612', N'01', null, N'Cora de Comstar', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CI', N'Côte d''Ivoire', N'61202', N'612', N'02', N'Moov', N'Atlantique Cellulaire', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CI', N'Côte d''Ivoire', N'61203', N'612', N'03', N'Orange', N'Orange', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CI', N'Côte d''Ivoire', N'61204', N'612', N'04', N'KoZ', N'Comium Ivory Coast Inc', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CI', N'Côte d''Ivoire', N'61205', N'612', N'05', N'MTN', N'Loteny Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CI', N'Côte d''Ivoire', N'61206', N'612', N'06', N'GreenN', N'Oricel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CI', N'Côte d''Ivoire', N'61207', N'612', N'07', N'café', N'Aircomm', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CI', N'Côte d''Ivoire', N'61218', N'612', N'18', null, N'YooMee', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BF', N'Burkina Faso', N'61301', N'613', N'01', N'Telmob', N'Onatel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BF', N'Burkina Faso', N'61302', N'613', N'02', N'Orange', N'Orange Burkina Faso', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BF', N'Burkina Faso', N'61303', N'613', N'03', N'Telecel Faso', N'Telecel Faso SA', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NE', N'Niger', N'61401', N'614', N'01', N'SahelCom', N'La Société Sahélienne de Télécommunications (SahelCom)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NE', N'Niger', N'61402', N'614', N'02', N'Airtel', N'Bharti Airtel Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NE', N'Niger', N'61403', N'614', N'03', N'Moov', N'Atlantique Telecom (subsidiary of Etisalat)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NE', N'Niger', N'61404', N'614', N'04', N'Orange', N'Orange Niger', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TG', N'Togo', N'61501', N'615', N'01', N'Togo Cell', N'Togo Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TG', N'Togo', N'61503', N'615', N'03', N'Moov', N'Moov Togo', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BJ', N'Benin', N'61601', N'616', N'01', null, N'Benin Telecoms Mobile', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BJ', N'Benin', N'61602', N'616', N'02', N'Moov', N'Telecel Benin', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BJ', N'Benin', N'61603', N'616', N'03', N'MTN', N'Spacetel Benin', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BJ', N'Benin', N'61604', N'616', N'04', N'BBCOM', N'Bell Benin Communications', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BJ', N'Benin', N'61605', N'616', N'05', N'Glo', N'Glo Communication Benin', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MU', N'Mauritius', N'61701', N'617', N'01', N'my.t', N'Cellplus Mobile Communications Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MU', N'Mauritius', N'61702', N'617', N'02', N'MOKOZE / AZU', N'Mahanagar Telephone Mauritius Limited (MTML)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MU', N'Mauritius', N'61703', N'617', N'03', N'CHILI', N'Mahanagar Telephone Mauritius Limited (MTML)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MU', N'Mauritius', N'61710', N'617', N'10', N'Emtel', N'Emtel Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LR', N'Liberia', N'61801', N'618', N'01', N'Lonestar Cell MTN', N'Lonestar Communications Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LR', N'Liberia', N'61802', N'618', N'02', N'Libercell', N'Atlantic Wireless (Liberia) Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LR', N'Liberia', N'61804', N'618', N'04', N'Novafone', N'Novafone Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LR', N'Liberia', N'61807', N'618', N'07', N'Orange LBR', N'Orange Liberia', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LR', N'Liberia', N'61820', N'618', N'20', N'LIBTELCO', N'Liberia Telecommunications Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SL', N'Sierra Leone', N'61901', N'619', N'01', N'Orange', N'Orange SL Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SL', N'Sierra Leone', N'61902', N'619', N'02', N'Africell', N'Lintel Sierra Leone Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SL', N'Sierra Leone', N'61903', N'619', N'03', N'Africell', N'Lintel Sierra Leone Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SL', N'Sierra Leone', N'61904', N'619', N'04', N'Comium', N'Comium (Sierra Leone) Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SL', N'Sierra Leone', N'61905', N'619', N'05', N'Africell', N'Lintel Sierra Leone Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SL', N'Sierra Leone', N'61906', N'619', N'06', N'SierraTel', N'Sierra Leone Telephony', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SL', N'Sierra Leone', N'61907', N'619', N'07', null, N'Qcell Sierra Leone', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SL', N'Sierra Leone', N'61909', N'619', N'09', N'Smart Mobile', N'InterGroup Telecom SL', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SL', N'Sierra Leone', N'61925', N'619', N'25', N'Mobitel', N'Mobitel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SL', N'Sierra Leone', N'61940', N'619', N'40', null, N'Datatel (SL) Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SL', N'Sierra Leone', N'61950', N'619', N'50', null, N'Datatel (SL) Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GH', N'Ghana', N'62001', N'620', N'01', N'MTN', N'MTN Group', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GH', N'Ghana', N'62002', N'620', N'02', N'Vodafone', N'Vodafone Group', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GH', N'Ghana', N'62003', N'620', N'03', N'AirtelTigo', N'Millicom Ghana', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GH', N'Ghana', N'62004', N'620', N'04', N'Expresso', N'Kasapa / Hutchison Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GH', N'Ghana', N'62005', N'620', N'05', null, N'National Security', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GH', N'Ghana', N'62006', N'620', N'06', N'AirtelTigo', N'Airtel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GH', N'Ghana', N'62007', N'620', N'07', N'Globacom', N'Globacom Group', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GH', N'Ghana', N'62008', N'620', N'08', N'Surfline', N'Surfline Communications Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GH', N'Ghana', N'62009', N'620', N'09', N'NITA', N'National Information Technology Agency', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GH', N'Ghana', N'62010', N'620', N'10', N'Blu', N'Blu Telecommunications', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GH', N'Ghana', N'62011', N'620', N'11', null, N'Netafrique Dot Com Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GH', N'Ghana', N'62012', N'620', N'12', null, N'BTL', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GH', N'Ghana', N'62013', N'620', N'13', null, N'Goldkey', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GH', N'Ghana', N'62014', N'620', N'14', N'busy', N'BusyInternet', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GH', N'Ghana', N'62015', N'620', N'15', null, N'Lebara', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GH', N'Ghana', N'62016', N'620', N'16', null, N'Telesol', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GH', N'Ghana', N'62017', N'620', N'17', null, N'iBurst Africa', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NG', N'Nigeria', N'62100', N'621', N'00', null, N'Capcom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NG', N'Nigeria', N'62120', N'621', N'20', N'Airtel', N'Bharti Airtel Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NG', N'Nigeria', N'62122', N'621', N'22', N'InterC', N'InterC Network Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NG', N'Nigeria', N'62124', N'621', N'24', null, N'Spectranet', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NG', N'Nigeria', N'62125', N'621', N'25', N'Visafone', N'Visafone Communications Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NG', N'Nigeria', N'62126', N'621', N'26', null, N'Swift', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NG', N'Nigeria', N'62127', N'621', N'27', N'Smile', N'Smile Communications Nigeria', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NG', N'Nigeria', N'62130', N'621', N'30', N'MTN', N'MTN Nigeria Communications Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NG', N'Nigeria', N'62140', N'621', N'40', N'Ntel', N'Nigerian Mobile Telecommunications Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NG', N'Nigeria', N'62150', N'621', N'50', N'Glo', N'Globacom Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NG', N'Nigeria', N'62160', N'621', N'60', N'9mobile', N'Emerging Markets Telecommunication Services Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TD', N'Chad', N'62201', N'622', N'01', N'Airtel', N'Bharti Airtel SA', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TD', N'Chad', N'62202', N'622', N'02', N'Tawali', N'SotelTchad', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TD', N'Chad', N'62203', N'622', N'03', N'Tigo', N'Millicom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TD', N'Chad', N'62207', N'622', N'07', N'Salam', N'SotelTchad', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CF', N'Central African Republic', N'62301', N'623', N'01', N'Moov', N'Atlantique Telecom Centrafrique SA', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CF', N'Central African Republic', N'62302', N'623', N'02', N'TC', N'Telecel Centrafrique', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CF', N'Central African Republic', N'62303', N'623', N'03', N'Orange', N'Orange RCA', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CF', N'Central African Republic', N'62304', N'623', N'04', N'Azur', N'Azur RCA', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CM', N'Cameroon', N'62401', N'624', N'01', N'MTN Cameroon', N'Mobile Telephone Network Cameroon Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CM', N'Cameroon', N'62402', N'624', N'02', N'Orange', N'Orange Cameroun S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CM', N'Cameroon', N'62403', N'624', N'03', N'Camtel', N'Camtel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CM', N'Cameroon', N'62404', N'624', N'04', N'Nexttel', N'Viettel Cameroun', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CV', N'Cape Verde', N'62501', N'625', N'01', N'CVMOVEL', N'CVMóvel, S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CV', N'Cape Verde', N'62502', N'625', N'02', N'T+', N'UNITEL T+ TELECOMUNICACÕES, S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ST', N'São Tomé and Príncipe', N'62601', N'626', N'01', N'CSTmovel', N'Companhia Santomense de Telecomunicações', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ST', N'São Tomé and Príncipe', N'62602', N'626', N'02', N'Unitel STP', N'Unitel São Tomé and Príncipe', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GQ', N'Equatorial Guinea', N'62701', N'627', N'01', N'Orange GQ', N'GETESA', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GQ', N'Equatorial Guinea', N'62703', N'627', N'03', N'Muni', N'Green Com S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GA', N'Gabon', N'62801', N'628', N'01', N'Libertis', N'Gabon Telecom S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GA', N'Gabon', N'62802', N'628', N'02', N'Moov', N'Gabon Telecom S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GA', N'Gabon', N'62803', N'628', N'03', N'Airtel', N'Airtel Gabon S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GA', N'Gabon', N'62804', N'628', N'04', N'Azur', N'USAN Gabon S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GA', N'Gabon', N'62805', N'628', N'05', N'RAG', N'Réseau de l’Administration Gabonaise', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CG', N'Congo', N'62901', N'629', N'01', N'Airtel', N'Celtel Congo', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CG', N'Congo', N'62907', N'629', N'07', N'Airtel', N'Warid Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CG', N'Congo', N'62910', N'629', N'10', N'Libertis Telecom', N'MTN CONGO S.A', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CD', N'Democratic Republic of the Congo', N'63001', N'630', N'01', N'Vodacom', N'Vodacom Congo RDC sprl', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CD', N'Democratic Republic of the Congo', N'63002', N'630', N'02', N'Airtel', N'Airtel sprl', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CD', N'Democratic Republic of the Congo', N'63005', N'630', N'05', N'Supercell', N'Supercell SPRL', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CD', N'Democratic Republic of the Congo', N'63086', N'630', N'86', N'Orange RDC', N'Orange RDC sarl', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CD', N'Democratic Republic of the Congo', N'63088', N'630', N'88', N'YTT', N'Yozma Timeturns sprl', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CD', N'Democratic Republic of the Congo', N'63089', N'630', N'89', N'Orange RDC', N'Orange RDC sarl', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CD', N'Democratic Republic of the Congo', N'63090', N'630', N'90', N'Africell', N'Africell RDC sprl', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AO', N'Angola', N'63102', N'631', N'02', N'UNITEL', N'UNITEL S.a.r.l.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AO', N'Angola', N'63104', N'631', N'04', N'MOVICEL', N'MOVICEL Telecommunications S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AO', N'Angola', N'63105', N'631', N'05', null, N'Africell', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GW', N'Guinea-Bissau', N'63201', N'632', N'01', N'Guinetel', N'Guinétel S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GW', N'Guinea-Bissau', N'63202', N'632', N'02', N'MTN Areeba', N'Spacetel Guiné-Bissau S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GW', N'Guinea-Bissau', N'63203', N'632', N'03', N'Orange', null, 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GW', N'Guinea-Bissau', N'63207', N'632', N'07', N'Guinetel', N'Guinétel S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SC', N'Seychelles', N'63301', N'633', N'01', N'Cable & Wireless', N'Cable & Wireless Seychelles', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SC', N'Seychelles', N'63302', N'633', N'02', N'Mediatech', N'Mediatech International', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SC', N'Seychelles', N'63305', N'633', N'05', null, N'Intelvision Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SC', N'Seychelles', N'63310', N'633', N'10', N'Airtel', N'Telecom Seychelles Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SD', N'Sudan', N'63401', N'634', N'01', N'Zain SD', N'Zain Group - Sudan', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SD', N'Sudan', N'63402', N'634', N'02', N'MTN', N'MTN Sudan', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SD', N'Sudan', N'63403', N'634', N'03', N'MTN', N'MTN Sudan', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SD', N'Sudan', N'63405', N'634', N'05', N'canar', N'Canar Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SD', N'Sudan', N'63407', N'634', N'07', N'Sudani One', N'Sudatel Group', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SD', N'Sudan', N'63409', N'634', N'09', N'khartoum INC', N'NEC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'RW', N'Rwanda', N'63510', N'635', N'10', N'MTN', N'MTN Rwandacell SARL', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'RW', N'Rwanda', N'63511', N'635', N'11', N'Rwandatel', N'Rwandatel S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'RW', N'Rwanda', N'63512', N'635', N'12', N'Rwandatel', N'Rwandatel S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'RW', N'Rwanda', N'63513', N'635', N'13', N'Airtel', N'Airtel RWANDA', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'RW', N'Rwanda', N'63514', N'635', N'14', N'Airtel', N'Airtel RWANDA', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'RW', N'Rwanda', N'63517', N'635', N'17', N'Olleh', N'Olleh Rwanda Networks', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ET', N'Ethiopia', N'63601', N'636', N'01', N'MTN', N'Ethio Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SO', N'Somalia', N'63701', N'637', N'01', N'Telesom', N'Telesom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SO', N'Somalia', N'63704', N'637', N'04', N'Somafone', N'Somafone FZLLC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SO', N'Somalia', N'63710', N'637', N'10', N'Nationlink', N'NationLink Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SO', N'Somalia', N'63720', N'637', N'20', N'SOMNET', N'SOMNET', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SO', N'Somalia', N'63730', N'637', N'30', N'Golis', N'Golis Telecom Somalia', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SO', N'Somalia', N'63750', N'637', N'50', N'Hormuud', N'Hormuud Telecom Somalia Inc', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SO', N'Somalia', N'63757', N'637', N'57', N'UNITEL', N'UNITEL S.a.r.l.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SO', N'Somalia', N'63760', N'637', N'60', N'Nationlink', N'Nationlink Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SO', N'Somalia', N'63767', N'637', N'67', N'Horntel Group', N'HTG Group Somalia', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SO', N'Somalia', N'63770', N'637', N'70', null, N'Onkod Telecom Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SO', N'Somalia', N'63771', N'637', N'71', N'Somtel', N'Somtel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SO', N'Somalia', N'63782', N'637', N'82', N'Telcom', N'Telcom Somalia', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'DJ', N'Djibouti', N'63801', N'638', N'01', N'Evatis', N'Djibouti Telecom SA', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KE', N'Kenya', N'63901', N'639', N'01', N'Safaricom', N'Safaricom Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KE', N'Kenya', N'63902', N'639', N'02', N'Safaricom', N'Safaricom Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KE', N'Kenya', N'63903', N'639', N'03', N'Airtel', N'Bharti Airtel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KE', N'Kenya', N'63904', N'639', N'04', null, N'Mobile Pay Kenya Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KE', N'Kenya', N'63905', N'639', N'05', N'Airtel', N'Bharti Airtel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KE', N'Kenya', N'63906', N'639', N'06', null, N'Finserve Africa Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KE', N'Kenya', N'63907', N'639', N'07', N'Telkom', N'Telkom Kenya', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KE', N'Kenya', N'63908', N'639', N'08', null, N'Wetribe Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KE', N'Kenya', N'63909', N'639', N'09', null, N'Homeland Media Group Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KE', N'Kenya', N'63910', N'639', N'10', N'Faiba 4G', N'Jamii Telecommunications Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KE', N'Kenya', N'63911', N'639', N'11', null, N'Jambo Telcoms Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KE', N'Kenya', N'63912', N'639', N'12', null, N'Infura Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KE', N'Kenya', N'63913', N'639', N'13', null, N'Hidiga Investments Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KE', N'Kenya', N'63914', N'639', N'14', null, N'NRG Media Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TZ', N'Tanzania', N'64001', N'640', N'01', null, N'Shared Network Tanzania Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TZ', N'Tanzania', N'64002', N'640', N'02', N'tiGO', N'MIC Tanzania Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TZ', N'Tanzania', N'64003', N'640', N'03', N'Zantel', N'Zanzibar Telecom Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TZ', N'Tanzania', N'64004', N'640', N'04', N'Vodacom', N'Vodacom Tanzania Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TZ', N'Tanzania', N'64005', N'640', N'05', N'Airtel', N'Bharti Airtel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TZ', N'Tanzania', N'64006', N'640', N'06', null, N'WIA Company Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TZ', N'Tanzania', N'64007', N'640', N'07', N'TTCL Mobile', N'Tanzania Telecommunication Company LTD (TTCL)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TZ', N'Tanzania', N'64008', N'640', N'08', N'Smart', N'Benson Informatics Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TZ', N'Tanzania', N'64009', N'640', N'09', N'Halotel', N'Viettel Tanzania Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TZ', N'Tanzania', N'64011', N'640', N'11', N'SmileCom', N'Smile Telecoms Holdings Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TZ', N'Tanzania', N'64012', N'640', N'12', null, N'MyCell Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TZ', N'Tanzania', N'64013', N'640', N'13', N'Cootel', N'Wiafrica Tanzania Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'TZ', N'Tanzania', N'64014', N'640', N'14', null, N'MO Mobile Holding Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UG', N'Uganda', N'64101', N'641', N'01', N'Airtel', N'Bharti Airtel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UG', N'Uganda', N'64104', N'641', N'04', null, N'Tangerine Uganda Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UG', N'Uganda', N'64106', N'641', N'06', N'Vodafone', N'Afrimax Uganda', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UG', N'Uganda', N'64110', N'641', N'10', N'MTN', N'MTN Uganda', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UG', N'Uganda', N'64111', N'641', N'11', N'Uganda Telecom', N'Uganda Telecom Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UG', N'Uganda', N'64114', N'641', N'14', N'Africell', N'Africell Uganda', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UG', N'Uganda', N'64116', N'641', N'16', null, N'SimbaNET Uganda Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UG', N'Uganda', N'64118', N'641', N'18', N'Smart', N'Suretelecom Uganda Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UG', N'Uganda', N'64120', N'641', N'20', null, N'Hamilton Telecom Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UG', N'Uganda', N'64122', N'641', N'22', N'Airtel', N'Bharti Airtel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UG', N'Uganda', N'64126', N'641', N'26', N'Lycamobile', N'Lycamobile Network Services Uganda Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UG', N'Uganda', N'64130', N'641', N'30', null, N'Anupam Global Soft Uganda Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UG', N'Uganda', N'64133', N'641', N'33', N'Smile', N'Smile Communications Uganda Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UG', N'Uganda', N'64140', N'641', N'40', null, N'Civil Aviation Authority (CAA)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UG', N'Uganda', N'64144', N'641', N'44', N'K2', N'K2 Telecom Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UG', N'Uganda', N'64166', N'641', N'66', N'i-Tel', N'i-Tel Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BI', N'Burundi', N'64201', N'642', N'01', N'econet Leo', N'Econet Wireless Burundi PLC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BI', N'Burundi', N'64202', N'642', N'02', N'Tempo', N'VTEL MEA', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BI', N'Burundi', N'64203', N'642', N'03', N'Onatel', N'Onatel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BI', N'Burundi', N'64207', N'642', N'07', N'Smart Mobile', N'LACELL SU', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BI', N'Burundi', N'64208', N'642', N'08', N'Lumitel', N'Viettel Burundi', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BI', N'Burundi', N'64282', N'642', N'82', N'econet Leo', N'Econet Wireless Burundi PLC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MZ', N'Mozambique', N'64301', N'643', N'01', N'mCel', N'Mocambique Celular S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MZ', N'Mozambique', N'64303', N'643', N'03', N'Movitel', N'Movitel, SA', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MZ', N'Mozambique', N'64304', N'643', N'04', N'Vodacom', N'Vodacom Mozambique, S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZM', N'Zambia', N'64501', N'645', N'01', N'Airtel', N'Bharti Airtel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZM', N'Zambia', N'64502', N'645', N'02', N'MTN', N'MTN Group', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZM', N'Zambia', N'64503', N'645', N'03', N'ZAMTEL', N'Zambia Telecommunications Company Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZM', N'Zambia', N'64507', N'645', N'07', null, N'Liquid Telecom Zambia Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MG', N'Madagascar', N'64601', N'646', N'01', N'Airtel', N'Bharti Airtel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MG', N'Madagascar', N'64602', N'646', N'02', N'Orange', N'Orange Madagascar S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MG', N'Madagascar', N'64603', N'646', N'03', N'Sacel', N'Sacel Madagascar S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MG', N'Madagascar', N'64604', N'646', N'04', N'Telma', N'Telma Mobile S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MG', N'Madagascar', N'64605', N'646', N'05', N'BIP / blueline', N'Gulfsat Madagascar S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZW', N'Zimbabwe', N'64801', N'648', N'01', N'Net*One', N'Net*One Cellular (Pvt) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZW', N'Zimbabwe', N'64803', N'648', N'03', N'Telecel', N'Telecel Zimbabwe (PVT) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZW', N'Zimbabwe', N'64804', N'648', N'04', N'Econet', N'Econet Wireless', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NA', N'Namibia', N'64901', N'649', N'01', N'MTC', N'MTC Namibia', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NA', N'Namibia', N'64902', N'649', N'02', N'switch', N'Telecom Namibia', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NA', N'Namibia', N'64903', N'649', N'03', N'TN Mobile', N'Telecom Namibia', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NA', N'Namibia', N'64904', N'649', N'04', null, N'Paratus Telecommunications (Pty)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NA', N'Namibia', N'64905', N'649', N'05', null, N'Demshi Investments CC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NA', N'Namibia', N'64906', N'649', N'06', null, N'MTN Namibia', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NA', N'Namibia', N'64907', N'649', N'07', null, N'Capricorn Connect', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MW', N'Malawi', N'65001', N'650', N'01', N'TNM', N'Telecom Network Malawi', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MW', N'Malawi', N'65002', N'650', N'02', N'Access', N'Access Communications Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MW', N'Malawi', N'65003', N'650', N'03', N'MTL', N'Malawi Telecommunications Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MW', N'Malawi', N'65010', N'650', N'10', N'Airtel', N'Airtel Malawi Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LS', N'Lesotho', N'65101', N'651', N'01', N'Vodacom', N'Vodacom Lesotho (Pty) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LS', N'Lesotho', N'65102', N'651', N'02', N'Econet Telecom', N'Econet Ezi-cel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LS', N'Lesotho', N'65110', N'651', N'10', N'Vodacom', N'Vodacom Lesotho (Pty) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BW', N'Botswana', N'65201', N'652', N'01', N'Mascom', N'Mascom Wireless (Pty) Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BW', N'Botswana', N'65202', N'652', N'02', N'Orange', N'Orange (Botswana) Pty Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BW', N'Botswana', N'65204', N'652', N'04', N'beMobile', N'Botswana Telecommunications Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SZ', N'Swaziland', N'65301', N'653', N'01', null, N'SPTC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SZ', N'Swaziland', N'65302', N'653', N'02', null, N'Eswatini Mobile Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SZ', N'Swaziland', N'65310', N'653', N'10', N'MTN Eswatini', N'MTN Eswatini Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KM', N'Comoros', N'65401', N'654', N'01', N'HURI', N'Comores Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'KM', N'Comoros', N'65402', N'654', N'02', N'TELCO SA', N'Telecom Malagasy (Telma)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65501', N'655', N'01', N'Vodacom', N'Vodacom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65502', N'655', N'02', N'Telkom', N'Telkom SA SOC Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65503', N'655', N'03', N'Telkom', N'Telkom SA SOC Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65504', N'655', N'04', null, N'Sasol (Pty) Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65505', N'655', N'05', null, N'Telkom SA Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65506', N'655', N'06', null, N'Sentech (Pty) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65507', N'655', N'07', N'Cell C', N'Cell C (Pty) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65510', N'655', N'10', N'MTN', N'MTN Group', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65511', N'655', N'11', null, N'South African Police Service Gauteng', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65512', N'655', N'12', N'MTN', N'MTN Group', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65513', N'655', N'13', N'Neotel', N'Neotel Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65514', N'655', N'14', N'Neotel', N'Neotel Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65516', N'655', N'16', null, N'Phoenix System Integration (Pty) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65517', N'655', N'17', null, N'Sishen Iron Ore Company (Ltd) Pty', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65519', N'655', N'19', N'rain', N'Wireless Business Solutions (Pty) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65521', N'655', N'21', null, N'Cape Town Metropolitan Council', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65524', N'655', N'24', null, N'SMSPortal (Pty) Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65525', N'655', N'25', null, N'Wirels Connect', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65527', N'655', N'27', null, N'A to Z Vaal Industrial Supplies Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65528', N'655', N'28', null, N'Hymax Talking Solutions (Pty) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65530', N'655', N'30', null, N'Bokamoso Consortium', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65531', N'655', N'31', null, N'Karabo Telecoms (Pty) Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65532', N'655', N'32', null, N'Ilizwi Telecommunications', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65533', N'655', N'33', null, N'Thinta Thinta Telecommunications Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65534', N'655', N'34', null, N'Bokone Telecoms Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65535', N'655', N'35', null, N'Kingdom Communications Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65536', N'655', N'36', null, N'Amatole Telecommunications Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65538', N'655', N'38', N'rain', N'Wireless Business Solutions (Pty) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65541', N'655', N'41', null, N'South African Police Service', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65546', N'655', N'46', null, N'SMS Cellular Services (Pty) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65550', N'655', N'50', null, N'Ericsson South Africa (Pty) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65551', N'655', N'51', null, N'Integrat (Pty) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65553', N'655', N'53', N'Lycamobile', N'Lycamobile (Pty) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65565', N'655', N'65', null, N'Vodacom Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65573', N'655', N'73', N'rain', N'Wireless Business Solutions (Pty) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65574', N'655', N'74', N'rain', N'Wireless Business Solutions (Pty) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65575', N'655', N'75', N'ACSA', N'Airports Company South Africa', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65576', N'655', N'76', null, N'Comsol Networks (Pty) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ZA', N'South Africa', N'65577', N'655', N'77', N'Umoja Connect', N'One Telecom (Pty) Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'ER', N'Eritrea', N'65701', N'657', N'01', N'Eritel', N'Eritrea Telecommunications Services Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SH', N'Saint Helena', N'65801', N'658', N'01', N'Sure', N'Sure South Atlantic Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SS', N'South Sudan', N'65902', N'659', N'02', N'MTN', N'MTN South Sudan', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SS', N'South Sudan', N'65903', N'659', N'03', N'Gemtel', N'Gemtel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SS', N'South Sudan', N'65904', N'659', N'04', N'Vivacell', N'Network of the World (NOW)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SS', N'South Sudan', N'65906', N'659', N'06', N'Zain', N'Zain South Sudan', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SS', N'South Sudan', N'65907', N'659', N'07', N'Sudani', N'Sudani', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BZ', N'Belize', N'70267', N'702', N'67', N'DigiCell', N'Belize Telemedia Limited (BTL)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BZ', N'Belize', N'70268', N'702', N'68', N'INTELCO', N'International Telecommunications Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BZ', N'Belize', N'70269', N'702', N'69', N'SMART', N'Speednet Communications Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BZ', N'Belize', N'70299', N'702', N'99', N'SMART', N'Speednet Communications Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GT', N'Guatemala', N'70401', N'704', N'01', N'Claro', N'Telecomunicaciones de Guatemala, S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GT', N'Guatemala', N'70402', N'704', N'02', N'Tigo', N'Millicom / Local partners', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GT', N'Guatemala', N'70403', N'704', N'03', N'Claro', N'Telecomunicaciones de Guatemala, S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SV', N'El Salvador', N'70601', N'706', N'01', N'Claro', N'CTE Telecom Personal, S.A. de C.V.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SV', N'El Salvador', N'70602', N'706', N'02', N'Digicel', N'Digicel, S.A. de C.V.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SV', N'El Salvador', N'70603', N'706', N'03', N'Tigo', N'Telemovil El Salvador S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SV', N'El Salvador', N'70604', N'706', N'04', N'Movistar', N'Telefónica Móviles El Salvador', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SV', N'El Salvador', N'70605', N'706', N'05', N'RED', N'INTELFON, S.A. de C.V.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HN', N'Honduras', N'708001', N'708', N'001', N'Claro', N'Servicios de Comunicaciones de Honduras S.A. de C.V.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HN', N'Honduras', N'708002', N'708', N'002', N'Tigo', N'Celtel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HN', N'Honduras', N'708030', N'708', N'030', N'Hondutel', N'Empresa Hondureña de Telecomunicaciones', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'HN', N'Honduras', N'708040', N'708', N'040', N'Digicel', N'Digicel de Honduras', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NI', N'Nicaragua', N'71021', N'710', N'21', N'Claro', N'Empresa Nicaragüense de Telecomunicaciones, S.A. (ENITEL) (América Móvil)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NI', N'Nicaragua', N'710300', N'710', N'300', N'Tigo', N'Telefonía Celular de Nicaragua, S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'NI', N'Nicaragua', N'71073', N'710', N'73', N'Claro', N'Servicios de Comunicaciones S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CR', N'Costa Rica', N'71201', N'712', N'01', N'Kölbi ICE', N'Instituto Costarricense de Electricidad', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CR', N'Costa Rica', N'71202', N'712', N'02', N'Kölbi ICE', N'Instituto Costarricense de Electricidad', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CR', N'Costa Rica', N'71203', N'712', N'03', N'Claro', N'Claro CR Telecomunicaciones (Aló)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CR', N'Costa Rica', N'71204', N'712', N'04', N'Liberty', N'Liberty Latin America', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CR', N'Costa Rica', N'71220', N'712', N'20', N'fullmóvil', N'Virtualis S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PA', N'Panama', N'71401', N'714', N'01', N'Cable & Wireless', N'Cable & Wireless Panama S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PA', N'Panama', N'71402', N'714', N'02', N'Tigo', N'Grupo de Comunicaciones Digitales, S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PA', N'Panama', N'714020', N'714', N'020', N'Tigo', N'Grupo de Comunicaciones Digitales, S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PA', N'Panama', N'71403', N'714', N'03', N'Claro', N'América Móvil', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PA', N'Panama', N'71404', N'714', N'04', N'Digicel', N'Digicel Group', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PA', N'Panama', N'71405', N'714', N'05', N'Cable & Wireless', N'Cable & Wireless Panama S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PE', N'Peru', N'71606', N'716', N'06', N'Movistar', N'Telefónica del Perú S.A.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PE', N'Peru', N'71607', N'716', N'07', N'Entel', N'Entel Perú S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PE', N'Peru', N'71610', N'716', N'10', N'Claro', N'América Móvil Perú', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PE', N'Peru', N'71615', N'716', N'15', N'Bitel', N'Viettel Peru S.A.C.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PE', N'Peru', N'71617', N'716', N'17', N'Entel', N'Entel Perú S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AR', N'Argentina', N'722010', N'722', N'010', N'Movistar', N'Telefónica Móviles Argentina S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AR', N'Argentina', N'722020', N'722', N'020', N'Nextel', N'NII Holdings', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AR', N'Argentina', N'722034', N'722', N'034', N'Personal', N'Telecom Personal S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AR', N'Argentina', N'722040', N'722', N'040', N'Globalstar', N'TE.SA.M Argentina S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AR', N'Argentina', N'722070', N'722', N'070', N'Movistar', N'Telefónica Móviles Argentina S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AR', N'Argentina', N'722310', N'722', N'310', N'Claro', N'AMX Argentina S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AR', N'Argentina', N'722320', N'722', N'320', N'Claro', N'AMX Argentina S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AR', N'Argentina', N'722330', N'722', N'330', N'Claro', N'AMX Argentina S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AR', N'Argentina', N'722341', N'722', N'341', N'Personal', N'Telecom Personal S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AR', N'Argentina', N'722350', N'722', N'350', N'PORT-HABLE', N'Hutchison Telecommunications Argentina S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72400', N'724', N'00', N'Nextel', N'NII Holdings, Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72401', N'724', N'01', null, N'SISTEER DO BRASIL TELECOMUNICAÇÔES', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72402', N'724', N'02', N'TIM', N'Telecom Italia Mobile', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72403', N'724', N'03', N'TIM', N'Telecom Italia Mobile', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72404', N'724', N'04', N'TIM', N'Telecom Italia Mobile', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72405', N'724', N'05', N'Claro', N'Claro', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72406', N'724', N'06', N'Vivo', N'Telefônica Brasil S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72410', N'724', N'10', N'Vivo', N'Telefônica Brasil S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72411', N'724', N'11', N'Vivo', N'Telefônica Brasil S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72412', N'724', N'12', N'Claro', N'Claro', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72415', N'724', N'15', N'Sercomtel', N'Sercomtel Celular', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72416', N'724', N'16', N'Brasil Telecom GSM', N'Brasil Telecom GSM', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72417', N'724', N'17', N'Surf Telecom', N'Correios Celula', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72418', N'724', N'18', N'datora', N'Datora (Vodafone)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72421', N'724', N'21', N'LIGUE', N'Ligue Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72423', N'724', N'23', N'Vivo', N'Telefônica Brasil S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72424', N'724', N'24', null, N'Amazonia Celular', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72428', N'724', N'28', N'No name', null, 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72429', N'724', N'29', N'Unifique', N'Unifique Telecomunicações S/A', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72430', N'724', N'30', N'Oi', N'TNL PCS Oi', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72431', N'724', N'31', N'Oi', N'TNL PCS Oi', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72432', N'724', N'32', N'Algar Telecom', N'Algar Telecom S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72433', N'724', N'33', N'Algar Telecom', N'Algar Telecom S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72434', N'724', N'34', N'Algar Telecom', N'Algar Telecom S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72435', N'724', N'35', null, N'Telcom Telecomunicações', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72436', N'724', N'36', null, N'Options Telecomunicações', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72437', N'724', N'37', N'aeiou', N'Unicel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72438', N'724', N'38', N'Claro', N'Claro', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72439', N'724', N'39', N'Nextel', N'NII Holdings, Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72454', N'724', N'54', N'Conecta', N'PORTO SEGURO TELECOMUNICAÇÔES', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BR', N'Brazil', N'72499', N'724', N'99', N'Local', null, 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73001', N'730', N'01', N'entel', N'Entel Telefonía Móvil S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73002', N'730', N'02', N'Movistar', N'Telefónica Móvil de Chile', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73003', N'730', N'03', N'CLARO CL', N'Claro Chile S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73004', N'730', N'04', N'WOM', N'Novator Partners', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73005', N'730', N'05', null, N'Multikom S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73006', N'730', N'06', N'Telsur', N'Blue Two Chile S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73007', N'730', N'07', N'Movistar', N'Telefónica Móvil de Chile', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73008', N'730', N'08', N'VTR Móvil', N'VTR S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73009', N'730', N'09', N'WOM', N'Novator Partners', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73010', N'730', N'10', N'entel', N'Entel Telefonía Móvil S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73011', N'730', N'11', null, N'Celupago S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73012', N'730', N'12', N'Colo-Colo MóvilWanderers Móvil', N'Telestar Móvil S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73013', N'730', N'13', N'Virgin Mobile', N'Tribe Mobile Chile SPA', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73014', N'730', N'14', null, N'Netline Telefónica Móvil Ltda', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73015', N'730', N'15', null, N'Cibeles Telecom S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73016', N'730', N'16', null, N'Nomade Telecomunicaciones S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73017', N'730', N'17', null, N'COMPATEL Chile Limitada', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73018', N'730', N'18', null, N'Empresas Bunker S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73019', N'730', N'19', N'móvil Falabella', N'Sociedad Falabella Móvil SPA', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73020', N'730', N'20', null, N'Inversiones Santa Fe Limitada', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73022', N'730', N'22', null, N'Cellplus SpA', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73023', N'730', N'23', null, N'Claro Servicios Empresariales S. A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73026', N'730', N'26', null, N'WILL S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73027', N'730', N'27', null, N'Cibeles Telecom S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CL', N'Chile', N'73099', N'730', N'99', N'Will', N'WILL Telefonía', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732001', N'732', N'001', N'Movistar', N'Colombia Telecomunicaciones S.A. ESP', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732002', N'732', N'002', N'Edatel', N'Edatel S.A. ESP', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732003', N'732', N'003', null, N'LLEIDA S.A.S.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732004', N'732', N'004', null, N'COMPATEL COLOMBIA SAS', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732020', N'732', N'020', N'Tigo', N'Une EPM Telecomunicaciones S.A. E.S.P.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732099', N'732', N'099', N'EMCALI', N'Empresas Municipales de Cali', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732100', N'732', N'100', N'Claro', N'Comunicacion Celular S.A. (Comcel)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732101', N'732', N'101', N'Claro', N'Comunicacion Celular S.A. (Comcel)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732102', N'732', N'102', null, N'Bellsouth Colombia', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732103', N'732', N'103', N'Tigo', N'Colombia Móvil S.A. ESP', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732111', N'732', N'111', N'Tigo', N'Colombia Móvil S.A. ESP', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732123', N'732', N'123', N'Movistar', N'Colombia Telecomunicaciones S.A. ESP', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732124', N'732', N'124', N'Movistar', N'Colombia Telecomunicaciones S.A. ESP', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732130', N'732', N'130', N'AVANTEL', N'Avantel S.A.S', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732142', N'732', N'142', null, N'Une EPM Telecomunicaciones S.A. E.S.P.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732154', N'732', N'154', N'Virgin Mobile', N'Virgin Mobile Colombia S.A.S.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732165', N'732', N'165', null, N'Colombia Móvil S.A. ESP', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732176', N'732', N'176', null, N'DirecTV Colombia Ltda', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732187', N'732', N'187', N'eTb', N'Empresa de Telecomunicaciones de Bogotá S.A. ESP', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732199', N'732', N'199', null, N'SUMA Movil SAS', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732208', N'732', N'208', null, N'UFF Movil SAS', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732210', N'732', N'210', null, N'Hablame Colombia SAS ESP', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732220', N'732', N'220', null, N'Libre Tecnologias SAS', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732230', N'732', N'230', null, N'Setroc Mobile Group SAS', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732240', N'732', N'240', null, N'Logistica Flash Colombia SAS', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732250', N'732', N'250', null, N'Plintron Colombia SAS', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732360', N'732', N'360', N'WOM', N'Partners Telecom Colombia SAS', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'CO', N'Colombia', N'732666', N'732', N'666', N'Claro', N'Comunicacion Celular S.A. (Comcel)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VE', N'Venezuela', N'73401', N'734', N'01', N'Digitel', N'Corporacion Digitel C.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VE', N'Venezuela', N'73402', N'734', N'02', N'Digitel GSM', N'Corporacion Digitel C.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VE', N'Venezuela', N'73403', N'734', N'03', N'DirecTV', N'Galaxy Entertainment de Venezuela C.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VE', N'Venezuela', N'73404', N'734', N'04', N'Movistar', N'Telefónica Móviles Venezuela', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VE', N'Venezuela', N'73406', N'734', N'06', N'Movilnet', N'Telecomunicaciones Movilnet', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BO', N'Bolivia', N'73601', N'736', N'01', N'Viva', N'Nuevatel PCS De Bolivia SA', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BO', N'Bolivia', N'73602', N'736', N'02', N'Entel', N'Entel SA', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BO', N'Bolivia', N'73603', N'736', N'03', N'Tigo', N'Telefónica Celular De Bolivia S.A', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GY', N'Guyana', N'73800', N'738', N'00', N'E-Networks', N'E-Networks Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GY', N'Guyana', N'738002', N'738', N'002', N'GT&T Cellink Plus', N'Guyana Telephone & Telegraph Co.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GY', N'Guyana', N'738003', N'738', N'003', null, N'Quark Communications Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GY', N'Guyana', N'73801', N'738', N'01', N'Digicel', N'U-Mobile (Cellular) Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GY', N'Guyana', N'738040', N'738', N'040', N'E-Networks', N'E-Networks Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GY', N'Guyana', N'73805', N'738', N'05', null, N'eGovernment Unit, Ministry of the Presidency', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'EC', N'Ecuador', N'74000', N'740', N'00', N'Movistar', N'Otecel S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'EC', N'Ecuador', N'74001', N'740', N'01', N'Claro', N'CONECEL S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'EC', N'Ecuador', N'74002', N'740', N'02', N'CNT Mobile', N'Corporación Nacional de Telecomunicaciones (CNT EP)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'EC', N'Ecuador', N'74003', N'740', N'03', N'Tuenti', N'Otecel S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GF', N'French Guiana', N'74204', N'742', N'04', N'Free', N'Free Caraïbe', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PY', N'Paraguay', N'74401', N'744', N'01', N'VOX', N'Hola Paraguay S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PY', N'Paraguay', N'74402', N'744', N'02', N'Claro', N'AMX Paraguay S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PY', N'Paraguay', N'74403', N'744', N'03', null, N'Compañia Privada de Comunicaciones S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PY', N'Paraguay', N'74404', N'744', N'04', N'Tigo', N'Telefónica Celular Del Paraguay S.A. (Telecel)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PY', N'Paraguay', N'74405', N'744', N'05', N'Personal', N'Núcleo S.A. (TIM)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PY', N'Paraguay', N'74406', N'744', N'06', N'Copaco', N'Copaco S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SR', N'Suriname', N'74602', N'746', N'02', N'Telesur', N'Telecommunications Company Suriname (Telesur)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SR', N'Suriname', N'74603', N'746', N'03', N'Digicel', N'Digicel Group Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SR', N'Suriname', N'74604', N'746', N'04', N'Digicel', N'Digicel Group Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'SR', N'Suriname', N'74605', N'746', N'05', N'Telesur', N'Telecommunications Company Suriname (Telesur)', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UY', N'Uruguay', N'74800', N'748', N'00', N'Antel', N'Administración Nacional de Telecomunicaciones', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UY', N'Uruguay', N'74801', N'748', N'01', N'Antel', N'Administración Nacional de Telecomunicaciones', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UY', N'Uruguay', N'74803', N'748', N'03', N'Antel', N'Administración Nacional de Telecomunicaciones', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UY', N'Uruguay', N'74807', N'748', N'07', N'Movistar', N'Telefónica Móviles Uruguay', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UY', N'Uruguay', N'74810', N'748', N'10', N'Claro', N'AM Wireless Uruguay S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'UY', N'Uruguay', N'74815', N'748', N'15', null, N'ENALUR S.A.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'FK', N'Falkland Islands', N'750001', N'750', N'001', N'Sure', N'Sure South Atlantic Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'99903', N'999', N'03', N'1&1', N'Drillisch Online AG', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'DE', N'Germany', N'99907', N'999', N'07', N'1&1', N'Drillisch Online AG', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            );

            set @log_message = N'Insert genereated ones ';

            exec etl.log_event @proc, @arg_job, @log_message;

            insert into dm_dom_network_usage.itm_rel_network_provider_worldzone (
                country_cd
              , country_desc
              , network_provider_id
              , mcc
              , mnc
              , brand
              , operator
              , basic_service
              , worldzone_id
              , worldzone_desc
              , dm_load_date
              , dm_load_job_id
            )
            values (
                N'US', N'United States', N'314100', N'314', N'100', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314101', N'314', N'101', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314102', N'314', N'102', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314103', N'314', N'103', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314104', N'314', N'104', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314105', N'314', N'105', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314106', N'314', N'106', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314107', N'314', N'107', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314108', N'314', N'108', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314109', N'314', N'109', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314110', N'314', N'110', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314111', N'314', N'111', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314112', N'314', N'112', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314113', N'314', N'113', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314114', N'314', N'114', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314115', N'314', N'115', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314116', N'314', N'116', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314117', N'314', N'117', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314118', N'314', N'118', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314119', N'314', N'119', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314120', N'314', N'120', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314121', N'314', N'121', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314122', N'314', N'122', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314123', N'314', N'123', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314124', N'314', N'124', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314125', N'314', N'125', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314126', N'314', N'126', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314127', N'314', N'127', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314128', N'314', N'128', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314129', N'314', N'129', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314130', N'314', N'130', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314131', N'314', N'131', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314132', N'314', N'132', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314133', N'314', N'133', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314134', N'314', N'134', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314135', N'314', N'135', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314136', N'314', N'136', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314137', N'314', N'137', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314138', N'314', N'138', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314139', N'314', N'139', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314140', N'314', N'140', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314141', N'314', N'141', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314142', N'314', N'142', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314143', N'314', N'143', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314144', N'314', N'144', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314145', N'314', N'145', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314146', N'314', N'146', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314147', N'314', N'147', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314148', N'314', N'148', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314149', N'314', N'149', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314150', N'314', N'150', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314151', N'314', N'151', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314152', N'314', N'152', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314153', N'314', N'153', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314154', N'314', N'154', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314155', N'314', N'155', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314156', N'314', N'156', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314157', N'314', N'157', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314158', N'314', N'158', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314159', N'314', N'159', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314160', N'314', N'160', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314161', N'314', N'161', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314162', N'314', N'162', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314163', N'314', N'163', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314164', N'314', N'164', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314165', N'314', N'165', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314166', N'314', N'166', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314167', N'314', N'167', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314168', N'314', N'168', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314169', N'314', N'169', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314170', N'314', N'170', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314171', N'314', N'171', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314172', N'314', N'172', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314173', N'314', N'173', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314174', N'314', N'174', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314175', N'314', N'175', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314176', N'314', N'176', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314177', N'314', N'177', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314178', N'314', N'178', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314179', N'314', N'179', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314180', N'314', N'180', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314181', N'314', N'181', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314182', N'314', N'182', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314183', N'314', N'183', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314184', N'314', N'184', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314185', N'314', N'185', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314186', N'314', N'186', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314187', N'314', N'187', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314188', N'314', N'188', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314189', N'314', N'189', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'314190', N'314', N'190', null, N'Reserved for Public Safety', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            );

            set @log_message = N'Insert triggy ones ';

            exec etl.log_event @proc, @arg_job, @log_message;

            insert into dm_dom_network_usage.itm_rel_network_provider_worldzone (
                country_cd
              , country_desc
              , network_provider_id
              , mcc
              , mnc
              , brand
              , operator
              , basic_service
              , worldzone_id
              , worldzone_desc
              , dm_load_date
              , dm_load_job_id
            )
            values (
                N'AU', N'Australia', N'50501', N'505', N'01', N'Telstra', N'Telstra Corporation Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50502', N'505', N'02', N'Optus', N'Singtel Optus Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50503', N'505', N'03', N'Vodafone', N'Vodafone Hutchison Australia Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50504', N'505', N'04', null, N'Department of Defence', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50505', N'505', N'05', N'Ozitel', null, 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50506', N'505', N'06', N'3', N'Vodafone Hutchison Australia Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50507', N'505', N'07', N'Vodafone', N'Vodafone Network Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50508', N'505', N'08', N'One.Tel', N'One.Tel Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50509', N'505', N'09', N'Airnet', null, 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50511', N'505', N'11', N'Telstra', N'Telstra Corporation Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50512', N'505', N'12', N'3', N'Vodafone Hutchison Australia Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50513', N'505', N'13', N'RailCorp', N'Railcorp, Transport for NSW', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50514', N'505', N'14', N'AAPT', N'TPG Telecom', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50515', N'505', N'15', N'3GIS', null, 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50516', N'505', N'16', N'VicTrack', N'Victorian Rail Track', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50517', N'505', N'17', null, N'Optus', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50518', N'505', N'18', N'Pactel', N'Pactel International Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50519', N'505', N'19', N'Lycamobile', N'Lycamobile Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50520', N'505', N'20', null, N'Ausgrid Corporation', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50521', N'505', N'21', null, N'Queensland Rail Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50522', N'505', N'22', null, N'iiNet Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50523', N'505', N'23', null, N'Challenge Networks Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50524', N'505', N'24', null, N'Advanced Communications Technologies Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50525', N'505', N'25', null, N'Pilbara Iron Company Services Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50526', N'505', N'26', null, N'Dialogue Communications Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50527', N'505', N'27', null, N'Nexium Telecommunications', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50528', N'505', N'28', null, N'RCOM International Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50530', N'505', N'30', null, N'Compatel Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50531', N'505', N'31', null, N'BHP', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50532', N'505', N'32', null, N'Thales Australia', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50533', N'505', N'33', null, N'CLX Networks Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50534', N'505', N'34', null, N'Santos Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50535', N'505', N'35', null, N'MessageBird Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50536', N'505', N'36', N'Optus', N'Optus Mobile Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50537', N'505', N'37', null, N'Yancoal Australia Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50538', N'505', N'38', N'Truphone', N'Truphone Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50539', N'505', N'39', N'Telstra', N'Telstra Corporation Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50540', N'505', N'40', null, N'CITIC Pacific Mining', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50541', N'505', N'41', null, N'Aqura Technologies Pty', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50542', N'505', N'42', N'GEMCO', N'Groote Eylandt Mining Company Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50543', N'505', N'43', null, N'Arrow Energy Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50544', N'505', N'44', null, N'Roy Hill Iron Ore Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50545', N'505', N'45', null, N'Clermont Coal Operations Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50546', N'505', N'46', null, N'AngloGold Ashanti Australia Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50547', N'505', N'47', null, N'Woodside Energy Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50548', N'505', N'48', null, N'Titan ICT Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50549', N'505', N'49', null, N'Field Solutions Group Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50550', N'505', N'50', null, N'Pivotel Group Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50551', N'505', N'51', null, N'Fortescue Metals Group', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50552', N'505', N'52', null, N'OptiTel Australia', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50553', N'505', N'53', null, N'Shell Australia Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50554', N'505', N'54', null, N'Nokia Solutions and Networks Australia Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50561', N'505', N'61', N'CommTel NS', N'Commtel Network Solutions Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50562', N'505', N'62', N'NBN', N'National Broadband Network Co.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50568', N'505', N'68', N'NBN', N'National Broadband Network Co.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50571', N'505', N'71', N'Telstra', N'Telstra Corporation Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50572', N'505', N'72', N'Telstra', N'Telstra Corporation Limited', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50588', N'505', N'88', null, N'Pivotel Group Pty Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50590', N'505', N'90', N'Optus', N'Singtel Optus Proprietary Ltd', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AU', N'Australia', N'50599', N'505', N'99', N'One.Tel', N'One.Tel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'LC', N'Saint Lucia', N'33805', N'338', N'05', N'Digicel', N'Digicel', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            );

            insert into dm_dom_network_usage.itm_rel_network_provider_worldzone (
                country_cd
              , country_desc
              , network_provider_id
              , mcc
              , mnc
              , brand
              , operator
              , basic_service
              , worldzone_id
              , worldzone_desc
              , dm_load_date
              , dm_load_job_id
            )
            values (
                N'JE', N'Jersey', N'23403', N'234', N'03', N'Airtel-Vodafone', N'Jersey Airtel Limited', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'IM', N'Isle of Man', N'23418', N'234', N'18', N'Cloud 9 Mobile', N'Cloud 9 Mobile Communications PLC', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23428', N'234', N'28', null, N'Marathon Telecom Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'IM', N'Isle of Man', N'23436', N'234', N'36', N'Sure Mobile', N'Sure Isle of Man Ltd.', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23450', N'234', N'50', N'JT', N'JT Group Limited', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GG', N'Guernsey', N'23455', N'234', N'55', N'Sure Mobile', N'Sure (Guernsey) Limited', 'data', '2', 'Weltzone 2', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23458', N'234', N'58', N'Pronto GSM', N'Manx Telecom', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'GB', N'United Kingdom', N'23473', N'234', N'73', null, N'Bluewave Communications Ltd', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'RU', N'Russia', N'25012', N'250', N'12', N'Baykalwestcom', N' Akos / Baykal Westcom / New Telephone Company / Far Eastern Cellular', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'LU', N'Luxembourg', N'27077', N'270', N'77', N'Tango', N'Tango SA', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'LU', N'Luxembourg', N'27099', N'270', N'99', N'Orange', N'Orange S.A.', 'data', '1', 'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'PR', N'Puerto Rico', N'310017', N'310', N'017', N'ProxTel', N'North Sight Communications Inc.', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'GU', N'Guam', N'310032', N'310', N'032', N'IT&E Wireless', N'IT&E Overseas, Inc', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GU', N'Guam', N'310033', N'310', N'033', null, N'Guam Telephone Authority', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'MP', N'Northern Marianas', N'310110', N'310', N'110', N'IT&E Wireless', N'PTI Pacifica Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310120', N'310', N'120', N'T-Mobile', N'T-Mobile US', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'GU', N'Guam', N'310140', N'310', N'140', N'GTA Wireless', N'Teleguam Holdings, LLC', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VI', N'US Virgin Islands', N'310260', N'310', N'260', N'T-Mobile', N'T-Mobile US', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PR', N'Puerto Rico', N'310280', N'310', N'280', N'AT&T', N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'MP', N'Northern Marianas', N'310370', N'310', N'370', N'Docomo', N'NTT DoCoMo Pacific', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GU', N'Guam', N'310400', N'310', N'400', N'IT&E Wireless', N'IT&E Overseas, Inc', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'US', N'United States', N'310410', N'310', N'410', N'AT&T', N'AT&T Mobility', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'GU', N'Guam', N'310470', N'310', N'470', N'Docomo', N'NTT DoCoMo Pacific', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GU', N'Guam', N'310480', N'310', N'480', N'IT&E Wireless', N'IT&E Overseas, Inc', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GU', N'Guam', N'311120', N'311', N'120', N'IT&E Wireless', N'IT&E Overseas, Inc', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GU', N'Guam', N'311250', N'311', N'250', N'IT&E Wireless', N'IT&E Overseas, Inc', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'VI', N'US Virgin Islands', N'311470', N'311', N'470', N'Viya', N'Vitelcom Cellular Inc.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'AS', N'American Samoa', N'311780', N'311', N'780', N'ASTCA', N'American Samoa Telecommunications', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PR', N'Puerto Rico', N'313510', N'313', N'510', null, N'Puerto Rico Telecom Company', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'PR', N'Puerto Rico', N'313790', N'313', N'790', N'Liberty', N'Liberty Cablevision of Puerto Rico LLC', 'data', '3', 'Weltzone 3', @arg_load_date, @arg_job
            )
                 , (
                N'BM', N'Bermuda', N'338050', N'338', N'050', N'Digicel Bermuda', null, 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PS', N'Palestinian Territory, Occupied', N'42505', N'425', N'05', N'Jawwal', N'Palestine Cellular Communications, Ltd.', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'PS', N'Palestinian Territory, Occupied', N'42506', N'425', N'06', N'Ooredoo', N'Ooredoo Palestine', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'IR', N'Iran', N'43293', N'432', N'93', N'Iraphone', N'Iraphone & Farzanegan Pars', 'data', '4', 'Weltzone 4', @arg_load_date, @arg_job
            );

            insert into dm_dom_network_usage.itm_rel_network_provider_worldzone (
                country_cd
              , country_desc
              , network_provider_id
              , mcc
              , mnc
              , brand
              , operator
              , basic_service
              , worldzone_id
              , worldzone_desc
              , dm_load_date
              , dm_load_job_id
            )
            values (
                N'GE', N'Georgia', N'28967', N'289', N'67', N'Aquafon', N'Aquafon JSC', 'data', 4, N'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'GE', N'Georgia', N'28988', N'289', N'88', N'A-Mobile', N'A-Mobile LLSC', 'data', 4, N'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BL', N'Saint-Barthelemy', N'34003', N'340', N'03', N'FLOW', N'UTS Caraïbe', 'data', 1, N'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BL', N'Saint-Barthelemy', N'34004', N'340', N'04', N'Free', N'Free Caraïbe', 'data', 1, N'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BL', N'Saint-Barthelemy', N'34008', N'340', N'08', N'Dauphin', N'Dauphin Telecom', 'data', 1, N'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BL', N'Saint-Barthelemy', N'34009', N'340', N'09', N'Free', N'Free Caraïbe', 'data', 1, N'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BL', N'Saint-Barthelemy', N'34010', N'340', N'10', null, N'Guadeloupe Téléphone Mobile', 'data', 1, N'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BL', N'Saint-Barthelemy', N'34012', N'340', N'12', null, N'Martinique Téléphone Mobile', 'data', 1, N'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'BQ', N'Bonaire, Sint Eustatius and Saba', N'36231', N'362', N'31', null, N'Eutel N.V.', 'data', 4, N'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BQ', N'Bonaire, Sint Eustatius and Saba', N'36233', N'362', N'33', null, N'WICC N.V.', 'data', 4, N'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BQ', N'Bonaire, Sint Eustatius and Saba', N'36251', N'362', N'51', N'Telcell', N'Telcell N.V.', 'data', 4, N'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BQ', N'Bonaire, Sint Eustatius and Saba', N'36254', N'362', N'54', N'ECC', N'East Caribbean Cellular', 'data', 4, N'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BQ', N'Bonaire, Sint Eustatius and Saba', N'36259', N'362', N'59', N'FLOW', N'Liberty Latin America', 'data', 4, N'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BQ', N'Bonaire, Sint Eustatius and Saba', N'36260', N'362', N'60', N'FLOW', N'Liberty Latin America', 'data', 4, N'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BQ', N'Bonaire, Sint Eustatius and Saba', N'36263', N'362', N'63', null, N'CSC N.V.', 'data', 4, N'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BQ', N'Bonaire, Sint Eustatius and Saba', N'36268', N'362', N'68', N'Digicel', N'Curaçao Telecom N.V.', 'data', 4, N'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BQ', N'Bonaire, Sint Eustatius and Saba', N'36269', N'362', N'69', N'Digicel', N'Curaçao Telecom N.V.', 'data', 4, N'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BQ', N'Bonaire, Sint Eustatius and Saba', N'36274', N'362', N'74', null, N'PCS N.V.', 'data', 4, N'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BQ', N'Bonaire, Sint Eustatius and Saba', N'36276', N'362', N'76', N'Digicel', N'Antiliano Por N.V.', 'data', 4, N'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BQ', N'Bonaire, Sint Eustatius and Saba', N'36278', N'362', N'78', N'Telbo', N'Telefonia Bonairiano N.V.', 'data', 4, N'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BQ', N'Bonaire, Sint Eustatius and Saba', N'36291', N'362', N'91', N'FLOW', N'Liberty Latin America', 'data', 4, N'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BQ', N'Bonaire, Sint Eustatius and Saba', N'36294', N'362', N'94', N'Bayòs', N'Bòbò Frus N.V.', 'data', 4, N'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'BQ', N'Bonaire, Sint Eustatius and Saba', N'36295', N'362', N'95', N'MIO', N'E.O.C.G. Wireless', 'data', 4, N'Weltzone 4', @arg_load_date, @arg_job
            )
                 , (
                N'YT', N'Mayotte', N'64700', N'647', N'00', N'Orange', N'Orange La Réunion', 'data', 1, N'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'YT', N'Mayotte', N'64701', N'647', N'01', N'Maoré Mobile', N'BJT Partners', 'data', 1, N'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'YT', N'Mayotte', N'64702', N'647', N'02', N'Only', N'Telco OI', 'data', 1, N'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'YT', N'Mayotte', N'64703', N'647', N'03', N'Free', N'Telco OI', 'data', 1, N'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'YT', N'Mayotte', N'64704', N'647', N'04', N'Zeop', N'Zeop mobile', 'data', 1, N'EU-Zone', @arg_load_date, @arg_job
            )
                 , (
                N'YT', N'Mayotte', N'64710', N'647', N'10', N'SFR Réunion', N'Société Réunionnaise du Radiotéléphone', 'data', 1, N'EU-Zone', @arg_load_date, @arg_job
            );
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

exec tools.manageextendedproperty
    @name = N'MS_Description'
  , @value = N'Load procedure for the table dm_dom_network_usage.rel_country_provider_worldzone'
  , @level0type = N'SCHEMA'
  , @level0name = N'dm_dom_network_usage'
  , @level1type = N'PROCEDURE'
  , @level1name = N'load_itm_rel_network_provider_worldzone';
go

exec tools.manageextendedproperty
    @name = N'MS_Description'
  , @value = N'Job ID, is set by automic'
  , @level0type = N'SCHEMA'
  , @level0name = N'dm_dom_network_usage'
  , @level1type = N'PROCEDURE'
  , @level1name = N'load_itm_rel_network_provider_worldzone'
  , @level2type = N'PARAMETER'
  , @level2name = N'@arg_job';
go