
# laravel-docker-primary

This is a lavarel project which is contenarized with docker. Here I have decoupled all the docker files which will give you more control over each container.

### Prerequisites

What things you need to have installed in your machine:

```
Git, Docker, docker-compose, composer
```

### How to run this lavarel application skeleton on your local machine?


The steps to follow:

```
clone the repo in your local computer with "git clone https://github.com/farhadraiyan/laravel-docker-primary.git" 
```
```
Navigate to the '/backend/php/src' install all dependancies with "composer install" command.
```
```
And finally go the root dir of this project where the docker-compose.yaml file is and hit "docker-compose up" from command line. 
```
Now you will see the default laravel app running on localhost:8080.

### Limitations

This app will be fine if you have composer installed on your machine and if you are willing to take one step ("composer install") more before docker-compose up.

