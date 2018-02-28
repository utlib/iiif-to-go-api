# IIIF API in a Box

IIIF API in a Box is a set of Vagrant scripts that set up portable VirtualBox machines running University of Toronto's IIIF API web application. These machines can be used to set up workshops or evaluate IIIF risk-free.

## Bundled Software

PRE-RELEASE ALERT: Due to unreleased content, some of these bundled dependencies must be pre-downloaded before setting up. 

- IIIF API (clone into `iiifAPI`)
- Loris 2.0
- Mirador (download build of `utlib/mirador` at GitHub into `mirador`)

## System Requirements

- Windows 7 or higher / Mac OS X El Capitan or higher / Ubuntu 14.04 LTS or higher
- At least 4GB available hard drive space
- 4GB RAM total or more, at least 2GB available
- VirtualBox 5.1.30+ or 5.2.6+ or above (link)
- Vagrant 2.0.2 or above (link)
	- (Windows only) WMF 4.0 or above
	
Note: If you do not already have VirtualBox and Vagrant installed, please install VirtualBox first and Vagrant second.

## Installation

* If VirtualBox is not installed, [download](https://www.virtualbox.org/wiki/Downloads) and install it.
	* In the installer's "Custom Setup" step, ensure that "VirtualBox Networking" is set to be installed. 
	* Restart your system after the installer finishes.
* If Vagrant is not installed, [download](https://www.vagrantup.com/downloads.html) and install it.
- Clone this repository or download its zip file.
- Double-click the start file for your system (`start.bat` for Windows, `start.command` for Mac OS X, `start.sh` for Ubuntu).
- Allow up several minutes for box dependencies to download and set up.

If installation is successful, a browser window should appear notifying that IIIF in a Box is ready. The URL should be `http://localhost:8000`.

*Command Line Usage: You can also start IIIF API in a Box using `vagrant up`. When it is done setting up, simply browse to `http://localhost:8000`.*

## Usage

To begin, simply run `start.bat` for Windows, `start.command` for Mac OS X, or `start.sh` for Ubuntu. The box should start up within a minute. When it is done starting up, a browser window should appear navigated to `http://localhost:8000` displaying the API's main interface. The default login credentials are `admin / adminPassword` for the administrator, and `staff / staffPassword` for the standard user.

To add images to the build-in Loris server, simply drag image files into the `loris` shared directory. The IIIF Image URL prefix for images added this way is: `http://localhost:8111/loris/synced/<name of image plus extension>`

To view your IIIF API's top-level collection in Mirador, visit `http://localhost:8222`.

To end, simply run `stop.bat` for Windows, `stop.command` for Mac OS X, or `stop.sh` for Ubuntu.

*Command Line Usage: You can also start IIIF API in a Box using `vagrant up` and shut it down using `vagrant halt`. If you wish to see diagnostic output while the box is starting up, run `vagrant up --debug`.*

## Uninstallation

Run `uninstall.bat` if you use Windows, `uninstall.command` if you use Mac OS X or `uninstall.sh` if you use Ubuntu. This will remove the VirtualBox image generated during installation.

*Command Line Usage: You can uninstall IIIF API in a Box using `vagrant destroy`.*

## License

IIIF API in a Box is licensed under Apache License 2.0.
