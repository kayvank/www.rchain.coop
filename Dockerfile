FROM node:8.12-alpine
ENV APP_DIR /var/app
ENV PORT 3000
RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR
COPY . $APP_DIR
EXPOSE $PORT
CMD ["npm", "start"]
