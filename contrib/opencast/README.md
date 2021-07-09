## Opencast configuration
create an `opencast.conf` file with the below variables

OC_DIGEST_LOGIN=\<opencast_system_account:CHANGE_ME\>

OC_WORKFLOW=\<opencast-workflow\>

OC_SERVER=\<https://opencast-server>

OC_SERIES=\<default opencast series UUID\>

OC_TITLE_PREFIX=\<title of recording\>

OC_NAME=\<presenter name\>

RS_S3_ARCHIVE=\<s3-archive\>


you may used the AWS secrets manager to define the above. for example:

```OC_SERVER=`aws secretsmanager get-secret-value --secret-id OC_SERVER | jq -r '.SecretString'` ```
