## Generate htpasswd hash

Basic:
```sh
docker run --rm --name apache httpd:alpine htpasswd -nb $USERNAME $PASSWORD
```

For traefik:

```sh
docker run --rm --name apache httpd:alpine htpasswd -nb $USERNAME $PASSWORD | sed -e s/\\$/\\$\\$/g
```

## OpenvPN

Tutorials:
- https://www.grottedubarbu.fr/serveur-openvpn-5-minutes-docker/
- https://github.com/kylemanna/docker-openvpn/blob/master/docs/docker-compose.md

### Setup

Clone git project:

```sh
git clone https://github.com/kylemanna/docker-openvpn.git ./vpn/repository
```

Build docker image:

```sh
docker-compose build openvpn
```

Create folders to save configuration and certificates:

```sh
mkdir ./vpn/data
mkdir ./vpn/clients
```

Initialize configuration files:

```sh
docker-compose run --rm openvpn ovpn_genconfig -u udp://$SERVER_IP
```

Generate certificates:

```sh
docker-compose run --rm openvpn ovpn_initpki
```

> - Enter passphrase
> - Enter Common Name (server name)

*(Optional)* fix ownership:

```sh
sudo chown -R $(whoami): ./vpn/data
```

### Usage

Start server:

```sh
docker-compose up -d openvpn
```

Add client:

```sh
docker-compose run --rm openvpn easyrsa build-client-full $CLIENTNAME nopass
```

Retrieve client certificates:

```sh
docker-compose run --rm openvpn ovpn_getclient $CLIENTNAME > ./vpn/clients/$CLIENTNAME.ovpn
```

Revoke a client:

```sh
docker-compose run --rm openvpn ovpn_revokeclient $CLIENTNAME remove
```

List clients:

```sh
docker-compose run --rm openvpn ovpn_listclients
```

### Update

Pull repository updates:

```sh
cd ./vpn/repository
git pull --rebase
cd ../..
```

Rebuild docker image:

```sh
docker-compose build openvpn
```

Restart container:

```sh
docker-compose restart openvpn
```
