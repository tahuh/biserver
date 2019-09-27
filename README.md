# biserver
Server settings for Bioinformatics

# Rationale
Thanks to rapid increase of next-generation sequencing(NGS) data, bioinformatics is required every laboratory studying genetics or genomics using NGS.

There are many ways to set-up bioinformatics and data analysis server including

1. [Anaconda] (https://www.anaconda.com/)
2. [Bioconda] (https://bioconda.github.io/)
3. Other ways to do

But here are some problems that I have experienced when setting analysis server.

1. A newby who never experienced server settings having tough time and sometimes get frustrated.

2. Even researcher who are familiar with server settings, it is time consuming when one reset the server.

3. Related to number 2 above, one may forget to install some required tools or libraries formerly installed.

4. Several other issues such as development environment difference or analysis environ settings.

5. Reproducibility of data for other researchers to do the same analysis.

6. Any other good reason then let me know!

To overcome those issues, I decided to write simple docker container and hope this helps.

# Purpose
Make the research and server settings reproducible.

# Getting started

Oh, before we gets started we assume one has a -*Linux*- server

1. First download and install [Docker](https://docs.docker.com/install/) .

2. Then clone this repository
```
$ git clone https://github.com/tahuh/biserver.git
```

3. Follow the command line below
```
$ cd biserver
$ docker build -t biserver .
```

4. Check server is running
```
$ docker run --rm -ti biserver
```

Thats it!

# Tools currently included in this docker
1. BWA
2. Samtools
3. HISAT2
4. Bowtie2

# Reference file location
By default, we use GRCh38 reference downloaded from UCSC

1. /biserver/reference/UCSC/hg38/hg38.fa 

2. For HISAT2, /biserver/reference/hisat2/grch38_snp_tran/grch38_snp_tran is base reference image 

# TODO list
1. Make it as runnable web server
2. Add more tools

# License
MIT

# Issue
If there are any issues then write on issue tab.
