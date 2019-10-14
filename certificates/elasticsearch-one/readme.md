How to create certificates for elasticsearch-one: 

* Install ssl

```bash
> sudo yum -y install openssl
```

or

```bash
> brew install openssl
```


* Create private key

```bash
> openssl genrsa -out elasticsearch-oneplcs12.key 2048
```
IMPORTANT: Convert these to PKCS#5 v1.5 to work correctly with the JDK. Output from
this command will be used in all the config files.

* Convert to PKCS#5 v1.5

```
> openssl pkcs8 -v1 "PBE-SHA1-3DES" -in "elasticsearch-oneplcs12.key" -topk8 -out "elasticsearch-one.key" -nocrypt
```

* Create the CSR and enter the organization and server details:

```bash
$ openssl req -new -key elasticsearch-one.key -out elasticsearch-one.csr
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value, If you enter '.', the field will
be left blank.
----
Country Name (2 letter code) [AU]:RO
State or Province Name (full name) [Some-State]:Cluj
Locality Name (eg, city) []:Cluj-Napoca
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Elasticsearch-Cluster
Organizational Unit Name (eg, section) []:Elasticsearch-Cluster-Prod
Common Name (e.g. server FQDN or YOUR name) []:elasticsearch-one.elasticcluster.com
Email Address []:cioclea.doru@gmail.com
Please enter the following 'extra' attributes to be sent with your certificate request
A challenge password []:@#$!S0M3P4ssw0rD^$$@
An optional company name []:ElkDemoCompany

```

* Use the CSR to generate the signed Certificate:

```bash
$ openssl x509 -req -in elasticsearch-one.csr -CA ../root/elasticsearch-rootca.pem -CAkey ../root/elasticsearch-rootkey.key -CAcreateserial -out elasticsearch-one.pem -sha256
Signature ok
subject=/C=RO/ST=Cluj/L=Cluj-Napoca/O=Elasticsearch-Cluster/OU=Elasticsearch-Cluster-Prod/CN=elasticsearch-one.elasticcluster.com/emailAddress=cioclea.doru@gmail.com
Getting CA Private Key
```