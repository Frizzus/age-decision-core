set -eu

# EXPECTED: Fichier contenant le résultat attendu
# ACTUAL: Fichier contenant le résultat du test
# PROJECT_FILE: Fichier project.json

get_value_from_project () {
	jq -r ".$1" $PROJECT_FILE
}

curl --silent http://localhost:8000/health | jq > $ACTUAL

# jq -n couplé aux arguments --args permet d'échapper les caractères spéciaux.
# le fichier project.json, ne devrait pas contenir ce genre de caractères, si il en contient le test devrait l'arrêter
jq <<JSON > $EXPECTED
{
	"status":"ok",
	"service": "$(get_value_from_project service_name)",
	"version": "$(get_value_from_project version)",
	"contract_version": "$(get_value_from_project contract_version)"
}
JSON

diff -u $ACTUAL $EXPECTED


