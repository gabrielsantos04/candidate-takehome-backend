## Using Docker
* docker-compose up --build
* docker-compose run web rake db:create db:migrate db:seed

## Using the API
### Retrieve a listing of all current registry entries
* GET http://localhost:3000/registry_hosts/list_all
### Retrieve a single registry entry by its internal ID
* GET http://localhost:3000/registry_hosts/<id\>
### Retrieve all current registry entries matching a “filter”
* GET http://localhost:3000/registry_hosts/search?filter=<filter\>
### Update any registry entry’s status from its current status to any of the three permitted options
* POST http://localhost:3000/registry_hosts/<id\>/update_status?status=<status\>
### Create a new registry entry
* POST http://localhost:3000/registry_hosts
  * Body:
    ```json
    {
      "registry_host": {
        "source": "source",
        "destination": "destination",
        "status": "active",
        "confidential": false
      }
    }
    ```
### Update a registry entry
* PUT http://localhost:3000/registry_hosts/`<id>`
  * Body:
    ```json
    {
      "registry_host": {
        "id": 1,
        "source": "source",
        "destination": "destination",
        "status": "active",
        "confidential": false
      }
    }
    ```
    
## Running specs
* rspec spec/controllers/registry_hosts_controller_spec.rb
* rspec spec/models/registry_host_spec.rb

## Background

Your team is responsible for maintaining a registry of hosts and URLs that redirect to designated destinations.

Examples of registry entries:

| **Source** | **Destination** |
| --- | --- |
| domain.net/old_page.html | domain.net/new_page.html |
| old.site.com | new.site.com |
| example.org | www.example.org |


The task is to make this registry accessible via an HTTP JSON API.

A typical entry in the registry has the following structure (all fields required):

* URL to redirect from (“source”)
* Destination URL to redirect to (“destination”)
* Status (one of Active, Inactive, or Scheduled)
* Confidential (true/false)
* Created At
* Updated At

## Requirements

Via the developed API, one must be able to:

a) Retrieve a listing of all current registry entries.

b) Retrieve a single registry entry by its internal ID.

c) Retrieve all current registry entries matching a “filter” string on the source URL .
For example, filtering for ‘omai’ should retrieve “domain.net/old_page.html” and other matching entries, but not “old.site.com”.

d) Update any registry entry’s status from its current status to any of the three permitted options (Active, Inactive or Scheduled)


<br />

Important: A Confidential registry entry should never have the following fields returned by the API:
* Destination URL
* Status
* Updated At timestamp


## Considerations

* Anonymous access is all that is necessary to connect to the API via these four ways, and retrieve JSON responses. No form of login nor authentication is required.

* Any creation or alteration of a registry entry must be simultaneously timestamped in the “Created At” and “Updated At” fields.

* Your solution must contain a docker manifest so we can run your application in containers. While your submission will still be considered without a docker manifest/definition, the presence of a working docker manifest counts significantly in overall consideration of your submission.


## Submission Instructions

* This private repo has been created just for you. Please push your code to it and notify your urllo recruiting contact when you’re done! You are free to alter the contents of this repo in any way you please.


* This repo contains a “seed” JSON file as a starting point for registry entries, to load into any backend data storage mechanism you prefer. You may add to, or edit, the seed data if you prefer. Dates and times in the seed file are represented in the [ISO 8601 standard](https://fits.gsfc.nasa.gov/iso-time.html).

* Submission shall utilize Ruby/Rails.
