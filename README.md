# PHP App

This is a Simple PHP apps that read a config.json file and output the content on the screen. The example is made to run as a Container that mount the config file as a volume.


## Pre requisit
1. Podman or Docker to build the image
1. Access to a container registry. In this case we use Quay.io
1. Access to an Openshift 4.X installation



## Demo

#### Retrieve/build the image

There is 2 options to retrieve the require image for this demo.

* ##### Option 1

    Build the container from a Fork or Clone of this repository and uploaded to your container registry.

Example using podman:
* Build the image
    ```
    podman build -t php-json-reader .
    ```
* Test running the image localy.
    ```
    podman run --name php-reader -d -p 8080:8080 localhost/php-json-reader
    ```
    
    The image can now be access at http://localhost:8080

    :warning: The config file doesn't display since no volume is mounted.

* Stop the container
    ```
    podman stop php-reader
    ```

* Tag the image
    ```
    podman *tag localhost/php-json-reader [YOUR_REGISTRY_URL]/php-json-reader:stable
    ```
* Push the image
    ```
    podman push [IMAGE_TAG_CREATE_BEFORE]
    ```

* ##### Option 2

    Use the image that was already build found at 
    ```
    quay.io/froberge/php-json-reader:stable
    ```

#### Create the new Application

1. Create a new project.
    ```
    oc new-project php-demo
    ```

1. Create a `new-app`. For this command we use option 2
    ```
    oc new-app --name php-reader --docker-image=quay.io/froberge/php-json-reader:stable --as-deployment-config=true
    ```

1. Expose the application
    ```
    oc expose services/php-reader
    ```

#### Create the needed secrets
```
oc create secret generic app-config --from-file=docs/config.json
```

### Add the secrets to the Deployment Config
```
oc set volume dc/php-reader --add  --type=secret \
 -m /opt/ \
--name php-json-reader-vol --secret-name app-config
```

:warning: You might have to scale down and up for the pod to see the changes. 