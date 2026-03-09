#!/usr/bin/env bash

_install_go() {
	local version tar
	version=$(curl -sL http://go.dev/dl/?mode=json | jq -r '.[0].version')

	download https://go.dev/dl/${version}.linux-amd64.tar.gz
	extract ${version}.linux-amd64.tar.gz

	sudo rm -rf /usr/local/go
	sudo mv go /usr/local/go
}

with_temp_dir _install_go
