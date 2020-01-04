FROM httpd:2.4.33-alpine

RUN apk update; apk upgrade;

# Copy custom-apache.conf file to proxy php requests to php-fpm container
COPY custom-apache.conf /usr/local/apache2/conf/custom-apache.conf
#copy everything from
# COPY ../../frontend/public_html/ /usr/local/apache2/htdocs/
#Including our custom apche config file to httpd.conf
RUN echo Include /usr/local/apache2/conf/custom-apache.conf >> /usr/local/apache2/conf/httpd.conf


