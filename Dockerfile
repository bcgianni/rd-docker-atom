FROM resultadosdigitais/rd-atom:v2

# install atom plugins
COPY atom-packages /tmp/
RUN apm install --packages-file /tmp/atom-packages
