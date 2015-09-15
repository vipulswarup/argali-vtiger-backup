#script to dump vtiger mysql database
timestamp="$(date +"%Y-%m-%d_%H-%M-%S")"
bak_folder=/opt/backup
bak_file="$bak_folder/vtiger_backup_$timestamp.sql"

mkdir $bak_folder

mysqldump -u root vtiger_db > "$bak_file"

#check for pigz - multi threaded zip utility
apt-get install pigz
#zip the backup
pigz --best $bak_file

#delete previous backup
#copy file name from /opt/backup/bakfile.txt
old_bak_file_name=$(</opt/backup/bakfile.txt)
echo "Deleting old backup file: $old_bak_file_name"
rm "$old_bak_file_name"

#write name of created file in a txt file for uploader script to pick up
echo "$bak_file.gz" > /opt/backup/bakfile.txt
