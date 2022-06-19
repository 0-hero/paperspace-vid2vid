FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y rsync htop git openssh-server

RUN apt-get install python3-pip -y
RUN ln -s /usr/bin/python3 /usr/bin/python
#RUN pip3 install --upgrade pip
RUN mkdir /notebooks
WORKDIR /notebooks
#Torch and dependencies:
RUN pip3 install http://download.pytorch.org/whl/cu80/torch-0.4.0-cp35-cp35m-linux_x86_64.whl 
RUN pip3 install numpy==1.16.0 pillow==5.4.1 torchvision==0.2.2 cffi==1.14 tensorboardX==2.1
RUN pip3 install tqdm scipy==1.4.1 PyWavelets==0.4.0 six==1.7.3 networkx==1.8.1 cycler==0.10.0 kiwisolver==1.1.0 cppy==1.2.1 matplotlib==3.0.3 scikit-image==0.14.2 colorama==0.3.7 
RUN pip3 install setproctitle==1.1.10 pytz==2022.1 ipython==7.9

#vid2vid dependencies
RUN apt-get install libglib2.0-0 libsm6 libxrender1 -y
RUN pip3 install dominate==2.6.0 certifi==2021.10.08 requests==2.25.1
RUN pip3 install --upgrade pip==19.3
RUN pip install opencv-python==4.4.0.42 opencv-python-headless==4.4.0.42
RUN pip install --upgrade traitlets==4.3.3 jedi==0.17.2 pyparsing==2.4.7 pygments==2.7.4 notebook==6.2.0 qtconsole==4.7.7 nbconvert jupyter jupyterlab==0.34.0
RUN pip install --upgrade jupyter_contrib_nbextensions jupyterlab-git
RUN pip install -I jinja2==2.11.3

#pix2pixHD, required for initializing training
RUN git clone https://github.com/NVIDIA/pix2pixHD /notebooks/pix2pixHD

#vid2vid install
RUN git clone https://github.com/NVIDIA/vid2vid /notebooks/vid2vid
# WORKDIR /vid2vid
#download flownet2 model dependencies
#WARNING: we had an instance where these scripts needed to be re-run after the docker instance was launched
# RUN python scripts/download_flownet2.py
# RUN python scripts/download_models_flownet2.py

COPY run.sh /run.sh
CMD ["/run.sh"]

