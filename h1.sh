#!/bin/bash
# insfollow v2.0
# recoded by: Termux Professor
# github.com/termuxprofessor/insfollow
# If you use any part from this code, give me the credits, please, read the License

clear
string4=$(openssl rand -hex 32 | cut -c 1-4)
string8=$(openssl rand -hex 32  | cut -c 1-8)
string12=$(openssl rand -hex 32 | cut -c 1-12)
string16=$(openssl rand -hex 32 | cut -c 1-16)
device="android-$string16"
uuid=$(openssl rand -hex 32 | cut -c 1-32)
phone="$string8-$string4-$string4-$string4-$string12"
guid="$string8-$string4-$string4-$string4-$string12"
header='Connection: "close", "Accept": "*/*", "Content-type": "application/x-www-form-urlencoded; charset=UTF-8", "Cookie2": "$Version=1" "Accept-Language": "en-US", "User-Agent": "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'
var=$(curl -i -s -H "$header" https://i.instagram.com/api/v1/si/fetch_headers/?challenge_type=signup&guid=$uuid > /dev/null)
var2=$(echo $var | grep -o 'csrftoken=.*' | cut -d ';' -f1 | cut -d '=' -f2)
ig_sig="4f8732eb9ba7d1c8e8897a75d6474d4eb3f5279137431b2aafb71fafe2abe178"



banner() {
echo ""

echo -e "\e[1;91m ═╦═\e[1;92m┌─┐ ┌┌──┐\e[1;91m╔══╗\e[1;92m┌──┐┬   ┬   ┌──┐┬ ┬ ┬"

echo -e "\e[1;91m  ║ \e[1;92m│ │ ││   \e[1;91m║   \e[1;92m│  ││   │   │  ││ │ │"

echo -e "\e[1;91m  ║ \e[1;92m│ │ │└──┐\e[1;91m╠═╣ \e[1;92m│  ││   │   │  ││ │ │"

echo -e "\e[1;91m  ║ \e[1;92m┘ └─┘└──┘\e[1;91m║   \e[1;92m└──┘┴──┘┴──┘└──┘└─┴─┘"

echo -e "\e[1;91m ═╩═\e[1;92m         \e[1;91m╩   by - \e[1;92mTermux Professor"

}


login_user() {




check_follow=$(curl -s -L -b cookie.$user -d "ig_sig_key_version=4&signed_body=$hmac.$data" -s --user-agent 'User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"' -w "\n%{http_code}\n" -H "$header" "https://i.instagram.com/api/v1/friendships/create/$celeb/" | grep -o '"following": true')

if [[ $check_follow == "a" ]]; then
printf " \n\e[1;31m [!] Error\n"
printf " \n\e[1;33m [::] There is problem in you instagram account\n"
printf " \n\e[1;31m [:] Reason\n"
printf " \n\e[1;33m - You have reached today's following/unfollowing limit of instagram\n."
printf " \n\e[1;33m - You account is temporary banned by instagram\n"
printf " \n\e[1;32m [:] Solution\n"
printf " \n\e[1;33m - Don't follw or unfollow any in instagram for 24 hour then run script again it will work.\n"

exit 1
else
printf " \e[1;92mSuccess\e[0m\n"
fi
sleep 3

done
printf " \e[1;31m[\e[0m\e[1;77m+\e[0m\e[1;31m]\e[0m\e[1;77m Sleeping 60 secs...\e[0m\n"
sleep 60
#unfollow
for celeb in $(cat celeb_id); do
data='{"_uuid":"'$guid'", "_uid":"'$username_id'", "user_id":"'$celeb'", "_csrftoken":"'$var2'"}'
hmac=$(echo -n "$data" | openssl dgst -sha256 -hmac "${ig_sig}" | cut -d " " -f2)
printf " \e[1;31m[\e[0m\e[1;77m+\e[0m\e[1;31m]\e[0m\e[1;93m Trying to unfollow celebgram %s ..." $celeb
check_unfollow=$(curl -s -L -b cookie.$user -d "ig_sig_key_version=4&signed_body=$hmac.$data" -s --user-agent 'User-Agent: "Instagram 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"' -w "\n%{http_code}\n" -H "$header" "https://i.instagram.com/api/v1/friendships/destroy/$celeb/" | grep -o '"following": false' )

if [[ $check_unfollow == "a" ]]; then
printf "\n \e[1;93m [!] Error, stoping to prevent blocking\n"
printf " \e[1;33m [-] You reached today's limit. Try tomorrow again.\n"
printf " \e[1;33m [-] We have set limit for prevent blockage of your instagram account.\n"
exit 1
else
printf " \e[1;92mSuccess\e[0m\n"
fi

sleep 3
done
printf " \e[1;31m[\e[0m\e[1;77m+\e[0m\e[1;31m]\e[0m\e[1;77m Sleeping 60 secs for block prevention...\e[0m\n"
sleep 60


done


}

menu() {

printf "\n"
printf " \e[1;31m[\e[0m\e[1;77m01\e[0m\e[1;31m]\e[0m\e[1;93m Increase Followers\e[0m\n"
printf " \e[1;31m[\e[0m\e[1;77m02\e[0m\e[1;31m]\e[0m\e[1;93m Exit\e[0m\n"
printf "\n"


read -p $' \e[1;31m[\e[0m\e[1;77m::\e[0m\e[1;31m]\e[0m\e[1;77m Choose an option: \e[0m' option

if [[ $option -eq 1 ]]; then
login_user
increase_followers

elif [[ $option -eq 2 ]]; then
printf "\n"
printf "  \e[1;91mBye Bye !!\e[0m\n"
printf "\n"
exit

else

printf " \e[1;93m[!] Invalid Option!\e[0m\n"
sleep 2
menu

fi
}


banner
menu
