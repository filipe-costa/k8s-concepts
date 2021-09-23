.PHONY: \
		build \
		create-ns \
		create-pv \
		chi-svc \
		elastic-svc \
		fluentd-svc \
		kibana-svc \
		check-nginx-controller

SHELL := /bin/bash
	
# Build image
build:
	docker build -t chi .

create-ns: 
	kubectl apply -f ./config/kube-logging-ns.yaml

create-pv: 
	kubectl apply -f ./config/persistent-vol.yaml

chi-svc:
	kubectl apply -f ./config/chi-service.yaml

elastic-svc: 
	kubectl apply -f ./config/elastic-service.yaml

kibana-svc: 
	kubectl apply -f ./config/kibana-service.yaml

fluentd-svc:
	kubectl apply -f ./config/fluentd-service.yaml

check-nginx-controller:
	kubectl wait --namespace ingress-nginx \
		--for=condition=ready pod \
		--selector=app.kubernetes.io/component=controller \
		--timeout=120s
