## A. DOCKER INSTALATION:

1.- You must install Docker following the web instructions:
    

Link: www.docker.com

2.- You must follow the steps in the docker web to be familiar with.

3.- Also follow the instructions 'Post-installation steps for Linux'.

4.- It's important to clean your docker images and containers when you are goin to start with docker.

5. Install docker-compose.

Link: www.https://docs.docker.com/compose/install/

6. If you are user Windows remember share your C: drive in docker settings.


##  B. RUN DOCKER

1.- Download git:

~~~
git clone https://github.com/devscola/consensus
~~~

Start the docker-compose service to be able to run the test:

~~~
docker build
docker-compose build
~~~

In one console, up the docker container, in other console run the tests:

Console A:
~~~
docker-compose up
~~~

Console B:
    
All test:
    
~~~
docker-compose run web rake test
~~~

The unitarian spec tests:


~~~
docker-compose run web rake tdd
~~~


The behauvior spec tests:


~~~
docker-compose run web rake bdd
~~~

To run specific test you can do it like this:

docker-compose run web rspec -e  'any word of the test title' 


##C. QUICK SUMMARY OF DOCKER CHEAT SHEET

We are going to have docker images and docker containers, they are different.

For list images:

~~~
docker <image>
~~~

To run a container:

~~~
docker run [options]
~~~

Delete a image:

~~~
docker rmi <image>
~~~

If you can't delete a image is because it has not a tag. You should look your IMAGE ID to write it:

~~~
docker rmi <image_tag>
~~~

If de system don't allow you to delete it, is because you have to stop the container:

~~~
docker rmi <image> --force
~~~

View the containers:

~~~
docker ps -a
~~~

Delete a container:

~~~
docker rm <whalesay>
~~~

Delete all containers:

~~~
docker rm $(docker ps -a -q)
~~~

If it doesn't work, we can add -f (force):
    
~~~
docker rm -f $(docker ps -a -q)
~~~
    
Delete all images:

docker rmi -f $(docker images -q)
    
Every time that we make exit in our docker, we have to delete the container and we have to run again. 

~~~
docker rm <container_name>
~~~
