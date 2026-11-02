# Entry
Handles routing incoming requests to microservices. Does not handle TLS.

## How to interact with entry
Backend does not need to interact with this repo at this point. This is subject to change. Potential changes include making sure the grpc port is configurable via env variables or http2 path changes.

All requests from frontend will go through here. This repo will check what service frontend is requesting, check with auth if the session token is valid, and route it to the proper service if it is. Auth does not check the following routes.
- Auth's login method
- User services' registration method

## Design Choices
I will be using Envoy Proxy for the entry into the project. Envoy Proxy is a Cloud Native Compute Foundation (CNCF) graduate, with support for gRPC.

We will be using version >=1.40.2, since it includes the patch for the eMudhra certs.
