$PBExportHeader$w_consulta_produto.srw
forward
global type w_consulta_produto from w_manutencao
end type
end forward

global type w_consulta_produto from w_manutencao
string menuname = "m_consultas"
end type
global w_consulta_produto w_consulta_produto

type variables
w_manutencao Telas
end variables

on w_consulta_produto.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_consultas" then this.MenuID = create m_consultas
end on

on w_consulta_produto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_recuperar;call super::ue_recuperar;long vllCodProduto
String vlsFiltro

vllcodproduto = dw_get.GetItemNumber(1,'cod_produto')

if not isnull(vllCodProduto) Then
	vlsFiltro = 'Produto_Cod_produto = '+string(vllcodproduto)

end if

dw_manutencao.Retrieve()
dw_manutencao.visible = true
dw_manutencao.setFilter(vlsFiltro)
dw_manutencao.filter()



end event

event ue_inicializacao;call super::ue_inicializacao;dw_manutencao.visible = False
end event

event resize;call super::resize;Tela = Create w_manutencao

if (ib_AjustarLarguraDw) then
	dw_manutencao.width = newWidth - Telas.x - Telas.x
end if

if (ib_AjustarAlturaDw) then
	dw_manutencao.height = newHeight - Telas.y - Telas.y
end if

return
end event

type mle_filtro from w_manutencao`mle_filtro within w_consulta_produto
integer x = 2926
integer y = 80
end type

type dw_get from w_manutencao`dw_get within w_consulta_produto
integer width = 1047
integer height = 124
string dataobject = "dw_get_consulta_produto"
end type

type dw_manutencao from w_manutencao`dw_manutencao within w_consulta_produto
boolean visible = false
integer y = 136
integer width = 4192
integer height = 1332
string dataobject = "dw_consulta_produto"
boolean resizable = true
end type

