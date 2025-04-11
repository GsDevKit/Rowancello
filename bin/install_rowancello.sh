set -x

newExtent.solo -r 37x battery_g -e snapshots/extent0.rowancello.dbf

./rowancello.topaz -lq

# run the following using SystemUser
installProject.stone file:/bosch1/users/dhenrich/_stones/git/Rowancello/rowan/specs/Rowancello-Base.ston --projectsHome=/bosch1/users/dhenrich/_stones/git -D -- -I .topazini_sys

# run the following using DataCurator
installProject.stone file:/bosch1/users/dhenrich/_stones/git/Rowancello/rowan/specs/Rowancello.ston --projectsHome=/bosch1/users/dhenrich/_stones/git -D


