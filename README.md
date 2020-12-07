# GmailCovidAlert
Scapes my edu for emails by the school. If it detects a email it will send a message in discord.



# How to use
1. Go to https://mail.google.com/mail/u/1/feed/atom. If you have multiple gmails, increase `1` in the URL untill you find the email you want to use.
2. Right click and click inspect
3. Click the network tab. 
4. Refresh the page and select the request with the name atom.
5. Right click and select copy, then select copy all as cURL (bash). Remove the other random requesta but the first one. 
6. Copy the whole curl command into line 35. 
7. Edit your crontab and paste the following command:`* * * * * /bin/bash -l -c 'cd /root/crons/; ruby utica.rb' 
8. Dont forget to change the `/root/crons` with the location of where the sript is, also change `utica.rb` to the name of your script. 



# crontab 
Every minute the job will run the script which will check your email for a message from the school. To make sure there is no dups, it will check if the publish date is the same. If it is different the script will assume the email is new and send a message in discord. 


# Step Up

- If a directory named `configs` doesnt exist. The script will create a new directory. 
- `configs/utica.txt` is where the script keeps track of the the publish date. This ensures that the script will not detect old emails and spam discord.
