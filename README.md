# RTPengine on docker
![license](https://img.shields.io/github/license/mach1el/docker-rtpengine?color=pink&style=plastic)
![Size](https://img.shields.io/github/repo-size/mach1el/docker-rtpengine?style=plastic)

RTPengine server for streaming RTP on SIP proxy/server such as: [Opensips](https://www.opensips.org/),[Kamailio](https://www.kamailio.org/w/)...
Builded on [debian buster](https://www.debian.org/releases/buster/)

### Pull from hub
	docker pull mich43l/rtpengine

### Build from source
	git clone https://github.com/mach1el/docker-rtpengine.git && cd docker-rtpengine
	docker image build -t docker-rtpengine .
	
### Run
*	docker run -tid --rm --name=rtpengine --network=host docker-rtpengine
* docker run -tid --rm --name=rtpengine -v /path/to/cfg:/etc/rtpengine docker-rtpengine

### Note
Mount config dir `/etc/rtpengine`  if you want run by your rules.