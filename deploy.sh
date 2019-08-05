docker build -t bernardobraslourenco/multi-client:latest -t bernardobraslourenco/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bernardobraslourenco/multi-server:latest -t bernardobraslourenco/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bernardobraslourenco/multi-worker:latest -t bernardobraslourenco/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push bernardobraslourenco/muilt-client:latest
docker push bernardobraslourenco/muilt-client:$SHA
docker push bernardobraslourenco/muilt-server:latest
docker push bernardobraslourenco/muilt-server:$SHA
docker push bernardobraslourenco/muilt-worker:latest
docker push bernardobraslourenco/muilt-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bernardobraslourenco/muilt-server:$SHA
kubectl set image deployments/client-deployment client=bernardobraslourenco/muilt-client:$SHA
kubectl set image deployments/worker-deployment worker=bernardobraslourenco/muilt-worker:$SHA