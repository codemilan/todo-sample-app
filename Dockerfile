FROM       evgenyg/ruby
ADD     .  /todo-sample-app
WORKDIR    /todo-sample-app
EXPOSE     3000
RUN        ./docker/bundle-install.sh
CMD        ./docker/rails-server.sh
