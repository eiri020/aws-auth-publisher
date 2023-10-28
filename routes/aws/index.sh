SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source bash-ini-parser/bash-ini-parser
source config

awsRoute() {
   add_response_header "Content-Type" "application/json"

   cfg_parser ${aws_credentials}

   profile=$2
   [ -z "$profile" ] && profile=default

   eval cfg_section_${profile}

   results=$(jq ".aws_profile = \"${profile}\" | .aws_access_key_id=\"${aws_access_key_id}\" | .aws_secret_access_key=\"${aws_secret_access_key}\" | .aws_session_token=\"${aws_session_token}\" | .aws_expiration=\"${aws_expiration}\"" ${SCRIPT_DIR}/template.json)
   send_response_ok_exit <<< $results
}

on_uri_match '^/aws/(.*)$' awsRoute
