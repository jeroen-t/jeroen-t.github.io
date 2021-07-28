---
title: "Lets create a PowerShell Module and publish it to the PSGallery using GitHub Actions!"
subtitle: "A step-by-step tutorial on how to create a PowerShell Module and publish it to the PSGallery by using GitHub Actions"
date: 2021-07-28T19:06:05+02:00
lastmod: 2021-07-28T19:06:05+02:00
draft: false
author: "Jeroen Trimbach"
description: "A step-by-step tutorial on how to create a PowerShell Module and publish it to the PSGallery by using GitHub Actions"
weight: 1

page:
    theme: "wide"

upd: ""
authorComment: ""

tags: ["Blog","PowerShell","Module","GitHub Actions","YAML","CICD"]
# ,"Azure","Bicep","ARM","Templates"
categories: ["Documentation","Learning"]

hiddenFromHomePage: false
hiddenFromSearch: false

resources:
- name: "featured-image"
  src: "featured-image.png"
# - name: featured-image-preview
#   src: featured-image-preview.jpg

# featuredImage: ""
# featuredImagePreview: ""
# images: [""]

toc:
  enable: true
math:
  enable: false

license: ""
---

A step-by-step tutorial on how to create a PowerShell Module and publish it to the PSGallery by using GitHub Actions

<!--more-->

You might be like me. Use PowerShell daily. Oneliners most of the time. For more advanced tasks you write a script and perhaps schedule those by using Task Scheduler, the SQL Server Agent or something similar. But creating a PowerShell module? Publishing it to the PowerShellGallery? Crazy!

I'm by no means an expert but I got it working. So if you are interested then try to follow along. You might learn something new. I sure did! 😎
## Prerequisites

### GitHub Account

I'm hosting the source code of my module in a Git repository on GitHub. If you are interested in doing the same you should create a GitHub account if you don't already have one. They have a free plan available and the process is straight forward. Just go to their [site](https://github.com/) to sign up.

### Git in PowerShell

The posh-git package that provides integration between Git and PowerShell. It will display Git status summary information in your PowerShell prompt and provides support for tab completion when working with Git commands, branches, paths, etc. I want it 🤗

Follow the process as described on their [site](https://git-scm.com/book/en/v2/Appendix-A%3A-Git-in-Other-Environments-Git-in-PowerShell) on how to install it.

### Pester

Pester is available on Windows 10 or later by default.\
You can check whether you have this module installed by running:
```powershell
Get-Module Pester -ListAvailable
```
The 3.4.0 version ships as part of Windows 10 and is a bit problematic. To avoid headaches I would suggest updating it right away. Unfortunately updating the module using the Update-Module cmdlet won't work. So you will have to install the latest version of Pester side-by-side using the follow tactic. Open PowerShell as Admin and run the following command:

```powershell
Install-Module -Name Pester -Force -SkipPublisherCheck
```
Now if you run the following command again:
```powershell
Get-Module Pester -ListAvailable
```
It will display both the shipping and the latest version of Pester.

### (Optional) Visual Studio code

I highly suggest using a code editor. My editor of choice is Visual Studio Code.

To install VS Code run:
```powershell
winget install Microsoft.VisualStudioCode
```

{{< admonition type=tip title="the winget tool" open=false >}}
The winget tool is the client interface to the Windows Package Manager service. You can use it to search for and/or install applications. It also has some other commands in store that allow you to display installed packages, export/import, validate and a bunch of more useful stuff. Once you have it installed simply run `winget` to see all commands that are available. You can read more about winget [here](https://docs.microsoft.com/en-us/windows/package-manager/winget/)
{{< /admonition>}}

And of course if you prefer a different editor yourself than you can use that one instead.

## Prepare your Git repository

I hope you have read through the prerequisites and signed up for GitHub because [GitHub](https://github.com/) is where we start.
We are going to set up the Git repository (repo) for our module.

Click on your profile in the top right of the page. A menu will open. Click on `Your repositories`. We are going to create a new repository so click on `New`.

Provide a meaningful name for your repository. I provided the name of the module I created.
Optionally you can give a description for you repository as well.

Another decision you will have to make is whether you want your repository publicly visible or not. Set your repo to either:
* Public: Anyone on the internet can see this repository. You choose who can commit.
* Private: You choose who can see and commit to this repository.

You can always change this in the settings of your repository later as well.

Additionaly you can select whether you want to initialize your repository with a README file, a .gitignore file and a license.

Once you have provided all the necessary information press the button `Create repository` at the bottom of the page.

Congrats on your Repo!

Now go back to the page that lists all your repositories and open the repository that you have just created. There should be a green button named `Code`. Press that button and copy the provided URL. Open PowerShell on your machine and browse to your working folder. For this example I am using my home directory.

```powershell
cd $home
```
clone your Repository by running the following command:
```powershell
git clone https://github.com/<username>/<repository>.git
```
replace the URL with the one you have copied earlier. Or just replace the tokens with your own details.

There you go! You have your repository locally now. Awesome! I think? A bit empty though..? Hmm, lets work on that!

## Prepare your PowerShell repository

// describe what it will look like

e.g.
* design patterns / folder structure
* run Tree utility to show what mine looks like
* describe what comes later. E.g. .Github workflow, maybe .vscode/.devcontainer? (or out of scope?)

First we will have to think about how we design our repository. We want an ordered folder structure. I have looked at what others have done and most of them have a similar structure as the one that I have used below.

{{< admonition type=tip title="the tree command" open=false >}}
The tree command displays the directory structure of a path or of the disk in a drive graphically. It's a very useful tool to quickly get a grasp on how the folder structure is.

Read more about this command [here](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/tree)

For the example below I ran the command: `tree . /F`. Where . is the current directory I'm in and /F to display files as well.
{{< /admonition>}}

In the root of the repository I have a README and License file. The README file is an important part of your repository. Actually, mine should get some love! 😅

The `.github` and `build_scripts` folders can be ignored for now. We will cover this later once we start working on our pipeline.

For now create a directory with the name of your module. This is where we are going to create our module and manifest files for our PowerShell moduule. Within the directory we just created, create another folder with the name `functions`. This is where we are going to place all our functions.

```
JTAZ
│   LICENSE
│   README.md
│   Unit.Tests.xml
│
├───.github
│   └───workflows
│           main.yml
│
├───build_scripts
│       build.ps1
│
└───jtAz
    │   jtAz.psd1
    │   jtAz.psm1
    │   jtAz.Test.ps1
    │
    └───functions
            Get-jtAzProviderNamespace.ps1
            Get-jtAzResourceTypes.ps1
            Get-jtAzTemplate.ps1
```

Now that we have a skeleton of our PowerShell repository lets commit and push these changes to our repository on GitHub. To do this run the commands:

```powershell
git add .
git commit -m "first commit"
git push origin main
```

Now if you check your repository on GitHub your code will be there as well.

>>> Uh oh - this looks a bit empty. I am planning to work on that.

## A sample function

// either create a sample function or just show my own code

tbd

## A sample module

// either create a sample function or just show my own code

tbd

## The manifest file

// either create a sample function or just show my own code

tbd

## Running Pester tests

// simple tests

tbd

## PowerShellGallery

// PSGallery manual stuff

* Account creation
* API Key
* NuGet package

## Build script / Pipeline / Actions

* prepare build
* yaml stuff
* tasks
* don't forget secret!

## Conclusion

* summary of what we have done/learned
* what can be done next

If you want to learn more about PowerShell then I highly recommend reading through the two books that I have mentioned below. The books are very well written and I have learned a lot from them. Whenever I want to do something in PowerShell but not sure what the correct approach is I try to search in those books first. I will pick up something new most of the times as well.

  * Learn PowerShell in a Month of Lunches - Don Jones, Jeffery Hicks
  * Learn PowerShell Scripting in a Month of Lunches - Don Jones, Jeffery Hicks
