#!/bin/bash

# INSTALL ALL THE PROJECT DISCOVERY IMPORTANT TOOLS WITH A SINGLE FILE
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
go install github.com/projectdiscovery/cvemap/cmd/cvemap@latest
go install github.com/projectdiscovery/katana/cmd/katana@latest
