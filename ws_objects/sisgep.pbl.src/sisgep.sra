$PBExportHeader$sisgep.sra
$PBExportComments$Generated Application Object
forward
global type sisgep from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
String VGS_Menu
end variables

global type sisgep from application
string appname = "sisgep"
string themepath = "C:\Program Files (x86)\Appeon\PowerBuilder 19.0\IDE\theme"
string themename = "Do Not Use Themes"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 2
long richtexteditx64type = 3
long richtexteditversion = 1
string richtexteditkey = ""
string appicon = ""
string appruntimeversion = "22.1.0.2819"
end type
global sisgep sisgep

on sisgep.create
appname="sisgep"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on sisgep.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;Open(w_mdi_ancestral)

// Profile Estoque
SQLCA.DBMS = "ADO.Net"
SQLCA.AutoCommit = False
SQLCA.DBParm = "Namespace='System.Data.SqlClient',TrustedConnection=1,DataSource='DESKTOP-C4Q9Q0U\SQLEXPRESS',Database='estoque_sisgep'"

// Conexão
Connect Using sqlca;

Choose Case SQLCA.sqlcode
	Case -1
		messageBox('Falha na Conexão',SQLCA.sqlErrtext,Stopsign!)
		Return
end choose



end event

