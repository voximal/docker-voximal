## Voximal Stack  Dockerfile

This repository contains the Dockerfile recipe to build a voximal stack container using Docker.
Voximal allows you to create voice portals with VoiceXML language to interact with humans through phone calls. It is integrated with Asterisk, and FreePBX core softwares.

The core telephony software is Asterisk, the open source PBX. Web GUI is the popular FreePBX, propulsed by LAMP (Linux,Apache,Mysql,PHP). Mission critical software Voximal, is free for one channel.

Voximal is compliant with VoiceXML 2.1's W3C standard language. Asterisk offers all common VoIP protocols, as SIP. Speech recognition and synthesis is available over MRCP's IETF standard or even native HTTP connector. The stack suite runs on the unbeatable GNU/Linux operating system. 

## Downloading prebuit latest image for rolling version (test)

```
docker pull voximal/stacktest
```

## Building

```
docker build -t voximal/stack  https://github.com/voximal/docker-voximal/tree/test
```

## Running

You need to open port 80, for freepbx http interface, and UDP port 4569, if
you would like to call easily. 

```
docker run -i -t -p 80:80 -p 4569:4569/udp  voximal/stacktest  my_init -- bash -l
```

## Post-installing

Get your container's IP address (replace the CONTAINER_ID):

```
docker inspect --format '{{ .NetworkSettings.IPAddress }}' <CONTAINER_ID>
```

Then go to http://container.ip with your web browser.


---

**More information on https://wiki.voximal.com**
