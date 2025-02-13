## Welcome to the docker tutorial.

First, we will connect to the DSI servers.

``` shell
ssh ubuntu@landmark-t-01.dsi.ic.ac.uk
su -l ah3918
```

You should now be in your home directory. Next, we're going to make sure docker daemon is running.

``` {.shell .sh}
docker run hello-world
```

We will also login to our docker.

``` shell
docker login
```

Next, we're going to clone the essential functions repository.

### Setting up

```         
git clone https://github.com/johnsonlab-ic/essential_functions/
cd essential_functions
```

Then, we're going to build our first image! I've loaded a very simple image, in `Docker_images/Dockerfile.tutorial.`

```         
docker build -t my_tutorial_image:latest -f Docker_images/Dockerfile.tutorial .
```

Where;

-   `-t tutorial_image:latest` tags the image with the name `tutorial_image` and the tag `latest`.

-   `-f Dockerfile.tutorial` specifies the Dockerfile to use.

-   `.` specifies the current directory as the build context.

You have now build a Docker "image", which is a lightweight, standalone executable package that contains everything you've loaded the instructions with.

## Running the containers

To make use of this Docker image, you need to run a Docker **container**. A **container** is a runtime "instance" of a docker image - which again, uses the image and loads all necessary packages. The "instance" is an important distinction; because you can run multiple containers from the same image. The important part of a container is that it is **isolated from the host system**, meaning you can do whatever you want within them without fear of breaking anything. It also means that it's lightweight and **completely** **configurable**. Now, you can run your image!

``` shell
docker run -it --name tutorial_container my_tutorial_image:latest
```

This will open up an interactive session. You are now "inside" the container. Anything done here will remain in the container. To exit the container, you can use "`exit`" . This "stops" the container, and you would have to re-start it and re-attach it.

`docker ps` will show active containers

`docker ps -a` will show active and stopped containers

## 

### Mounting the file system

One of the "drawbacks" of a container is that it is in fact, completely isolated to everything; it is it's own system, with its own packages, filesystem, config files etc. It doesn't know about anything "outside" of it. Unless, you specifically mount directories in it.

First, we'll create a directory in your home directory, and add some textfiles. Make sure you are no longer inside the container!

``` shell
cd $home
mkdir -p tutorial_dir
echo "This is file 1" > tutorial_dir/file1.txt
echo "This is file 2" > tutorial_dir/file2.txt
```

Then, we'll restart the container. For security reasons, docker does not allow you to mount a folder on an already "created" container. So we'll remove/delete the old container and start again.

``` shell
docker stop tutorial_container
docker rm tutorial_container
docker run -it --name tutorial_container -v $(pwd)/tutorial_dir:/app/tutorial_dir my_tutorial_image:latest
```

# 

### Bonus - Jupyter server within a docker container

You can even create a jupyter server within a docker container that you can connect to externally! I have created a file called Dockerfile.tutorial_jupyter which contains some instructions to set this up.

To run this you need to.

1.  Build the image

```         
cd ${home}
cd essential_functions/
git pull
docker build -t jupyter_tutorial:latest -f Docker_images/Dockerfile.tutorial_jupyter .
```

2.  Run the container

```         
cd $home
docker run -p 8888:8888 -v ./tutorial_dir:/app/tutorial_dir --name jupyter_tutorial_container jupyter_tutorial:latest
```

3.  This will run a jupyter server. You can connect with the provided link.