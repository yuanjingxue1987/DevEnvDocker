# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Install sudo
RUN apt-get update && apt-get install -y sudo git bash curl neovim

# install node
WORKDIR /setup
RUN curl -sL https://deb.nodesource.com/setup_20.x -o nodesource_setup.sh
RUN chmod +x ./nodesource_setup.sh
RUN ./nodesource_setup.sh
RUN apt install -y nodejs

RUN echo "alias vim='nvim'" >> /etc/bash.bashrc

# install shopify cli
RUN npm install -g @shopify/cli@latest

# Create a new user and add to the sudo group
RUN useradd -m -s /bin/bash yuanjingx && echo "yuanjingx:beadylanxyj222" | chpasswd && usermod -aG sudo yuanjingx

# Copy the local folder to the container's working directory
COPY ./configs/ssh /home/yuanjingx/.ssh
COPY ./configs/.gitconfig /home/yuanjingx/
RUN chown -R yuanjingx:yuanjingx /home/yuanjingx/.ssh
RUN chown yuanjingx:yuanjingx /home/yuanjingx/.gitconfig

# Switch to the new user
USER yuanjingx

# Set the working directory
WORKDIR /home/yuanjingx

# Optional: Default command
CMD ["bash"]

