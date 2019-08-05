docker build -t bernardobraslourenco/multi-client:latest -t bernardobraslourenco/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bernardobraslourenco/multi-server:latest -t bernardobraslourenco/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bernardobraslourenco/multi-worker:latest -t bernardobraslourenco/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push bernardobraslourenco/multi-client:latest
docker push bernardobraslourenco/multi-client:$SHA
docker push bernardobraslourenco/multi-server:latest
docker push bernardobraslourenco/multi-server:$SHA
docker push bernardobraslourenco/multi-worker:latest
docker push bernardobraslourenco/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bernardobraslourenco/multi-server:$SHA
kubectl set image deployments/client-deployment client=bernardobraslourenco/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bernardobraslourenco/multi-worker:$SHA