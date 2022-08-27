$PBExportHeader$w_login.srw
forward
global type w_login from window
end type
type entrar from commandbutton within w_login
end type
type senha from singlelineedit within w_login
end type
type st_2 from statictext within w_login
end type
type usuario from singlelineedit within w_login
end type
type st_1 from statictext within w_login
end type
type p_1 from picture within w_login
end type
end forward

global type w_login from window
integer width = 2510
integer height = 1340
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
entrar entrar
senha senha
st_2 st_2
usuario usuario
st_1 st_1
p_1 p_1
end type
global w_login w_login

type variables
uo_funcionario uoi_funcionario
end variables

on w_login.create
this.entrar=create entrar
this.senha=create senha
this.st_2=create st_2
this.usuario=create usuario
this.st_1=create st_1
this.p_1=create p_1
this.Control[]={this.entrar,&
this.senha,&
this.st_2,&
this.usuario,&
this.st_1,&
this.p_1}
end on

on w_login.destroy
destroy(this.entrar)
destroy(this.senha)
destroy(this.st_2)
destroy(this.usuario)
destroy(this.st_1)
destroy(this.p_1)
end on

event open;uoi_funcionario = Create uo_funcionario
end event

type entrar from commandbutton within w_login
integer x = 1129
integer y = 360
integer width = 334
integer height = 160
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Entrar"
boolean flatstyle = true
end type

event clicked;string vls_senha
string vls_usuario
long vll_ret

vls_usuario = usuario.Text
vls_senha = senha.Text

vll_ret = uoi_funcionario.of_existe( vls_usuario, vls_senha)

if vll_ret = 0 Then
	messageBox('Atenção','Usuário ou senha incorreto!',Stopsign!)
	Return
else
	Close(w_login)
	Open(w_mdi_ancestral)
end if


end event

type senha from singlelineedit within w_login
integer x = 1632
integer y = 184
integer width = 631
integer height = 116
integer taborder = 20
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_login
integer x = 1335
integer y = 184
integer width = 402
integer height = 116
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 0
string text = "Senha:"
boolean focusrectangle = false
end type

type usuario from singlelineedit within w_login
integer x = 553
integer y = 184
integer width = 631
integer height = 116
integer taborder = 10
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_login
integer x = 187
integer y = 184
integer width = 402
integer height = 116
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 0
string text = "Usuário:"
boolean focusrectangle = false
end type

type p_1 from picture within w_login
integer width = 2505
integer height = 1368
string picturename = "D:\SISGEP\Tenis_plano de Fundo.jpg"
boolean focusrectangle = false
end type

