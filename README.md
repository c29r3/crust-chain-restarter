# crust-chain-restarter  
This utility is designed to be used in the Crust Network project  
Chain periodically hangs on the same block. Crust worker can't send a report. This strongly affects the worker report rate

This script allows:
 - Automatically reboot chain and api containers if the block in the chain does not change for 60 seconds   
 - Send notifications via Telegram bot  
 
*You can fork this repository and replace `https://raw.githubusercontent.com/c29r3/crust-chain-restarter/main/restarter.sh` to your url*  
 
 ## Requirements  
 - jq  
 - curl  
 - tmux  
 
 ## Screenshot  
 ![alt text](https://github.com/c29r3/crust-chain-restarter/blob/main/restarter.png?raw=true)
 
 ## How to use  
 1. Install requirements  
 ```bash
 apt update && apt install -y curl jq tmux
 ```  
 2. [Get your own Telegram bot token](https://core.telegram.org/bots#creating-a-new-bot)  
 3. Run through tmux, so script will work in background  
```bash
tmux new -s crust-restarter -d "curl -s https://raw.githubusercontent.com/c29r3/crust-chain-restarter/main/restarter.sh | bash -s -- "YOUR_BOT_TOKEN" YOUR_TG_ID"
```
<YOUR_BOT_TOKEN> - This token you should get on step 2  
<YOUR_TG_ID>     - [your TG ID can be found out through this bot](https://t.me/userinfobot)  

### Turn off script  
```bash
tmux kill-session -t crust-restarter
```

### Ansible  
If you are familiar with ansible, you can run the script at once on all the workers by one command  
```bash
ansible -i inventory.yml crust -f 25 -m shell -u root -a 'tmux new -s crust-restarter -d "curl -s https://raw.githubusercontent.com/c29r3/crust-chain-restarter/main/restarter.sh | bash -s -- "YOUR_BOT_TOKEN" YOUR_TG_ID"'
```
