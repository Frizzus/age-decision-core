
set -eu

if test -d "./.venv/" 
then
	printf "The virtual environnement is already created, use 'make del_venv' to delete it" 
	exit 1
fi

# A faire pour supprimer .venv en cas de problème d'installation
trap '' EXIT

python -m venv ./.venv/
. ./.venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -r ./requirements.txt
python -m pip install -r ./requiements.dev.txt
deactivate
