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

To make use of this Docker image, you need to run a Docker **container**. A **container** is a runtime "instance" of a docker image - which again, uses the image and loads all necessary packages. The "instance" is an important distinction; because you can run multiple containers from the same image. The important part of a container is that it is **isolated from the host system**, meaning you can do whatever you want within them without fear of breaking anything. It also means that it's lightweight and **completely** **configurable**. Now, you can run your image!

```         
docker run -it --name tutorial_container my_tutorial_image:latest
```

In this case, it will go straight to R