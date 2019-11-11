How to create certificates for elasticsearch: 

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
> openssl genrsa -out elasticsearchplcs12.key 2048
```
IMPORTANT: Convert these to PKCS#5 v1.5 to work correctly with the JDK. Output from
this command will be used in all the config files.

* Convert to PKCS#5 v1.5

```
> openssl pkcs8 -v1 "PBE-SHA1-3DES" -in "elasticsearchplcs12.key" -topk8 -out "elasticsearch.key" -nocrypt
```

* Create the CSR and enter the organization and server details:

```bash
$ openssl req -new -key elasticsearch.key -out elasticsearch.csr
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
Organization Name (eg, company) [Internet Widgits Pty Ltd]:EsCluster
Organizational Unit Name (eg, section) []:EsClusterOu
Common Name (e.g. server FQDN or YOUR name) []:elasticsearch*
Please enter the following 'extra' attributes to be sent with your certificate request
A challenge password []:@#$!S0M3P4ssw0rD^$$@
An optional company name []:ElkDemoCompany

```

* Use the CSR to generate the signed Certificate:

```bash
$ openssl x509 -req -in elasticsearch.csr -CA ../root/elasticsearch-rootca.pem -CAkey ../root/elasticsearch-rootkey.key -CAcreateserial -out elasticsearch.pem -sha256
Signature ok
subject=/C=RO/ST=Cluj/L=Cluj-Napoca/O=EsCluster/OU=EsClusterOU/CN=elasticsearch*
Getting CA Private Key
```