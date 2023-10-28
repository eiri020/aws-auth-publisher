# aws-auth-publisher
Publish AWS credentials over a local http port for use in Postman.

Note: Running this service is not secure. It will publish your credentials over anonymous http. It should be configured only for localhost access and be closed down when not in use. 

## The automatically get your aws credentials in postmans requests
For accessing AWS resources we need to regulary fetch the temporarly AWS credentials for the role we need to work on (e.g. aws-azure-login). 

When testing AWS API's wih Postman we need to copy and paste those credentials in the postman authorization fields each time the credentials are expired or you change role or account.

Because postman cannot read local text files or executes something that does, i created this small service that publishes the credentials on the localhost (when configured correct). 
Postman can then fetch those credentials in a pre-request-script. and substitute them in the authorization data.

The service will listen on (default) port 8080:
```
  curl http://localhost:8080/aws/
```
which will output the credentials for default AWS profile in a json object, like:
```
{
	"aws_profile": "profile",
	"aws_access_key_id": "bar",
	"aws_secret_access_key": "foo",
	"aws_session_token": "yep",
	"aws_expiration": "2023-07-27T15:26:33.000Z"
}
```
Adding a specific profile to the url will display the credentials of that profile.


## Local service setup
### Requirements
- socat
- jq

### Setup
1. Clone repository
   ```
   git clone https://github.com/eiri020/aws-auth-publisher.git
   cd aws-auth-publisher
   git submodule init
   git submodule update
   ```
2. Update ./config
   - svc_port=< portnumber to listen on >
   - aws_credentials=< full path to your aws credentials file >
3. Make sure the socat "bind=127.0.0.1" is added to in de indedx.sh script for only publishing your credentials on your local host
4. start server 
   ```
   ./index.sh &
   ```
5. Update your AWS credentials, e.g.
   ```
   aws-azure-login
   ```
6. Verify the service
   ```
   curl http://localhost:8080/aws/
   ```
   It should display the credentials  

## Docker service setup
1. Build your docker image
   ```
   docker build . -t aws-auth-publisher
   ```
2. Verify docker-compose.yaml. Make sure the local ip is included in the port settings
3. Start service
   ```
   docker-compose up -d
   docker logs aws-auth-publisher
   ```
4. Update your AWS credentials, e.g.
   ```
   aws-azure-login --profile=fs
   ```
5. Verify the service
   ```
   curl http://localhost:8080/aws/fs
   ```
   It should display the credentials  

### Postman setup

1. Create collection variables, without an initial value
	 - aws_profile
	 - aws_access_key_id
	 - aws_secret_access_key
	 - aws_session_token
	 - aws_expiration

   See [screenshot](postman/variables.png)
2. Add a pre-request script for the postman collection
   See [script](postman/pre-request-script.js) and [screenshot](postman/pre-request-script.png)
3. Configre AWS configuration for the postman collection
   See [screenshot](postman/authorization.png)
4. Now your api calls will use your credentials, you can check the current values of variables in the collection settings, which should now be set.


## Similar solutions
- https://github.com/nuttmeister/pm-creds
- 