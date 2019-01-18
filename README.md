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

## RMark

## Mark
The Mark executable is found in ./fortran/mark_linux



## Before you launch docker-compose
* Open lyttleR/docker-compose.yml in a text editor
* Find the <your-pass-word>  and replace with your password


## Startup
```
cd lyttleR/
docker-compose build
docker-compose up
```
This was a useful page
http://www.phidot.org/software/mark/rmark/linux/


Multistage build
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
docker-compose run lyttle-rstudio  env
docker-compose run lyttle-rstudio  gcc --version
docker-compose run lyttle-rstudio  find . -name libgfortran.so.*
docker-compose run lyttle-rstudio  find . -name gcc

docker-compose run lyttle-fortran  env
docker-compose run lyttle-fortran  gcc --version
docker-compose run lyttle-rstudio  gcc --version
docker-compose run lyttle-rstudio  find . -name libgfortran.so.*
docker-compose run lyttle-rstudio ldd /usr/local/bin/mark

docker-compose run lyttle-rstudio ls -l /usr/local/lib64

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



GPG_KEYS=B215C1633BCA0477615F1B35A5B3A004745C015A     B3C42148A44E6983B3E4CC0793FA9B1AB75C61B8     90AA470469D3965A87A5DCB494D03953902C9419     80F98B2E0DAB6C8281BDF541A7C8C3B2F71EDF1C     7F74F97C103468EE5D750B583AB00996FC26A641     33C235A34C46AA3FFB293709A328C3A2C3C45C06
GCC_MIRRORS=https://ftpmirror.gnu.org/gcc         https://bigsearcher.com/mirrors/gcc/releases         https://mirrors-usa.go-parts.com/gcc/releases     https://mirrors.concertpass.com/gcc/releases         http://www.netgull.com/gcc/releases
GCC_VERSION=7.4.0



PATH=/home/rstudio/kitematic/lyttleR/mark_linix:/usr/lib/rstudio-server/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=738c23028f3d
TERM=xterm
USER=rstudio
PASSWORD=<your-pass-word-here>
R_VERSION=3.5.2
LC_ALL=en_US.UTF-8
LANG=en_US.UTF-8
S6_VERSION=v1.21.7.0
S6_BEHAVIOUR_IF_STAGE2_FAILS=2
HOME=/root



libgfortran.so.4

docker-compose run rstudio  ../../usr/bin/ldd ../../usr/bin/gcc

docker-compose run rstudio find . -name libgfortran.so.*
docker-compose run rstudio find ../../ -name libgfortran.so.*
docker-compose run rstudio find ../../ -name gcc7

docker-compose run gcc env
docker-compose run gcc find . -name libgfortran.so.4
docker-compose run gcc find . -name libgfortran.so.*
docker-compose run gcc find . -name libgfortran.*.*
docker-compose run gcc ls /srv
docker-compose run gcc ls ./usr/lib
docker-compose run gcc ls ./usr/lib/gcc
docker-compose run gcc ls /usr/local/lib64
docker-compose run rstudio ls /usr/local/lib64

docker-compose run gcc ldd ./igraph.so


docker cp lyttler_gcc_1:/usr/local/lib64 ./gcc/lib64


## R-Studio
* open a browser
* http://localhost:8787
* RStudio uses the linix version of mark
* RMark is installed via the Dockerfile

## Shutdown
```
docker-compose down
```

## kitematic Folder
You will find the lyttleR project in the kitematic folder.  This is where it should be.

## RMark Path
Best we can tell the RMark.exe should be stashed somewhere in the path.
```
# list folders in the rstudio container
docker-compose run rstudio ls

# list environment variables in the rstudio container
docker-compose run rstudio env


docker-compose run rstudio find / -name libgfortran.so.*

# list contents of mark folder
docker-compose run rstudio ls /home/rstudio/kitematic/lyttleR/mark_linix

# list contents of a folder on the PATH
docker-compose run rstudio ls /usr/lib/rstudio-server/bin
docker-compose run rstudio ls /usr/bin

# manually move mark to folder on the path
docker-compose run rstudio cp /home/rstudio/kitematic/lyttleR/mark_linix/mark /usr/lib/rstudio-server/bin

# check the target folder and CRAP no mark file
docker-compose run rstudio ls /usr/lib/rstudio-server/bin
# NO LUCK

# manually move mark to folder on the path
docker-compose run rstudio cp /home/rstudio/kitematic/lyttleR/mark_linix/mark /usr/bin
docker-compose run rstudio ls /usr/bin
# NO LUCK

# try exec
docker-compose exec rstudio cp /home/rstudio/kitematic/lyttleR/mark_linix/mark /usr/bin
docker-compose run rstudio ls /usr/bin
# NO LUCK

# docker-compose run rstudio ls /usr/local/lib64/ # NO
docker-compose run rstudio find


```

Build a new RStudio with GFortarn 7
https://stackoverflow.com/questions/39626579/is-there-a-way-to-combine-docker-images-into-1-container
https://docs.docker.com/develop/develop-images/multistage-build/
dockerfile
```
FROM rocker/rstudio:latest

# install RMark package 
RUN Rscript -e "install.packages('RMark')"

FROM gcc:7.4
RUN apt-get update && \
apt-get -y install gcc mono-mcs && \
rm -rf /var/lib/apt/lists/*
```
Build
```
docker build -t rstudio/gfortran7:latest
```

