#!/bin/bash
##diffpatch
#NOME : HENRIQUE LUZ RODRIGUES
##### : 11-04-2012

	Menu () {

	 	main=$(zenity --width=300 --height=250 --list --column "Escolha uma opção:" \
                      	      --title="Diff Patch" \
				      " 1  –  Diff Patch" \
				      " 2  –  Aplicar Diff Patch" \
				      " 3  –  About")

			case ${main} in
				" 1  –  Diff Patch") diff_patch ;;
				" 2  –  Aplicar Diff Patch") app_diff_patch ;;
				" 3  –  About") about ;;	
			esac
}

	diff_patch () {
			patch=`zenity --width=250 --height=200 --entry \
			--title="Diff Patch" \
			--text="Digite o nome do patch:"`

	if [ $? -eq 1 ] ; then
		Menu
		     elif [ -z $patch ] ; then     
		     zenity --error --text="Informe um nome para o Patch"
		     diff_patch
				elif ! [ -z `grep -w $patch /home/VoxBras/lista.txt` ] ; then
				zenity --error --text="Patch já existe"
				diff_patch
	else
		echo "$patch.patch" >> lista.txt
		cd /home/VoxBras 
		diff -Nur Projeto_Original/Galway_Original/Galway/ PROJETOS/Galway/Galway/ > $patch.patch
		chmod 777 $patch.patch
		mv $patch.patch /home/VoxBras/Historico_Diff_Patch
		zenity --info --text="Patch '$patch' criado com sucesso"
	fi
	Menu
}

	app_diff_patch () {
			   arq=`zenity --file-selection \
			   --title="Diff Patch" \
		    	   --text="Selecione o Patch:"`

	if [ $? -eq 1 ] ; then
	Menu
	fi

	cd /home/VoxBras/Projeto_Original/Galway_Original/Galway
	patch -p3 < $arq
	Menu	
}
	
	about () {
		  zenity --width=300 --height=250 --list --column "Contato:" \
                      	      					 --title="Diff Patch" \
				     				 " Henrique Luz Rodrigues" \
				      				 " henrique.lr89@gmail.com.br"
		  						 Menu
}
Menu
	

