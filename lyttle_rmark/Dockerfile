# Goal: Get mark running
# Strategy: Use multistage to add the 7.4 fortran libs to the fortran libs used in rocker/studio 
FROM gcc:7.4 as fortran
# get the libs from this version of fortran
WORKDIR /gcc7
RUN apt-get update && \
    apt-get -y install gcc mono-mcs && \
    rm -rf /var/lib/apt/lists/*

FROM rocker/rstudio
# Move the mark file
COPY ./mark_linux/mark /usr/local/bin
# set target folder for fortran libs
WORKDIR /usr/lib/x86_64-linux-gnu
# get fortran libs from fortran 
COPY --from=fortran /usr/local/lib64/ .
WORKDIR /
ENV LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu:${LD_LIBRARY_PATH}"
ENV PATH=${LD_LIBRARY_PATH}:${PATH}
# istall interface to Mark file
RUN Rscript -e "install.packages('RMark')"
# Questions asked during the develpment of this Docekerfile
# what are multistage builds? Multistage is the key to integrating the new fortran with the old
# how is PATH set? Use docker ENV to set PATH  ... export is not the solution
# how can env vars from fortran be copied forward to new image?  Didn't solve this... did it manually
# how to get copy of mark file from source and configure using Docker
