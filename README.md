# Rowancello utility for converting a BaselineOf into Rowan metadate
## Under development

### Porting/Development support scripts


Set up a new 3.7.4 Rowan3 stone with Rowan:masterV3.5 installed (required). 
Note that Rowan is loaded into the stone during rebuild_stone.sh, so you just 
need to arrange to update your copy of the RowanV3 project to use the lastest commit on masterV3.5 branch.#

### Set of .topazini files and users (seaside user created by rebuild_stone.sh script)
```
 	.topazini
			seaside
	 .topazini_datacurator
			DataCurator
	 .topazini_seaside
			seaside
	 .topazini_sys
			SystemUser

bin/rebuild_stone.sh
bin/install_rowancello.sh

bin/analyze.topaz -lq

```
*bin/rebuild_stone.sh* (needs customization for your environment) installs RowanClientServicesV3 and RowanV3 into a standard extent.rowan3.dbf then stashes a snapshot (rowancello.dbf) into the the snapshots directory.

*bin/install_rowancello.sh* starts a stone on a fresh copy snapshots/rowancello.dbf and installs RowanCello into the
stone, installing code as SystemUser and seaside user.

*bin/analyze.topaz* (needs customizaton) reads a BaselineOf and writes out a Dictionary of Dictionaries containing the raw metadata from the BaselineOf.

The goal is to product a directory of Rowan metadata that duplicates the functionality of the BaselineOf. 

Here's a picture of the directory structure for a stone that I use (bin is symbolically linked to RowanCello/bin:
```
bosch:battery_h>ls -altr
total 116032
lrwxrwxrwx  1 dhenrich smalltalk        58 Apr 25 10:25 product -> /bosch1/users/dhenrich/_stones/37x/h_37x/noop50/gs/product
drwxr-xr-x 29 dhenrich smalltalk      4096 Apr 25 10:25 ..
-rw-r--r--  1 dhenrich smalltalk    133440 Apr 25 10:25 system.conf
-rw-r--r--  1 dhenrich smalltalk        34 Apr 25 10:25 gem.conf
lrwxrwxrwx  1 dhenrich smalltalk        89 Apr 25 10:25 .GDKStoneSpec.ston -> /bosch1/users/dhenrich/gsdevkit_stones_REGISTRY/gsdevkit_stones/stones/37x/battery_h.ston
lrwxrwxrwx  1 dhenrich smalltalk        62 Apr 25 10:28 bin -> /bosch1/users/dhenrich/_stones/git/Rowancello/bin/
-rw-r--r--  1 dhenrich smalltalk       359 Apr 25 10:35 customenv
drwxr-xr-x  2 dhenrich smalltalk      4096 Apr 25 10:35 sandbox
lrwxrwxrwx  1 dhenrich smalltalk        27 Apr 25 10:38 createSeasideUser.topaz -> bin/createSeasideUser.topaz
lrwxrwxrwx  1 dhenrich smalltalk        25 Apr 25 10:39 install_rowancello.sh -> bin/install_rowancello.sh
lrwxrwxrwx  1 dhenrich smalltalk        20 Apr 25 10:39 rebuild_stone.sh -> bin/rebuild_stone.sh
-rw-r--r--  1 dhenrich smalltalk        72 Apr 25 10:39 .topazini_sys
-rw-r--r--  1 dhenrich smalltalk        73 Apr 25 10:40 .topazini_datacurator
-rw-r--r--  1 dhenrich smalltalk        69 Apr 25 10:40 .topazini_seaside
lrwxrwxrwx  1 dhenrich smalltalk        69 Apr 25 10:41 .topazini -> .topazini_seaside
lrwxrwxrwx  1 dhenrich smalltalk        28 Apr 25 11:36 rowancello_seaside.topaz -> bin/rowancello_seaside.topaz
lrwxrwxrwx  1 dhenrich smalltalk        27 Apr 25 11:36 rowancello_system.topaz -> bin/rowancello_system.topaz
drwxr-xr-x  2 dhenrich smalltalk      4096 Apr 25 11:47 snapshots
drwxr-xr-x  5 dhenrich smalltalk      4096 Apr 25 13:49 .
drwxr-xr-x  2 dhenrich smalltalk      4096 Apr 25 14:18 logs
-rw-r--r--  1 dhenrich smalltalk   1186816 Apr 25 14:44 tranlog4.dbf
-rw-r--r--  1 dhenrich smalltalk 117440512 Apr 25 14:44 extent0.dbf
```

The instructions assume that you are using [GsDevKit_stones](https://github.com/GsDevKit/GsDevKit_stones) to manage your stones ...
