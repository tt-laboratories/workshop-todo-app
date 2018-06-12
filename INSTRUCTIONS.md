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

#### Create task controller with new action

Create a file `app/controllers/tasks_controller.rb`.

```ruby
class TasksController < ApplicationController
  def new
  end
end
```

#### Create a task form

Prepare task variable:

```ruby
  def new
    @task = Task.new
  end
```

Create a file `app/views/tasks/new.html.erb`:

```html
<%= form_for(@task) do |f| %>
    <%= f.label :title %>
    <%= f.text_field :title %>
    
    <%= f.label :note %>
    <%= f.text_area :note %>
    
    <%= f.submit %>
<% end %>
```

#### Create a create action

```ruby
class TasksController < ApplicationController
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.create(task_params)
    redirect_to tasks_path
  end
  
private
  
  def task_params
    params.require(:task).permit(:title, :note)
  end
end
```

#### Create a task index

Add index action to tasks controller:

```ruby
  def index
    @tasks = Task.all
  end
```

Create an index view in `app/views/index.html.erb`:

```html
<table>
    <tr>
        <td>Title</td>
        <td>Note</td>
        <td>Completed</td>
    </tr>
    <% @tasks.each do |task| %>
        <tr>
            <td><%= task.title %></td>
            <td><%= task.note %></td>
            <td><%= task.completed %></td>
        </tr>
    <% end %>
</table>
```

#### Open application layout

Open `/views/layouts/application.html.erb`
