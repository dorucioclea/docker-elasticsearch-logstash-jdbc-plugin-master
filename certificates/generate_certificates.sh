echo "Generating ROOT certificates"

openssl genrsa -out ./root/elasticsearch-rootkey.key 2048

openssl req -config certificate.cnf -x509 -new -key ./root/elasticsearch-rootkey.key -sha256 -out ./root/elasticsearch-rootca.pem

echo "Done generating ROOT certificates"

echo "Generating elastic search node certificates"

openssl genrsa -out ./elasticsearch/elasticsearchplcs12.key 2048

openssl pkcs8 -v1 "PBE-SHA1-3DES" -in "./elasticsearch/elasticsearchplcs12.key" -topk8 -out "./elasticsearch/elasticsearch.key" -nocrypt

openssl req -config certificate.cnf -new -key ./elasticsearch/elasticsearch.key -out ./elasticsearch/elasticsearch.csr

openssl x509 -req -in ./elasticsearch/elasticsearch.csr -CA ./root/elasticsearch-rootca.pem -CAkey ./root/elasticsearch-rootkey.key -CAcreateserial -out ./elasticsearch/elasticsearch.pem -sha256

echo "Done generating elastic search node certificates"

echo "Generating admin elastic certificates"

openssl genrsa -out ./admin/adminplcs12.key 2048

openssl pkcs8 -v1 "PBE-SHA1-3DES" -in "./admin/adminplcs12.key" -topk8 -out "./admin/admin.key" -nocrypt

openssl req -config certificate.cnf -new -key ./admin/admin.key -out ./admin/admin.csr

openssl x509 -req -in ./admin/admin.csr -CA ./root/elasticsearch-rootca.pem -CAkey ./root/elasticsearch-rootkey.key -CAcreateserial -out ./admin/admin.pem -sha256

echo "Done generating admin elastic certificates"

echo "Generate Kibana certificates"

openssl genrsa -out ./kibana/kibanaplcs12.key 2048

openssl pkcs8 -v1 "PBE-SHA1-3DES" -in "./kibana/kibanaplcs12.key" -topk8 -out "./kibana/kibana.key" -nocrypt

openssl req -config certificate.cnf -new -key ./kibana/kibana.key -out ./kibana/kibana.csr

openssl x509 -req -in ./kibana/kibana.csr -CA ./root/elasticsearch-rootca.pem -CAkey ./root/elasticsearch-rootkey.key -CAcreateserial -out ./kibana/kibana.pem -sha256

echo "Done generating Kibana certificates"

echo "Generate Logstash certificates"

openssl genrsa -out ./logstash/logstashplcs12.key 2048

openssl pkcs8 -v1 "PBE-SHA1-3DES" -in "./logstash/logstashplcs12.key" -topk8 -out "./logstash/logstash.key" -nocrypt

openssl req -config certificate.cnf -new -key ./logstash/logstash.key -out ./logstash/logstash.csr

openssl x509 -req -in ./logstash/logstash.csr -CA ./root/elasticsearch-rootca.pem -CAkey ./root/elasticsearch-rootkey.key -CAcreateserial -out ./logstash/logstash.pem -sha256

echo "Done generating Logstash certificates"


echo "Distinguished Name"
openssl x509 -subject -nameopt RFC2253 -noout -in ./elasticsearch/elasticsearch.pem


echo "Verify certs NODE"
openssl verify -verbose -CAfile ./root/elasticsearch-rootca.pem ./elasticsearch/elasticsearch.pem
echo ""

echo "Verify certs CLIENT"
openssl verify -verbose -CAfile ./root/elasticsearch-rootca.pem ./elasticsearch/elasticsearch.pem
echo ""