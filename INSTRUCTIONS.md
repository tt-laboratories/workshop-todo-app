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

Check what has been created by the generator (router, controller, database.yml, Gemfile, ...).

### Go into created app-directory

```
$ cd <app_name>
```

### Install required packages

```
$ bundle install
```

### Run server

When using codenvy:

- Click the play-icon in the menu-bar and select `run`
- Then run-tab will show you a preview-url which returns the app

If are using rails in your command line

- Type `rails server`
- Visit `http://localhost:3000` in your browser

## Build The App

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

We will create the following MVC components:

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
    @task = Task.new
  end
end
```

#### Create a task form

Create a view in `app/views/tasks/new.html.erb`:

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

Update the tasks controller:

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
    <thead>
        <tr>
            <th>Title</th>
            <th>Note</th>
            <th>Completed</th>
        </tr>
    </thead>
    <tbody>
        <% @tasks.each do |task| %>
            <tr>
                <td><%= task.title %></td>
                <td><%= task.note.truncate(20) %></td>
                <td><%= task.completed %></td>
            </tr>
        <% end %>
    </tbody>
</table>
``

### Make it pretty

#### Use Bootstrap

Add bootstrap gem to `Gemfile`:

```
gem 'bootstrap', '~> 4.1.1'
```

Install newly added packages:

```
$ bundle install
```

Rename `app/assets/stylesheets/application.css` to `app/assets/stylesheets/application.scss`

Import bootstrap in `application.scss`:

```
@import "bootstrap";
```

Restart server.

##### Style tasks index view:

```html
<table class="table table-bordered table-striped table-hover">
    <thead class="thead-light">
        <tr>
            <th>Title</th>
            <th>Note</th>
            <th>Completed</th>
        </tr>
    </thead>
    <tbody>
        <% @tasks.each do |task| %>
            <tr>
                <td><strong><%= task.title %></strong></td>
                <td><%= task.note.truncate(20) %></td>
                <td><%= task.completed %></td>
            </tr>
        <% end %>
    </tbody>
</table>
```

#### Update application layout

```html
<!DOCTYPE html>
<html>
  <head>
    <title>WorkshopTodoApp</title>
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <div class="container">
        <div class="jumbotron">
            <h1>Todo-App
                <small>Tutorial application</small>
            </h1>
        </div>
        
        <%= yield %>
    </div>
  </body>
</html>
```

#### Add button to create a task

Update `application.html.erb`:

```html
<div class="container">
    <div class="jumbotron">
        <h1>Todo-App
            <small>Tutorial application</small>
        </h1>
        <%= link_to 'New task', new_task_path, class: 'btn btn-primary' %>
    </div>

    <%= yield %>
</div>
```

#### Make form pretty

Add simple_form to Gemfile

```
gem 'simple_form'
```

Install and initialize simple-form:

```
$ bundle install
$ rails generate simple_form:install --bootstrap
```

Update `app/views/tasks/new.html.erb`

```html
<%= simple_form_for(@task, wrapper: :horizontal_form) do |f| %>
    <%= f.input :title %>
    
    <%= f.input :note %>
    
    <%= f.button :submit, class: 'btn btn-primary'%>
<%end%>
```

#### Set index as root path

Add the following root definition to the `config/routes.rb`

```
root to: 'tasks#index'
```

### Task show
step-4 

Add link to Task show view in `app/views/tasks/index.html.erb`
```html
<td><strong><%= link_to(task.title, task)%></strong></td>
```

add show action to `TasksController.rb`
```ruby
def show
  @task = Task.find(params[:id])
end
```

add show template `app/views/tasks/show.html.erb` (new file)
```html
<h2>Task:</h2>

<h2><%= @task.title %></h2>
<p><%= @task.note %></p>
<%= @task.completed %>

<%= link_to('Back', tasks_path) %>
```

### Tasks#destroy
add destroy button to task `app/views/tasks/show.html.erb`
```html
<%= link_to('Delete', task_path(@task), method: :delete, data: {confirm: 'are you sure'}) %>
```

add destroy action to TasksController:
```ruby
def destroy
  @task = Task.find(params[:id])
  @task.destroy
  redirect_to tasks_path
end
```

### Tasks#edit
add **edit** button to `app/views/tasks/show.html.erb`
```html
<%= link_to('Edit', edit_task_path(@task)) %>
```

add edit action to TaskController:

```ruby
def edit
  @task = Task.find(params[:id])
end
```
extract form into its own partial `app/views/tasks/_form.html.erb`
```html
<%= simple_form_for(@task, wrapper: :horizontal_form) do |f| %>
    <%= f.input :title %>

    <%= f.input :note %>

    <%= f.button :submit, class: 'btn btn-primary'%>
<%end%>
```

add edit view `app/views/tasks/edit.html.erb`
```html
<h2>Edit task</h2>
<%= render partial: 'form' %>
```

use the new partial in tasks#new `app/views/tasks/new.html.erb'
```html
<h2>Add a new task</h2>
<%= render partial: 'form' %>
```

add update action to TasksController
```ruby
def update
  @task = Task.find(params[:id])
  @task.update(task_params)
  redirect_to @task
end
```

### Task complete
add route `config/routes.rb`
```ruby
Rails.application.routes.draw do
  resources :tasks do
    member do
      patch :toggle_complete
    end
  end
end

```

add Buttons into `app/views/tasks/index.html.erb`
```html
<% if task.completed? %>
  <td><%= link_to('Uncomplete', toggle_complete_task_path(task, completed: false), method: :patch)%></td>
<% else %>
  <td><%= link_to('Complete', toggle_complete_task_path(task, completed: true), method: :patch)%></td>
<% end %>
```
add toggle_complete action to TasksController:

```ruby
def toggle_complete
  @task = Task.find(params[:id])
  if params[:completed] == 'true'
    @task.completed = Time.now
  else
    @task.completed = nil
  end
  @task.save
  redirect_to tasks_path
end
```
