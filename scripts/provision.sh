#!/bin/bash -eux

packages=(
  nginx
)

main() {
  install_packages
  configure_nginx
}

install_packages() {
  apt-get update
  apt-get install -y ${packages[@]}
}

configure_nginx() {
  mkdir -p /var/www/keygenradio
  chown -R www-data:www-data /var/www/keygenradio
  chmod -R 755 /var/www/keygenradio

  rm -f /etc/nginx/sites-enabled/default
  cat > /etc/nginx/sites-available/keygenradio <<'END'
server {
    listen 80;
    root /var/www/keygenradio;
    index index.html;
    server_name keygenradio.com;
}
END
  sudo ln -fsn /etc/nginx/sites-available/keygenradio /etc/nginx/sites-enabled/keygenradio

  service nginx restart
  update-rc.d nginx defaults
}

main
