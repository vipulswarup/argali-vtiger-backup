#script to dump vtiger mysql database
timestamp="$(date +"%Y-%m-%d_%H-%M-%S")"
bak_folder=/opt/backup
mkdir $bak_folder

mysqldump -u root -phewlettp vtiger_db > "$bak_folder/vtiger_backup_$timestamp.sql"

