# Use the base Ubuntu image
FROM debian:bookworm

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
# Install required packages
RUN apt-get update && apt-get install -y openssh-server && apt-get clean

# Create SSH directory and configure SSH service
RUN mkdir /var/run/sshd && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && \
    echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config && \
    echo 'root:rootpassword' | chpasswd

# link the current private key to it

# Set up a user for SSH (optional)

# Expose SSH port
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]
