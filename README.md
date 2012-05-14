rbox
====

A Ruby wrapper for box.com API version 1.
(also now as box.net, now at box.com but just call me box its okay)

Featuring: my personal fight with Box api, resulting in  viable wrapper with a test suite that pass and just the feature I needed for what I had to do. Look at the client spec.

Synopsis
========

```ruby
option = { :api_token => 'unique-api-token' }
client = Rbox.new(options)

client.get_ticket
`open #{client.authorize_url}`
client.get_auth_token

account_tree = client.get_account_tree
root_folder = account_tree.root_folder

# Files
puts account_tree.files.map { |f| f.file_name }.join(', ')
## Folders
puts account_tree.folders.map { |f| f.name }.join(', ')

## Explore the tree
root_folder.folders.first.files.first.file_name
...
```

Why not v2?
===========

Good question. I wish I heard of it before starting working on it. That being said, its not possible to work with box API v2 without v1.
You at least need to authenticate with v1, and v2 has missing feature (in my case file sharing operation).


Pull request?
=============

Yes.