set -x

export ROWAN_PROJECTS_HOME=/bosch1/users/dhenrich/_stones/37x/g_37x_externals_st
stone_name=battery_g

newExtent.solo -r 37x $stone_name -e product/bin/extent0.rowan3.dbf

#run the following using SystemUser
./rowancello_system.topaz -lq 

installProject.stone file:$ROWAN_PROJECTS_HOME/RowanClientServicesV3/rowan/specs/RowanClientServices.ston --projectsHome=$ROWAN_PROJECTS_HOME -D -- -I .topazini_sys

# RowanV3 needs to be using latest masterV3.5 branch
installProject.stone file:$ROWAN_PROJECTS_HOME/RowanV3/rowan/specs/Rowan.ston --alias=RowanV3 --projectsHome=$ROWAN_PROJECTS_HOME -D -- -I .topazini_sys

#run the following using as DataCurator (done as part of topaz script)
./createSeasideUser.topaz -lq


snapshot.stone snapshots --extension=rowancello.dbf -- -I .topazini_sys

ls -altr snapshots
