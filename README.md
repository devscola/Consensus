### README.md

## DOCKER INSTALATION:

1.- You must install Docker following the web instructions:

Link: www.docker.com

2.- You must follow the steps in the docker web to be familiar with.

3.- Also follow the instructions 'Post-installation steps for Linux'.

4.- It's important to clean your docker images and containers when you are goin to start with docker.

5. Install docker-compose.

Link: https://docs.docker.com/compose/install/

6. If you are user Windows remember share your C: drive in docker settings.


## RUN APP

1.- Download git:

~~~
git clone https://github.com/devscola/consensus
~~~

Start the docker-compose service to be able to run the test:

~~~
docker pull devscola/consensus:latest
docker-compose build
~~~

In one console, up the docker container:

**Console A:**

~~~
docker-compose up
~~~


If you want test the app, in other console run the tests:

**Console B:**

All test:
~~~
docker-compose run web rake test
~~~

If you want view app, open navigator (firefox, chrome, ...) and visit localhost:4567

# More information in file **CONTRIBUTING.md**
