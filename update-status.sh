#!/bin/bash

# Download SPARQL Integrate (if not already available)
[ -f si.jar ] || wget -O si.jar https://github.com/SmartDataAnalytics/SparqlIntegrate/releases/download/sparql-integrate-bundle-1.0.3-SNAPSHOT/sparql-integrate-bundle-1.0.3-SNAPSHOT-jar-with-dependencies.jar

# TODO Update lod cloud status once the PR is accepted
# wget -O LODCloud_SPARQL_Endpoints.ttl https://raw.githubusercontent.com/OpenLinkSoftware/general-turtle-doc-collection/master/LODCloud_SPARQL_Endpoints.ttl

# Map each endpoint to its own named graph,
# run the status check for each named graph in parallel
# and then merge the results
java -cp si.jar sparqlintegrate LODCloud_SPARQL_Endpoints.ttl 'CONSTRUCT { GRAPH ?o { ?s ?p ?o } } { ?s ?p ?x FILTER(?p = sd:endpoint) BIND(IRI(REPLACE(STR(?x), "\\s+", "")) AS ?o) }' | \
java -cp si.jar ngs map -t '5000,5000' --sparql status-check.sparql | \
java -cp si.jar sparqlintegrate --w=trig/pretty --u - 'PREFIX schema: <https://schema.org/> CONSTRUCT WHERE { ?s ?p ?o } ORDER BY ?s ?p ?o' > next-status.ttl

./diff-status.sh latest-status.ttl next-status.ttl > effective-status.ttl

mv effective-status.ttl latest-status.ttl


