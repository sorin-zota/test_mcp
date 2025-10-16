CREATE TABLE [rl_dom_self_care].[prognoze]
(
[function_call_date] [date] NULL,
[function_call_date_id] [int] NULL,
[function_call_hour] [int] NOT NULL,
[control_center_desc] [nvarchar] (200) COLLATE Latin1_General_100_CI_AS_SC NULL,
[typ] [varchar] (25) COLLATE Latin1_General_100_CI_AS_SC NOT NULL,
[prognose] [decimal] (38, 6) NULL
) ON [SECONDARY]
GO
