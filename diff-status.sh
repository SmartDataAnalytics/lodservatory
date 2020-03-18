#!/bin/bash

# Purpose: Prevent update of service statu time stamps if the status has not changed

# This script is in staging status and not yet active


# Load the old status
# Copy it to a named graph (we should add a short cut for this)
# Laod the current status into the default graph
# Replace new timestamps in the default graph with the old ones from the named graph if the status is still the same
sparql-integrate --w=trig/pretty \
  latest-status-old.ttl \
  'DELETE { ?s ?p ?o } INSERT { GRAPH eg:old { ?s ?p ?o } } WHERE { ?s ?p ?o }' \
  latest-status.ttl \
  'PREFIX : <https://schema.org/> DELETE { ?s :dateModified ?newTime } INSERT { ?s :dateModified ?oldTime } WHERE { ?s :serverStatus ?newStatus ; :dateModified ?newTime GRAPH ?g { ?s :serverStatus ?oldStatus ; :dateModified ?oldTime } FILTER(?oldStatus = ?newStatus) }' \
  spo.sparql > new-status.ttl
