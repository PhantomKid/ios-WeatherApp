#  简化版天气预报App项目
**该项目使用cocoapods对工程进行集成，图片使用开源库SDWebImage下载。天气接口采用的是和风天气免费的开发版API，项目练习使用了TabbarController、TableView等各种控件以及网络请求,json字符串反序列化与本地数据存储**

## 项目进度
1. [x] 天气预报功能
2. [x] 城市选择功能+自动定位功能
3. [x] 包含日期、温度、气压、风向、风力和风速以及各种舒适度指数等信息
4. [ ] 数据储存功能
5. [ ] 背景动画和音效
6. [x] 数据呈现功能（也许要使用NSNotification进行实时信息传递，告诉viewController呈现获得的天气数据？）

## 项目结构
    |—— README.md
    |—— QWeather-Icons
    |—— Pods
    |—— Podfile
    |—— Podfile.lock
    |—— Weather.xcodeproj
    |—— Weather.xcworkspace
    |—— WeatherTest
    |—— WeatherUITests
    |—— Weather
            |—— main.m
            |—— main.storyboard
            |—— launch.storyboard
            |—— AppDelegate.h
            |—— AppDelegate.m
            |—— SceneDelegate.h
            |—— SceneDelegate.m
            |—— WeatherData.h
            |—— WeatherData.m
            |—— WeatherViewController.h
            |—— WeatherViewController.m
            |—— WeatherIndexController.h
            |—— WeatherIndexController.m
            |—— PlaceSelectionViewController.h
            |—— PlaceSelectionViewController.m
            |—— Weather.xcdatamodeld
            |—— Assets.xcassets
            |—— Base.lproj
            |—— en.lproj
            |—— zh-Hans.lproj
            |—— info.plist
            |—— Property List.plist

## 项目架构介绍
1. main.m: 主程序入口
2. main.storyboard: 程序运行时显示的所有界面以及界面、控件的相互关系
3. launch.storyboard: 程序加载时显示的界面
4. WeatherData: 自定义的天气数据类，包含各种数据和网络请求方法
5. WeatherViewController: 实时天气数据展示界面类
6. WeatherIndexController: 天气指数数据展示界面类
7. PlaceSelectionViewController: 近期天气预报展示界面类

    

