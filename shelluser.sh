#! /bin/bash
###Manager User
#NOME : HENRIQUE LUZ RODRIGUES
##### : 11/05/2012

zenity --warning --text="PARA FUNCIONAR CORRETAMENTE EXECUTE COMO ROOT"

Menu () {

	 main=$(zenity --width=710 --height=510 --list --column "Gerência de usuários." \
                      --title="Gerenciador  de  Usuários" \
			" 1  –  Adicionar um usuário ao sistema" \
			" 2  –  Adicionar um grupo ao sistema" \
			" 3  –  Adicionar um usuário já existente a um grupo já existente" \
			" 4  –  Criar um usuário e adicioná-lo a um grupo já existente" \
			" 5  –  Mostrar informações pessoais de um determinado usuário" \
			" 6  –  Modificar as informações pessoais de um determinado usuário" \
			" 7  –  Configurar a data de última modificação de senha do usuário" \
			" 8  –  Configurar o número mínimo de dias para modificação da senha do usuário" \
			" 9  –  Configurar o número máximo de dias para modificação da senha do usuário" \
			"10 –  Configurar o número de dias de aviso antes do prazo final de alteração de senha" \
			"11 –  Configurar a data de desabilitação do usuário" \
			"12 –  Mostrar as configurações de senha de um determinado usuário" \
			"13 –  Mostrar de quais grupos um dado usuário faz parte" \
			"14 –  Modificar o grupo dono de um dado arquivo" \
			"15 –  Modificar o usuário dono de um dado arquivo" \
			"16 –  Permitir que um usuário criado se torne o usuário root utilizando o comando  sudo" \
			"17 –  About")                                                


	case ${main} in
			" 1  –  Adicionar um usuário ao sistema")user ;;
			" 2  –  Adicionar um grupo ao sistema")grupo ;;
			" 3  –  Adicionar um usuário já existente a um grupo já existente")adgrp ;;
			" 4  –  Criar um usuário e adicioná-lo a um grupo já existente")aduser_grp ;;
			" 5  –  Mostrar informações pessoais de um determinado usuário")inf_user ;;
			" 6  –  Modificar as informações pessoais de um determinado usuário")mod_user ;;
			" 7  –  Configurar a data de última modificação de senha do usuário")dat_pass ;;
			" 8  –  Configurar o número mínimo de dias para modificação da senha do usuário")day_min ;;
			" 9  –  Configurar o número máximo de dias para modificação da senha do usuário")day_max ;;
			"10 –  Configurar o número de dias de aviso antes do prazo final de alteração de senha")day_ant ;;
			"11 –  Configurar a data de desabilitação do usuário")dat_off ;;
			"12 –  Mostrar as configurações de senha de um determinado usuário")user_info ;;
			"13 –  Mostrar de quais grupos um dado usuário faz parte")user_group ;;
			"14 –  Modificar o grupo dono de um dado arquivo")modarq ;;
			"15 –  Modificar o usuário dono de um dado arquivo")arq_user ;;
			"16 –  Permitir que um usuário criado se torne o usuário root utilizando o comando sudo")user_root ;;
			"17 –  About")info_ ;;
	esac
}

user () {

        find /home | zenity --progress --width 350 --pulsate --text "Aguarde..." \
			   
	usuario=`zenity --width=250 --height=200 --entry \
			--title="Adicionar usuário" \
			--text="Digite o nome do usuário:"`
		
		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $usuario ] ; then     
			zenity --error --text="Informe um nome para o usuário"
			user

				elif ! [ -z `grep -w $usuario /etc/passwd` ] ; then
				zenity --error --text="Usuário já existe"
				user

		else
		   adduser $usuario
		   zenity --info --text="Usuário '$usuario' adicionado com sucesso"
		fi
		Menu

}

grupo () {

	find /home | zenity --progress --width 350 --pulsate -- text "Aguarde..." \
	                   
	grp=`zenity --width=250 --height=200 --entry \
			--title="Adicionar Grupo" \
			--text="Digite o nome do grupo:"`

		if [ $? -eq 1 ] ; then
		Menu
	
			elif [ -z $grp ] ; then
			zenity --error --text="Informe um nome para o grupo"
			grupo

				elif ! [ -z `grep -w $grp /etc/group` ] ; then
				zenity --error --text="Grupo existe :D"
				grupo
	
		else
		   addgroup $grp
		   zenity --info --text="Grupo '$grp' Adicionado com sucesso"
		fi
		Menu

}

adgrp () {

	find /home | zenity --progress --width 350 --pulsate -- text "Aguarde..." \
			  
	ad_user=`zenity --width=250 --height=200 --entry \
			--title="Adicionar usuário ao grupo" \
			--text="Digite o nome do usuário:"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $ad_user ] ; then
			zenity --error --text="Informe um nome de usuário"
			adgrp

				elif [ -z `grep -w $ad_user /etc/passwd` ] ; then
				zenity --error --text="Usuário não existe :D"
				Menu	
		fi
		
	ad_grp=`zenity --width=250 --height=200 --entry \
			--title="Adicionar grupo ao usuário" \
			--text="Digite o nome do grupo:"`

		if [ $? -eq 1 ] ; then
		Menu
	
			elif [ -z $ad_grp ] ; then
			zenity --error --text="Informe o nome do grupo"
			adgrp

				elif [ -z `grep -w $ad_grp /etc/group` ] ; then
				zenity --error --text="Grupo não existe :D"
				Menu	

		else
		   addgroup $ad_user $ad_grp
		   zenity --info --text="Usuário '$ad_user' adicionado ao grupo '$grp'"
		fi
		Menu	
			
}

aduser_grp () {

	find /home | zenity --progress --width 350 --text "Aguarde..." \
			  
	grp_ad=`zenity --width=250 --height=200 --entry \
			--title="Adicionar usuário a grupo existente" \
			--text="Digite o nome do grupo:"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $grp_ad ] ; then
			zenity --error --text="Informe o nome do grupo"
			aduser_grp

				elif [ -z `grep -w $grp_ad /etc/group` ] ; then
				zenity --error --text="Grupo não existe :D"
				Menu
		fi

	user_ad=`zenity --width=250 --height=200 --entry \
			--title="Adicionar novo usuário" \
			--text="Digite o nome do usuário:"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $user_ad ] ; then     
			zenity --error --text="Informe um nome para o usuário"
			aduser_grp

				elif ! [ -z `grep -w $user_ad /etc/passwd` ] ; then
				zenity --error --text="Usuário já existe"
				aduser_grp

		else
		   adduser $user_ad --ingroup $grp_ad
		   zenity --info --text="Usuário '$user_ad' criado e adicionado ao grupo '$grp_ad' com sucesso" 
		fi
		Menu

}

inf_user () {	

	find /home | zenity --progress --width 350 --text "Aguarde..." \
			    
	userinfo=`zenity --width=250 --height=200 --entry \
			--title="Informações do usuário" \
			--text="Digite o nome do usuário:"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $userinfo ] ; then
			zenity --error --text="Informe o nome do usuário"
			inf_user

				elif [ -z `grep -w $userinfo /etc/passwd` ] ; then
				zenity --error --text="Usuário não existe :D"
				Menu

		else
		   finger $userinfo
		   zenity --info --text="informações exibidas no terminal"	
		fi	
		Menu

}

mod_user () {

	find /home | zenity --progress --width 350 --text "Aguarde..." \
			   
	usermod=`zenity --width=250 --height=200 --entry \
			--title="Informações do usuário" \
			--text="Digite o nome do usuário:"`

		if [ $? -eq 1 ] ; then
		Menu
			
			elif [ -z $usermod ] ; then
			zenity --error --text="Informe o nome do usuário"
			mod_user

				elif [ -z `grep -w $usermod /etc/passwd` ] ; then
				zenity --error --text="Usuário não existe :D"
				Menu

		else
		   chfn $usermod
		   zenity --info --text="alterado com sucesso!"	
		fi	
		Menu

}

dat_pass () {

	find /home | zenity --progress --width 350 --text "Aguarde..." \
			    
	datuser=`zenity --width=250 --height=200 --entry \
			--title="Informações de senha" \
			--text="Digite o nome do usuário:"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $datuser ] ; then
			zenity --error --text="Informe o nome do usuário"
			dat_pass

				elif [ -z `grep -w $datuser /etc/passwd` ] ; then
				zenity --error --text="Usuário não existe :D"
				Menu
		fi

	anomod=`zenity --width=250 --height=200 --entry \
			--title="Informações de senha" \
			--text="Digite o ano:"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $anomod ] ; then
			zenity --error --text="Informe o ano"
			dat_pass
		fi

	mesmod=`zenity --width=250 --height=200 --entry \
			--title="Informações de senha" \
			--text="Digite o mês:"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $mesmod ] ; then
			zenity --error --text="Informe o mês"
			dat_pass
		fi

	daysmod=`zenity --width=250 --height=200 --entry \
			--title="Informações de senha" \
			--text="Digite o dia:"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $daysmod ] ; then
			zenity --error --text="Informe o dia"
			dat_pass
	
		else
		   chage -d $anomod-$mesmod-$daysmod $datuser
		   zenity --info --text="alterado com sucesso!"	
		fi
		Menu

}

day_min () {
		
	find /home | zenity --progress --width 350 --text "Aguarde..." \
			    
	usermin=`zenity --width=250 --height=200 --entry \
			--title="Informações de senha" \
			--text="Digite o nome do usuário:"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $usermin ] ; then
			zenity --error --text="Informe o nome do usuário"
			day_min

				elif [ -z `grep -w $usermin /etc/passwd` ] ; then
				zenity --error --text="Usuário não existe :D"
				Menu
		fi

	dayspass=`zenity --width=250 --height=200 --entry \
			--title="Informações de senha" \
			--text="Digite o dia:"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $dayspass ] ; then
			zenity --error --text="Informe o quantidade de dias"
			day_min
	
		else
		   chage -m $dayspass $usermin
		   zenity --info --text="alterado com sucesso!"	
		fi
		Menu

}
day_max () {

	find /home | zenity --progress --width 350 --text "Aguarde ..." \
			    
		usermax=`zenity --width=250 --height=200 --entry \
			--title="Informações de senha" \
			--text="Digite o nome do usuário:"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $usermax ] ; then
			zenity --error --text="Informe o nome do usuário"
			day_max

				elif [ -z `grep -w $usermax /etc/passwd` ] ; then
				zenity --error --text="Usuário não existe :D"
				Menu
		fi

	dayspass=`zenity --width=250 --height=200 --entry \
			--title="Informações de senha" \
			--text="Digite o dia:"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $dayspass ] ; then
			zenity --error --text="Informe o quantidade de dias"
			day_max
	
		else
		   chage -M $dayspass $usermax
		   zenity --info --text="alterado com sucesso!"	
		fi
		Menu

}

day_ant () {

	find /home | zenity --progress --width 350 --text "Aguarde ..."
			   
	userant=`zenity --width=250 --height=200 --entry \
			--title="Informações de senha" \
			--text="Digite o nome do usuário:"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $userant ] ; then
			zenity --error --text="Informe o nome do usuário"
			day_ant

				elif [ -z `grep -w $userant /etc/passwd` ] ; then
				zenity --error --text="Usuário não existe :D"
				Menu
		fi

	dayspass=`zenity --width=250 --height=200 --entry \
			--title="Informações de senha" \
			--text="Digite prazo de aviso:"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $dayspass ] ; then
			zenity --error --text="Informe o quantidade de dias"
			day_ant
	
		else
		   chage -W $dayspass $userant
		   zenity --info --text="alterado com sucesso!"	
		fi
		Menu

}

dat_off () {

	find /home | zenity --progress --width 350 --text "Aguarde..."
		  	    
	useroff=`zenity --width=250 --height=200 --entry \
			--title="Informações de conta" \
			--text="Digite o nome do usuário:"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $useroff ] ; then
			zenity --error --text="Informe o nome do usuário"
			dat_off

				elif [ -z `grep -w $useroff /etc/passwd` ] ; then
				zenity --error --text="Usuário não existe :D"
				Menu
		fi

	dayspass=`zenity --width=250 --height=200 --entry \
			--title="Informações de senha" \
			--text="Digite data de desativação: EX:2010-12-31"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $dayspass ] ; then
			zenity --error --text="Informe a data"
			dat_off
	
		else
		   chage -E $dayspass $useroff
		   zenity --info --text="alterado com sucesso!"	
		fi
		Menu

}

user_info () {

	find /home | zenity --progress --width 350 --text "Aguarde..."
			   
	userinfo=`zenity --width=250 --height=200 --entry \
			--title="Informações de senha" \
			--text="Digite o nome do usuário:"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $userinfo ] ; then
			zenity --error --text="Informe o nome do usuário"
			user_info

				elif [ -z `grep -w $userinfo /etc/passwd` ] ; then
				zenity --error --text="Usuário não existe :D"
				Menu
	
		else
		   chage -l $userinfo
		   zenity --info --text="visualize no terminal!"	
		fi
		Menu

}	

user_group () {

	find /home | zenity --progress --width 350 --text "Aguarde..."
			    
	usergroup=`zenity --width=250 --height=200 --entry \
			--title="Informações de Grupo" \
			--text="Digite o nome do usuário:"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $usergroup ] ; then
			zenity --error --text="Informe o nome do usuário"
			user_group

				elif [ -z `grep -w $usergroup /etc/passwd` ] ; then
				zenity --error --text="Usuário não existe :D"
				Menu

		else
		   groups $usergroup
		   zenity --info --text="visualize no terminal!"	
		fi
		Menu

}

modarq () {

	find /home | zenity --progress --width 350 --text "Aguarde..."

	group=`zenity --width=250 --height=200 --entry \
			--title="Informações de Grupo" \
			--text="Digite o nome do Grupo:"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $group ] ; then
			zenity --error --text="Informe o nome do grupo"
			modarq

				elif [ -z `grep -w $group /etc/group` ] ; then
				zenity --error --text="Grupo não existe :D"
				Menu
		fi
	
	arq=`zenity --file-selection \
		    --title="Informações de Grupo" \
		    --text="Digite o nome do arquivo:"`

		if [ $? -eq 1 ] ; then
		Menu

		else
		   chown .$group $arq
		   zenity --info --text="Alterado com sucesso!"
		fi
		Menu

}

arq_user () {

	find /home | zenity --progress --width 350 --text "Aguarde..."

	user=`zenity --width=250 --height=200 --entry \
			--title="Informações de usuário" \
			--text="Digite o nome do usuário:"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $user ] ; then
			zenity --error --text="Informe o nome do usuário"
			arq_user

				elif [ -z `grep -w $user /etc/passwd` ] ; then
				zenity --error --text="Usuário não existe :D"
				Menu
		fi
	
	arq=`zenity --file-selection \
		    --title="Informações de usuário" \
		    --text="Digite o nome do arquivo:"`

		if [ $? -eq 1 ] ; then
		Menu

		else
		   chown $user $arq
		   zenity --info --text="Alterado com sucesso!"
		fi
		Menu
}

user_root () {

	find /home | zenity --progress --width 350 --text "Aguarde..."
			    
	user=`zenity --width=250 --height=200 --entry \
			--title="Informações de Usuário" \
			--text="Digite o nome do usuário:"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $user ] ; then
			zenity --error --text="Informe o nome do usuário"
			user_root

				elif [ -z `grep -w $user /etc/passwd` ] ; then
				zenity --error --text="Usuário não existe :D"
				Menu

		else	
		addgroup $user sudo	
		zenity --info --text="Passo 1: Informe a senha do usuário"
		zenity --info --text="Passo 2: Alterando usuário utilize sudo -i para virar root"
		zenity --info --text="Passo 3: Para sair e volta ao menu utilize exit" 
		login $user
		Menu
		fi

}

info_ () {

	find /home | zenity --progress --width 350 --text "Aguarde..."

	zenity --list --column "Informações." \
		      --title="About" \ "Henrique" \ "email: henrique.lr89@gmail.com"
}
Menu
