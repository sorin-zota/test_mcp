use access
go

-----------------------------------------------
--------------VARIABLEN------------------------
-----------------------------------------------
declare @code nvarchar(255)               = 'fi_clarity_adb1_processed_messages'
declare @revision nvarchar(255)           = '20250903'
declare @name nvarchar(255)               = 'Fileimport clarity_adb1_processed_messages'
declare @description nvarchar(max)        = 'Fileimport of genaico_adb1.processed_messages from clarity adb1'

declare @directory nvarchar(255)          = 'c:\mountpoints\gpfs\import\access\clarity\processed_messages\v1'
declare @files nvarchar(255)              = 'processed_messages_20%.csv'


declare @mode_id smallint                 = import.get_once_mode()   --import.get_latest_mode, import.get_once_mode(), import.get_always_mode()

declare @sl_db nvarchar(255)              = 'access'
declare @sl_schema nvarchar(255)          = 'sl_genaico_adb1'
declare @sl_tablename nvarchar(255)       = 'processed_messages'
declare @sl_tablename_full nvarchar(255)  = @sl_db + '.' + @sl_schema + '.' + @sl_tablename

declare @ods_db nvarchar(255)             = 'access'
declare @ods_schema nvarchar(255)         = 'ods_genaico_adb1'
declare @ods_tablename nvarchar(255)      = 'processed_messages'
declare @ods_tablename_full nvarchar(255) = @ods_db + '.' + @ods_schema + '.' + @ods_tablename

declare @coldelim nvarchar(255)           = '\t'  --Spaltentrenner, meist '\t', ',' ';' wird nur in der column_map verwendet, aber nicht gespeichert
declare @rowdelim nvarchar(255)           = '\n'  --Zeilentrenner \r\n für Win, \n für Linux
declare @quotes nvarchar(255)             = '"'   --Anführungszeichen die in der CSV Datei verwendet werden
declare @skip int                         = 1   --Anzahl Headerzeilen die übersprungen werden sollen

declare @type_id smallint                 = import.get_delimited_type()   --Auswahl ob Spaltenbreite fix oder mit Delimiter
declare @encoding_id smallint             = import.get_utf8_encoding()   --Auswahl ob Daten als ASCII oder UTF8 vorliegen
declare @sl_load_delta nchar(1)           = 'I'   --I=Inkrementell, d.h. nur Insert und Update werden gemerged, F=Full auch Deletes werden gemerged   --'F' for full oder 'I' for incremental 

declare @column_map import.column_map

-----------------------------------------------
--------------PREVIEW ORDNER & CSVFILE---------
-----------------------------------------------
/*
exec import.dir @directory                -- Zeigt den Inhalt des Verzeichnisses an 
exec import.preview N'', 1000             -- Name des Testfiles aus dem Verzeichnis in Anführungsziechen einsetzen und testweise 1000 Zeilen importieren
*/

-----------------------------------------------
--------------SPALTENDEFINITIONEN--------------
-----------------------------------------------
insert into @column_map
  ( no,  skip,  name,											type,					format,      delimiter,  is_quoted, fixed,  [null],  zero,  empty,  is_primary_key,  is_nullable )
values
  ( 1,   0,     'message_id',									'uniqueidentifier',		null,        @coldelim,  0,         null,   'NULL',  null,  null,   0,               0 )
 ,( 2,   0,     'user_message_id',								'uniqueidentifier',     null,        @coldelim,  0,         null,   'NULL',  null,  null,   0,               1 )
 ,( 3,   0,     'conversation_id',								'uniqueidentifier',     null,        @coldelim,  0,         null,   'NULL',  null,  null,   0,               1 )
 ,( 4,   0,     'timestamp_utc',								'datetime',			'try_convert(datetime,left(timestamp_utc,len(timestamp_utc)-3))',        @coldelim,  0,         null,   'NULL',  null,  null,   0,               1 )
 ,( 5,   0,     'agent_id',										'uniqueidentifier',     null,        @coldelim,  0,         null,   'NULL',  null,  null,   0,               1 )
 ,( 6,   0,     'agent_config_id',								'uniqueidentifier',     null,        @coldelim,  0,         null,   'NULL',  null,  null,   0,               1 )
 ,( 7,   0,     'source',										'varchar(64)',	        null,        @coldelim,  0,         null,   'NULL',  null,  null,   0,               1 )
 ,( 8,   0,     'instance',										'varchar(64)',	        null,        @coldelim,  0,         null,   'NULL',  null,  null,   0,               1 )
 ,( 9,   0,     'message_type',									'varchar(64)',	        null,        @coldelim,  0,         null,   'NULL',  null,  null,   0,               1 )
 ,(10,   0,     'status',										'varchar(64)',	        null,        @coldelim,  0,         null,   'NULL',  null,  null,   0,               1 )
 ,(11,   0,     'intent_classification_node_ids',				'nvarchar(500)',        null,        @coldelim,  0,         null,   'NULL',  null,  null,   0,               1 )
 ,(12,   0,     'intent_classifier_config_tree_version_id',      'int',					null,        @coldelim,  0,         null,   'NULL',  null,  null,   0,               1 )
 ,(13,   0,     'm9_clusters',								    'nvarchar(500)',		null,        @coldelim,  0,         null,   'NULL',  null,  null,   0,               1 )
 ,(14,   0,     'm9_clusters_config_version_id',				    'int',					null,        @coldelim,  0,         null,   'NULL',  null,  null,   0,               1 )


-----------------------------------------------
--------------IMPORT TESTEN--------------------
-----------------------------------------------
/*
 exec import.[test]
    @directory
  , @files
  , @encoding_id
  , @type_id
  , @quotes
  , @rowdelim
  , @skip
  , @column_map 
  , 1000             -- Anzahl Zeilen
 */
 

 /*	------------------------------------- SL & ODS DB objects definition ---------------------------------------------
declare @tempt table (
    Query nvarchar(4000)
);

declare @Query nvarchar(4000);
declare @go nvarchar(10) = char(10) + 'go';
Insert @tempt Execute import.help_sl_table @sl_schema, @sl_tablename, @column_map                ; set @Query = (Select top 1 replace(Query,@go,'') from @tempt ) ; delete from @tempt ; Select @Query ; --Execute sp_executesql @Query ;
Insert @tempt Execute import.help_sl_procedure @code, @sl_schema, @sl_tablename                  ; set @Query = (Select top 1 replace(Query,@go,'') from @tempt ) ; delete from @tempt ; Select @Query ; --Execute sp_executesql @Query ;
Insert @tempt Execute import.help_sl_cleanup @code, @sl_schema, @sl_tablename                    ; set @Query = (Select top 1 replace(Query,@go,'') from @tempt ) ; delete from @tempt ; Select @Query ; --Execute sp_executesql @Query ;
Insert @tempt Execute import.help_sl_checkfor @code, @sl_schema, @sl_tablename                   ; set @Query = (Select top 1 replace(Query,@go,'') from @tempt ) ; delete from @tempt ; Select @Query ; --Execute sp_executesql @Query ;
Insert @tempt Execute import.help_ods_table @ods_schema, @ods_tablename, @column_map             ; set @Query = (Select top 1 replace(Query,@go,'') from @tempt ) ; delete from @tempt ; Select @Query ; --Execute sp_executesql @Query ;
Insert @tempt Execute import.help_ods_procedure @code, @ods_schema, @ods_tablename               ; set @Query = (Select top 1 replace(Query,@go,'') from @tempt ) ; delete from @tempt ; Select @Query ; --Execute sp_executesql @Query ;

--Insert @tempt Execute import.help_ods_table_as_seen_log @ods_schema, @ods_tablename, @column_map ; set @Query = (Select top 1 replace(Query,@go,'') from @tempt ) ; delete from @tempt ; Select @Query ; --Execute sp_executesql @Query ;
--Insert @tempt Execute import.help_ods_view_as_seen @ods_schema, @ods_tablename, @column_map      ; set @Query = (Select top 1 replace(Query,@go,'') from @tempt ) ; delete from @tempt ; Select @Query ; --Execute sp_executesql @Query ;
*/

-----------------------------------------------
--------------KONFIG IN DB SPEICHERN-----------
-----------------------------------------------
exec import.[save]
  @code
, @name
, @description
, @revision
, @directory
, @files
, @mode_id
, @type_id
, @encoding_id
, @sl_tablename_full
, @sl_load_delta
, @ods_tablename_full
, @quotes
, @rowdelim
, @skip
, @column_map

