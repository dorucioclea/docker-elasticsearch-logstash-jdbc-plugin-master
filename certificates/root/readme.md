How to create root certificates for elasticsearch: 

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
> openssl genrsa -out elasticsearch-rootkey.key 2048
```

* Create the CA and enter Organization details

```
> openssl req -x509 -new -key elasticsearch-rootkey.key -sha256 -out elasticsearch-rootca.pem
```

```bash
$ openssl req -x509 -new -key elasticsearch-rootkey.key -sha256 -out elasticsearch-rootca.pem
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
----
Country Name (2 letter code) [AU]:RO
State or Province Name (full name) [Some-State]:Cluj
Locality Name (eg, city) []:Cluj-Napoca
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Elasticsearch-Cluster
Organizational Unit Name (eg, section) []:Elasticsearch-Cluster-Prod
Common Name (e.g. server FQDN or YOUR name) []:elasticsearchprod
Email Address []:cioclea.doru@gmail.com
```

