FROM nginx
RUN chown -R nginx /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d
