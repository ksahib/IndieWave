# Use the official PHP image as the base
FROM php:8.1-apache

# Set the working directory
WORKDIR /var/www/html

# Copy the server folder contents into the Docker image
COPY ./server /var/www/html

# Enable Apache rewrite module
RUN a2enmod rewrite

# Expose port 80
EXPOSE 80

# Start the Apache service
CMD ["apache2-foreground"]
