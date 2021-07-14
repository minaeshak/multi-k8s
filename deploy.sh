docker build -t minaeshak/multi-client:latest -t minaeshak/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t minaeshak/multi-server:latest -t minaeshak/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t minaeshak/multi-worker:latest -t minaeshak/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push minaeshak/multi-client:latest
docker push minaeshak/multi-server:latest
docker push minaeshak/multi-worker:latest
docker push minaeshak/multi-client:$SHA
docker push minaeshak/multi-server:$SHA
docker push minaeshak/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=minaeshak/multi-server:$SHA
kubectl set image deployments/client-deployment client=minaeshak/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=minaeshak/worker-server:$SHA