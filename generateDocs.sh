#!/bin/bash

appledoc -h --project-name InfoStats2 --project-company "Matchstic" --company-id com.matchstic -t ./Appledoc_template --output ./help --index-desc ./README.md --ignore .m --ignore Reachability.h --ignore MediaRemote.h --ignore .mm --no-create-docset ./InfoStats2
