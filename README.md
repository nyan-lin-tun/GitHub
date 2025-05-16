# GitHub

# Environments/Production.xcconfig

This README explains how to create and configure a `Production.xcconfig` file in Xcode and place it under the **Environments** folder.

---

## 1. Add `Production.xcconfig`

1. Right-click on the **Environments** group.
2. Choose **New File from Template...**.
3. Under **iOS**, select **Other > Configuration Settings File** and click **Next**.
4. Name the file **Production.xcconfig** and ensure it is created inside the **Environments** folder. (No need to select any target)
5. Click **Create**.

## 2. Define Variables in `Production.xcconfig`

Within `Production.xcconfig`, you can override any build setting. For example:

```xcconfig
// Github OAuth token
APP_TOKEN = <YOUR TOKEN>
```

Variables defined here will apply only to the **Production** build and don't need to add `"`, `<` and `>`.

---

That’s it! You now have a dedicated `Production.xcconfig` file in your **Environments** folder to manage production-specific build settings separately from other environments.

## Features

- [x] GitHub user list
- [x] GitHub user detail

## How to run 
- Open terminal
- Enter command `cd ~/path/to/project`
- Enter command `xed .`