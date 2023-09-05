$PBExportHeader$w_cadastro_funcionario.srw
forward
global type w_cadastro_funcionario from w_manutencao
end type
end forward

global type w_cadastro_funcionario from w_manutencao
integer width = 3959
integer height = 1684
string menuname = "m_cadastro"
long backcolor = 15780518
string icon = "AppIcon!"
boolean ib_ajustarlarguradw = true
boolean ib_ajustaralturadw = true
end type
global w_cadastro_funcionario w_cadastro_funcionario

type variables
uo_funcionario uoi_funcionario

long Vil_matricula
end variables

on w_cadastro_funcionario.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_cadastro" then this.MenuID = create m_cadastro
end on

on w_cadastro_funcionario.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_recuperar;call super::ue_recuperar;long vllRow, vll_cod_matricula

if dw_manutencao.visible Then
	MessageBox('Atenção', 'Você já está executando uma Consulta, Favor abandoná-la para realizar uma nova',Stopsign!)
	return
end if

vllRow = dw_get.RowCount()

dw_get.accepttext( )

if isnull(dw_get.getItemNumber(vllRow,'matricula')) Then
	MessageBox('Atenção','Favor informar um código de matrícula',Stopsign!)
	return
end if

vll_cod_matricula = dw_get.GetItemNumber(1,'matricula')

vllRow = dw_manutencao.Retrieve(vll_cod_matricula)
if vllRow <=0 Then
	MessageBox('Atenção','Dados Não Encontrados.')
	return
end if

dw_manutencao.visible = true
dw_get.object.matricula.protect = 1

dw_manutencao.Modify("DataWindow.ReadOnly=Yes")


end event

event ue_inicializacao;call super::ue_inicializacao;uoi_funcionario = Create uo_funcionario

end event

event ue_adicionarlinha;call super::ue_adicionarlinha;long vllret

if dw_manutencao.visible Then
	MessageBox('Atenção', 'Você já está executando uma Inclusão, Favor abandoná-la para realizar uma nova',Stopsign!)
	return
end if

dw_manutencao.enabled = true
dw_manutencao.visible = true
dw_get.Object.matricula.protect = 1
vllret = uoi_funcionario.of_proximo()
dw_manutencao.SetItem(1,'cod_matricula',vllret)
dw_manutencao.object.cod_matricula.protect = true
end event

event ue_gravar;call super::ue_gravar;dw_get.Object.matricula.protect = 0
end event

event ue_excluir;call super::ue_excluir;long vllRow,vll_cod_matricula

if dw_manutencao.visible Then
	MessageBox('Atenção', 'Você já está executando uma Consulta, Favor abandoná-la para realizar uma nova',Stopsign!)
	return
end if

vllRow = dw_get.RowCount()

dw_get.accepttext( )

if isnull(dw_get.getItemNumber(vllRow,'matricula')) Then
	MessageBox('Atenção','Favor informar um código de matrícula',Stopsign!)
	return
end if

vll_cod_matricula = dw_get.GetItemNumber(1,'matricula')

vllRow = dw_manutencao.Retrieve(vll_cod_matricula)
Vil_matricula = dw_manutencao.GetItemNumber(1,'cod_matricula')

if vllRow <=0 Then
	MessageBox('Atenção','Dados Não Encontrados.')
	return
end if

dw_manutencao.visible = true
dw_get.object.matricula.protect = 1

dw_manutencao.Modify("DataWindow.ReadOnly=Yes")

vllRow = MessageBox('Atenção','Deseja Prosseguir com a Exclusão dos dados?',Question!,YesNo!)
if vllRow = 1 Then 
	dw_Manutencao.deleteRow (0)
	this.TriggerEvent ('ue_Gravar')
else
	return
end if

return
end event

event ue_alterar;call super::ue_alterar;long VllRow, vll_cod_matricula

dw_manutencao.Modify("DataWindow.ReadOnly=No")
if dw_manutencao.visible Then
	MessageBox('Atenção', 'Você já está executando uma Consulta, Favor abandoná-la para realizar uma nova',Stopsign!)
	return
end if

vllRow = dw_get.RowCount()

dw_get.accepttext( )

if isnull(dw_get.getItemNumber(vllRow,'matricula')) Then
	MessageBox('Atenção','Favor informar um código',Stopsign!)
	return
end if

vll_cod_matricula = dw_get.GetItemNumber(1,'matricula')

vllRow = dw_manutencao.Retrieve(vll_cod_matricula)
if vllRow <=0 Then
	MessageBox('Atenção','Dados Não Encontrados.')
	return
end if

dw_manutencao.visible = true
dw_get.object.matricula.protect = 1
dw_manutencao.object.cod_matricula.protect = 1
end event

event ue_abandonar;call super::ue_abandonar;dw_get.object.matricula.protect = 0
end event

type mle_filtro from w_manutencao`mle_filtro within w_cadastro_funcionario
integer x = 2039
integer y = 0
integer width = 1312
integer height = 144
end type

type dw_get from w_manutencao`dw_get within w_cadastro_funcionario
integer width = 928
integer height = 140
string dataobject = "dw_get_funcionario"
end type

type dw_manutencao from w_manutencao`dw_manutencao within w_cadastro_funcionario
boolean visible = false
integer y = 160
integer width = 3013
integer height = 1324
string dataobject = "dw_cadastro_funcionario"
boolean hsplitscroll = true
end type

