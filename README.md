# CI/CD project for hello world application

This project covers on following topics
1. CI via Azure Devops
2. Resource creation via Terraform
3. CD via Azure Devops

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
This is a seperate pipeline which is responsible for creation on underlying infrastructure. 
[pipeline](https://dev.azure.com/mkazla9/Mukul-Titaniam/_build?definitionId=3&_a=summary)

This has two sections
#### 1. Modules [Modules](https://github.com/mkazla9/Mukul-Titaniam-fork/tree/master/Deployment/tf-modules)
They are re-usable and can be added multiple times into different repos
#### 2. Actual infra TF files [Files](https://github.com/mkazla9/Mukul-Titaniam-fork/tree/master/Deployment/terraform-infra)
This section is using the re-usable modules to create the infrastructure. 

## CD
This section is included in the same yaml file, these steps are done using azure devops steps only.

```
- stage: DeployDocker
  displayName: Deploy jar file to virtual machine
  jobs:
  - job: Deployment
    displayName: deploy docker
    steps:
      - task: Bash@3
        displayName: Upload docker file to machine
        inputs:
          targetType: 'inline'
          script: 'docker save -o helloworld.tar helloworld:v1'
      - task: Bash@3
        displayName: Upload file to destination
        inputs:
          targetType: 'inline'
          script: 'ssh ssh adminuser@20.124.218.57 tar czf - helloworld.tar > /tmp/helloworld.tar;'
```

## Assumptions/considerations

1. While creating the VM via terraform, I have used the local SSH key instead of creating one via TF, In case
if you are testing the module, please create a SSH key with name ~/.ssh/id_rsa.pub
2. You need to run Terraform pipeline first so that infra is created first and then some additions are needed in pipeline variables so that the correct VM is picked
up. 
