echo "Removing old certificates"

rm ./admin/admin-key.pem
rm ./admin/admin.pem

rm ./elasticsearch/node-key.pem
rm ./elasticsearch/node.pem

rm ./kibana/kibana-key.pem
rm ./kibana/kibana.pem

rm ./logstash/logstash-key.pem
rm ./logstash/logstash.pem

echo "Done removing old certificates"

echo "Generating ROOT certificates"

openssl genrsa -out ./root/root-ca-key.pem 2048

openssl req -config certificate.cnf -new -x509 -sha256 -key ./root/root-ca-key.pem  -out ./root/root-ca.pem

echo "Done generating ROOT certificates"

echo "Generating admin elastic certificates"

openssl genrsa -out ./admin/admin-key-temp.pem 2048

openssl pkcs8 -inform PEM -outform PEM  -in ./admin/admin-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out ./admin/admin-key.pem

openssl req -config certificate.cnf -new -key ./admin/admin-key.pem -out ./admin/admin.csr

openssl x509 -req -in ./admin/admin.csr -CA ./root/root-ca.pem -CAkey ./root/root-ca-key.pem -CAcreateserial -sha256 -out ./admin/admin.pem 

echo "Done generating admin elastic certificates"

echo "Generating elastic search node certificates"

openssl genrsa -out ./elasticsearch/node-key-temp.pem 2048

openssl pkcs8 -inform PEM -outform PEM -in ./elasticsearch/node-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out ./elasticsearch/node-key.pem

openssl req -config certificate.cnf -new -key ./elasticsearch/node-key.pem -out ./elasticsearch/node.csr

openssl x509 -req -in ./elasticsearch/node.csr -CA ./root/root-ca.pem -CAkey ./root/root-ca-key.pem -CAcreateserial -sha256 -out ./elasticsearch/node.pem 

echo "Done generating elastic search node certificates"

echo "Generate Kibana certificates"

openssl genrsa -out ./kibana/kibana-key-temp.pem 2048

openssl pkcs8 -inform PEM -outform PEM  -in ./kibana/kibana-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out ./kibana/kibana-key.pem

openssl req -config certificate.cnf -new -key ./kibana/kibana-key.pem -out ./kibana/kibana.csr

openssl x509 -req -in ./kibana/kibana.csr -CA ./root/root-ca.pem -CAkey ./root/root-ca-key.pem -CAcreateserial -sha256 -out  ./kibana/kibana.pem 

echo "Done generating Kibana certificates"

echo "Generate Logstash certificates"

openssl genrsa -out ./logstash/logstash-key-temp.pem 2048

openssl pkcs8 -inform PEM -outform PEM -in ./logstash/logstash-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out ./logstash/logstash-key.pem

openssl req -config certificate.cnf -new -key ./logstash/logstash-key.pem -out ./logstash/logstash.csr

openssl x509 -req -in ./logstash/logstash.csr -CA ./root/root-ca.pem -CAkey ./root/root-ca-key.pem -CAcreateserial -sha256 -out  ./logstash/logstash.pem

echo "Done generating Logstash certificates"

echo "Cleanup temporary certificates"

rm ./admin/admin-key-temp.pem
rm ./admin/admin.csr
rm ./elasticsearch/node-key-temp.pem
rm ./elasticsearch/node.csr
rm ./kibana/kibana-key-temp.pem
rm ./kibana/kibana.csr
rm ./logstash/logstash-key-temp.pem
rm ./logstash/logstash.csr

rm ./.srl

echo "Done cleaning up temporary certificates"


echo "Distinguished Name"
openssl x509 -subject -nameopt RFC2253 -noout -in ./elasticsearch/node.pem


echo "Verify certs NODE"
openssl verify -verbose -CAfile ./root/root-ca.pem ./elasticsearch/node.pem
echo ""

echo "Verify certs CLIENT"
openssl verify -verbose -CAfile ./root/root-ca.pem ./elasticsearch/node.pem
echo ""

echo "Elasticsearch nodes DN"
openssl x509 -subject -nameopt RFC2253 -noout -in ./elasticsearch/node.pem