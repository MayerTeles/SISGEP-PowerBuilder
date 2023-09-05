﻿$PBExportHeader$w_consulta_produto_nome.srw
forward
global type w_consulta_produto_nome from w_manutencao
end type
end forward

global type w_consulta_produto_nome from w_manutencao
integer width = 3575
string menuname = "m_consultas"
long backcolor = 15780518
windowanimationstyle closeanimation = rightroll!
boolean ib_ajustarlarguradw = true
boolean ib_ajustaralturadw = true
end type
global w_consulta_produto_nome w_consulta_produto_nome

type variables
w_manutencao Telas
end variables

on w_consulta_produto_nome.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_consultas" then this.MenuID = create m_consultas
end on

on w_consulta_produto_nome.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_recuperar;call super::ue_recuperar;string vlsNome
String vlsFiltro

dw_get.accepttext( )
vlsNome = dw_get.GetItemString(1,'nome')

if dw_manutencao.visible Then
	MessageBox('Atenção','Favor Abandonar a consulta para realizar outra!')
	Return
End if

if not isnull(vlsNome) Then
	vlsFiltro = "UPPER(produto_nome) LIKE '%"+ UPPER(vlsNome)+"%'"
end if

dw_manutencao.Retrieve()
dw_manutencao.visible = true
dw_manutencao.setFilter(vlsFiltro)
dw_manutencao.filter()
dw_get.object.nome.protect = 1



end event

event ue_inicializacao;call super::ue_inicializacao;dw_manutencao.visible = False
end event

event ue_abandonar;call super::ue_abandonar;dw_get.object.nome.protect = 0
end event

type mle_filtro from w_manutencao`mle_filtro within w_consulta_produto_nome
integer x = 2926
integer y = 80
end type

type dw_get from w_manutencao`dw_get within w_consulta_produto_nome
integer width = 1047
integer height = 124
string dataobject = "dw_get_nome_produto"
end type

type dw_manutencao from w_manutencao`dw_manutencao within w_consulta_produto_nome
boolean visible = false
integer y = 136
integer width = 2770
integer height = 1332
string dataobject = "dw_consulta_produto"
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

