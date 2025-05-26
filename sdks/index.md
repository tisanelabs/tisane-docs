# Overview

Tisane Embedded allows in-process integration of the Tisane functionality in desktop and server applications, eliminating the need to connect to a remote server. The two principal components of the package are the runtime library and the set of language models. 

The core library is based on POSIX C/C++ and uses RocksDB to store its language models, supporting all POSIX-compliant OSes. For easier integration in .NET applications, Core .NET wrapper component is provided.

* [Tisane Embedded SDK for C/C++](./candc++.md)
* [Tisane Embedded SDK for .NET](./dotnet.md)

For on-premise deployment of Tisane as a separate web service, see: [On-premise Deployment](../guides/deployment/onprem.md).

## Response and Configuration Guides

* [Configuration and customization](../apis/tisane-api-configuration.md)
* [Response JSON reference](../apis/tisane-api-response-guide.md)

