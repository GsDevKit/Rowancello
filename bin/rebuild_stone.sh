set -x

newExtent.solo -r 37x battery_g -e product/bin/extent0.rowan3.dbf

#run the following using SystemUser
installProject.stone file:/bosch1/users/dhenrich/_stones/37x/g_37x_externals_st/RowanClientServicesV3/rowan/specs/RowanClientServices.ston --projectsHome=/bosch1/users/dhenrich/_stones/37x/g_37x_externals_st -D -- -I .topazini_sys

snapshot.stone snapshots --extension=rowancello.dbf

ls -altr snapshots -- -I .topazini_sys

