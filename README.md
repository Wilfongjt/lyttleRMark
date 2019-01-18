# lyttleRMark
Install of Rstudio with RMark


## Clone the Repo
```
# make a folder somewhere
cd <folder-name>/  # replace <folder-name> with your folder name
git clone https://github.com/Wilfongjt/lyttleR.git
cd lyttleR/

```

## Prerequisites
* Docker
* Docker-compose

## RMark and Mark
* RMark is installed by Docker
* The Mark executable is copied from the ./fortran/mark_linux folder

## Before you launch docker-compose
* Open lyttleR/docker-compose.yml in a text editor
* Find the <your-pass-word>  and replace with your password
* Don't commit your password Github

## Startup
```
cd lyttleR/
docker-compose build
docker-compose up
```
## Shutdown
```
docker-compose down
```

## Fortran
* gcc 7.4 contains libgfortran.so.4
* https://hub.docker.com/_/gcc/ 
* https://gcc.gnu.org/releases.html


## R-Studio
* open a browser @ http://localhost:8787
* open the code @ /kitematic/sample/sample.R
* RMark is installed via the Dockerfile

### kitematic Folder
You will find a sample project in the kitematic folder.  This is where it should be.


## Work to be done
* Update the fortran/Dockerfile to download mark file from the source
* Fix the RStudio user and password
* Add environment file (.env) include sample code to load .env
* Slim down the Docker images

## References
This was a useful page http://www.phidot.org/software/mark/rmark/linux/

## Helpful Commands
```
docker-compose run lyttle-rstudio  env
docker-compose run lyttle-rstudio  gcc --version
docker-compose run lyttle-rstudio  find . -name libgfortran.so.*
docker-compose run lyttle-rstudio  find . -name gcc
docker-compose run lyttle-rstudio ldd /usr/local/bin/mark
docker-compose run lyttle-rstudio ls -l /usr/lib/x86_64-linux-gnu

```
