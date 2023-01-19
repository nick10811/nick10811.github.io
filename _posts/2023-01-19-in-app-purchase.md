---
layout: post
title: 'In-App Purchase (IAP)'
date: '2023-01-19'
author: Nick Yang
tags:
- iOS
- IAP
---

There are no opportunities to develop IAP apps in my iOS career. Recently, I began to survey this technique and workflow in Apple after I received requirements from PM. It was a surprise to me that rare iOS developers have this experience. But it is easy to understand everyone does not want to pay 30% of the fee to Apple. [The famous case is a lawsuit between Epics Games and Apple.](https://en.wikipedia.org/wiki/Epic_Games_v._Apple)

## Review Guildelines
In the beginning, let's read carefully the [Review Guidelines](https://developer.apple.com/app-store/review/guidelines/#business) from Apple. It is a good way to understand the basic rules of IAP and ensure your app can be passed by Apple review. Please notice that 3.1.1 and 3.1.3(e) mentioned digital goods, subscriptions, in-game currencies, premium content, or unlocking a full version should be adopted this way. Hence, the streaming platform, and gaming apps should use IAP. But it is allowed to use third-party payment methods for the E-commerce apps with physical goods.

## In-app purchase types
Okay, if you understand the review guidelines, and you have a plan to develop an IAP app, you could keep reading this article. 

There are four types of IAP in Apple. They are Consumable, Non-Consumable, Auto-Renewable Subscription, and Non-Renewing Subscription.

| Type | Description |
| --- | --- |
| Consumable | A product that is used once, after which it becomes depleted and must be purchased again. Example: fish food in a fishing app. |
| Non-Consumable | A product that is purchased once and does not expire or decrease with use. Example: Race track for a game app.|
| Auto-Renewable Subscription | A product that allows users to purchase dynamic content for a set period. This type of Subscription renews automatically unless cancelled by the user. Example: Monthly subscriptions for an app offering streaming services. |
| Non-Renewing Subscription | A product that allows users to purchase a service with a limited duration. The content of this in-app purchase can be static. This type of Subscription does not renew automatically. Example: One year subscription to a catalog of archived articles. |

## Workflow for configuring in-app purchases
Here are several steps you can follow to configure in-app purchases in App Store Connect and Xcode.

1. Sign the Paid Applications Agreement.
To offer in-app purchases, you must sign the Paid Applications Agreement. You can sign the agreement in App Store Connect. For more information, see [Agreements, Tax, and Banking](https://help.apple.com/app-store-connect/#/devb6df5ee51).

![Agreements, Tax, and Banking](/public/in-app-purchase/agreement_tax_banking.png)

2. Configure in-app purchases in App Store Connect.
Next, you can configure in-app purchases in App Store Connect. For more information, see [Create In-app purchase](https://help.apple.com/app-store-connect/#/devae49fb316).

There are two fields you need to fill in, Reference Name and Product ID.
* Reference Name - A unique name for internal tracking. I could be edited anytime.
* Product ID - A unique ID to identify your product. **The Product ID can't editable after saving. It can't be used again even if the product is deleted.**

![Create In-app purchase](/public/in-app-purchase/create_iap.png)

3. Enable in-app purchases in Xcode.
After you configure in-app purchases in App Store Connect, you can Add the in-app purchase capability to your app in Xcode.

![Add the in-app purchase capability](/public/in-app-purchase/add_iap_capability.png)

4. Test in-app purchases in Xcode.
To test in-app purchases without incurring any charges, Apple provides a testing environment called Sandbox. For more information, see [Test in-app purchases in Sandbox](https://developer.apple.com/documentation/storekit/in-app_purchase/testing_in-app_purchases_with_sandbox). You need to [create a sandbox tester account](https://help.apple.com/app-store-connect/#/dev8b997bee1) in App Store Connect.

> Notes: It is better to use the **US** tester in Sandbox. Because it might occur an error message, `Cannot connect to iTunes Store`, when you use other countries' testers.

![Test in-app purchases in Sandbox](/public/in-app-purchase/sandbox_testers.png)

## StoreKit
After you finish the configuration, you can start to develop your app. Apple provides a framework called StoreKit to help you implement IAP. For more information, see [StoreKit](https://developer.apple.com/documentation/storekit). I think I will write a new article to introduce how to use StoreKit to implement IAP in the future.

## References
* [Review Guidelines](https://developer.apple.com/app-store/review/guidelines/#business)
* [Overview of In-App Purchase](https://developer.apple.com/in-app-purchase/)
* [Workflow for configuring in-app purchases](https://help.apple.com/app-store-connect/#/devb57be10e7)
* [In-app purchase types](https://help.apple.com/app-store-connect/#/dev3cd978dbd)
* [Create in-app purchases](https://help.apple.com/app-store-connect/#/devae49fb316)
* [StoreKit](https://developer.apple.com/documentation/storekit)
* [General information](https://help.apple.com/app-store-connect/#/dev84b80958f)