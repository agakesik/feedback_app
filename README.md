# ROLLER DERBY FEEDBACK APP

## Application for easier evaluating skaters skill during roller derby training

### Project backstory

As trainers for roller derby team [Warsaw Hellcats Roller Girls](http://www.warsawhellcats.com/) (and later other Warsaw teams) we need to be aware of skill level of all skaters on trainings.  Additionally every skater, that wants to be rosted for a game has to be eligible: they have to pass ["Minimum Skills Requirements"](https://resources.wftda.org/education/skater-training/)

Because of this we recently started rating our skaters on their skills (those listed in requirements + some additional that we decided were crucial as well) using these guildelines:

* each skater is to be ranked on 1 of 4 levels: "0 contact", "minor contact", "full contact", "playing"

Roller derby is a full contact sport on roller skates, because of that we have to be fully aware of the threat a player can be to themself and others on the track. Only those that are comfortable on skates are allowed to practice contact parts, and only those who are in full controll of themself can take part in games.

* each skater is evaluated on each skill using ratings in range 1-5

1 means a skater tried doing this skill, but is still at the beginning of learning it
2 means skater is getting a grip on it, understands the basics and just need some more time
3 means skater "passed" evaluation for a minimum requiremenents - this is goal for all new skaters
4 & 5 are for pushing seasoned players to better themself and give them clear feedback on where they are with their skills 

We started using Google Spreasheet as an easy way to store, edit and view all this evaluations

// Add screenshot for visual

### Reasons to create app

Google Spreadsheets *were* working, but weren't ideal:
* while good to view on desctop, they were challenging to view on mobile
* we didn't want to make all evaluations public (to prevent unhealthy comparising between skaters and focusing too much on others), but at the same time wanted to share with a skater their ratings. Our only way was to make screenshots of spreadsheet and cut it one by one.

## Project status
### Working, but still in progress
Currently we have fully functioning application
* user signup/login 
  * everyone can see their evaluations
  * users with "coach" title can see everyone's evaluations and add new ones
  * coach users can also change "skater status" (rank 1-4), add new users and add new skills
  * only users with "admin" title can delete users and skills (as it's should be fully intentional, since it's delete all connected rating as well)
* to add new user: 
    * coach creates new user without any comfirnation needed, so they can start evaluating as soon as they need - for example on skater's very first training with a team
    * if skates commits to a team and wants to see their progress they ask coach or admin to activate their account
    * coach/admin edits user account adding their email adress and sends activation email
    * skater gets and email with a link, that redirects them to page where they can set up account password
    * since then skater has full access to their account
  
// add screenshots

But they are still things that would be helpfull, for example: 
  * more freedom with editing rating systems (adding/changing ranges for skater status % skill evaluation)
  * more informations on evaluation: who added, when was it added, leaving additional feedback in form of comments
  
### Live preview

To see current preview [go here](https://rd-feedback-app.herokuapp.com/login)
login information: 
* coach user: coach@admin.com
* admin user: admin@admin.com
* password to both: "foobar"
feel free to check it out and play all the options

## Contact
Feel free to contact me: aga@gmail.com 
