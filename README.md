# 🚀 Neocron
<p>
  <a href="https://t.me/aioexp">
    <img src="https://img.shields.io/badge/Telegram-Contact-blue?logo=telegram" alt="Telegram Channel">
  </a>
  <a href="https://github.com/monhacer/Neocron/stargazers">
    <img src="https://img.shields.io/github/stars/monhacer/Neocron?style=social" alt="GitHub stars">
  </a>
</p>
Neocron is a simple and interactive bash script for managing cron jobs on Debian-based systems.  
You can easily list current cron jobs, add new ones with custom intervals, and delete specific cron jobs directly from the terminal. 🎯

---

## ✨ Features

- 📋 View all current cron jobs with clear formatting  
- ➕ Add new cron jobs by specifying frequency in months, days, hours, minutes, and seconds (seconds handled with a workaround)  
- 🗑️ Delete individual cron jobs by selecting from a numbered list  
- 🎨 Colorful, user-friendly menu interface

---

## 🎬 Demo

### 📂 Main Menu  
![Main Menu](https://github.com/monhacer/Neocron/blob/main/menu.png)

### ➕ Add Cronjob  
![Add Cronjob](https://github.com/monhacer/Neocron/blob/main/add.png)

### 📋 Current Cronjobs & 🗑️ Delete Option  
![Current Cronjobs](https://github.com/monhacer/Neocron/blob/main/currdel.png)

---

## 🛠️ Installation

1. Download make the script executable:
```
wget https://raw.githubusercontent.com/monhacer/Neocron/refs/heads/main/Neocron.sh
chmod +x Neocron.sh
./Neocron.sh
```
2. For future use just run:
 ```
./Neocron.sh
```
---

## 🎯 Usage

- Choose option `1` to list current cron jobs and optionally delete any of them.  
- Choose option `2` to add a new cron job. You will be prompted to enter the command and specify frequency intervals.  
- Choose option `0` to exit.

---

## ⚠️ Notes

- ⏳ Specifying seconds is not natively supported by cron, so the script uses a `while true` loop with `sleep` for that functionality.  
- 🔑 Make sure you run the script with appropriate permissions to modify your user's crontab.

---

## 📄 License

© 2025 aioexp.  
This project is open source and available under the MIT License.

---

## 📫 Contact

[aioexp](https://t.me/aioexp)
