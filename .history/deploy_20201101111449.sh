docker build -t jakubkot/multi-client:latest -t jakubkot/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jakubkot/multi-server:latest -t jakubkot/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jakubkot/multi-worker:latest -t jakubkot/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jakubkot/multi-client
docker push jakubkot/multi-server
docker push jakubkot/multi-worker
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jakubkot/multi-server
