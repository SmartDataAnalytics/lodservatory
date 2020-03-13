# lodservatory: Linked Open Data and SPARQL Endpoint Status Observatory

This repository features community datasets about SPARQL endpoints and datasets using DCAT2 as the back bone.
This means you get

* A list of service URLS
* Dataset identifiers and their relations to services that host them
* Service Status information (online/offline)
* More information to come

Although https://sparqles.ai.wu.ac.at/ has a nice user interface and features a non-RDF API, this repo demonstrates, that combining a dataset of sparql endpoints with a sparql query that retrieves the online status with a git action is sufficient to automatically publish time-related datasets with service information.
