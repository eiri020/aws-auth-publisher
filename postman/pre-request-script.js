pm.sendRequest({
  url: "http://localhost:8080/aws/default",
  method: "GET",
  }, function (_, response) {
      if (response.status == "OK") {
          const body = response.json()
          pm.collectionVariables.set("aws_access_key_id", body.aws_access_key_id)
          pm.collectionVariables.set("aws_secret_access_key", body.aws_secret_access_key)
          pm.collectionVariables.set("aws_session_token", body.aws_session_token)
          pm.collectionVariables.set("aws_expiration", body.aws_expiration)
          pm.collectionVariables.set("aws_profile", body.aws_profile)
      } else {
          throw new Error(response.text() || "Error fetching aws credentials")
      }
  }
)