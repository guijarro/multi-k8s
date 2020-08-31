docker build -t mguijarro/multi-client:latest -t mguijarro/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mguijarro/multi-server:latest -t mguijarro/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mguijarro/multi-worker:latest -t mguijarro/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mguijarro/multi-client:latest
docker push mguijarro/multi-server:latest
docker push mguijarro/multi-worker:latest

docker push mguijarro/multi-client:$SHA
docker push mguijarro/multi-server:$SHA
docker push mguijarro/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mguijarro/multi-server:$SHA
kubectl set image deployments/client-deployment client=mguijarro/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mguijarro/multi-worker:$SHA
