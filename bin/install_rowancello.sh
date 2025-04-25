set -x

export ROWAN_PROJECTS_HOME=/bosch1/users/dhenrich/_stones/git
stone_name=battery_h

newExtent.solo -r 37x $stone_name -e snapshots/extent0.rowancello.dbf

./rowancello_seaside.topaz -lq

# run the following using SystemUser
installProject.stone file:$ROWAN_PROJECTS_HOME/Rowancello/rowan/specs/Rowancello-Base.ston --projectsHome=$ROWAN_PROJECTS_HOME -D -- -I .topazini_sys

# run the following using seaside
installProject.stone file:$ROWAN_PROJECTS_HOME/Rowancello/rowan/specs/Rowancello.ston --projectsHome=$ROWAN_PROJECTS_HOME -D  -- -I .topazini_seaside


