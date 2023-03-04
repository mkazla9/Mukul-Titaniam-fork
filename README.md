# CI/CD project for hello world application

This project covers on following topics
1. CI via Azure Devops
2. Resource creation via Terraform
3. CD via Terraform

## CI
This section contains two major units
#### 1. Build: 
This section covers compile and build part for the java application which is done via Azure devops

```
  - job: Build
    displayName: Compile and build docker image
    steps:
      - task: Maven@4
        inputs:
          mavenPomFile: 'pom.xml'
          publishJUnitResults: false
          javaHomeOption: 'JDKVersion'
          mavenVersionOption: 'Default'
          mavenAuthenticateFeed: false
          effectivePomSkip: false
          sonarQubeRunAnalysis: false
```

Once build is successful it creates a target folder where the jar file gets created from the above step
, post which docker runs and creates an image using the jar file

```
      - task: Docker@2
        inputs:
          command: 'build'
          Dockerfile: '**/Dockerfile'
          arguments: '-t helloworld:v1'
          addPipelineData: false
          addBaseImageData: false
```

#### Dockerfile
```
#  Base image
FROM thothbot/alpine-jre8:latest

# Add Target JAR file
COPY target/myproject-0.0.1-SNAPSHOT.jar ./

# Expose ports
EXPOSE 8080:8080

# Modify Users
USER 1001

# Entry point for Application
ENTRYPOINT ["java", "-jar", "./myproject-0.0.1-SNAPSHOT.jar"]

```

## Infrastructure creation
Since it is a one time job, I have intentionally added the infrastructure creation job in the pipeline only
. This step is done using terraform where we are creating multiple resources like Vnets, subnet, VM, LB and public ip address. 
















## Assumptions/considerations

1. While creating the VM via terraform, I have used the local SSH key instead of creating one via TF, In case
if you are testing the module, please create a SSH key with name ~/.ssh/id_rsa.pub
