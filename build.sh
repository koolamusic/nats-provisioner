#!/usr/bin/env bash
set -ex

ver=(NATS_SERVER 2.2.2)

(
	cd ./build
	docker build --tag nats:2.2.2-alpine3.13 .
)