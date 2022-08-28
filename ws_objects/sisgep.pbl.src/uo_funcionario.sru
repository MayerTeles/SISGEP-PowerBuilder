$PBExportHeader$uo_funcionario.sru
forward
global type uo_funcionario from nonvisualobject
end type
end forward

global type uo_funcionario from nonvisualobject
end type
global uo_funcionario uo_funcionario

type variables
long vil_matricula
end variables

forward prototypes
public function long of_existe (string p_usuario, string p_senha)
public function integer of_proximo ()
end prototypes

public function long of_existe (string p_usuario, string p_senha);
Long vll_mat

SELECT 
	Cod_matricula,
	nome,
	cargo
INTO 
	:VGL_matricula,
	:VGS_Nome,
	:VGS_Cargo
FROM Funcionario
WHERE nome_usuario = :p_usuario 
AND senha = :p_senha
AND situacao = 'A'
USING SQLCA;

if SQLCA.sqlcode < 0 Then
	MessageBox('Erro!',sqlca.sqlerrtext,Stopsign!)
	return -1
end if

if VGL_matricula = 0 Then
	return 0
end if
return 1
end function

public function integer of_proximo ();
Long Vll_matricula

SELECT 
	MAX(funcionario.cod_matricula)
	INTO 
	:Vll_matricula
	From funcionario
	Using SQLCA;
	
	if SQLCA.sqlcode < 0 Then
		MessageBox('Erro ao Buscar Sequencial do Produto!', sqlca.sqlerrtext,Stopsign!)
		return -1
	end if
	
	if isnull(Vll_matricula) Then return 1
		
	return Vll_matricula + 1
	
end function

on uo_funcionario.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_funcionario.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

