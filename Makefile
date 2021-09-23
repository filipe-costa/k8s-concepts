.PHONY: \
		build \
		kube-logging-ns \
		persistent-vol \
		kibana-svc \
		fluentd-svc \
		elastic-svc \
		chi-svc \
		check-nginx-controller

SHELL := /bin/bash
	
# Build image
build:
	docker build -t chi .

kube-logging-ns:
	kubectl apply -f ./config/kube-logging-ns.yaml

persistent-vol: 
	kubectl apply -f ./config/persistent-vol.yaml

kibana-svc:
	kubectl apply -f ./config/kibana-service.yaml

fluentd-svc:
	kubectl apply -f ./config/fluentd-service.yaml

elastic-svc:
	kubectl apply -f ./config/elastic-service.yaml

chi-svc:
	kubectl apply -f ./config/chi-service.yaml

check-nginx-controller:
	kubectl wait --namespace ingress-nginx \
		--for=condition=ready pod \
		--selector=app.kubernetes.io/component=controller \
		--timeout=120s