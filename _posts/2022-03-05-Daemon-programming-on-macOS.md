---
layout: post
title: 'Daemon programming on macOS'
date: '2022-03-05'
author: Nick Yang
tags:
- daemon
- launchd
- macOS
- crontab
---

In the development, sometimes we need to run certain services in the background. In macOS, it provides `launchd` to help you run services in the background. There are two separate session contexts, startup and login.

![sessions](/public/daemon_programming/lanchd_sessions.png)

## Type of Background Processes

Here, we only brief two common types. But there are [four types](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/DesigningDaemons.html#//apple_ref/doc/uid/10000172i-SW4-SW9) in fact.

- LaunchDaemon

Daemons are managed by `launchd` and performed while the system start. After setup, you should restart the Mac.

- LaunchAgent

Agents are managed by `launchd`, but only performed by the currently logged-in user. After setup, it will auto-run when you login.

## The `launchd` startup process

- Starup Session

After macOS is booted and the kernel is running, `launchd` is run to finish the system initialization.

1. It loads parameters from the property list files found in `/System/Library/LaunchDaemons` and `/Library/LaunchDaemons`.
2. It registers sockets and file descriptions requested by those daemons.
3. It launches daemons that requested to be running all the time.

- Login Session

When a user login, `launchd` is run on the second session. The steps as the startup session.

1. It loads parameters from the property list files found in `/System/Library/LaunchAgents` and `/Library/LaunchAgents`.
2. It registers sockets and file descriptions requested by those agents.
3. It launches agents that requested to be running all the time.

## Creating a `launchd` Property List File

To run `launchd`, you must create a `.plist` file to describe the behaviors for those daemons or agents. We put those into `/Library/*`, instead of under the system-level path, `/System/*`. Those property list files are placed under the corresponding path. The `.plist` describing daemons are installed in `/Library/LaunchDaemons`, and those describing agents are installed in `/Library/LaunchAgents`.

- Common Keys

| Key | Description |
| --- | --- |
| Label | unique string that identifiers your daemon (required) |
| ProgramArguments | contains the arguments used to launch your daemon. (required) |
| KeepAlive | specifies whether daemon always be running |
| RunAtLoad | whether your job is launched once at the time the job is loaded (default is false) |
| EnvironmentVariables | specify additional environmental variables to be set before running the job |
| UserName | specifies the user to run the job |
| WorkingDirectory | specifies a directory |

> 💡 type `$ man launchd.plist` in the terminal to read complete information.

This is a sample daemon that is automatically running the [gitlab-runner](https://docs.gitlab.com/runner/) after the system is booted. I made a file named `homebrew.mxcl.gitlab-runner.plist`and placed it  under `/Library/LaunchDaemons/` You can find more examples on the [Official documents](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html#//apple_ref/doc/uid/10000172i-SW7-SW3).

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>homebrew.mxcl.gitlab-runner</string>
  <key>ProgramArguments</key>
  <array>
    <string>/opt/homebrew/opt/gitlab-runner/bin/gitlab-runner</string>
    <string>--log-format=json</string>
    <string>--log-level=debug</string>
    <string>run</string>
  </array>
  <key>KeepAlive</key>
  <true/>
  <key>RunAtLoad</key>
  <true/>
  <key>EnvironmentVariables</key>
  <dict>
    <key>PATH</key>
    <string>/opt/homebrew/bin:/opt/homebrew/sbin:/usr/bin:/bin:/usr/sbin:/sbin</string>
  </dict>
  <key>UserName</key>
  <string>devops</string>
  <key>WorkingDirectory</key>
  <string>/Users/devops</string>
  <key>LegacyTimers</key>
  <true/>
  <key>StandardOutPath</key>
  <string>/Users/devops/logs/gitlab-runner.log</string>
  <key>StandardErrorPath</key>
  <string>/Users/devops/logs/gitlab-runner.log</string>
</dict>
</plist>
```

## Scheduling Timed Jobs

In Linux, you can run a background job on a timed schedule by `crontab`. You can read my previous article, [How to make a schedule to clean logs on Linux ?](https://nick10811.github.io/2016/05/09/how-to-make-schedule-to-clean-logs-on/). Despite you can still use it on macOS. However, the official recommends we adopt `launchd` instead. Here is the sample plist file.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.example.happybirthday</string>
    <key>ProgramArguments</key>
    <array>
        <string>happybirthday</string>
    </array>
    <key>StartCalendarInterval</key>
    <dict>
        <key>Day</key>
        <integer>11</integer>
        <key>Hour</key>
        <integer>0</integer>
        <key>Minute</key>
        <integer>0</integer>
        <key>Month</key>
        <integer>7</integer>
        <key>Weekday</key>
        <integer>0</integer>
    </dict>
</dict>
</plist>
```

## References

- [https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/Introduction.html#//apple_ref/doc/uid/10000172i-SW1-SW1](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/Introduction.html#//apple_ref/doc/uid/10000172i-SW1-SW1)