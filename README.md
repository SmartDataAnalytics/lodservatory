# Linked Open Data and SPARQL Endpoints Observatory

This repository features community datasets about SPARQL endpoints and datasets using the [DCAT2](https://www.w3.org/TR/vocab-dcat-2/) data model as the back bone.

What the community gets from this

* A list of service URLS
* Dataset identifiers and their relations to services that host them
* Service Status information (online/offline)
* More information to come

Although https://sparqles.ai.wu.ac.at/ has a nice user interface and features a non-RDF API, this repo demonstrates, that combining a dataset of sparql endpoints with a sparql query that retrieves the online status with a git action is sufficient to automatically publish time-slice datasets with service status information.


## Register your own endpoint 
(This is work in progress; it not yet implemented)


### Register the actual data

* Create a folder for the endpoint URL in the service directory. Omit the scheme (http(s)), reverse the host name (like Java packages), and create sub directories according to the path part of the URL. For example, `http://dbpedia.org/sparql` would turn into `services/org/dbpedia/sparql`
* Create a description of the service and the dataset it provides. In the simplest case this is just the endpointURL. DCAT distributions capture technical aspects of dataset distributions, and the graph(s) in which is it is hosted is such as aspect.
Note, that if the data hosted in a SPARQL endpoint does not exacly match a given dataset identifier, consider using a fresh dataset identifier such as 'http://your.endpoint/sparql#dataset`.

```turtle
#service.ttl
<http://dbpedia.org/sparql#service>
  a cat:DataService ;
  cat:endpointURL <http://dbpedia.org/sparql> ;
  .


<http://dbpedia.org/sparql#dataset> # <- Dataset identifier
  a cat:Dataset ;
  cat:distribution [
    a cat:Distribution ;
    cat:accessURL <http://dbpedia.org/sparql> ;
    catx:graphs (<http://dbpedia.org>) # <- Constrain the distribution to this graph
  ]
```
TODO Decide on catx namespace.


### Link to a remote description
Maybe you have your own git repo, sparql endpoint, or other source of information.
In that case there is no need to duplicate the information, but instead you can link to it.


#### Linking with Conjure
[Conjure](https://github.com/SmartDataAnalytics/Conjure/) is a system for referencing and transforming RDF data by means of workflows which can use hybrid ETL and query answering over views.

The simplest workflow specification is a simple URL reference. Any detected conjure descriptions will be transcluded into the _effective_ `service.ttl` file.
```
#service.ttl
@prefix rpif: <http://w3id.org/rpif/vocab#> .

[]
  a rpif:DataRefUrl ;
  rpif:dataRefUrl <https://your.remote/description> ;
  .
```



