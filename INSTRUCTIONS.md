# Tutorial instructions
## Setup

### Update Rails to newest version

```
$ gem install rails
```

### Create new app

```
$ rails new <app_name>
```

### Go into created app-directory

```
$ cd <app_name>
```

### Install required packages

```
$ bundle install
```

### Run server
Click the play-icon in the menu-bar and select `run`. The run-tab will show you a preview-url which returns the app.



### Create task model

```
$ rails generate model Task title:string note:text completed:date
```

### Run database migration

```
$ rake db:migrate
```
