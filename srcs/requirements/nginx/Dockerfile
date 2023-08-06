#buster debian son kararlı sürümün bir önceki sürüm
FROM debian:buster

RUN apt-get update && apt-get install -y nginx openssl

RUN mkdir /etc/nginx/ssl

COPY ./conf/nginx.conf /etc/nginx/conf.d/
COPY ./tools/nginx.sh /var/www

EXPOSE 443

RUN chmod +x /var/www/nginx.sh

#/run dizini, bazı Linux dağıtımlarında çalışma zamanı dosyalarının depolandığı bir yerdir. Log gibi dosyalar buradadır.
#-p dosya olup olmadığına göre dosya oluşturulur.
RUN mkdir -p /run/nginx

#ENTRYPOINT conteiner oluşturulduğunda çalıştırılması gerekenler belirtilebilir. 
ENTRYPOINT [ "var/www/nginx.sh" ]

# Container başlatıldığında nginx'i çalıştır
# 'CMD [ "nginx", "-g", "daemon off;" ]': Docker container'ını başlatırken çalışacak varsayılan komutu belirtir.
#	Bu durumda, Nginx web sunucusunu başlatır ve "daemon off;" seçeneğiyle arka planda çalışmasını sağlar.
CMD [ "nginx", "-g", "daemon off;" ]