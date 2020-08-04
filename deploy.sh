docker build -t mistyfo/multi-client:latest -t mistyfo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mistyfo/multi-server:latest -t mistyfo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mistyfo/multi-worker:latest -t mistyfo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mistyfo/multi-client:latest
docker push mistyfo/multi-server:latest
docker push mistyfo/multi-worker:latest

docker push mistyfo/multi-client:$SHA
docker push mistyfo/multi-server:$SHA
docker push mistyfo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mistyfo/multi-server:$SHA
kubectl set image deployments/client-deployment server=mistyfo/multi-client:$SHA
kubectl set image deployments/worker-deployment server=mistyfo/multi-worker:$SHA