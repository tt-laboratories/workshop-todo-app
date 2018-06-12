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
$ rails db:migrate
```

### Create a create action

#### Steps

- Route to the form
- Create action
- View

#### Route for task resources

Add routes for the task resource to `config/routes.rb`

```
resources :tasks
```

List all available routes of the application

```
$ rails routes
```

#### Create task controller

Create a file `app/controllers/tasks_controller.rb`.

```ruby
class TasksController < ApplicationController
  def new
  end
end
```

#### Open application layout

Open `/views/layouts/application.html.erb`
