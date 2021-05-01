# NATS

Build and run NATS on a container. Can be Caprover, k8s or any VM that can execute a Dockerfile.

## Specs

| spec   | verion      | note                     |
| ------ | ----------- | ------------------------ |
| alpine | alpine:3.13 |                          |
| NATS   | nats:2.2.2  | from github release page |
|        |             |                          |

## Directory structure

```sh
nats-run/
├── build
├── build
│   ├── docker-entrypoint.sh
│   ├── nats-server.conf
└───└── Dockerfile
```

This downloads the official NATS server [release binaries] from `official nats github repo`  when building the server image and `COPY` a default configuration file.

## Updating NATS server version

First, make sure there is a [published](https://github.com/nats-io/nats-server/tags) version of the new NATS server git tag and make sure the [release binaries] are ready to download.

Next, run this command. `update.sh` will update Dockerfiles and
anything else to the version you specify.

In addition, the scratch binaries will be built. We will fetch the server
version tag and use the specified Go version to build the binaries.

```sh
usage: ./update.sh <server version> <linux release sha256>
       ./update.sh 2.1.0 68e656b251e67e8358bef8483ab0d51c6619f3e7a1a9f0e75838d41ff368f728
```

You can get the Linux release SHA256 from the [release binaries] page or by
running this command.

```sh
shasum -a 256 nats-server.zip
```
