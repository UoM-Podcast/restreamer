#!/bin/bash
# Get the opencast conf
. /opt/opencast/opencast.conf

#OC_SERVER='opencastserver'
#OC_DIGEST_LOGIN='opencastdigestlogin'
#OC_WORKFLOW='opencastworkflow'

VIDEO_FILE=$1
BASE_NAME=$2

#set -eux
if [ ! -f "${VIDEO_FILE}" ]; then
read -r VIDEO_FILE
if [ ! -f "${VIDEO_FILE}" ]; then
exit 1
fi
fi
# transcode to mp4
#/usr/local/bin/ffmpeg -i $VIDEO_FILE -f mp4 /var/restreamer/recordings/$BASE_NAME.mp4
# Generate title and name
CURRENT_DATE=$(date '+%Y-%m-%dT_%H:%M:%S')
TITLE="${OC_TITLE_PREFIX} $CURRENT_DATE"
NAME="${OC_NAME}"
# Ingest media
/usr/bin/curl --insecure -s -o /dev/null -f -i --digest -u ${OC_DIGEST_LOGIN} \
-H "X-Requested-Auth: Digest" \
"${OC_SERVER}/ingest/addMediaPackage/${OC_WORKFLOW}" \
-F flavor="presenter/source" \
-F "BODY=@${VIDEO_FILE}" -F title="${TITLE}" \
-F creator="${NAME}" \
-F isPartOf="${OC_SERIES}"
# send to s3 for backup
aws s3 cp ${VIDEO_FILE} s3://${RS_S3_ARCHIVE}/${BASE_NAME}
# remove the file
rm -f ${VIDEO_FILE}
