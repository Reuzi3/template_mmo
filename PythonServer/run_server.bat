@echo off


cd Server
rem Executa o comando uvicorn
python -m uvicorn main:app --reload

rem Pausa para que você possa ver a saída antes que a janela seja fechada
pause

