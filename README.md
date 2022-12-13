This PHP application display the content of a file mounted by configmap

``` oc apply -k manifests/argocd  ```

this will create a php-demo namespace with a build config and a deployment for the application

to expose the application:

``` oc expose svc/php-cm -n php-demo ```

