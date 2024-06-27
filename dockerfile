# Use an official CentOS base image
FROM centos:latest

# Install required packages
RUN yum install -y centos-release-scl && \
    yum install -y httpd24-httpd rh-php73 rh-php73-php rh-php73-php-mbstring rh-php73-php-mysqlnd rh-php73-php-gd rh-php73-php-xml mariadb-server mariadb && \
    yum clean all

# Start Apache and MariaDB services
CMD ["scl", "enable", "httpd24", "httpd", "mariadb", "--", "/bin/bash"]
