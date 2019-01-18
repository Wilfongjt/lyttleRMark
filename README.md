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

## Potential Improvements
* Update the fortran/Dockerfile to download mark file from the source
* Fix the RStudio user and password
* Add environment file (.env) include sample code to load .env
* Slim down the Docker images

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


## Multistage build
```
cd /fortran
docker build . -t lyttle/rstudio 

```

## Fortran
* gcc 7.4 contains libgfortran.so.4
* https://hub.docker.com/_/gcc/ 
* https://gcc.gnu.org/releases.html

/usr/local/lib64/
./usr/lib/
./usr/share/doc/gcc-6-base/
./usr/share/doc/
./usr/share/lintian/overrides/
./usr/local/lib/
./usr/local/bin/
./usr/local/libexec/gcc
```









docker-compose run lyttle_rstudio ln -s /usr/local/bin/mark /usr/local/lib64/libgfortran.so.4
docker-compose run lyttle-rstudio ls -l /usr/local/bin



# docker-compose run lyttle-fortran ldd /usr/lib/gcc
# docker-compose run lyttle-fortran ldd /usr/share/doc/gcc-6-base/gcc
# docker-compose run lyttle-fortran ldd /usr/share/doc/gcc
# docker-compose run lyttle-fortran ldd /usr/share/lintian/overrides/gcc
# docker-compose run lyttle-fortran ldd /usr/local/lib/gcc
docker-compose run lyttle-fortran ldd /usr/local/bin/gcc
docker-compose run lyttle-fortran ldd /usr/local/libexec/gcc

```


## R-Studio
* open a browser @ http://localhost:8787
* open the code @ kitmatic/ RStudio uses the linux version of mark
* RMark is installed via the Dockerfile

## kitematic Folder
You will find the lyttleRMark project in the kitematic folder.  This is where it should be.

