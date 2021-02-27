FROM nginx:stable

COPY nginx.conf /etc/nginx/conf.d/myapp.conf

CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
