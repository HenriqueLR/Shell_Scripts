#!/bin/bash
##Manager tasks
#NOME : HENRIQUE LUZ RODRIGUES
##### : 11-04-2012

RESP="s" #Determina o loop do main
clear
op_1(){ #Mostrar os processos abertos
echo
clear
echo "Processos abertos: "
ps -aux
echo
}

op_2(){ #Mostrar o PID de algum programa
opcao="1"
while [ "$opcao" == "1" ]
do
clear
echo
echo "Digite o nome do programa: "
read nome_programa
clear
pid=`pidof $nome_programa`
echo "O programa $nome_programa tem o PID: $pid "
echo
echo "		Deseja descobrir o PID de outro programa?"
echo "		[1] - Sim"
echo "		[2] - Não"
read opcao
clear
done
}

op_3(){ #Parar a execucao
opcao="1"
while [ "$opcao" == "1" ]
do
clear
echo "Deseja parar pelo: "
echo "[1] - Nome"
echo "[2] - PID"
echo
echo "			Digite a opcao: "
read opc
clear

if [ "$opc" == "1" ]
then
echo "Digite o nome do processo:"
read nome_processo
kill -STOP $nome_processo
clear
echo "Parado!"
fi
if [ "$opc" == "2" ]
then
echo "Digite o PID do processo:"
read pid_processo
kill -STOP $pid_processo
clear
echo "Parado!"
fi
echo
echo "		Deseja parar outro processo?"
echo "		[1] - Sim"
echo "		[2] - Não"
read opcao
clear
done
}

op_4(){ #Continuar execucao
opcao="1"
while [ "$opcao" == "1" ]
do
clear
echo "Deseja parar pelo: "
echo "[1] - Nome"
echo "[2] - PID"
echo
echo "			Digite a opcao: "
read opc
clear
if [ "$opc" == "1" ]
then
echo "Digite o nome do processo."
read nome_processo
killall -CONT $nome_processo
clear
echo "Pode utilizar o programa agora..."
clear
fi
if [ "$opc" == "2" ]
then
echo "Digite o PID do processo."
read pid_processo
kill -CONT $pid_processo
clear
echo "Pode utilizar o programa agora..."
fi
echo
echo "		Deseja continuar outro processo?"
echo "		[1] - Sim"
echo "		[2] - Não"
read opcao
clear
done
}

op_5(){ #Terminar a execucao
opcao="1"
while [ "$opcao" == "1" ]
do
clear
echo "Deseja parar pelo: "
echo "[1] - Nome"
echo "[2] - PID"
echo
echo "			Digite a opcao: "
read opc
clear
if [ "$opc" == "1" ]
then
echo "Digite o nome do processo."
read nome_processo
killall -TERM $nome_processo
echo "Terminado!"
clear
fi
if [ "$opc" == "2" ]
then
echo "Digite o PID do processo."
read pid_processo
kill -TERM $pid_processo
echo "Terminado!"
clear
fi
echo
echo "		Deseja terminar outro processo?"
echo "		[1] - Sim"
echo "		[2] - Não"
read opcao
clear
done
}

op_6(){ #Matar um processo
opcao="1"
while [ "$opcao" == "1" ]
do
clear
echo "Deseja parar pelo: "
echo "[1] - Nome"
echo "[2] - PID"
echo
echo "			Digite a opcao: "
read opc
clear
if [ "$opc" == "1" ]
then
echo "Digite o nome do processo."
read nome_processo
killall -KILL $nome_processo
echo "Programa encerrado."
clear
fi
if [ "$opc" == "2" ]
then
echo "Digite o PID do processo."
read pid_processo
kill -KILL $pid_processo
echo "Programa encerrado."
clear
fi
echo
echo "		Deseja matar outro processo?"
echo "		[1] - Sim"
echo "		[2] - Não"
read opcao
clear
done
}


op_7(){ #Criar um processo
opcao="1"
while [ "$opcao" == "1" ]
do
clear
echo "Digite o NOME do processo: "
read processo
echo "Defina a prioridade (de -19 a 19): "
read prioridade
sudo nice -n $prioridade $processo
echo
echo "Deseja visualizar a prioridade pelo comando "TOP"?"
echo "[s/n]"
read rsp
if [ "$rsp" == "s" ] || [ "$rsp" == "S" ];then
top
fi
echo
echo "		Deseja criar outro processo?"
echo "		[1] - Sim"
echo "		[2] - Não"
read opcao
clear
done
}

op_8(){ #Mudar a prioridade
opcao="1"
while [ "$opcao" == "1" ]
do
clear
echo "Digite o NOME ou o PID do processo: "
read processo
echo "Digite a prioridade para este processo: "
read prioridade
sudo renice $prioridade $processo
echo
echo "		O $processo agora tem $prioridade de prioridade"
echo
echo
echo "		Deseja alterar outro processo?"
echo "		[1] - Sim"
echo "		[2] - Não"
read opcao
clear
done
}

op_9(){ #Mostrar Arvore
opcao="1"
while [ "$opcao" == "1" ]
do
clear
echo "Digite o PID do processo"
read pid
pstree $pid
echo
echo "		Deseja mostrar a arvore de outro processo?"
echo "		[1] - Sim"
echo "		[2] - Não"
read opcao
clear
done
}

op_10(){ #Matar um programa(cursor)
opcao="1"
while [ "$opcao" == "1" ]
do
clear
xkill
echo
echo "		Deseja matar usando o cursor outro processo?"
echo "		[1] - Sim"
echo "		[2] - Não"
read opcao
clear
done
}

op_11(){ #ORGANIZAR PROCESSOS

clear
top

}

op_0(){ #Sair
clear;exit
}

#MAIN

while [ "$RESP" == "s" ] || [ "$RESP" == "S" ]
do 
echo -e "\033[01;32m##### GERENCIDOR DE TAREFAS #####\033[01;37m"
echo
echo "Henrique Luz Rodrigues"
echo
echo "Escolha uma das alternativas: "
echo
echo "[1] - Mostrar os processos em execução."
echo "[2] - mostrar o PID de um processo."
echo "[3] - Parar a execucao de um processo."
echo "[4] - Continuar a execucao de um processo."
echo "[5] - Terminar a execucao de um processo."
echo "[6] - Matar um processo."
echo "[7] - Criar um processo com uma propriedade especifica"
echo "[8] - Mudar a prioridade de um processo."
echo "[9] - Mostrar a arvore de um processo."
echo "[10] - Matar um programa usando o cursor do mouse."
echo "[11] - Organizar os processos em ordem crescente por utilizacao do processador."
echo
echo "[0] - Sair do Gerenciador de Tarefas"
echo
echo "		Digite a sua opcao: "
read op

case $op in
1 ) op_1;;
2 ) op_2;;
3 ) op_3;;
4 ) op_4;;
5 ) op_5;;
6 ) op_6;;
7 ) op_7;;
8 ) op_8;;
9 ) op_9;;
10 ) op_10;;
11 ) op_11;;
0 ) op_0;;
* ) echo "Opcao Incorreta!"
esac
echo
echo "Deseja retornar ao Main? [s/n]"
read RESP
clear
done
