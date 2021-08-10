

# Build and push docker images

docker build --tag jreneponce/azfunckeda:latest .

docker run -p 8080:80 -it jreneponce/azfunckeda:latest

docker push jreneponce/azfunckeda:latest 

docker run -p 8080:80 -it --env AzureWebJobsStorage="DefaultEndpointsProtocol=https;AccountName=azfunckeda;AccountKey=O3art4A1nDwT2eX/7SLLgFNyGxNYDAjYJfiJMPl4WiIAipZNJtcSXJu0z6XSNQiM7enQ5ZQJD++iMmOGgwz2MQ==;EndpointSuffix=core.windows.net" jreneponce/azfunckeda:latest

# Install KEDA

kubectl apply -f keda-2.0.0.yaml

# Other links

https://github.com/kedacore/sample-hello-world-azure-functions/blob/master/README.md
https://keda.sh/docs/2.0/deploy/
https://www.thorsten-hans.com/deploy-azure-functions-to-kubernetes-and-scale-them-automatically/

 