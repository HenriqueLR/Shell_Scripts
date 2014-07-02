#! /bin/bash
##Manager networks
#NOME : HENRIQUE LUZ RODRIGUES
##### : 11-04-2012

zenity --warning --text="PARA FUNCIONAR CORRETAMENTE EXECUTE COMO ROOT"

Menu () {

	 main=$(zenity --width=710 --height=510 --list --column "Selecione:" \
                      --title="Gerenciador  de  Rede" \
			" 1  –  Configurar o nome da máquina." \
			" 2  –  Configurar um endereço IP." \
			" 3  –  Visualizar as configurações da interface de rede." \
			" 4  –  Crie uma rota padrão para o roteador." \
			" 5  –  Crie uma rota para uma rede qualquer." \
			" 6  –  Visualizar as rotas configuradas pelo sistema." \
			" 7  –  Remova a rota padrão criada." \
			" 8  –  Remova uma rota criada para uma rede qualquer." \
			" 9  –  Desative a interface de rede." \
		        "10 -  Ative a interface de rede." \
			"11 -  Renove o emprestimo de ip." \
			"12 -  Ping host com TTL." \
			"13 -  Ping host com tamanho de pacote." \
			"14 -  Ping host quantidade minima de pacote." \
			"15 -  Resolve um nome em um endereço IP." \
			"16 -  About")
			
	case ${main} in
			" 1  –  Configurar o nome da máquina.")machine_name ;;
			" 2  –  Configurar um endereço IP.")config_ip ;;
			" 3  –  Visualizar as configurações da interface de rede.")view_config_interfaces ;;
			" 4  –  Crie uma rota padrão para o roteador.")new_roter_default ;;
			" 5  –  Crie uma rota para uma rede qualquer.")new_roter_any ;;
			" 6  –  Visualizar as rotas configuradas pelo sistema.")view_config_roter_system ;;
			" 7  –  Remova a rota padrão criada.")dell_roter_default ;;
			" 8  –  Remova uma rota criada para uma rede qualquer.")dell_roter_any ;;
			" 9  –  Desative a interface de rede.")desable_interface ;;
		        "10 -  Ative a interface de rede.")active_interface ;;
		        "11 -  Renove o emprestimo de ip.")refresh_ip ;;
		        "12 -  Ping host com TTL.")ping_ttl ;;
		        "13 -  Ping host com tamanho de pacote.")ping_package ;;
		        "14 -  Ping host quantidade minima de pacote.")ping_package_minim ;;
		        "15 -  Resolve um nome em um endereço IP.")name_ip ;;
			"16 -  About")about ;;
	esac
}

machine_name () {

        find /etc/hostname | zenity --progress --width 350 --pulsate --text "Aguarde..." \
			   
	machine=`zenity --width=250 --height=200 --entry \
			--title="Gerenciador de Rede." \
			--text="Digite o nome da máquina:"`
		
		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $machine ] ; then     
			zenity --error --text="Informe um nome para a máquina."
			machine_name

				elif ! [ -z `grep -w $machine /etc/hostname` ] ; then
				zenity --error --text="Nome de máquina já existe."
				machine_name
		else
	        hostname $machine
		zenity --info --text="Hostname alterado com sucesso."
		fi
	Menu
}

config_ip () {

	find /etc/hostname | zenity --progress --width 350 --pulsate --text "Aguarde..." \

	ip=`zenity --width=250 --height=200 --entry \
			--title="Gerenciador de Rede." \
			--text="Digite um IP para maquina EX: 192.168.1.100/28:"`

	   	if [ $? -eq 1 ] ; then
	   	Menu

			elif [ -z $ip ] ; then     
			zenity --error --text="Informe um IP para a máquina."
			config_ip
	   	fi

	interface=`zenity --width=250 --height=200 --entry \
			--title="Gerenciador de Rede." \
			--text="Digite a interface de rede que deseja atribuir o IP EX: wlan0 / eth0.:"`

		if [ $? -eq 1 ] ; then
	   	Menu

			elif [ -z $interface ] ; then     
			zenity --error --text="Informe uma interface para configurar."
			config_ip

				elif [ -z `ifconfig | cut -d " " -f 1 |grep $interface` ] ; then
				zenity --error --text="Interface de rede não existe."
				config_ip
		
	   	else
		ifconfig $interface $ip
		zenity --info --text="IP alterado com sucesso."
	   	fi
	Menu
}

view_config_interfaces () {

	find /etc/hostname | zenity --progress --width 350 --pulsate --text "Aguarde..." \

	ifconfig -a

	zenity --info --text="Visualize as informações de interface no terminal."
	Menu

}
	
new_roter_default () {

	find /etc/hostname | zenity --progress --width 350 --pulsate --text "Aguarde..." \

	rota=`zenity --width=250 --height=200 --entry \
			--title="Gerenciador de Rede." \
			--text="Digite IP do rotiador para rota padrão EX: 192.168.1.1:"`

	   	if [ $? -eq 1 ] ; then
	   	Menu

			elif [ -z $rota ] ; then     
			zenity --error --text="Informe um IP para a rota padrão."
			new_roter_default

	   	else
		route add default gw $rota
		zenity --info --text="Rota Padrão criada com sucesso."
	   	fi
	Menu
}

new_roter_any () {

	find /etc/hostname | zenity --progress --width 350 --pulsate --text "Aguarde..." \

	rota_any=`zenity --width=250 --height=200 --entry \
			--title="Gerenciador de Rede." \
			--text="Digite IP da rota que deseja criar EX: 192.168.1.80:"`

	   	if [ $? -eq 1 ] ; then
	   	Menu

			elif [ -z $rota_any ] ; then     
			zenity --error --text="Informe um IP para a rota."
			new_roter_any

	   	else
		route add -net $rota_any
		zenity --info --text="Rota criada com sucesso."
	   	fi
	Menu
}

view_config_roter_system () {

	find /etc/hostname | zenity --progress --width 350 --pulsate --text "Aguarde..." \

	route	
	
	zenity --info --text="Visualize no Terminal."
	Menu
}

dell_roter_default () {

	find /etc/hostname | zenity --progress --width 350 --pulsate --text "Aguarde..." \

	dell_router=`zenity --width=250 --height=200 --entry \
			--title="Gerenciador de Rede." \
			--text="Digite IP da rota que deseja Remover EX: 192.168.1.80:"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $dell_router ] ; then     
			zenity --error --text="Informe o ip da rota."
			dell_roter_default

		else 
	    	route del default gw $dell_router
	    	zenity --info --text="Rota padrão removida com sucesso."
		fi
	Menu
}

dell_roter_any () {

	find /etc/hostname | zenity --progress --width 350 --pulsate --text "Aguarde..." \

	dell_router_any=`zenity --width=250 --height=200 --entry \
			--title="Gerenciador de Rede." \
			--text="Digite IP da rota que deseja Remover EX: 192.168.1.55:"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $dell_router_any ] ; then     
			zenity --error --text="Informe o ip da rota."
			dell_roter_any

		else 
	    	route del -net $dell_router_any
	    	zenity --info --text="Rota padrão removida com sucesso."
		fi
	Menu	
}

desable_interface () {

	find /etc/hostname | zenity --progress --width 350 --pulsate --text "Aguarde..." \

	desable=`zenity --width=250 --height=200 --entry \
			--title="Gerenciador de Rede." \
			--text="Digite a interface:"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $desable ] ; then
			zenity --error --text="Informe uma interface de rede."
			desable_interface

				elif [ -z `ifconfig -a | cut -d" " -f 1 | grep $desable` ] ; then
				zenity --error --text="Interface de rede não existe."
				desable_interface

		else
		ifconfig $desable down
		zenity --info --text="Interface desabilitada com sucesso."
		fi
	Menu
}

active_interface () {

	find /etc/hostname | zenity --progress --width 350 --pulsate --text "Aguarde..." \

	active=`zenity --width=250 --height=200 --entry \
			--title="Gerenciador de Rede." \
			--text="Digite a interface:"`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $active ] ; then
			zenity --error --text="Informe uma interface de rede."
			active_interface

				elif [ -z `ifconfig -a | cut -d" " -f 1 | grep $active` ] ; then
				zenity --error --text="Interface de rede não existe."
				active_interface

		else
		ifconfig $active up
		zenity --info --text="Interface desabilitada com sucesso."
		fi
	Menu
}

refresh_ip () {
		
	find /etc/hostname | zenity --progress --width 350 --pulsate --text "Aguarde..." \

	
	refresh=`zenity --width=250 --height=200 --entry \
					--title="Gerenciador de Rede." \
					--text="Digite a interface."`
					
		if [ $? -eq 1 ] ; then
		Menu
			
			elif [ -z $refresh ] ; then
			zenity --error --text="Informe a interface."
			refresh_ip
				
				elif [ -z `ifconfig -a | cut -d" " -f 1 | grep $refresh` ] ; then
				zenity --error --text="Interface de rede não existe."
				refresh_ip
			
		else
		dhclient $refresh
		zenity --info --text="Ip Renovado com sucesso."
		fi
	Menu
}

ping_ttl () {

	find /etc/hostname | zenity --progress --width 350 --pulsate --text "Aguarde..." \

	
	ip=`zenity --width=250 --height=200 --entry \
				--title="Gerenciador de Rede." \
				--text="Digite o endereço que deseja pingar. Ex: wwww.google.com.br."`
	
		if [ $? -eq 1 ] ; then
		Menu
	
			elif [ -z $ip ] ; then
			zenity --error --text="Informe o endereço que deseja pingar."
			ping_ttl
		fi

	ping=`zenity --width=250 --height=200 --entry \
		     --title="Gerenciador de Rede." \
		     --text="Digite o valor do ttl que deseja pingar."`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $ping ] ; then
			zenity --error --text="Informe o valor do ttl para pingar."
			ping_ttl
	
		else
	    	ping -t $ping $ip
		zenity --info --text="Visualize no terminal."
		fi
	Menu
}

ping_package () {

	find /etc/hostname | zenity --progress --width 350 --pulsate --text "Aguarde..." \

	ip=`zenity --width=250 --height=200 --entry \
		   --title="Gerenciador de Rede." \
		   --text="Digite o endereço que deseja pingar. Ex: wwww.google.com.br ."`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $ip ] ; then
			zenity --error --text="Informe o endereço que deseja pingar."
			ping_package
		fi

	ping=`zenity --width=350 --height=200 --entry \
		     --title="Gerenciador de Rede." \
	   	     --text="Digite o valor do pacote que deseja enviar no ping."`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $ping ] ; then
			zenity --error --text="Informe o tamanho do pacote para pingar."
			ping_package

		else
		ping -s $ping $ip
		zenity --info --text="Visualize no terminal."
		fi
	Menu
}

ping_package_minim () {

	find /etc/hostname | zenity --progress --width 350 --pulsate --text "Aguarde..." \

	ip=`zenity --width=250 --height=200 --entry \
		   --title="Gerenciador de Rede." \
		   --text="Digite o endereço que deseja pingar. Ex: wwww.google.com.br ."`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $ip ] ; then
			zenity --error --text="Informe o endereço que deseja pingar."
			ping_package_minim
		fi

	ping=`zenity --width=350 --height=200 --entry \
		     --title="Gerenciador de Rede." \
	   	     --text="Digite o quantidade minima de pacotes a ser enviado."`

		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $ping ] ; then
			zenity --error --text="Informe quantidade mininma de pacotes."
			ping_package_minim

		else
		ping -c $ping $ip
		zenity --info --text="Visualize no terminal."
		fi
	Menu
}

name_ip () {

	find /etc/hostname | zenity --progress --width 350 --pulsate --text "Aguarde..." \

	ip=`zenity --width=250 --height=200 --entry \
		   --title="Gerenciador de Rede." \
		   --text="Digite o endereço que deseja resolver. Ex: www.facebook.com.br"`
	
		if [ $? -eq 1 ] ; then
		Menu

			elif [ -z $ip ] ; then
			zenity --error --text="Digite o endereço que deseja resolver o nome."
			name_ip
		
		else
		nslookup $ip
		zenity --info --text="Visualize no terminal."
		fi
	Menu
}

about () {
		
	find /home | zenity --progress --width 350 --text "Aguarde..."

	zenity --list --column "Informações." \
		      --title="About" \ "Henrique" \ "email: henrique.lr89@gmail.com"
	Menu
}
Menu
