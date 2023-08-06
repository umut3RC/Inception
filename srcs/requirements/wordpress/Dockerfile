FROM debian:buster

RUN apt-get update && apt-get -y install wget curl bash php php-cgi php-mysql php-fpmphp-pdo php-gd php-cli php-mbstring redis php-redis sendmail && rm -rf /var/lib/apt/lists/*

#WordPress CLI'ı wp komutuyla çalıştırabilirsiniz. Bu yapı için curl kurulu olması gerekmektedir.
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

RUN mkdir /run/php

COPY ./tools/create-wp.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/create-wp.sh

ENTRYPOINT ["/usr/local/bin/create-wp.sh"]

# nginx'in standart dizinini gösterince artık nginx default olarak değil wordpress ile çalışacaktır.
WORKDIR /var/www/html/

# Port 9000'i dışarıya aç
EXPOSE 9000

ENV PATH="/usr/sbin/php-fpm7.3:$PATH"

RUN service php7.3-fpm start

RUN if [ -f /etc/php/7.3/fpm/pool.d/www.conf ]; then \
	    sed -i 's/^user = deploy$/user = www-data/' /etc/php/7.3/fpm/pool.d/www.conf && \
      sed -i 's/^group = deploy$/group = www-data/' /etc/php/7.3/fpm/pool.d/www.conf && \
      sed -i 's/^listen =$/listen = wordpress:9000/' /etc/php/7.3/fpm/pool.d/www.conf && \
      sed -i 's/^listen.owner = deploy$/listen.owner = www-data/' /etc/php/7.3/fpm/pool.d/www.conf && \
      sed -i 's/^listen.group = deploy$/listen.group = www-data/' /etc/php/7.3/fpm/pool.d/www.conf && \
      sed -i 's/^;listen.mode = 0660$/listen.mode = 0660/' /etc/php/7.3/fpm/pool.d/www.conf && \
      sed -i '/^\[www\]/ s/$/\nlisten = wordpress:9000/' /etc/php/7.3/fpm/pool.d/www.conf ; \
    else \
		  COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf && \
      echo "Copy process..." ; \
    fi

# php-fpm serverını başlat
CMD [ "php-fpm7.3", "-F" ]
# CMD [ "php-fpm" ]
# CMD [ "/usr/sbin/php-fpm7.3", "-F" ]
# CMD ["/usr/local/bin/create-wp.sh", "/usr/sbin/php-fpm7.3", "-F"]

# https://wiki.debian.org/WordPress
# $> docker pull debian:buster
# $> docker run -it debian:buster
# $> apt-get update && apt-get -y install php php-fpm
# $> find /usr/sbin/php-fpm7.3
# $> find /etc/php/7.3/fpm/pool.d/www.conf

# if you want to check wordpress www.conf file
# while running wordpress image:
#   $> docker exec -it wordpress bash
#   $> cat /etc/php/7.3/fpm/pool.d/www.conf