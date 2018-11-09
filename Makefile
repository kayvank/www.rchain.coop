VERSION=1.0
APP_NAME=rchain.coop
IMAGE=$(DOCKER_USER)/$(APP_NAME)
TAG=$(VERSION)-$(CIRCLE_BUILD_NUM)
K8_SPEC=k8-spec

GULP=node_modules/.bin/gulp

login:
	@docker login -u "$(DOCKER_USER)" -p "$(DOCKER_PASS)"

clean: 
	$(NODE) $(GULP) clean

install: login
	$(NODE) npm install 

dist: install
	$(NODE) $(GULP) 

build_image:  dist
	docker build -t $(IMAGE) .

tag_image: build_image
	docker tag $(IMAGE)  $(IMAGE):$(TAG)
	docker tag $(IMAGE) $(IMAGE):latest

publish: tag_image
	docker push $(IMAGE):$(TAG)
	docker push $(IMAGE):latest

build: publish
.DEFAULT_GOAL :=publish

dev_ns: 
	kubectl apply -f $(K8_SPEC)/dev/ns.yaml
	kubectl apply -f $(K8_SPEC)/rchain-coop-deploy.yaml --namespace dev
	kubectl apply -f $(K8_SPEC)/rchain-coop-service.yaml --namespace dev
	kubectl apply -f $(K8_SPEC)/rchain-coop-ingress.yaml --namespace dev
certs:
	$(K8_SPEC)/createCert.sh
	kubectl create secret tls ca-key-pair --key=$(K8_SPEC)/ca.key --cert=$(K8_SPEC)/ca.crt
	kubectl apply -f $(K8_SPEC)/issuer.yaml
	kubectl apply -f $(K8_SPEC)/certificate.yaml

