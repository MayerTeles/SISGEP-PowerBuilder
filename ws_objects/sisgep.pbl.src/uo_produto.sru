$PBExportHeader$uo_produto.sru
forward
global type uo_produto from coderobject
end type
end forward

global type uo_produto from coderobject
end type
global uo_produto uo_produto

forward prototypes
public function long of_proximo ()
end prototypes

public function long of_proximo ();long vll_Cod_produto

SELECT 
	MAX(produto.cod_produto)
	INTO 
	:vll_Cod_produto
	From Produto
	Using SQLCA;
	
	if SQLCA.sqlcode < 0 Then
		MessageBox('Erro ao Buscar Sequencial do Produto!', sqlca.sqlerrtext,Stopsign!)
		return -1
	end if
	
	if isnull(vll_Cod_produto) Then return 1
		
	return vll_Cod_Produto + 1
	
end function

on uo_produto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_produto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

