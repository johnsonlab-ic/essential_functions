## Welcome to the docker tutorial.

First, we will connect to the DSI servers.

``` shell
ssh ubuntu@landmark-t-01.dsi.ic.ac.uk
su -l ah3918
```

You should now be in your home directory. Next, we're going to make sure docker is running.

``` {.shell .sh}
docker run hello-world
```

We will also login to our docker.

``` shell
docker login
```

Next, we're going to