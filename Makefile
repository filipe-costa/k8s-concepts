.PHONY: \
		build \
		create-pv \
		create-pvc \
		deployment \
		search \
		aggregator \
		kibana \
		service \
		ingress \
		check-nginx-controller

SHELL := /bin/bash
	
# Build image
build:
	docker build -t chi .

create-pv: 
	kubectl apply -f ./config/pv.yaml

create-pvc:
	kubectl apply -f ./config/pv-claim.yaml

deployment:
	kubectl apply -f ./config/deployment.yaml

search: 
	kubectl apply -f ./config/elastic_search.yaml

aggregator:
	kubectl apply -f ./config/aggregator.yaml

kibana: 
	kubectl apply -f ./config/kibana.yaml

service:
	kubectl apply -f ./config/service.yaml

check-nginx-controller:
	kubectl wait --namespace ingress-nginx \
		--for=condition=ready pod \
		--selector=app.kubernetes.io/component=controller \
		--timeout=120s

ingress:
	kubectl apply -f ./config/ingress.yaml