set -eu

# EXPECTED: File containing expected value
# ACTUAL: File containing actual value
# PROJECT: Project file located at the root


get_value_from_project () {
	jq -r ".$1" $PROJECT_FILE
}

curl --silent http://localhost:8000/health | jq > $ACTUAL

jq <<JSON > $EXPECTED
{
	"status":"ok",
	"service": "$(get_value_from_project service_name)",
	"version": "$(get_value_from_project version)",
	"contract_version": "$(get_value_from_project contract_version)"
}
JSON

diff -u $ACTUAL $EXPECTED


