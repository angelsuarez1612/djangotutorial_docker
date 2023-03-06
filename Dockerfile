FROM python:3
WORKDIR /usr/src/app
MAINTAINER Ángel Suárez Pérez 'angelsp1612@gmail.com'
RUN apt-get install git && pip install --root-user-action=ignore --upgrade pip && pip install --root-user-action=ignore django mysqlclient
RUN git clone https://github.com/angelsuarez1612/djangotutorial_docker.git /usr/src/app && mkdir static
ADD ./fallo.sh /usr/src/app/
RUN chmod +x /usr/src/app/script.sh
ENV ALLOWED_HOSTS=*
ENV DB_HOST=django_mariadb
ENV USER_DJANGO=djangouser
ENV PASS_DJANGO=djangopass
ENV BD_DJANGO=djangobd
ENV DJANGO_SUPERUSER_PASSWORD=admin
ENV DJANGO_SUPERUSER_USERNAME=admin
ENV DJANGO_SUPERUSER_EMAIL=admin@example.org
ENTRYPOINT ["/usr/src/app/script.sh"]
