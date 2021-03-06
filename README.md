# Emerald Framework

[![Code Climate](https://codeclimate.com/github/EdDeAlmeidaJr/emeraldfw21/badges/gpa.svg)](https://codeclimate.com/github/EdDeAlmeidaJr/emeraldfw21)     [![Build Status](https://travis-ci.org/EdDeAlmeidaJr/emeraldfw21.svg?branch=master)](https://travis-ci.org/EdDeAlmeidaJr/emeraldfw21)     [![Test Coverage](https://codeclimate.com/github/EdDeAlmeidaJr/emeraldfw21/badges/coverage.svg)](https://codeclimate.com/github/EdDeAlmeidaJr/emeraldfw21/coverage)

Emerald Frameework is a full-stack web development framework designed for the strong!

Emerald Framework, among other things:

- Enforces good programming practices;
- Privileges convention over configuration;
- Completely separates code and UI;
- Allows the developers to choose the language they want to code;
- Allows the insertion of new languages;
- Creates Rack application which may be configured to use all Rack features; and,
- Integrates development with many useful services in the web, like Trello and SandCage.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'emeraldfw'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install emeraldfw

## Usage

### Basics

Emerald is based in some 'entities'. There are six of them by now.

**(A) Project** =>  A project is an Emerald application.

**(a.1)** In order to create a new Emerald application:

```bash
$ emeraldfw project create <your_project_name>
```

**IMPORTANT:** Emerald apps are created at `ENV['HOME']/emeraldfw/` directory. It is impossible to change this right now, but in future versions this location will be dictated by the user.

**(a.2)** To see a list of all Emerald applications in your workspace:

```bash
$ emeraldfw project list
```

**(a.3)** To remove an Emerald application from your workspace:

```bash
$ emerald project remove <your_project_name>
```

**IMPORTANT:** This action can't be undone. Be sure to have a backup if you use it, and be sure to use it against the correct project. We assume you are intelligent and smart enough o avoid erasing an important project and we won't treat you like Windows do, asking a many times if you are sure. So, be sure!

**(a.4)** To set the current project for anonymous actions (those who have effect on a project without specifying its name):

```bash
$ emerald project current <your_project_name>
```

**IMPORTANT:** When you create a project it turns out to be the current project.

**(a.5)** To add an email to receive notifications about changes in the current project:

```bash
$ emerald project notify <email_address>
```

**(a.6)** To remove an email from the notifications list:

```bash
$ emerald project unnotify <email_address>
```


**(B) Template**

One may insert web pages into a container. They may be inserted inside the <body></body> tag or in any container with an ID. When you create a new project it comes with with a template named 'default.html', which is at `ENV['HOME']/emeraldfw/your_app/web/views/templates`. Templates are pure HTML/Javascript. No special tags, no meta language... no bullshit. Pure HTML/Javascript.

**(b.1)** To create a template:

```bash
$ emeraldfw template create <template_name>
```

**(b.2)** To delete a template:

```bash
$ emeraldfw template remove <template_name>
```

- **Page**

A page is also piece of HTML code. It may contain invocations to many components and it is inserted at runtime into a template. Pages are stored at `ENV['HOME']/emeraldfw/your_app/web/views/pages`, and they are also pure HTML/Javascript.

To create a page:

```bash
$ emeraldfw page create <page_name>
```

To delete a page:

```bash
$ emeraldfw page remove <page_name>
```

- **Component**

A component is a piece of code which is inserted in a HTML container of your page. Emerald is based on components.

To create a component:

```bash
$ emeraldfw create component <component_name> [-R] [-A]
```
where:
      **-R** stands for remote, a component whose contents are outside app domain. If this flag is ommited, the request to get the component content will be to the application itself.
      **-A** stands for API, a component whose content is dynamic. If this flag is ommited the request will be for a static piece of HTML/Javascript code.

To delete a component:

```bash
$ emeraldfw delete component <component_name>
```

- **Resource**

Media is any image, video, sound, font or anything else you use to exhibit in your pages/templates.

You don't choose where Emerald Framework will put these files. It does this for you.

To add some media file to your app, just do:

```bash
$ emeraldfw resource create <path/to/the/media_file> [ --rlibrary | -r <resource_library_name>]
```

To remove some media file from your app:

```bash
$ emeraldfw resource remove <path/to/the/media_file> [ --rlibrary | -r <resource_library_name>]
```

- **Library**

Libraries like [**jQuery**](https://jquery.com/) and [**Bootstrap**](http://getbootstrap.com/) may be easily added to your app. 

(In fact, these two are already installed when you start a new project!)

Libraries are downloaded directly from Emerald Framework's Github page, where they are stores as **-ef** packeages, adapted to the standards of an Emerald application.

To add a library to your app, do:

```bash
$ emeraldfw add library <library_name>
```

To remove a library:

```bash
$ emeraldfw remove library <library_name>
```

### Advanced

Visit [our homepage](http://emeraldframework.herokuapp.com) to learn more about Emerald Framework's advanced features.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

If you want to be part of out [core team](), feel free to send a message to emerald.framework@gmail.com, telling us about you, your skills, the part of Emerald Framework you want to deal with and why do you think you can make it better.

But before doing this, please take sometime to read our [Code of Conduct](https://github.com/EmeraldFramework/emeraldfw/blob/master/doc/code_of_conduct.md) and see if you agree with it. Our Code of Conduct is very simple and short. And it is not negotiable. 

Bug reports and pull requests are welcome on GitHub at [our Github page](https://github.com/EmeraldFramework/emeraldfw).

## License

The gem is available as Open Source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

