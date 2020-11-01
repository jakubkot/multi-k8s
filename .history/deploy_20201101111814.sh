docker build -t jakubkot/multi-client:latest -t jakubkot/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jakubkot/multi-server:latest -t jakubkot/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jakubkot/multi-worker:latest -t jakubkot/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jakubkot/multi-client:latest
docker push jakubkot/multi-server:latest
docker push jakubkot/multi-worker:latest

docker push jakubkot/multi-client:$SHA
docker push jakubkot/multi-server:$SHA
docker push jakubkot/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jakubkot/multi-server:$SHA
kubectl set image deployments/client-deployment client=jakubkot/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jakubkot/multi-worker:$SHA
