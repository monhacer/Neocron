#!/bin/bash

RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
RESET='\e[0m'

while true; do
    clear
    echo -e "${GREEN}===========================================${RESET}"
    echo -e "${GREEN}Neocron V1.0${RESET}"
    echo -e "${GREEN}GitHub: https://github.com/monhacer/Neocron${RESET}"
    echo -e "${GREEN}===========================================${RESET}"
    echo
    echo -e "Select an option:"
    echo -e "1. ${GREEN}Current cronjobs list${RESET}"
    echo -e "2. ${GREEN}Add cronjob${RESET}"
    echo -e "0. ${GREEN}Exit${RESET}"
    echo -ne "${YELLOW}"
    read -rp "Enter your choice: " choice
    echo -e "${RESET}"

    case $choice in
        1)
            mapfile -t cronjobs < <(crontab -l 2>/dev/null | grep -v '^#' | sed '/^\s*$/d')
            if [ ${#cronjobs[@]} -eq 0 ]; then
                echo -e "${RED}No cronjobs found.${RESET}"
                echo -ne "${YELLOW}"
                read -rp "Press Enter to continue..." _
                echo -e "${RESET}"
                continue
            fi
            clear
            echo -e "${GREEN}===== CURRENT CRONJOBS =====${RESET}"
            for i in "${!cronjobs[@]}"; do
                echo -e "${GREEN}$((i+1)). ${cronjobs[i]}${RESET}"
                echo "----------------------------------------------------------------"
            done

            echo -ne "${YELLOW}"
            read -rp "Do you want to delete a cronjob? (y/n): " del_choice
            echo -e "${RESET}"

            if [[ "$del_choice" =~ ^[Yy]$ ]]; then
                read -rp "Enter the number of the cronjob to delete: " del_num
                if ! [[ "$del_num" =~ ^[0-9]+$ ]] || (( del_num < 1 || del_num > ${#cronjobs[@]} )); then
                    echo -e "${RED}Invalid number.${RESET}"
                else
                    unset 'cronjobs[del_num-1]'
                    # rebuild crontab without the deleted job
                    printf "%s\n" "${cronjobs[@]}" | crontab -
                    echo -e "${GREEN}Cronjob #$del_num deleted.${RESET}"
                fi
            fi

            read -rp "Press Enter to continue..." _
            ;;
        2)
            clear
            read -rp "Enter the command you want to schedule: " cmd
            echo -e "${YELLOW}Specify the frequency (use 0 for 'skip/every'):${RESET}"
            read -rp "Every how many months: " month
            read -rp "Every how many days: " day
            read -rp "Every how many hours: " hour
            read -rp "Every how many minutes: " minute
            read -rp "Every how many seconds (0 to skip): " second

            cron_minute="*"
            cron_hour="*"
            cron_day="*"
            cron_month="*"

            [[ $minute -ne 0 ]] && cron_minute="*/$minute"
            [[ $hour -ne 0 ]] && cron_hour="*/$hour"
            [[ $day -ne 0 ]] && cron_day="*/$day"
            [[ $month -ne 0 ]] && cron_month="*/$month"

            if [[ $second -eq 0 ]]; then
                (crontab -l 2>/dev/null; echo "$cron_minute $cron_hour $cron_day $cron_month * $cmd") | crontab -
                echo -e "${GREEN}Cronjob added: $cron_minute $cron_hour $cron_day $cron_month * $cmd${RESET}"
            else
                (crontab -l 2>/dev/null; echo "$cron_minute $cron_hour $cron_day $cron_month * while true; do $cmd; sleep $second; done &") | crontab -
                echo -e "${GREEN}Cronjob with seconds workaround added using sleep $second${RESET}"
            fi
            read -rp "Press Enter to continue..." _
            ;;
        0)
            echo -e "${RED}Exiting.${RESET}"
            clear
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid choice.${RESET}"
            read -rp "Press Enter to continue..." _
            ;;
    esac
done
