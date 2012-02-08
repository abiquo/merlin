Merlin
=======================

Merlin is a webapp tool for deploying VMs on ESXi and performing PXE installations

See wiki for more info

Getting started
----------------

Bootstrap the DB

    padrino rake ar:migrate

Create an admin user

    padrino rake seed 

Start the app

    padrino start

Note on patches/pull requests
-----------------------------
 
 * Fork the project.
 * Start a topic branch for your feature or bugfix.
 * Make your changes/additions in the topic branch.
 * Add tests for it. This is important so I don't break it in a future version unintentionally.
 * Commit to the topic branch.
 * Send me a pull request.

License
-------

See LICENSE file for details.

