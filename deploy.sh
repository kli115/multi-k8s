docker build -t kylelicode/multi-client:latest -t kylelicode/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kylelicode/multi-server:latest -t kylelicode/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kylelicode/multi-worker:latest -t kylelicode/multi-worker:$SHA -f ./worker/Doockerfile ./worker

docker push kylelicode/multi-client:latest
docker push kylelicode/multi-client:$SHA
docker push kylelicode/multi-server:latest
docker push kylelicode/multi-server:$SHA
docker push kylelicode/multi-worker:latest
docker push kylelicode/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kylelicode/multi-server:$SHA
kubectl set image deployments/client-deployment client=kylelicode/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kylelicode/multi-worker:$SHA