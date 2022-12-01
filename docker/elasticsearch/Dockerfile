FROM docker.elastic.co/elasticsearch/elasticsearch:7.6.0

RUN bin/elasticsearch-plugin install --batch analysis-phonetic

RUN bin/elasticsearch-plugin install --batch analysis-icu
