#script to dump vtiger mysql database
timestamp="$(date +"%Y-%m-%d_%H-%M-%S")"
bak_folder=/opt/backup
bak_folder_2="$bak_folder/vtiger_backup_$timestamp"

bak_file=vtiger_bak_$timestamp

mkdir $bak_folder
mkdir $bak_folder_2


#dump vtiger db
mysqldump -u root vtiger_db > "$bak_folder_2/vtiger_db_sql_dump.sql"
mysqldump -u root orangehrm_mysql > "$bak_folder_2/orangehrm_mysql_sql_dump.sql"

#copy the vtiger install folder as well
tar -cf "$bak_folder_2/vtigercrm.tar" /var/www/vtigercrm/
#copy the orangehrm install folder as well
tar -cf "$bak_folder_2/orangehrm.tar" /var/www/orangehrm/

#check for pigz - multi threaded zip utility
apt-get install pigz

#tar the bak folder
tar -cf $bak_folder/$bak_file.tar $bak_folder_2

#zip the backup
pigz --best $bak_folder/$bak_file.tar

#delete temp bak folder
rm -rf $bak_folder_2

#delete previous backup
#copy file name from /opt/backup/bakfile.txt
old_bak_file_name=$(</opt/backup/bakfile.txt)
echo "Deleting old backup file: $old_bak_file_name"
rm "$old_bak_file_name"

#write name of created file in a txt file for uploader script to pick up
echo "$bak_folder/$bak_file.tar.gz" > /opt/backup/bakfile.txt
