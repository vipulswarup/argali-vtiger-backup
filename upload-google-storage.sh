#copy file name from /opt/backup/bakfile.txt
value=$(</opt/backup/bakfile.txt)
echo "Bak file name is $value"
echo "Uploading $value"
#Copy backup to google cloud bucket
/usr/local/bin/gsutil -o GSUtil:parallel_composite_upload_threshold=150M cp $value gs://argali_vtiger_backup/ > /opt/backup/upload.log 2>&1
