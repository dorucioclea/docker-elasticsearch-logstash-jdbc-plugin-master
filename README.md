# Elasticsearch MariaDB Kibana Logstash demo

Simple demo showcasing automatically ingesting indexes into ES with help from `Logstash`

The elasticsearch cluster is componse of `two` master nodes.

### Development

This stack uses `docker-compose` to function. 

Simply

```bash
> docker-compose up
```

to start it up.

In order to stop the stack you can `CTRL+C` it.

If you want to remove everything you can

```bash
> docker-compose down --rmi all
```

to get rid of all containers. Built images will, however remain.

How to test
----

* You can use Kibana (accessible here: `http://localhost:5601`)
* You can check cluster health using the `Postman` collection (`/postman/Elasticsearch-Functions.postman_collection`)

You can test a search in kibana by clicking [this](http://localhost:5601/app/kibana#/dev_tools/console?load_from=https://www.elastic.co/guide/en/elasticsearch/reference/6.1/snippets/208.console&_g=()) link and load the following query:


```javascript
POST /_search
{
    "query" : {
        "term": {
          "design_step_name": {
            "value": "nama"
          }
        }
    }
}
```

License
----

MIT


**Free Software, Hell Yeah!**
