#!/usr/bin/env bash
set -ex

ver=(NTRY dist)

(
	cd "${ver[1]}"
	docker build --tag nats:2.2.2-alpine3.13 .
)