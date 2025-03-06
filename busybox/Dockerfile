# Use the base Ubuntu image
FROM debian:bookworm

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    openssh-server \
    wget \
    curl \
    vim \
    openssl \
    git \
    && apt-get clean

# Create SSH directory and configure SSH service
RUN mkdir /var/run/sshd && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && \
    echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config && \
    echo 'root:rootpassword' | chpasswd

# Clone the Kubernetes The Hard Way repository
RUN git clone --depth 1 https://github.com/kelseyhightower/kubernetes-the-hard-way.git /kubernetes-the-hard-way

# Change to the repository directory
WORKDIR /kubernetes-the-hard-way

# Replace arm64 with amd64 in downloads.txt
RUN sed -i 's/arm64/amd64/g' downloads.txt

# Download the required files
RUN wget -q --show-progress \
    --https-only \
    --timestamping \
    -P downloads \
    -i downloads.txt

# Make kubectl executable and move it to /usr/local/bin
RUN chmod +x downloads/kubectl && \
    cp downloads/kubectl /usr/local/bin/

# Expose SSH port
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]
