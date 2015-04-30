NYUDL::MDI::Message
===================

## Overview
Message class for New York University Digital Library's Message Driven
Infrastructure

## Status
in development

## Messages
All MDI messages are serialized using JSON.
There are a standard set of key-value pairs expected in all request  
and response messages.  
Service-specific key-value pairs are specified using the `params` key.

#### Request Messages

| key          | description                                                  |
|--------------|--------------------------------------------------------------|
|`version`     | the message format version                                   |
|`request_id`  | a UUID                                                       |
|`params`      | a hash containing service-specific key/value pairs           |

#### Response Messages

| key          | description                                                  |
|--------------|--------------------------------------------------------------|
|`version`     | the message format version                                   |
|`request_id`  | a UUID                                                       |
|`params`      | echo of request params                                       |
|`outcome`     | `success` or `error`                                         |
|`start_time`  | operation execution start  timestamp (ISO-8601 UTC)          |
|`end_time`    | operation execution finish timestamp (ISO-8601 UTC)          |
|`agent`       | a hash with keys `name`, `version`,`host`                    |
|`data`        | an optional key for returning data from the service          |
