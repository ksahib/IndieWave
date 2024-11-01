# Use the official PHP image as a base
FROM php:8.1-apache

# Install PDO and MySQL extensions
RUN docker-php-ext-install pdo pdo_mysql

# Copy the application code to the Apache server's document root
COPY ./server /var/www/html

# Set the working directory
WORKDIR /var/www/html

# Change permissions (optional, adjust based on your setup)
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80
