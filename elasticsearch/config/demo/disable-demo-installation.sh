echo "We do not execute install_demo_configuration.sh"
echo "Running the securityadmin.sh script to secure your cluster"

cd /usr/share/elasticsearch/plugins/opendistro_security/tools

#
# TODO: sudo not working in this context, make it work
#
sudo ./securityadmin.sh -cd ../securityconfig/ icl -nhnv -cacert /usr/share/elasticsearch/config/root-ca.pem -cert /usr/share/elasticsearch/config/admin.pem -key /usr/share/elasticsearch/config/admin-key.pem

echo "Done running securityadmin.sh"