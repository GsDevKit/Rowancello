set -x

newExtent.solo -r 37x battery_g -e product/bin/extent0.rowan3.dbf

#run the following using SystemUser
installProject.stone file:/bosch1/users/dhenrich/_stones/37x/g_37x_externals_st/RowanClientServicesV3/rowan/specs/RowanClientServices.ston --projectsHome=/bosch1/users/dhenrich/_stones/37x/g_37x_externals_st -D -- -I .topazini_sys

#run the following using as DataCurator

./createSeasideUser.topaz -lq


snapshot.stone snapshots --extension=rowancello.dbf -- -I .topazini_datacurator

ls -altr snapshots
