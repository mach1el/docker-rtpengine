# RTPengine on docker
RTPengine server for voice record using with some SIP proxy/server such as: [Opensips](https://www.opensips.org/),[Kamailio](https://www.kamailio.org/w/)...
Simply build on [debian buster](https://www.debian.org/releases/buster/)

### Build
	git clone https://github.com/t7hm1/rtpengine-docker.git && cd rtpengine-docker
	docker image build -t rtpengine_docker .
	
## Run
*	docker run -tid --rm --network=host rtpengine_docker

## License
![GitHub](https://img.shields.io/github/license/t7hm1/rtpengine-docker?style=flat-square)
