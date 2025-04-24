# Rowancello utility for converting a BaselineOf into Rowan metadate
## Under development

```
### Porting/Development support scripts
#
#	set up a new 3.7.4 Rowan3 stone with Rowan:masterV3.5 installed for best results when running Rowancello code
#
# set of .topazini files and users (seaside user created by rebuild_stone.sh script.
#
# 	.topazini
#			seaside
#	 .topazini_datacurator
#			DataCurator
#	 .topazini_seaside
#			seaside
#	 .topazini_sys
#			SystemUser
#
# rebuild_stone.sh (needs customization for your environment) installs RowanClientServicesV3 and RowanV3 into a
# standard extent.rowan3.dbf then stashes a snapshot (rowancello.dbf) into the the snapshots directory.
#
# install_rowancello.sh starts a stone on a fresh copy snapshots/rowancello.dbf and installs RowanCello into the
# stone, installing code as SystemUser and seaside user.
#

bin/rebuild_stone.sh
bin/install_rowancello.sh

```
