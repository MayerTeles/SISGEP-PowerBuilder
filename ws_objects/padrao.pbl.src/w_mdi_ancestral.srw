$PBExportHeader$w_mdi_ancestral.srw
$PBExportComments$Janela MDI (Multiple Document Interface) ancestral.
forward
global type w_mdi_ancestral from window
end type
type mdi_1 from mdiclient within w_mdi_ancestral
end type
end forward

global type w_mdi_ancestral from window
string tag = "SISGEP"
integer width = 4878
integer height = 2240
boolean titlebar = true
string title = "SISGEP (Sistema de gerenciamento de estoque)"
string menuname = "m_ancestral"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
long backcolor = 0
string icon = "AppIcon!"
boolean center = true
mdi_1 mdi_1
end type
global w_mdi_ancestral w_mdi_ancestral

type variables
m_ancestral mi_ancestral
end variables
on w_mdi_ancestral.create
if this.MenuName = "m_ancestral" then this.MenuID = create m_ancestral
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_mdi_ancestral.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event open;mi_ancestral = this.menuid

if VGS_Cargo <> 'Grente de Vendas' Then
	mi_ancestral.m_manutencao.enabled = false
end if
	
end event

type mdi_1 from mdiclient within w_mdi_ancestral
long BackColor=268435456
end type

