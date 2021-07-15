## Dockerfile for OpenSimulator

It is based on [official mono docker image](https://hub.docker.com/r/library/mono/).

- [OpenSimulator](http://opensimulator.org) 0.9.1.1
- Standalone Mode (port 9000)
- Username: Test User
- Password: password

See [OpenSim.ini.example](https://github.com/opensim/opensim/blob/master/bin/OpenSim.ini.example) and [Regions.ini.example](https://github.com/opensim/opensim/blob/master/bin/Regions/Regions.ini.example) for available settings.

### Building

1. Clone or download this project.

2. Modify the IP on ExternalHostName inside the Regions.ini to match your external IP address.

3. Modify OpenSim.ini, Standalone.ini and StandaloneCommon.ini to your preference.

4. Run docker build command.

```
docker build -t opensim .
```

### Running

You will need to forward both TCP and UDP port 9000 to your host.

```
docker run --name=opensim --rm -p 9000:9000 -p 9000:9000/udp -d opensim
```

or interactive mode with access to OpenSim CLI

```
docker run --name=opensim --rm -it -p 9000:9000 -p 9000:9000/udp opensim
```

To see the console logs:

```
docker logs -f opensim
```

To run any admin command, view the files:

```
docker exec -it opensim bash
```

To load the isus region (execute inside the OpenSimulator CLI):

```
Region (MyRegion) # load oar isus.oar
```

To create user (execute inside the OpenSimulator CLI) and answer the respective questions:

```
Region (MyRegion) # create user
```

NOTE: Currently, you may not be able to terminate the docker container even if you 'quit' the console. You'll need to run `docker stop` command from another terminal to kill the container.

### Connecting

Login URI should look like this.

http://[IP]:9000/

You should use the ExternalHostName fulfilled inside the Regions.ini for the [IP].

If you use Docker Toolbox or other hosts than localhost, you'll need to modify "localhost" so that it will be the same as your docker machine host name or ip. You may need to change the value of "ExternalHostName" in Regions.ini file as well. After changing, rebuild this image. For mac and windows, I suggest to use Dayturn Viewer (https://www.dayturn.com/viewer/index.php).

![img](https://i.imgur.com/Ups8CSR.png)

- Username: Test User
- Password: password

### Maintainer

Christophe Soares (soareschristophe@gmail.com)

### Credits to

Makopoppo (SL Name: Mako Nozaki) (https://github.com/Makopo/docker-opensimulator-simple)
