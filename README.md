# trash
Move files to your Macintosh trash can.

I wrote this to demonstrate simple functionality for command-line development including flag-like support and some decent user feedback.

Based on user feedback, I created a separate branch (more complicated) that uses AppleScripting so you can take advantage of the Trash Can's "Put Back" feature. Since this falls outside the scope of my sample code, it's available from the script branch and not main. Installation notes for both follow.

## Installation

* Install [homebrew](https://brew.sh).
* Install [mint](https://github.com/yonaskolb/Mint) with homebrew (`brew install mint`).
* From command line: `mint install erica/trash` *or* `mint install erica/trash@script` The latter installs the scripting version.

## Build notes

* This project includes a build phase that writes to /usr/local/bin
* Make sure your /usr/local/bin is writable: `chmod u+w /usr/local/bin`

