# CRM - Backend - Frontend
Repositorio del Proyecto CRM

**Si usted tiene alguna pregunta o problema, no dude en ponerse en contacto con: ric.salda.94@gmail.com.**

## Tabla de contenido

* [Requisitos](#requisitos)
* [Instalación](#instalación)
* [Estructura](#estructura)

## Requisitos

** Se requiere la instalación de docker para correr el proyecto **

[Docker versión 25 o mayor](https://www.docker.com)

[Docker Desktop versión 4.12 o mayor](https://www.docker.com/products/docker-desktop/)

##
** Se recomienda emplear las siguientes aplicaciones en caso de no utilizar docker**

[Node versión 14 o mayor ](https://nodejs.org/en/download)
 
 [Nginx ](https://docs.nginx.com/)

 [Mongo versión 7.0.9 ](https://www.mongodb.com/try/download/community)

## Instalación
1. [Descarga el proyecto.](https://github.com/epayco/Plugin_ePayco_WooCommerce#versiones)
2. acceder a la carpeta del proyecto cd /.
3. acceder a la terminal de comandos y correr el comando:  
    * docker compose -f docker-compose.yml up -d --build
    * configurar la conexion de mongo = const MONGODB_URI = "mongodb://mongo:27017/restapis"; del archivo "/backend/utils/index.js"
4. sin utilizar docker, acceder a la terminal de comandos: 
    * cd ./backend && npm install
    * cd ./backend && npm run dev
    * cd ./frontend && npm install
    * cd ./frontend && npm start
    * configurar la conexion de mongo = const MONGODB_URI = "mongodb://localhost:27017/restapis"; del archivo "/backend/utils/index.js"
5. esto habilitara los puertos 3000 y 3001 respectivos en el navegador **http://localhost:3000** y **localhost:3001**

## Estructura
### aplicación de React con  NodeJS backend y  MongoDB

Project structure:
```
├── backend
│   ├── ...
│   └── Dockerfile
│   
├── frontend
│   ├── ...
│   └── Dockerfile
│
├── nginx
│   └── nginx.conf 
│
└── README.md
```

[_compose.yaml_](compose.yaml)
```
services:
  frontend:
    build:
      context: frontend
    ...
    ports:
      - 3000:3000
    ...
  backend:
    container_name: backend
    restart: always
    build:
      context: backend
    ports:
      - 3001:3000
    ...
    depends_on:
      - mongo
  mongo:
    container_name: mongo
    restart: always
    ...
  nginx:
    container_name: nginx
    ...
```
El archivo de docker-compose define una aplicación con cuatro servicios "frontend", "backend", "host" y "db".
Al implementar la aplicación, Docker Compose asigna el puerto 3000 del contenedor del servicio frontend al puerto 3001 del host como se especifica en el archivo.
Asegúrese de que el puerto 3001 del host no esté en uso.

## Deploy with docker compose

```
$ docker compose up -d
Creating network "react-express-mongodb_default" with the default driver
Building frontend
Step 1/9 : FROM node:13.13.0-stretch-slim
 ---> aa6432763c11
...
Successfully tagged react-express-mongodb_app:latest
WARNING: Image for service app was built because it did not already exist. To rebuild this image you must use `docker-compose build` or `docker-compose up --build`.
Creating frontend        ... done
Creating mongo           ... done
Creating app             ... done
```

## Expected result

El listado de contenedores debe mostrar los contenedores en ejecución y el mapeo de puertos como se muestra a continuación:
```
$ docker ps
CONTAINER ID   IMAGE                   COMMAND                  CREATED          STATUS          PORTS                                               NAMES
b8f873578159   nginx:alpine            "/docker-entrypoint.…"   55 seconds ago   Up 53 seconds   80/tcp, 0.0.0.0:8080->8080/tcp, :::8080->8080/tcp   nginx
7339d3e94c42   restapis_crm-backend    "docker-entrypoint.s…"   58 seconds ago   Up 53 seconds   0.0.0.0:3001->3000/tcp, :::3001->3000/tcp           backend
aea94c282ae8   restapis_crm-frontend   "docker-entrypoint.s…"   58 seconds ago   Up 53 seconds   0.0.0.0:3000->3000/tcp, :::3000->3000/tcp           frontend
1d63aea0d279   mongo:7.0.9             "docker-entrypoint.s…"   58 seconds ago   Up 54 seconds   0/tcp, 27017/tcp                                    mongo
```

Después de que se inicie la aplicación, navegue hasta `http://localhost:3000` en su navegador web..

## Deploy with Node
#backend
```
$ cd backend && npm install
npm WARN deprecated source-map-url@0.4.1: See https://github.com/lydell/source-map-url#deprecated
npm WARN deprecated urix@0.1.0: Please see https://github.com/lydell/urix#deprecated
...
Some issues need review, and may require choosing
a different dependency.

Run `npm audit` for details.
```

```
$ npm run dev
> restapiscrm@1.0.0 dev
> nodemon index.js
[nodemon] 1.18.10
[nodemon] to restart at any time, enter `rs`
[nodemon] watching: *.*
[nodemon] starting `node index.js`
MongoDB connection with retry
...
MongoDB is connected
Server is up on port 3000
```

#Frontend
```
$ cd frontend && npm install
(##################) ⠧ reify:fsevents: sill reify mark deleted
...
To address all issues (including breaking changes), run:
  npm audit fix --force

Run `npm audit` for details
```

```
$npm start
> cliente-api@0.1.0 start
> react-scripts start
...
Starting the development server...
```

Después de que se inicie la aplicación, navegue hasta `http://localhost:3000` en su navegador web..