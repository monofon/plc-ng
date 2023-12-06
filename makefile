run-image: plc-ng-image
	docker run --rm \
		-p 8192:8888 \
		--name plc-ng \
		monofon/plc-ng:latest

plc-ng-image: 
	docker build --tag=plc-ng plc-ng-image
	docker tag plc-ng monofon/plc-ng
	docker push monofon/plc-ng

