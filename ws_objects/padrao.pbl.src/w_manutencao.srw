$PBExportHeader$w_manutencao.srw
$PBExportComments$Janela manutenção genérica.
forward
global type w_manutencao from window
end type
type mle_filtro from multilineedit within w_manutencao
end type
type dw_get from uo_dwget within w_manutencao
end type
type dw_manutencao from uo_datawindow_ancestral within w_manutencao
end type
end forward

global type w_manutencao from window
integer width = 2651
integer height = 1660
boolean titlebar = true
string menuname = "m_ancestral"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12632256
string icon = "ApplicationIcon2!"
boolean center = true
event ue_inserir ( long al_numlinha )
event ue_teste ( )
event ue_gravar ( )
event ue_excluir ( )
event ue_recuperar ( )
event type boolean ue_validardados ( ref string as_mensagemerro )
event type boolean ue_antesgravacao ( ref string as_mensagemerro )
event type boolean ue_aposgravacao ( ref string as_mensagemerro )
event ue_adicionarlinha ( )
event ue_inserirlinha ( )
event ue_inicializacao ( )
event ue_exportar ( )
event ue_filtrar ( )
event ue_abandonar ( )
event ue_alterar ( )
mle_filtro mle_filtro
dw_get dw_get
dw_manutencao dw_manutencao
end type
global w_manutencao w_manutencao

type variables
protected:
boolean ib_AjustarLarguraDw = false
boolean ib_AjustarAlturaDw = false



end variables

forward prototypes
public function integer of_arearegulo (integer lado, integer altura)
public function integer wf_janela ()
end prototypes

event ue_inserir(long al_numlinha);dw_manutencao.retrieve( )
// insere uma linha na datawindow, na posição da linha atual, empurrando as demais linhas para posição subsequente.
dw_Manutencao.insertRow (al_NumLinha)


return

end event

event ue_gravar();boolean vlb_Ok								// indica se está tudo bem (true) ou não (false)
integer vli_Retorno						// retorno da função
string vls_MensagemErro					// mensagem de erro

// verificar se os dados a serem gravados estão corretos
vlb_Ok = event ue_ValidarDados (vls_MensagemErro)
if (not vlb_Ok) then
	messageBox ('Erro de validação', vls_MensagemErro, StopSign!)
	return
end if

// ações antes de gravar
vlb_Ok = event ue_AntesGravacao(vls_MensagemErro)
if (not vlb_Ok) then
	// cancela / desfaz as transações feitas no banco de dados
	rollback ;

	messageBox ('Erro antes de gravar', vls_MensagemErro, StopSign!)
	return
end if


// atualiza as informações da datawindow no banco de dados
vli_Retorno = dw_Manutencao.update()
if (vli_Retorno = -1) then
	// cancela / desfaz as transações feitas no banco de dados
	rollback ;
	
	// importante que a message box apareça depois do rollback para que o banco de dados
	// não seja travado, caso o usuário demore a apertar o botão ok
	messageBox ('Gravação', 'Erro na gravação. ' + sqlca.SQLErrText, StopSign!)
end if

// ações após de gravar
vlb_Ok = event ue_AposGravacao(vls_MensagemErro)
if (not vlb_Ok) then
	// cancela / desfaz as transações feitas no banco de dados
	rollback ;
	
	messageBox ('Erro após gravação', vls_MensagemErro, StopSign!)
	return
end if

// efetiva as transações feitas até o momento no banco de dados
commit;

if vlb_Ok Then
	dw_manutencao.reset()
	dw_manutencao.visible = false
end if

return



end event

event type boolean ue_validardados(ref string as_mensagemerro);// escreva neste evento as validações da datawindow 


return true

end event

event type boolean ue_antesgravacao(ref string as_mensagemerro);// escreva neste evento as ações antes de gravar os dados


return true

end event

event type boolean ue_aposgravacao(ref string as_mensagemerro);// escreva neste evento as ações após gravar os dados


return true

end event

event ue_adicionarlinha();dw_manutencao.event getfocus( )
dw_manutencao.Insertrow(0)


return
end event

event ue_inicializacao();long ll_QtdLinha							// quantidade de linha recuperadas


// o comando SetTransObject associa a datawindow com a conexão. Se esse comando o Powerbuilder não sabe de onde os dados
// serão lidos. Desta forma, se uma janela (window) possuir mais de uma datawindow, nada impede que cada uma dela seja
// conectada a uma conexão diferente.
dw_Manutencao.setTransObject (sqlca)
dw_get.SetTransobject(sqlca)
dw_get.Retrieve()
dw_get.visible = true
dw_get.Reset()
dw_get.SetColumn(1)
dw_get.InsertRow(0)
end event

event ue_exportar();string ls_path_Nome 
string ls_nome_arquivo
int li_retorno
string ls_extensao_arquivo


li_retorno = GetFileSaveName ( 'Seleciona Arquivo',  ls_path_Nome, ls_nome_arquivo , 'TXT', &
   "Excel (*.xls),*.xls, Texto(*.txt), *.txt, Todos os Arquivos (*.*),*.*" )
 
IF li_retorno < 1 Then
  return
End If

ls_extensao_arquivo = right (ls_nome_arquivo, 3)
choose case ls_extensao_arquivo
	case 'txt'
		dw_manutencao.SaveAs(ls_path_Nome, text!, true)
		case 'xls'
		dw_manutencao.SaveAs(ls_path_Nome, Excel5!, true)
	case else
		dw_manutencao.SaveAs(ls_path_Nome, text!, true)
end choose


end event

event ue_filtrar();string ls_Filtro

ls_Filtro = mle_Filtro.text


dw_Manutencao.setFilter(ls_Filtro)
dw_Manutencao.filter()
end event

event ue_abandonar();dw_manutencao.reset()
dw_manutencao.visible = false
dw_get.reset()
dw_get.SetColumn(1)
dw_get.InsertRow(0)
end event

public function integer of_arearegulo (integer lado, integer altura);long Area

Area = Lado * Altura

return Area

end function

public function integer wf_janela ();return 1

end function

on w_manutencao.create
if this.MenuName = "m_ancestral" then this.MenuID = create m_ancestral
this.mle_filtro=create mle_filtro
this.dw_get=create dw_get
this.dw_manutencao=create dw_manutencao
this.Control[]={this.mle_filtro,&
this.dw_get,&
this.dw_manutencao}
end on

on w_manutencao.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mle_filtro)
destroy(this.dw_get)
destroy(this.dw_manutencao)
end on

event open;post event ue_Inicializacao()
return

end event

event closequery;integer li_Resposta						// resposta do usuário

// Accept the last data entered into the datawindow
dw_Manutencao.AcceptText()
 
//Check to see if any data has changed
if dw_Manutencao.DeletedCount() + dw_Manutencao.ModifiedCount() > 0 then
   li_Resposta = MessageBox("Fechando", "Deseja gravar os dados antes?", Question!, YesNoCancel!, 3)
 
 	choose case li_Resposta
		case 1	// Sim - usuário escolheu gravar antes de fechar
			event ue_Gravar()
			return 0
		  
		case 2	// Não usuário que sair sem gravar
			return 0
		case 3	// Cancela fechamento de janela
			return 1
	end choose
else
   // Se não houver dados apagados ou modificados a janela é fechada
	return 0
end if


end event

event resize;
if (ib_AjustarLarguraDw) then
	dw_manutencao.width = newwidth - this.x - this.x
end if

if (ib_AjustarAlturaDw) then
	dw_manutencao.height = newheight - this.y - this.y
end if

return


end event

type mle_filtro from multilineedit within w_manutencao
boolean visible = false
integer x = 1449
integer y = 60
integer width = 480
integer height = 116
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = styleshadowbox!
end type

type dw_get from uo_dwget within w_manutencao
integer x = 27
integer taborder = 10
end type

type dw_manutencao from uo_datawindow_ancestral within w_manutencao
event ue_eventodw ( )
integer x = 32
integer y = 280
integer width = 2414
integer height = 1196
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
boolean ib_ajustarlarguradw = true
boolean ib_ajustaralturadw = true
boolean ib_gerarauditoria = true
end type

