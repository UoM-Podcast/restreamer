#!/bin/bash
. /opt/opencast/opencast.conf
NUMBER_OF_INGESTS=1
#OC_SERVER='opencastserver'
#OC_DIGEST_LOGIN='opencastdigestlogin'
VIDEO_FILE=$1
echo ${OC_WORKFLOW}
#OC_WORKFLOW='opencastworkflow'
#set -eux
if [ ! -f "${VIDEO_FILE}" ]; then
read -r VIDEO_FILE
if [ ! -f "${VIDEO_FILE}" ]; then
exit 1
fi
fi
# Generate title and name
CURRENT_DATE=$(date '+%Y-%m-%d_%H:%M:%S')
TITLE="Test Livestream $CURRENT_DATE"
NAME="UoM"
# Ingest media
/usr/bin/curl -s -o /dev/null -f -i --digest -u ${OC_DIGEST_LOGIN} \
-H "X-Requested-Auth: Digest" \
"${OC_SERVER}/ingest/addMediaPackage/${OC_WORKFLOW}" \
-F flavor="presentation/source" \
-F "BODY=@${VIDEO_FILE}" -F title="${TITLE}" \
-F creator="${NAME}"
