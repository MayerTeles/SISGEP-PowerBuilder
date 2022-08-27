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
string VGS_Nome
String VGS_Cargo
Long VGL_matricula
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
string appruntimeversion = "19.2.0.2728"
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

event open;// Profile Estoque
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

Open(w_login)



end event

