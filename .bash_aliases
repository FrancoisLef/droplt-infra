alias c="clear"
alias l="ls -FGlAhph"
alias dc="docker"
alias dcc="docker-compose"

function dccRestart {
	docker-compose down --remove-orphans && docker-compose up -d
}

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

function htpasswd {
	docker run --rm --name apache httpd:alpine htpasswd -nb $1 $2
}

function htpasswdTraefik {
	docker run --rm --name apache httpd:alpine htpasswd -nb $1 $2 | sed -e s/\\$/\\$\\$/g
}
