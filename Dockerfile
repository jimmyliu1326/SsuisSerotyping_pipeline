FROM mambaorg/micromamba:0.14.0

ARG version=0.2.0

RUN apt-get update && \
    apt-get install -y procps git-all && \
    rm -rf /var/lib/apt/lists/* && \
    CONDA_DIR="/opt/conda" && \
    micromamba install -n base -y -c bioconda -c conda-forge srst2=${version} && \
    micromamba clean --all --yes && \
    rm -rf $CONDA_DIR/conda-meta && \
    rm -rf $CONDA_DIR/include && \
    rm -rf $CONDA_DIR/lib/python3.*/site-packages/pip && \
    find $CONDA_DIR -name '__pycache__' -type d -exec rm -rf '{}' '+'

RUN git clone https://github.com/jimmyliu1326/SsuisSerotyping_pipeline.git && \
    chmod +x SsuisSerotyping_pipeline/Ssuis_serotypingPipeline.pl && \
    for i in /SsuisSerotyping_pipeline/*; do ln -s $i /usr/local/bin/$(basename $i); done