# Linked Open Data and SPARQL Endpoints Observatory

This repo provides automated service monitoring of SPARQL Endpoints on an hourly basis.
The results are published in the file [latest-status.ttl](https://github.com/SmartDataAnalytics/lodservatory/blob/master/latest-status.ttl).
Many Linked Data clients can consume the data directly from

https://raw.githubusercontent.com/SmartDataAnalytics/lodservatory/master/latest-status.ttl

## How does it work

There is [this git action](.github/workflows/main.yml) which invokes the following process every hour.

The script [update-status.sh](update-status.sh) first downloads [OpenLink's SPARQL endpoint dataset](https://github.com/OpenLinkSoftware/general-turtle-doc-collection/blob/master/LODCloud_SPARQL_Endpoints.ttl) and then runs the SPARQL query in [status-check.sparql](status-check.sparql) on each endpoint URL.

The workflow runner is our [sparql-integrate command line tool](https://github.com/SmartDataAnalytics/Sparqlintegrate), built on [Apache Jena](https://jena.apache.org/), which simplifies the process of mashing-up RDF datasets and SPARQL queries.

## How to contribute...

### ... new endpoints?
This project uses
[OpenLink's SPARQL endpoint dataset](https://github.com/OpenLinkSoftware/general-turtle-doc-collection/blob/master/LODCloud_SPARQL_Endpoints.ttl) as the source, please make pull requests there.

### ... additional service information?
As github has API limits (1000 requests per hour) it may be better to make separate projects for other kind of informations, such as void descriptions. Note, that one can use this service status dataset as the basis in order to not waste requests!

Feel free to contribute your ideas on the issue tracker.

## How can I monitor my own endpoints?

Just clone the repo and use a different dataset of endpoints as the source.

## Licence
The source code of this repo is published under the [Apache License Version 2.0](LICENSE).


