set -eu

# EXPECTED: File containing expected value
# ACTUAL: File containing actual value
# PROJECT: Project file located at the root


get_value_from_project () {
	jq -r ".$1" $PROJECT_FILE
}

curl --silent http://localhost:8000/version | jq > $ACTUAL

jq <<JSON > $EXPECTED
{
	"service_name": "$(get_value_from_project service_name)",
	"app_name": "$(get_value_from_project app_name)",
	"version": "$(get_value_from_project version)",
	"contract_version": "$(get_value_from_project contract_version)",
	"repository": "$(get_value_from_project repository",
	"image": "$(get_value_from_project image"
}

JSON

diff -u $ACTUAL $EXPECTED


