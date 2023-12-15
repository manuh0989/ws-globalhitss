
## Instalación

Instalar el proyecto usando DockerFile

```bash
  docker compose up -d build
  docker run --name portal-medicos -p 8000:8000 -v C:\proyectos\SaludInteractiva:/var/www -d  portal-medicos 
  docker ps
  docker exec -it {{containerId}} bash
```

## Instalar Dependencias y generacion de Keys
```bash
  cp .env.example .env
  composer install --prefer-dist --no-dev -o
  composer install --optimize-autoloader --no-dev
  php artisan key:generate
```

## Fixer
```bash
mkdir -p tools/php-cs-fixer
composer require --working-dir=tools/php-cs-fixer friendsofphp/php-cs-fixeralias
alias fixer='/var/vendor/bin/php-cs-fixer fix /var/www/./'
```