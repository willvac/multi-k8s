docker build -t willvac/multi-client:latest -t willvac/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t willvac/multi-server:latest -t willvac/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t willvac/multi-worker:latest -t willvac/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push willvac/multi-client:latest
docker push willvac/multi-server:latest
docker push willvac/multi-worker:latest

docker push willvac/multi-client:$SHA
docker push willvac/multi-server:$SHA
docker push willvac/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=willvac/multi-server:$SHA
kubectl set image deployments/client-deployment client=willvac/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=willvac/multi-worker:$SHA


