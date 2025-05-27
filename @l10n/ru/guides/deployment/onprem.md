# On-premise Deployment

Tisane web service can be deployed outside of Tisane Labs' public cloud on customer's premises, in a private call center, or in a private cloud.

API methods on on-prem installations are the same as in our public cloud. (See: [Tisane API Reference](/apis/tisane-api-short).) Authentication headers are not required.

On-prem licenses are issued on a case-by-case basis. [Contact us to discuss your requirements](https://tisane.ai/on-prem).

For integration of Tisane as an in-process component, see: [Tisane Embedded SDKs](/sdks)

## RAM Requirements

**Lazy loading**: 50 Mb fixed + 50 to 100 Mb per language model
**Fully loaded**: between 400 Mb and 2 Gb per language model

Read more: [Lazy loading vs Fully Loaded Mode](/sdks/lazyloading.md)

## Linux

Tisane Web Service for Linux is a self-hosted executable (`tisane`) running as a web service, optionally as a daemon. Multiple instances can run on the same language database, the same machine, and using the same configuration. Each instance requires a separate port. 

### Requirements

Kernel version 6.0.0+

### Command-line Parameters

**Without parameters**

Runs a simple test, outputs its result, and exits.

**-port**

Launches the service listening on the specified port with the following parameter(s):

* *Parameter 1*: valid port number

**-parse**

Launches a single parse call and outputs its result with the following parameters:

* *Parameter 1*: language code
* *Parameter 2*: content
* *Parameter 3*: settings (must be enclosed in `{}` )

**-transform**

Launches a single transform call and outputs its result with the following parameters:

* *Parameter 1*: source language code
* *Parameter 2*: target language code(s)
* *Parameter 3*: content
* *Parameter 4*: settings (must be enclosed in `{}` )

**--version**

Outputs the runtime version.

### Configuration

Tisane's Linux configuration files use [TOML format](https://en.wikipedia.org/wiki/TOML). All the settings are under *\[main\]* section. The settings are:

* *path* (string, required) - a folder where the Tisane data files are located. Relative path is OK, so if it’s in the same folder, `./` works.
* *preload* (array of strings, optional) - language codes to load fully at the startup. The rest will use lazy loading (loading on demand). It is recommended to preload no more than one or two language models, unless the environment has multiple languages used very often. Also read: [Lazy loading vs Fully Loaded Mode](/sdks/lazyloading.md)
* *daemon* (boolean, optional) - if *true*, Tisane will be launched as a daemon (service). 
* *limit* (integer, optional) - the maximum length of the request in bytes.

Example:

```bash
[main]
path = "./"
preload = ["en", "es"]
daemon = true
```

{% admonition type="warning" %}

Do not use the `daemon` option when using Docker.

{% /admonition %}

### Installation

Once started with `-port` parameter specified, `tisane` accepts and responds to HTTP requests. To install, simply make sure the executable is launched when the system starts. The simplest way is to use the `systemd` suite.

We provide a Bash script to configure `systemd` to launch multiple instances of Tisane Web Service: [install.sh](/guides/sourcecode/install.sh)

More helper Bash scripts:

* stop all running instances of Tisane: [stop.sh](/guides/sourcecode/stop.sh)
* start instances of Tisane managed by `systemd`: [startall.sh](/guides/sourcecode/startall.sh)

#### install.sh Parameters
Parameters
- -f : Path to tisane zip file (install or update package)
- -p : Comma separated list of ports where you want to start the service
- -d : If you do not want to run tisane as a daemon , set this to "simple" and update your config file. (Suggested to not change this parameter , default is forking for daemon)
- -u : If used this option, it will try to force install tisane , by clearing all older files and stopping all running services

### Updates

To update:

1. Shut down any running instances of Tisane connected to the target linguistic database.
2. Deploy the update.
3. Start the instances again.

{% admonition type="info" %}

More Bash scripts for distribution and monitoring are available on request.

{% /admonition %}

## Windows

Tisane Runtime is a Windows service ASP.NET application. Tisane Runtime runs as a service only. Several instances can run on the same machine on different ports. 

Once installed, the instances are accessible in the Windows Services management console as shown on the screenshot below.

![Tisane Windows services](/guides/images/tisaneWindowsServices.png)

Tisane Runtime is self-hosted and does not require an external web server (no IIS, Apache, nginx, etc.).

### Requirements

ASP.NET Core Runtime 8+

[Download .NET 8.0](https://dotnet.microsoft.com/en-us/download/dotnet/8.0) (.NET Runtime package is required as well)

### Installation

1. Make sure ASP.NET Code 8+ and .NET Runtime 8+ are installed.
2. Create a folder on the server (e.g. `C:\Tisane`).
3. Create a subfolder for the binaries (e.g. `C:\Tisane\bin`).
4. Copy the Tisane binaries and the configuration file (`Tisane.Runtime.Service.dll.config`) to the executable subfolder(s). Don't forget the `native` subfolder for the RocksDB libraries. Unlike with the Linux edition, every instance must have its own folder because we rely on the configuration file to set the port the service will run on.
5. Execute `Tisane.Runtime.Service.exe -i` to install.
6. Copy the language models to the folder specified in the configuration (e.g. `C:\Tisane` or `C:\Tisane\db`).

#### Command-Line Parameters

* `-i` - install a new service for the binaries in the current folder
* `-u` - uninstall the service linked to the current folder
* `-r` - reinstall the service linked to the current folder

### Configuration

The configuration file (`Tisane.Runtime.Service.dll.config`) is a standard Configuration Manager format (XML) file that contains settings used by the Tisane service in its `appSettings` section:

* `DbPath` - (required) a folder where the Tisane data files are located. Absolute path, must end with `\` or `/`.
* `Port` - (required) a port to run the service on. Must not be in use.
* `PreloadLanguages` - a comma-delimited list of language codes to load fully at the startup. The rest will use lazy loading (loading on demand). It is recommended to preload no more than one or two language models, unless the environment has multiple languages used very often. Also read: [Lazy loading vs Fully Loaded Mode](/sdks/lazyloading.md)

Example: 

```xml
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
  <appSettings>
      <add key="DbPath" value="C:\Tisane\" />
      <add key="Port" value="3780" /> <!-- run on port 3780 -->
      <add key="PreloadLanguages" value="en,fr" /> <!-- preload English and French -->
   </appSettings>
</configuration>
```

### Updates

1. Shut down all Tisane services. Make sure no external application is accessing the Tisane data files and binaries.
2. Copy the new Tisane files over the existing files. 
3. Start the services again.

{% admonition type="warning" %}

Make sure you **do not overwrite the existing configuration file**.

{% /admonition %}

## Recommended Practices

Tisane is thread-safe, so multiple callers can connect to the same instance. When multiple language models are loaded, keeping the number of instances low helps. Still, it is recommended to keep the number of simultaneous requests reasonable.

From our experience, the best balance is 3 instances for a 4 core 8 Gb machine.

