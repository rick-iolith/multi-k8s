docker build -t gordonbleu/multi-client:latest -t gordonbleu/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gordonbleu/multi-server:latest -t gordonbleu/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gordonbleu/multi-worker:latest -t gordonbleu/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push gordonbleu/multi-client:latest
docker push gordonbleu/multi-server:latest
docker push gordonbleu/multi-worker:latest

docker push gordonbleu/multi-client:$SHA
docker push gordonbleu/multi-server:$SHA
docker push gordonbleu/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gordonbleu/multi-server:$SHA
kubectl set image deployments/client-deployment client=gordonbleu/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gordonbleu/multi-worker:$SHA
