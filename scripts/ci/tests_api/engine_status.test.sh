set -eu

# EXPECTED: File containing expected value
# ACTUAL: File containing actual value
# INFRA_SETTINGS: File Containing setting from the infrastructure part 

get_value_from_settings () {
	value="$1"
	awk -c "BEGIN {FS=\"=\"}; /$value/ {print \$2}" $INFRA_SETTINGS
}

curl --silent http://localhost:8000/version | jq > $ACTUAL

jq <<JSON > $EXPECTED
{
  "input_analysis": {
    "engine": "opencv-yunet",
    "loaded": true
  },
  "inference": {
    "model_id": $(get_value_from_settings age_model_id)
    "model_version": $(get_value_from_settings age_model_version),
    "task": "age_estimation",
    "runtime": "onnx",
    "scoring_policy_id": $(get_value_from_settings age_scoring_policy_id),
    "mode": "onnx",
    "use_mock_model": $(get_value_from_settings use_mock_model),
    "model_loaded": true,
    "output_supported": true
  }
}
JSON

diff -u $ACTUAL $EXPECTED


