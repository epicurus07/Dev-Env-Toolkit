# insert "user_id user-password database"
USER_SET_LIST=("sonar sonar sonar" "redmine redmine redmine" "gitbucket gitbucket gitbucket")
USER_SET_USER_INDEX=0
USER_SET_PASS_INDEX=1
USER_SET_DATABASE_INDEX=2

for elem in "${USER_SET_LIST[@]}"
do
user_set=($elem)
	if [ -z "${user_set[$USER_SET_USER_INDEX]}" ] | [ -z "${user_set[$USER_SET_PASS_INDEX]}" ]
	then
		echo >&2 "error: user id or password not exist"
		exit 1
	fi

	echo "CREATE USER '${user_set[$USER_SET_USER_INDEX]}'@'%' IDENTIFIED BY '${user_set[$USER_SET_PASS_INDEX]}' ;" | "${mysql[@]}"

	if [ "${user_set[$USER_SET_DATABASE_INDEX]}" ]
	then
		echo "CREATE DATABASE IF NOT EXISTS \`${user_set[$USER_SET_DATABASE_INDEX]}\` ;" | "${mysql[@]}"
		echo "GRANT ALL ON \`${user_set[$USER_SET_DATABASE_INDEX]}\`.* TO '${user_set[$USER_SET_USER_INDEX]}'@'%' ;" | "${mysql[@]}"
	fi
done
echo 'FLUSH PRIVILEGES ;' | "${mysql[@]}"
