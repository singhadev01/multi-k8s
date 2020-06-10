# https://github.com/ajaysinghdocker/multi-k8s/blob/master/deploy.sh
docker build -t ajaysinghdocker/multi-client:latest -t ajaysinghdocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ajaysinghdocker/multi-server:latest -t ajaysinghdocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ajaysinghdocker/multi-worker:latest -t ajaysinghdocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ajaysinghdocker/multi-client:latest
docker push ajaysinghdocker/multi-server:latest
docker push ajaysinghdocker/multi-worker:latest

docker push ajaysinghdocker/multi-client:$SHA
docker push ajaysinghdocker/multi-server:$SHA
docker push ajaysinghdocker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ajaysinghdocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=ajaysinghdocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ajaysinghdocker/multi-worker:$SHA