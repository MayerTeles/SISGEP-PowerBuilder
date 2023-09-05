$PBExportHeader$w_cadastro_venda.srw
forward
global type w_cadastro_venda from w_manutencao
end type
end forward

global type w_cadastro_venda from w_manutencao
integer width = 3959
integer height = 1684
string menuname = "m_venda"
long backcolor = 15780518
string icon = "AppIcon!"
boolean ib_ajustarlarguradw = true
boolean ib_ajustaralturadw = true
end type
global w_cadastro_venda w_cadastro_venda

type variables
uo_funcionario uoi_funcionario
uo_produto uoi_produto
uo_venda	uoi_venda

long Vil_matricula, vilrow
end variables

on w_cadastro_venda.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_venda" then this.MenuID = create m_venda
end on

on w_cadastro_venda.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_recuperar;call super::ue_recuperar;//long vllRow, vll_cod_venda
//
//if dw_manutencao.visible Then
//	MessageBox('Atenção', 'Você já está executando uma Consulta, Favor abandoná-la para realizar uma nova',Stopsign!)
//	return
//end if
//
//vllRow = dw_get.RowCount()
//
//dw_get.accepttext( )
//
//if isnull(dw_get.getItemNumber(vllRow,'cod_venda')) Then
//	MessageBox('Atenção','Favor informar um código de venda',Stopsign!)
//	return
//end if
//
//vll_cod_matricula = dw_get.GetItemNumber(1,'matricula')
//
//vllRow = dw_manutencao.Retrieve(vll_cod_matricula)
//if vllRow <=0 Then
//	MessageBox('Atenção','Dados Não Encontrados.')
//	return
//end if
//
//dw_manutencao.visible = true
//dw_get.object.matricula.protect = 1
//
//dw_manutencao.Modify("DataWindow.ReadOnly=Yes")
//
//
end event

event ue_inicializacao;call super::ue_inicializacao;uoi_funcionario = Create uo_funcionario
uoi_produto		= Create uo_produto
uoi_venda		= Create uo_venda
 
end event

event ue_adicionarlinha;call super::ue_adicionarlinha;if not(dw_manutencao.visible) Then
	dw_manutencao.visible = true
end if

vilrow += 1
dw_manutencao.object.cod_venda.protect = true
dw_manutencao.SetItem(vilrow,'fk_funcionario_cod_matricula', VGL_matricula)
dw_manutencao.SetItem(vilrow,'status', 'C')
dw_manutencao.SetItem(vilrow,'matricula_func', VGL_matricula)
dw_manutencao.SetItem(vilrow,'data_venda',ToDay())
dw_manutencao.SetItem(vilrow,'cod_venda',uoi_venda.of_proximo()+vilrow)

if dw_get.Visible Then dw_get.Visible = False


end event

event ue_gravar;call super::ue_gravar;dw_get.Object.matricula.protect = 0
end event

event ue_excluir;call super::ue_excluir;
	dw_Manutencao.deleteRow (dw_manutencao.GetRow())
	
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

type mle_filtro from w_manutencao`mle_filtro within w_cadastro_venda
integer x = 2039
integer y = 0
integer width = 1312
integer height = 144
end type

type dw_get from w_manutencao`dw_get within w_cadastro_venda
boolean visible = false
integer width = 928
integer height = 140
boolean enabled = false
string dataobject = "dw_get_venda"
end type

type dw_manutencao from w_manutencao`dw_manutencao within w_cadastro_venda
boolean visible = false
integer y = 160
integer width = 3858
integer height = 1324
string dataobject = "dw_venda"
boolean hsplitscroll = true
end type

event dw_manutencao::itemchanged;call super::itemchanged;decimal vldvalor

Choose Case dwo.name
	Case 'fk_produto_cod_produto'
		dw_manutencao.SetItem(row,'valor_total',uoi_produto.of_retorna_valor(long(data)))
		
	Case 'quant_produtos'
		vldvalor = dw_manutencao.GetItemDecimal(row,'valor_total')
		vldvalor *= long(data)
		dw_manutencao.SetItem(row,'valor_total',vldvalor)
		
End Choose
end event

