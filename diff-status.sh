#!/bin/bash

# Purpose: Prevent update of service status time stamps if the status has not changed


CURRENT="$1"
NEXT="$2"

[ -f "$CURRENT" ] || touch "$CURRENT"

# Load the old status
# Copy it to a named graph (we should add a short cut for this)
# Laod the current status into the default graph
# Replace new timestamps in the default graph with the old ones from the named graph if the status is still the same
java -cp si.jar sparqlintegrate --w=trig/pretty \
  "$CURRENT" \
  'DELETE { ?s ?p ?o } INSERT { GRAPH eg:old { ?s ?p ?o } } WHERE { ?s ?p ?o }' \
  "$NEXT" \
  'PREFIX schema: <https://schema.org/> DELETE { ?s schema:dateModified ?newTime } INSERT { ?s schema:dateModified ?oldTime } WHERE { ?s schema:serverStatus ?newStatus ; schema:dateModified ?newTime GRAPH ?g { ?s schema:serverStatus ?oldStatus ; schema:dateModified ?oldTime } FILTER(?oldStatus = ?newStatus) }' \
  'CONSTRUCT WHERE { ?s ?p ?o } ORDER BY ?s ?p ?o'


