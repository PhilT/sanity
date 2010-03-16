Sanity. Build Automation.
=========================

Pulls from a Git repository and Automatically runs your rspec, cucumber, Test::Unit, integration and Javascript tests and other rake tasks on every branch and every commit of your project.

Features:

* Simple setup (Uses SQLite)
* Multiple project support [done]
* Live Commandline output [done]
* Add projects via a web interface [done]
* Web based project status [done]
* Build details view [started]
* Exclude branches you don't want to build [done]
* Builds every commit since last build or the last one (when Sanity first starts) [done]

Running
-------
Server:
    script/build_server

Web interface:
    script/server

Todo
----
* Add detail view to builds index
* Make sure refresh is only triggered on index pages while idle or keep previously shown detail view on builds
* Modify builds refresh to just add in new builds

