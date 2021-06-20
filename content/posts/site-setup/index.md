---
weight: 3
title: "How to create a website using Hugo and GitHub Pages"
# subtitle: "A step-by-step tutorial of setting up my site"
date: 2021-06-19T16:03:42+02:00
lastmod: 2021-06-19T22:22:42+02:00
draft: false
author: "Jeroen Trimbach"
description: "A write-up/step-by-step tutorial of I have setup my site using Hugo with the uBlogger theme and hosted it on GitHub Pages."

page:
    theme: "wide"

upd: ""
authorComment: ""

tags: ["Blog","Setup","GitHub Pages"]
categories: ["Documentation"]

hiddenFromHomePage: false
hiddenFromSearch: false

#1000x500
resources:
- name: "featured-image"
  src: "featured-image.png"


#featuredImage: ""
#featuredImagePreview: ""
#images: [""]

toc:
  enable: true
math:
  enable: false

license: ""
---

A write-up/step-by-step tutorial of I have setup my site using Hugo with the uBlogger theme and hosted it on GitHub Pages.

<!--more-->

## Pre-Requisites

### Chocolatey

I have used chocolatey for installing all pre-reqs. If you are also interested in using a package manager and don't have Chocolatey installed yet you can do so by following the instructions on their website https://chocolatey.org/install.

Or you can just open PowerShell as Admin and run the following script:
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
 ```

### Hugo

Now lets put Chocolatey to use.. ;)

From Powershell run the following install command:
```powershell
choco install hugo-extended -confirm
```
The terminal should display a message saying that the installation was successful.
We can verify this by running the command:
```powershell
hugo version
```

### GIT

And again using chocolatey we can simply install git by running:
```powershell
choco install git
```

And once that is done we have everyting we need.
The following are optional requirements but I do suggest having a look at them.

### Optional

#### 1. Domain Name

The only cost we will have is having to buy a domain name.
Unless of course you are ok with your site ending with github.io.
We can always change this afterwards as well.

You can buy a domain at any domain registrar.
I bought my domain at Namecheap.

#### 2. GitHub Account

I am using GitHub pages to host my site. If you are interested in doing the same you should create a GitHub account if you don't already have one. They have a free plan available and the process is straight forward. Just go to their site to sign up.

#### 3. Visual Studio Code

I highly suggest using a code editor. My editor of choice is Visual Studio Code.

To install VS Code run:
```powershell
choco install vscode
```
And of course if you prefer a different editor yourself than you can use that one instead.

## Create a Hugo site

### 1. Create a site folder

Before we start let us create a directory in which our Hugo sites will be stored.
For this demo I will use create a Hugo folder on C:.
```PowerShell
cd C:\; mkdir Hugo | cd
```
The command below will create a new Hugo site in a folder named "sitefolder" in the current directory.
If you want it to be created in a different location then change your working directory to the desired location.
You can specify a name other than "sitefolder" by just replacing it to whatever you like.
```powershell
hugo new site sitefolder
```

### 2. Add a theme for your site

Before we can start deploying our site we need to pick a theme. There are a lot of which you can choose from https://themes.gohugo.io/. I am using the uBlogger theme (https://themes.gohugo.io/ublogger/).

Once you have found your theme you will have to install it.\ 
You can either download a zip file of the latest release of the theme and extract it in the themes directory, clone the themes GitHub repository to theme directory directly or create an empty git repository and make it a submodule of your site directory.

I went with the latter.

Now let's change directory to our new site folder, create an empty git repository and download and add our new theme as a subdirectory.\
We do this by running:
```powershell
cd sitefolder
git init
git submodule add https://github.com/upagge/uBlogger.git themes/uBlogger
```

Now that we have our theme we can add it as a default to our configuration file.\
In our sites directory we need to make some changes to the config.toml file to achieve this.
So open the file in VS Code:
```powershell
code .\config.toml
```

And add these settings to the site configuration:
```toml
# Default theme
Theme = "uBlogger"

[params]
	# uBlogger theme version
	Version = "2.0.X"
```

Save the config.toml file and open your terminal again.
From your site directory run:
```powershell
hugo serve
```
Once the build succeeds the web server will be available at http://localhost:1313/\
Open this site in your browser (ctrl + click in terminal to open).

It is empty as of now but this is what we got as of now.\
You can leave your terminal open and make changes to the config or any content files.\
Any changes made will immediately reflect on the page.

### 3. Some more theme changes

Our site as of now is still looking a bit empty.. time to change that.

First we will have to make some changes to the configuration.\
We can have a peak at the sample site of our theme which is listed in the exampleSite folder of our themes directory.\
But the uBlogger theme also has a default configuration in their documentation.
Which I am going to use for now.
```toml
baseURL = "http://example.org/"
# [en, zh-cn, fr, ...] determines default content language
defaultContentLanguage = "en"
# language code
languageCode = "en"
title = "My New Hugo Site"

# Change the default theme to be use when building the site with Hugo
theme = "uBlogger"

[params]
  # uBlogger theme version
  version = "2.0.X"

[menu]
  [[menu.main]]
    identifier = "posts"
    # you can add extra information before the name (HTML format is supported), such as icons
    pre = ""
    # you can add extra information after the name (HTML format is supported), such as icons
    post = ""
    name = "Posts"
    url = "/posts/"
    # title will be shown when you hover on this menu link
    title = ""
    weight = 1
  [[menu.main]]
    identifier = "tags"
    pre = ""
    post = ""
    name = "Tags"
    url = "/tags/"
    title = ""
    weight = 2
  [[menu.main]]
    identifier = "categories"
    pre = ""
    post = ""
    name = "Categories"
    url = "/categories/"
    title = ""
    weight = 3

# Markup related configuration in Hugo
[markup]
  # Syntax Highlighting (https://gohugo.io/content-management/syntax-highlighting)
  [markup.highlight]
    # false is a necessary configuration
    noClasses = false
```

Edit the config.toml file in our sites directory and paste this big chunk of config stuff in there.\
Before we start making more edits lets save the file and have a look at our site now.
http://localhost:1313/ in case you closed your browser.

Or if you have exit PowerShell run:
```powershell
hugo serve
```
keep it running.. it is nice to see what is happening.

Well, after changing the config we got a menu even a light/dark mode button. Neat!\
But.. our homepage is still looking empty. Time to config some more.

We are going to add onto our param section:
```toml
[params]
    # uBlogger theme version
    version = "2.0.X"
    # site default theme ("light", "dark", "auto")
    # defaultTheme = "auto"
    # public git repo url only then enableGitInfo is true
    # gitRepo = "https://github.com/upagge/dolboblog-theme"
    # which hash function used for SRI, when empty, no SRI is used ("sha256", "sha384", "sha512", "md5")
    fingerprint = ""
    # date format
    dateFormat = "02-01-2006"
    # website images for Open Graph and Twitter Cards
    # images = ["/logo.png"]
    # site description
    description = "About uBlogger Theme"
    # site keywords
    keywords = ["Theme", "Hugo"]
      # Search config
    #   [params.search]
    #     enable = true
    #     # type of search engine ("lunr", "algolia")
    #     type = "algolia"
    #     # max index length of the chunked content
    #     contentLength = 4000
    #     # placeholder of the search bar
    #     placeholder = ""
    #     # max number of results length
    #     maxResultLength = 10
    #     # snippet length of the result
    #     snippetLength = 30
    #     # HTML tag name of the highlight part in results
    #     highlightTag = "em"
    #     # whether to use the absolute URL based on the baseURL in search index
    #     absoluteURL = false
    #     [languages.en.params.search.algolia]
    #       index = "index.en"
    #       appID = "PASDMWALPK"
    #       searchKey = "b42948e51daaa93df92381c8e2ac0f93"
      # Home page config
      [params.home]
        # amount of RSS pages
        rss = 10
        # Home page profile
        [params.home.profile]
          enable = true
          # Gravatar Email for preferred avatar in home page
          gravatarEmail = ""
          # URL of avatar shown in home page
          avatarURL = "" #"/images/avatar.png"
          # title shown in home page (HTML format is supported)
          title = "uBlogger | Hugo Theme"
          # subtitle shown in home page (HTML format is supported)
          subtitle = "A Clean, Elegant but Advanced Hugo Theme"
          # whether to show social links
          social = true
          # disclaimer (HTML format is supported)
          disclaimer = ""
        # Home page posts
        [params.home.posts]
          enable = true
          # special amount of posts in each home posts page
          paginate = 6
      # Social config in home page
      # There is a lot more available! Check out the example site config.
      [params.social]
        GitHub = ""
        Linkedin = ""
        RSS = true
    # Header config
      [params.header]
        # desktop header mode ("fixed", "normal", "auto")
        # desktopMode = "fixed"
        # mobile header mode ("fixed", "normal", "auto")
        # mobileMode = "auto"
        # Header title config
        # [params.header.title]
            # URL of the LOGO
            # logo = ""
            # title name
            # name = "uBlogger"
            # you can add extra information before the name (HTML format is supported), such as icons
            # pre = "<i class='fas fa-pencil-alt fa-fw'></i>"
            # you can add extra information after the name (HTML format is supported), such as icons
            # post = ""
        # Footer config
        [params.footer]
            enable = true
            # Custom content (HTML format is supported)
            custom = ''
            # whether to show Hugo and theme info
            hugo = true
            # whether to show copyright info
            copyright = true
            # whether to show the author
            # 是否显示作者
            author = true
            # site creation time
            since = 2021
            # ICP info only in China (HTML format is supported)
            # icp = ""
            # license info (HTML format is supported)
            license= '<a rel="license external nofollow noopener noreffer" href="https://creativecommons.org/licenses/by-nc/4.0/" target="_blank">CC BY-NC 4.0</a>'
        # Section (all posts) page config
        [params.section]
            # special amount of posts in each section page
            paginate = 20
            # date format (month and day)
            dateFormat = "02-01"
            # amount of RSS pages
            rss = 10
        # List (category or tag) page config
        [params.list]
            # special amount of posts in each list page
            paginate = 20
            # date format (month and day)
            dateFormat = "02-01"
            # amount of RSS pages
            rss = 10
```
Edit wherever required. Maybe uncomment or comment something.\
There is a lot of tweaking you can do and whilst you keep your site running locally you can see the impact on the fly.

I am still playing with the config myself so for now I will leave this section here.\
But definitely try it out yourself.

If you hadn't noticed already the posts page is missing.\
Well.. we haven't created a post yet. Time for another mission! 


### 4. Let's create a post

To create a new post we can simple run the new command from our sites directory.\
Make sure to specify the posts folder when you are creating a post.

```powershell
# Creating a post can be done using the new command
hugo new posts/site-setup.md

# Let's have a check and see what that did
code .\content\posts\site-setup.md
```

Note that the content displayed is configured by the default.md file located in the archetypes folder.\
We can create a pre-configured post by replacing it with our themes default.md file located in /theme/uBlogger/archetypes.

For now lets just edit the title of our post, set draft to false and write some sample text below the last "---".\
Once you have done that save the file.

What are you waiting for? Check out your site :)

## Hosting your site (on GitHub)

I hope by now the process of creating and tweaking your site.\
Now it is time to share our creation with others.

### 1. Build the static pages

First we will have to build the static pages.\
We can achieve this by running the command:
```powershell
hugo
# or if you want to include draft posts:
hugo -D
```
Your output will be in the public directory of your site.

### 2. Create your site's GitHub repository

Sign in to your GitHub account and click on "Create a new repository".\
In order to host your generated content you must use a repo name of the following format:

> YOURUSERNAME.github.io

Also if you are using a free account make sure to leave the repository Public.
All other boxes can be left unchecked.

### 3. Push our site's static pages to our repo

Back on our local machine.
Make sure your working directory is the public directory.
From there run the following:
```powershell
git init
git add .
git remote add origin https://github.com/YOURUSERNAME/YOURUSERNAME.github.io.git
git commit -m "commit"
git push origin master
```
Once completed go back to your GitHub repository.\
Your files are now stored in your repository and your site should display by following the link http://YOURUSERNAME.github.io

### 4. Add your own domain name

#### @ GitHub

Go to the settings of your repository. On the sidebar click the 'Pages' button.\
Under 'custom domain' specify your own domain name (e.g. www.jeroentrimbach.com) and click save.\
A file with the name CNAME will be created in your repository with your specified domain name as its content.

#### @ your Domain Registrar

This may differ per Domain Registrar but the process shouldn't be too difficult.

Log in to your domain registrar's account manager, select your domain name and go to the DNS settings.\
Create a CNAME record that points your domain name to your github.io site.

It will show like this:

|Type|Host|Value|TTL|
|:--|:--:|:--:|--:|
|CNAME|www|jeroen-t.github.io|automatic|

#### @ GitHub

Go back to the settings of your sites repository and go to back to where you added your custom domain.\
After a while your validation will pass.\
Optionally you can also enforce HTTPS for your site but it may take a while before you can check that box.\
You can come back later to do this.

### 5. Pull the CNAME file to your site locally

From your local machine make sure the working directory is the public folder.\
We are now going to pull the CNAME file that we created in GitHub to make sure it is included in future builds.
```powershell
git pull origin master
```

## Basic flow for writing and publishing a new post

So now we have our site hosted on GitHub pages and we are able to access it through our own custom domain. Sweet! 😍

But what if we want to publish new content?

We have learned how to create a new post.
```powershell
# set site as working directory
cd sitefolder
# create a new hugo post
hugo new posts\new-post.md
# edit your post in vs code
code .\content\posts\new-post.md
# and save..
# check locally if we achieved the desired result
hugo serve
# open http://localhost:1313/ in your browser
# ctrl + C to exit
```

When we are happy with our newly created content then we can build the static pages using the hugo command.\
Followed by pushing our static pages in the public folder to our GitHub repo.
```powershell
# build static pages
hugo
# or if including drafts: hugo -D
# change the to the public directory
cd ./public
git add .
git commit -m "commit"
git push origin master
```

That's it! Now if we refresh our site it should contain the newly created content.

Have fun! 👍