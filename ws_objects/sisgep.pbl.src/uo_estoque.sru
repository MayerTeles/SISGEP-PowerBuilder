$PBExportHeader$uo_estoque.sru
forward
global type uo_estoque from oleobject
end type
end forward

global type uo_estoque from oleobject
end type
global uo_estoque uo_estoque

forward prototypes
public function long of_insere (long p_cod_produto, long p_quantidade)
public function integer of_atualiza_estoque (integer p_cod_produto, integer p_quantidade)
public function integer of_exclui (integer p_cod_produto)
end prototypes

public function long of_insere (long p_cod_produto, long p_quantidade);INSERT INTO estoque (cod_produto,quantidade)
VALUES (:p_cod_produto, :p_quantidade)
Using SQLCA;

if SQLCA.sqlcode < 0 Then
	MessageBox('Erro!',sqlca.sqlerrtext,Stopsign!)
	return -1
end if

return 1 

end function

public function integer of_atualiza_estoque (integer p_cod_produto, integer p_quantidade);UPDATE estoque
SET cod_produto = :p_cod_produto,
quantidade = :p_quantidade
WHERE cod_produto = :p_cod_produto
Using SQLCA;

if SQLCA.sqlcode < 0 Then
	MessageBox('Erro!',sqlca.sqlerrtext,Stopsign!)
	return -1
end if

Return 1
end function

public function integer of_exclui (integer p_cod_produto);DELETE estoque
WHERE cod_produto = :p_cod_produto
Using sqlca;

if SQLCA.sqlcode < 0 Then
	MessageBox('Erro!',sqlca.sqlerrtext,Stopsign!)
	return -1
end if

return 1
end function

on uo_estoque.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_estoque.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

