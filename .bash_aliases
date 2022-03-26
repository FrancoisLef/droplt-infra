###
# Helpers
###
alias c="clear"
alias l="ls -FGlAhph"
alias dc="docker"
alias dcc="docker-compose"

###
# Docker-compose functions
###
function dccdown {
	docker-compose down --remove-orphans
}

function dccstop {
	docker-compose stop $1
}

function dccstart {
	docker-compose up --remove-orphans -d $1
}

function dccupdate {
	docker-compose pull $1
}

function dccrestart {
	docker-compose up --remove-orphans --force-recreate -d $1
}

function dcclogs {
	docker-compose logs -f $1
}

###
# VPN functions
###
function vpnStart {
	docker-compose up -d openvpn
}

function vpnStop {
	docker-compose stop openvpn
}

function vpnAddUser {
	docker-compose run --rm openvpn easyrsa build-client-full $1 nopass
	docker-compose run --rm openvpn ovpn_getclient $1 > ~/vpn/clients/$1.ovpn
}

function vpnListUser {
	docker-compose run --rm openvpn ovpn_listclients
}

function vpnRemoveUser {
	docker-compose run --rm openvpn ovpn_revokeclient $1 remove
}

###
# HTpasswd functions
###
function htpasswd {
	docker run --rm --name apache httpd:alpine htpasswd -nb $1 $2
}

function htpasswdTraefik {
	docker run --rm --name apache httpd:alpine htpasswd -nb $1 $2 | sed -e s/\\$/\\$\\$/g
}
