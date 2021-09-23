# K8S-Concepts

## How to run

Clone repository:

    $ git clone https://github.gamesys.co.uk/Filipe-Costa/k8s-concepts

Open the terminal and run the following commands:
    
    $ minikube config set WantVirtualBoxDriverWarning false
    $ minikube config set driver virtualbox
    $ minikube config set cpus 2
    $ minikube config set memory 8192
    $ minikube start

Wait for minikube to start then activate ingress addon:

    $ minikube addons enable ingress

On the same terminal window run (to allow minikube to run local docker images):

    $ eval $(minikube docker-env)

Run the following commands in order:

    $ Make build
    $ Make create-ns
    $ Make create-pv
    $ Make chi-svc

Wait a minute or two between each of these services:

    $ Make elastic-svc
    $ Make fluentd-svc
    $ Make kibana-svc

Run the following command:

    $ minikube ip

Copy the IP and add it to your /etc/hosts file (don't forget to save it):

    $ sudo nano /etc/hosts


    <ip> chi.com, logging.com

You can now access the pages through your browser window:

    http://chi.com/healthz -> returns OK

    http://logging.com/kibana -> returns Kibana dashboard

Setup Index Pattern in Kibana:

- Management > Stack Management > Index Patterns > Create Index Pattern

- Add logstash* to the index pattern

Check if Fluentd is aggregating logs correctly:

- curl -v http://chi.com/healthz

- Go to http://logging.com/kibana > Discovery > Analytics > Type chi-svc in the search bar, it should show that the endpoint has been hit.

## Todo

- Understand why Fluentd image doesn't allow to read custom logs stored at /data/logs (probably a lack of permissions?)

## References
[Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
[DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)
[Service](https://kubernetes.io/docs/concepts/services-networking/service/)
[DNS for Services and Pods](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/)
[Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)
[Ingress Controllers](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/)
[Role-based Access Control (RBAC)](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)