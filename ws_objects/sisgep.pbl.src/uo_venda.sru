$PBExportHeader$uo_venda.sru
forward
global type uo_venda from nonvisualobject
end type
end forward

global type uo_venda from nonvisualobject
end type
global uo_venda uo_venda

forward prototypes
public function long of_proximo ()
public function long of_proximo_seq ()
end prototypes

public function long of_proximo ();Long vllproximo

SELECT 
	MAX(cod_venda)
INTO
	:vllproximo
FROM Venda
Using SQLCA;

if isnull(vllproximo) Then Return 0

Return vllproximo
end function

public function long of_proximo_seq ();Long vllseq

SELECT 
	MAX(seq_compra)
INTO
	:vllseq
	FROM Compra
	USING SQLCA;
	
	if isnull(vllseq) Then
		return 1
	end if
	
	Return vllseq+1
	
end function

on uo_venda.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_venda.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

