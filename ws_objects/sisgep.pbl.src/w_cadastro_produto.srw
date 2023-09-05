$PBExportHeader$w_cadastro_produto.srw
forward
global type w_cadastro_produto from w_manutencao
end type
end forward

global type w_cadastro_produto from w_manutencao
integer width = 3959
integer height = 1684
string menuname = "m_cadastro"
boolean ib_ajustarlarguradw = true
boolean ib_ajustaralturadw = true
end type
global w_cadastro_produto w_cadastro_produto

type variables
uo_produto	uoi_produto
uo_estoque  uoi_estoque

Long Vil_Cod_Produto
Long Vil_quantidade
end variables

on w_cadastro_produto.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_cadastro" then this.MenuID = create m_cadastro
end on

on w_cadastro_produto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_recuperar;call super::ue_recuperar;long vllRow, vll_cod_produto

if dw_manutencao.visible Then
	MessageBox('Atenção', 'Você já está executando uma Consulta, Favor abandoná-la para realizar uma nova',Stopsign!)
	return
end if

vllRow = dw_get.RowCount()

dw_get.accepttext( )

if isnull(dw_get.getItemNumber(vllRow,'cod_produto')) Then
	MessageBox('Atenção','Favor informar um código',Stopsign!)
	return
end if

vll_cod_produto = dw_get.GetItemNumber(1,'cod_produto')

vllRow = dw_manutencao.Retrieve(vll_cod_produto)
if vllRow <=0 Then
	MessageBox('Atenção','Dados Não Encontrados.')
	return
end if

dw_manutencao.visible = true
dw_get.object.cod_produto.protect = 1

dw_manutencao.Modify("DataWindow.ReadOnly=Yes")


end event

event ue_inicializacao;call super::ue_inicializacao;uoi_produto = Create uo_produto
uoi_estoque = Create uo_estoque
end event

event ue_adicionarlinha;call super::ue_adicionarlinha;long vllret

if dw_manutencao.visible Then
	MessageBox('Atenção', 'Você já está executando uma Inclusão, Favor abandoná-la para realizar uma nova',Stopsign!)
	return
end if

dw_manutencao.enabled = true
dw_manutencao.visible = true
dw_get.Object.cod_produto.protect = 1
vllret = uoi_produto.of_proximo( )
dw_manutencao.SetItem(1,'produto_cod_produto',vllret)
dw_manutencao.object.produto_cod_produto.protect = true
end event

event ue_gravar;call super::ue_gravar;// campo código do produto protegido
dw_get.Object.cod_produto.protect = 0
end event

event ue_aposgravacao;call super::ue_aposgravacao;long vllRet
String vlsMensagemErro

if VGS_menu = 'Adicionar' Then
	vllRet = uoi_estoque.of_insere(dw_manutencao.GetItemNumber(1,'produto_cod_produto'),dw_manutencao.GetItemNumber(1,'estoque_quantidade'))
end if
if VGS_menu = 'Excluir' Then
	vllRet = uoi_estoque.of_exclui(vil_cod_produto)
end if
if VGS_menu = 'Alterar' Then
	vllRet = uoi_estoque.of_atualiza_estoque(dw_manutencao.GetItemNumber(1,'produto_cod_produto'),dw_manutencao.GetItemNumber(1,'estoque_quantidade'))
end if


if vllRet < 0 Then
	MessageBox('Erro!','Produto não adicionado ao estoque.',StopSign!)
	Return false
End if

Return true
end event

event ue_excluir;call super::ue_excluir;long vllRow,vll_cod_produto

if dw_manutencao.visible Then
	MessageBox('Atenção', 'Você já está executando uma Consulta, Favor abandoná-la para realizar uma nova',Stopsign!)
	return
end if

vllRow = dw_get.RowCount()

dw_get.accepttext( )

if isnull(dw_get.getItemNumber(vllRow,'cod_produto')) Then
	MessageBox('Atenção','Favor informar um código',Stopsign!)
	return
end if

vll_cod_produto = dw_get.GetItemNumber(1,'cod_produto')

vllRow = dw_manutencao.Retrieve(vll_cod_produto)
vil_cod_produto = dw_manutencao.GetItemNumber(1,'produto_cod_produto')

if vllRow <=0 Then
	MessageBox('Atenção','Dados Não Encontrados.')
	return
end if

dw_manutencao.visible = true
dw_get.object.cod_produto.protect = 1

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

event ue_alterar;call super::ue_alterar;long VllRow, vll_cod_produto

dw_manutencao.Modify("DataWindow.ReadOnly=No")
if dw_manutencao.visible Then
	MessageBox('Atenção', 'Você já está executando uma Consulta, Favor abandoná-la para realizar uma nova',Stopsign!)
	return
end if

vllRow = dw_get.RowCount()

dw_get.accepttext( )

if isnull(dw_get.getItemNumber(vllRow,'cod_produto')) Then
	MessageBox('Atenção','Favor informar um código',Stopsign!)
	return
end if

vll_cod_produto = dw_get.GetItemNumber(1,'cod_produto')

vllRow = dw_manutencao.Retrieve(vll_cod_produto)
if vllRow <=0 Then
	MessageBox('Atenção','Dados Não Encontrados.')
	return
end if

dw_manutencao.visible = true
dw_get.object.cod_produto.protect = 1
dw_manutencao.object.produto_cod_produto.protect = 1
end event

type mle_filtro from w_manutencao`mle_filtro within w_cadastro_produto
integer x = 2039
integer y = 0
integer width = 1312
integer height = 144
end type

type dw_get from w_manutencao`dw_get within w_cadastro_produto
integer width = 928
integer height = 140
string dataobject = "dw_get_produto"
end type

type dw_manutencao from w_manutencao`dw_manutencao within w_cadastro_produto
boolean visible = false
integer y = 160
integer width = 3013
integer height = 1324
string dataobject = "dw_cadastro_produto"
boolean hsplitscroll = true
end type

