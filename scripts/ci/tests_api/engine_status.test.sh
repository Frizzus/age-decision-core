set -eu

# EXPECTED: File containing expected value
# ACTUAL: File containing actual value
# INFRA_SETTINGS: File Containing setting from the infrastructure part 

get_value_from_settings () {
	value="$1"
	awk "BEGIN {FS=\"=\"}; /$value/ {print \$2}" $INFRA_SETTINGS
}

# Python boolean always begin with capitalize T or F (True, False)
# It is not a valid bool in json
to_valid_bool () {
	tr '[A-Z]' '[a-z]'
}

curl --silent http://localhost:8000/version | jq > $ACTUAL

jq <<JSON > $EXPECTED
{
  "input_analysis": {
    "engine": "opencv-yunet",
    "loaded": true
  },
  "inference": {
    "model_id": $(get_value_from_settings age_model_id),
    "model_version": $(get_value_from_settings age_model_version),
    "task": "age_estimation",
    "runtime": "onnx",
    "scoring_policy_id": $(get_value_from_settings age_scoring_policy_id),
    "mode": "onnx",
    "use_mock_model": $(get_value_from_settings use_mock_model | to_valid_bool),
    "model_loaded": true,
    "output_supported": true
  }
}
JSON

diff -u $ACTUAL $EXPECTED


