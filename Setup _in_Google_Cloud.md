# How to deploy your Containerize Web Application in Google Cloud.

In this method we are going to deploy an containerized Web Application on Google Cloud using [Google Cloud Run](https://cloud.google.com/run).

## Requirements

- Google Cloud Account
- Docker File 

That's all we require.  

## Steps

 1. Go to [Cloud Run Console](https://console.cloud.google.com/)
 2. Click Create service to display the Create service form  
	 ![image](https://cloud.google.com/run/docs/images/create-service-form.png)     
	In the form,
	1.  Select Cloud Run (fully managed) as your development platform.
	2.  Select the [region](https://cloud.google.com/run/docs/quickstarts/prebuilt-deploy#before-you-begin) 	where you want your service located.    
	3.  Specify the name you want to give to your service.
	4.  Select **Allow unauthenticated invocations** to be able to open the result in your web browser
	5.  Click **Next** to continue to the second page of the service creation form
	![image](https://cloud.google.com/run/docs/images/create-service-form2.png)
	6.  **Note** : Before proceeding with this step make sure you have push your container image.
	7.  Use `gcr.io/{service-name}/{container-name}` as a container image.
		service-name : Created in Step 2.3
		container-name : name of the Docker container pushed   
	8. Click **Create** to deploy the image to Cloud Run and wait for the deployment to finish.
 3.   Click the displayed URL link to run the deployed container.

Before Proceeding with Step 2.6, we have to push the Container.

1. Setup the [Google Cloud SDK](https://cloud.google.com/sdk/docs)
2. After setting up, run `gcloud init` 
3. Then create a docker file
4. Finally, run `gcloud builds submit --tag gcr.io/{service-name}/{container-name}`

OR

1. `docker build . --tag gcr.io/{service-name}/{container-name}`
2. `gcloud auth configure-docker`
3. `docker push gcr.io/{service-name}/{container-name}`

## Tested For
    
 - [x] Flask Application (Containerized)

## References

 1. https://cloud.google.com/run/docs/quickstarts/prebuilt-deploy
 2. https://cloud.google.com/run/docs/quickstarts/build-and-deploy