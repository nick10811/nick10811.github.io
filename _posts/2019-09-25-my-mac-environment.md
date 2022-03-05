---
layout: post
title: My Mac environment
date: '2019-09-25'
author: Nick Yang
tags:
- Linux
- macOS
- Git
---


I know that every software engineer has a development environment that he is favorited. This article records all my Mac environment in order to set up faster when I change the computer in the future.

## Basic on the Mac

### [Home-brew](https://brew.sh/)

Every Mac lover may know this package management tool. This is my first installation when I begin to use a new Mac.

```bash
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### [Wget](https://www.gnu.org/software/wget/wget.html)

This is a powerful open-source software which I recommend you to install it. When you are a terminal passionate, you cannot miss this tool. I almost use it to download digital contents.

```bash
$ brew install wget
```

### [Nmap](https://nmap.org/)

As a computer security researcher, I always do something over the network. Hence, I need it. hmm…

```bash
$ brew install nmap
```

## Building Development Environment

### [Xcode](https://apps.apple.com/tw/app/xcode/id497799835?mt=12)

It can be downloaded from the AppStore. But I recommend you download it through the [developer website](https://developer.apple.com/download/all/?q=Xcode), that is faster than the AppStore.

### [SF Symbols](https://developer.apple.com/sf-symbols/)

To search the system icon name in the iOS.

### [Git](https://git-scm.com/)

```bash
$ brew install git
```

Well, sometimes view the git graph in the terminal is very ugly. So I recommend you to use some GUI tool to assistant you. Such as **[SouceTree](https://www.sourcetreeapp.com/)** is a great visual tool. But now, I try **[Fork](https://git-fork.com/)**, which is light and has a simple view.

### Package management in the Xcode project

As an iOS developer, I used a lot of third-party libraries. There is two most popular management tool you can choose. But it almost depends on your team’s choice.

### [CocoaPods](https://cocoapods.org/)

```bash
$ gem install cocoapods -v 1.7.1
$ pod setup
```

### [Carthage](https://github.com/Carthage/Carthage)

```bash
$ brew install carthage
```

## Must have tools

### Browser

**Safari** is my main browser, but I will switch to **[Chrome](https://www.google.com.tw/chrome/browser/desktop/index.html)** for certain development requirements.

### Chat software

Most startups choose **[Slack](https://slack.com/)** as their communication tool. However, many Taiwanese companies are still using **[Skype](https://www.skype.com/)**. I used **[Telegram](https://telegram.org/)**, messages are encrypted, when I was in a gambling company. And I use **[Line](https://line.me/)** with my friends. However, it is annoying when I need to install individually thoes applications. **[Rambox](https://rambox.app)** is an all-in-one message center. Unfortunately, it begins to charge. But you can also install previous version [0.7.9](https://github.com/ramboxapp/community-edition/releases/tag/0.7.9). 

### Editor

Currently, I prefer to use **[Visual Studio Code](https://code.visualstudio.com/)** which is made by Microsoft. You can install many extensions to enhance its features. I used to **[Sublime Text 2](https://www.sublimetext.com/)** which is similar but it is not free.

## Optional

### Design

In the past, many developer communicate with designer via [Zeplin](https://zeplin.io/). But now, [Figma](https://www.figma.com/) is an alternative. It is free, and let you make an easy design by yourself.

### Network

#### [Proxyman](https://proxyman.io/)

It enables develoepr to capture, inspect, and manipulate HTTP(s) request and response structures.

## Online tools

Some simple requirement you can use the online tool to solve it.

### [JSON Editor Online](http://jsoneditoronline.org/)

It is a web-based tool to view, edit, format, and validate JSON

### [WTF Auto layout?](https://www.wtfautolayout.com/)

UI bugs are not easy to understand on the Xcode’s console. This tool can convert constraint error log to the easy way.

### [Screen Sizes](https://www.screensizes.app/)

You can find all of the screen sizes among Apple ecosystems.

### [iOS and iPadOS usage](https://developer.apple.com/support/app-store/)

As an iOS developer, you need to know users' usage.

### [Swagger Editor](https://editor.swagger.io/)

I very recommend your team to edit the API document via Swagger. It has a clear interface to understand each API action and It can post API just like [Postman](https://www.getpostman.com/). I think it is powerful than Postman.

Finally, I know there are many useful tools so that you have a lot of installation steps. In order to reduce installation steps, I write a shell script ([mac\_setup.sh](https://gist.github.com/nick10811/15e3eaf022c5bcf9ea6710caf9f5149d)) to automatically install all tools which I mentioned above. Please feel free to use it and edit it to fit your demands. You can also leave your comments to introduce other awesome tools which I’m not used.

​