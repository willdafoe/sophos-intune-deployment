:: install-sophos.cmd
:: last modified date: 08/29/2022
@ECHO OFF
SET SOURCE=%~dp0
SET SOURCE=%SOURCE:~0,-1%

:: Default install command
SophosSetup.exe --quiet 

:: Additional supported installation switches
:: |---------------------------------------------------------------------------------------------------------------------------------------|
:: |                       DESCRIPTION                   |                             COMMAND LINE SWITCH                                 |  
:: |-----------------------------------------------------|---------------------------------------------------------------------------------|
:: |Doesn't attempt to perform automatic proxy detection.| --noproxydetection                                                              |
:: | ----------------------------------------------------|---------------------------------------------------------------------------------|
:: |Allows you to manually set the installer language.   | --language=<language ID\>                                                       |     
:: |By default the installer uses the system language.   |                                                                                 |
:: |-----------------------------------------------------|---------------------------------------------------------------------------------|
:: |Specifies the Sophos Central device group to join    | * --devicegroup=<Central group\>                                                |  
:: |the device to. You can also use this option to add   |                                                                                 |
:: |devices to a subgroup.                               | * --devicegroup=<Central group\>\\<Central subgroup\>                           |
:: |                                                     |                                                                                 |
:: | NOTE: If the Group or Subgroup doesn't exist        |                                                                                 |
:: |       it is created.                                |                                                                                 |
:: |-----------------------------------------------------|---------------------------------------------------------------------------------|
:: |Allows you to specify your own catalog of            | --crtcatalogpath=C:\\catalog\\productcatalog.xml                                |
:: |competitors to remove.                               |                                                                                 |
:: |-----------------------------------------------------|---------------------------------------------------------------------------------|
:: |Specifies a list of message relays to use.           | --messagerelays=<comma-separated message relay list of IPs including the port\> |   
:: |-----------------------------------------------------|---------------------------------------------------------------------------------|
:: |Specifies the MCS server to connect to.              | --epinstallerserver <registration server URL\>                                  |
:: |-----------------------------------------------------|---------------------------------------------------------------------------------|
:: |Specifies a custom proxy to use.                     | --proxyaddress=<custom proxy address\>                                          |
:: |-----------------------------------------------------|---------------------------------------------------------------------------------|
:: |If a custom proxy has been specified, set the        | --proxyusername=<custom proxy user name\>                                       |
:: |username with this option.                           |                                                                                 |
:: |-----------------------------------------------------|---------------------------------------------------------------------------------|
:: |If a custom proxy and username have been specified,  | --proxypassword=<custom proxy password\>                                        |
:: |set the password with this option.                   |                                                                                 |
:: |-----------------------------------------------------|---------------------------------------------------------------------------------|
:: |Overrides the name of the device                     | --computernameoverride=<override for computer name\>                            |
:: |to be used in Sophos Central.                        |                                                                                 |
:: |-----------------------------------------------------|---------------------------------------------------------------------------------|
:: |Overrides the domain name of the device              | --domainnameoverride=<override for domain\>                                     |
:: |to be used in Sophos Central.                        |                                                                                 |
:: |-----------------------------------------------------|---------------------------------------------------------------------------------|
:: |Specifies the token of the Sophos Central customer   | --customertoken=<the customer token\>                                           |
:: |to associate the device with.                        |                                                                                 |
:: |-----------------------------------------------------|---------------------------------------------------------------------------------|
:: |Specifies a list of products to install.             | --products=<comma-separated list of products\>                                  |
:: |If you specify a product that you don't              |                                                                                 |
:: |have a license for, then it isn't installed.         |                                                                                 |
:: |                                                     |                                                                                 |
:: | NOTE: List of products to install, comma-separated. |                                                                                 |
:: |       Available options are:                        |                                                                                 |
:: |        > antivirus                                  |                                                                                 |
:: |        > intercept                                  |                                                                                 |
:: |        > mdr                                        |                                                                                 |
:: |        > xdr                                        |                                                                                 |
:: |        > deviceEncryption                           |                                                                                 |
:: |        > all                                        |                                                                                 |
:: |-----------------------------------------------------|---------------------------------------------------------------------------------|