#Sertifika için
if [ ! -f /etc/ssl/certs/nginx.crt ] || [ ! -f /etc/ssl/private/nginx.key ]; then
echo "Nginx: No nginx.crt or nginx.key";
#openssl req komutunu kullanarak, 4096 bitlik RSA şifreleme ile 365 gün süreyle geçerli bir
#x509 tipinde SSL sertifikası oluşturur.
openssl req -newkey rsa:4096 -x509 -sha256 -nodes -days 365 \
	-out /etc/ssl/certs/nginx.crt \
	-keyout /etc/ssl/private/nginx.key \
	-subj "/C=TR/ST=Kocaeli/L=Istanbul/O=Ecole42/OU=uercan/CN=uercan"
#Subject (Konu) alanını /C=TR/ST=Kocaeli/L=Istanbul/O=Ecole42/OU=uercan/CN=uercan olarak ayarlar.
#Burada /C Türkiye'nin ISO kodu, /ST Kocaeli ilinin adı, /L İstanbul ilinin adı, /O Organizasyon adı,
#/OU Organizasyon birimi, /CN ise "Common Name" yani genellikle web sitesinin tam alan adı olarak kullanılır.
echo "Nginx: Set up!";
fi
#exec "$@" bash betiğinin ardından başlatılacak olan Nginx veya başka bir komutu çalıştırmayı sağlar.
#"$@" ifadesi, script'e verilen komutları (eğer varsa) değişken olarak alarak,
#onları komut satırında olduğu gibi çalıştırır.
#Bu sayede bash betiği çalıştıktan sonra Nginx veya başka bir komut çalıştırılabilir
#ve kontrol Dockerfile veya Docker Compose dosyasına geçer.
exec "$@"