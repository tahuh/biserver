# Dockerfile description
# This docker file aims to build easiest way to set-up the basic bioinformatics
# server equipped with various number of tools

FROM ubuntu:16.04

MAINTAINER Thomas Sunghoon Heo <tahuh1124@gmail.com>

ENV PATH /usr/local/bin:$PATH
ENV LANG C.UTF-8
WORKDIR /biserver

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive; \
apt install -y build-essential \
autoconf automake perl \
zlib1g-dev libbz2-dev \
liblzma-dev libcurl4-gnutls-dev \
libssl-dev libncurses5-dev git

# Establish BWA and samtools
RUN git clone https://github.com/samtools/htslib.git /biserver/htslib
RUN ls /biserver
RUN git clone https://github.com/samtools/samtools.git /biserver/samtools && \
cd /biserver/samtools && autoheader && autoconf -Wno-syntax && \
./configure --enable-configure--htslib --enable-plugins --enable-libcurl --enable-gcs --with-htslib=/biserver/htslib && \
make && make install

RUN apt-get install bwa

# Set-up Bowtie2
RUN apt-get install -y libtbb-dev
RUN git clone https://github.com/BenLangmead/bowtie2.git /biserver/bowtie2 && \
cd /biserver/bowtie2 && \
make

RUN cp /biserver/bowtie2/bowtie2 /usr/bin/bowtie2

RUN cp /biserver/bowtie2/bowtie2-align-s /usr/bin/bowtie2-align-s
RUN cp /biserver/bowtie2/bowtie2-align-l /usr/bin/bowtie2-align-l
RUN cp /biserver/bowtie2/bowtie2-build /usr/bin/bowtie2-build
RUN cp /biserver/bowtie2/bowtie2-build-l /usr/bin/bowtie2-build-l
RUN cp /biserver/bowtie2/bowtie2-build-s /usr/bin/bowtie2-build-s
RUN cp /biserver/bowtie2/bowtie2-inspect /usr/bin/bowtie2-inspect
RUN cp /biserver/bowtie2/bowtie2-inspect-s /usr/bin/bowtie2-inspect-s
RUN cp /biserver/bowtie2/bowtie2-inspect-l /usr/bin/bowtie2-inspect-l

# Reference Genome download from UCSC
RUN apt-get install -y wget
RUN mkdir -p /biserver/reference/UCSC/hg38
RUN wget https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/analysisSet/hg38.analysisSet.2bit
RUN wget https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/analysisSet/hg38.analysisSet.chroms.tar.gz
RUN mv hg38.analysisSet.2bit /biserver/reference/UCSC/hg38/hg38.2bit
RUN mv hg38.analysisSet.chroms.tar.gz /biserver/reference/UCSC/hg38/hg38.analysisSet.chroms.tar.gz


RUN apt-get install -y python2.7 python2.7-dev python-pip
RUN python -m pip install pip --upgrade
RUN python -m pip install wheel
RUN python -m pip install setuptools
RUN python -m pip install numpy
RUN python -m pip install pandas
RUN python -m pip install cython
RUN python -m pip install matplotlib
RUN python -m pip install scipy
RUN python -m pip install scikit-learn
RUN python -m pip install pysam
RUN python -m pip install pyfaidx

COPY . /biserver
RUN python /biserver/merge_fasta.py
RUN mv hg38.fa /biserver/reference/UCSC/hg38/hg38.fa

# Set-up HISAT2
RUN wget --content-disposition https://cloud.biohpc.swmed.edu/index.php/s/grch38_snp_tran/download
RUN mkdir -p /biserver/reference/hisat2
RUN tar -zxvf grch38_snp_tran.tar.gz
RUN mv -r ./grch38_snp_tran /biserver/reference/hisat2/grch38_snp_tran

RUN git clone https://github.com/DaehwanKimLab/hisat2.git /biserver/hisat2
RUN cd /biserver/hisat2 && make

RUN cp /biserver/hisat2/hisat2 /usr/bin/hisat2

RUN cp /biserver/hisat2/hisat2-align-s /usr/bin/hisat2-align-s
RUN cp /biserver/hisat2/hisat2-align-l /usr/bin/hisat2-align-l
RUN cp /biserver/hisat2/hisat2-build /usr/bin/hisat2-build
RUN cp /biserver/hisat2/hisat2-build-l /usr/bin/hisat2-build-l
RUN cp /biserver/hisat2/hisat2-build-s /usr/bin/hisat2-build-s
RUN cp /biserver/hisat2/hisat2-inspect /usr/bin/hisat2-inspect
RUN cp /biserver/hisat2/hisat2-inspect-s /usr/bin/hisat2-inspect-s
RUN cp /biserver/hisat2/hisat2-inspect-l /usr/bin/hisat2-inspect-l
