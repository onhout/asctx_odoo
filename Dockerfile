FROM odoo:12
USER root

ENV PATH /opt/conda/bin:$PATH

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install gcc g++ python3 python3-pip wget python-numpy bowtie2 samtools bwa bzip2 ca-certificates ncbi-blast+ primer3 \
    tesseract-ocr \
    libglib2.0-0 libxext6 libsm6 libxrender1 -y --no-install-recommends \
    && apt-get clean 

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda2-4.5.11-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN conda update -n base conda
RUN conda config --add channels bioconda \
  && conda config --add channels conda-forge \
  && conda install biopython \
  && conda install -c bioconda trimmomatic flash cas-offinder sra-tools \
  && conda install -c conda-forge poppler \
  && conda clean -ay

RUN pip3 install wheel
RUN pip3 install pillow pytesseract pdf2image

