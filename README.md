# Getting Started

The first thing to do is to clone this repository.

```
cd $HOME
git clone https://github.com/cs6888-public/cs6888-public.git
```

The following instructions all assume you cloned into your $HOME directory.

Now we are ready to build a docker image to host our homeworks. 
To do this you must have Docker and Docker Compose installed locally on your machine. 

Once installed and your docker instance is running you execute the following:

```
cd cs6888-public
docker-compose up --build &
```

Building may take from 5-30 minutes depending on your hardware.

```
docker-compose exec main bash
```

The final command will drop you into a shell where you execute commands and scripts that we have provided.

