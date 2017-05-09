## Website: https://www.MyEtherWallet.com
## Chrome Extension: https://chrome.google.com/webstore/detail/myetherwallet-cx/nlbmnnijcnlegkjjpcfjclmcfggfefdm
## Download the Latest Release: https://github.com/kvhnuke/etherwallet/releases/latest
- dist-vX.X.X.X.zip is the smaller package containing the gh-pages branch aka MyEtherWallet.com
- chrome-extension-vX.X.X.X.zip is the chrome extension package
- source code is the full source for developers to get started with (although cloning or forking the mercury branch is probably a better choice)

## `mercury` is the development branch. gh-pages contains only the smaller dist folder only and is served to MyEtherWallet.com via CloudFlare.




### MyEtherWallet

MyEtherWallet is an open source, javascript, client-side tool for generating Ether wallets. It was created and is maintained by [kvhnuke](https://github.com/kvhnuke) and [tayvano](https://github.com/tayvano) aka [insomniasexx](https://www.reddit.com/user/insomniasexx).

- Generate Wallets completely client side.
- Unlock variety of key types: raw private key, encrypted private key, keystore file, mnemonics, Ledger Nano S hardware wallet.
- Easily send Ether and *any* ERC-20 Standard Token. Many tokens included as default: DGD, GNT, ICN, MKR, PLU, REP, SNGLS, and more.
- Send "Only ETH" or "Only ETC" to ensure you are not victim of replay attacks.
- Generate and send offline transactions, ensuring your private keys never touch an internet-connected device.
- Securely access your ETH & Tokens on your [Ledger Nano S](http://support.ledgerwallet.com/knowledge_base/topics/how-to-use-myetherwallet-with-your-nano-s) via the MyEtherWallet interface (Chrome & Opera natively, Firefox w/ [add-on](https://addons.mozilla.org/en-US/firefox/addon/u2f-support-add-on/))
- Now in 18 languages thanks 100% to the amazing Ethereum community.
- Supports URI Strings on Send Transaction Page. [Read More.](https://github.com/kvhnuke/etherwallet/issues/283#issuecomment-261849895)
    - to=[address]
    - value=[number]
    - sendMode=[ether | token]
    - tokenSymbol=[ARC | ICN | MKR | ....]
    - gasLimit=[number] OR gas=[number]
    - data=[hex data]
    - Example 1: https://www.myetherwallet.com/?to=0x7cB57B5A97eAbe94205C07890BE4c1aD31E486A8&value=1&tokenSymbol=REP&gaslimit=50000#send-transaction
    - Example 2: https://www.myetherwallet.com/?to=0x7cB57B5A97eAbe94205C07890BE4c1aD31E486A8&value=1&gaslimit=23000&data=0x5468616e6b20796f752c204d455720322e30#send-transaction

**Goals**

 - **Empower the people**: Give people the ability to interact with the Ethereum blockchain without having to run a full node.
 - **Make it easy & free**: Everyone should be able to create a wallet AND and send Ether & Tokens.
 - **People are the Priority**: You are the most important. Always. If monetization leads to a worse user experience, we don't do it. (ie: ads)
 - **A learning experience, too**: We want to educate about safely storing private keys and what public/private keys are. We don't want to hide behind usernames, passwords, or mnenmonics. That can come later.
 - **If it can be hacked, it will be hacked**: Never save, store, or transmit any private key anywhere at any time.
 - **Offline / Client-Side**: User should be able to run locally and offline without issue.
 - **Private**: No tracking!!! No emails. No ads. No demographics. We don't even know how many wallets have been generated or transactions have been sent, let alone who / what / where you are.
 - **Open source & audit-able**






### Users (non-developers)

It is recommended you start with our help page @ https://www.myetherwallet.com/#help.

You can run MyEtherWallet.com on your computer instead of from the GitHub servers. You can generate a wallet completely offline and send transactions from the "Offline Transaction" page.

- Go to [https://github.com/kvhnuke/etherwallet/releases/latest](https://github.com/kvhnuke/etherwallet/releases/latest).
- Click on `dist-vX.X.X.X.zip`.
- Move zip to an airgapped computer.
- Unzip it and double-click `index.html`.
- MyEtherWallet.com is now running entirely on your computer.

In case you are not familiar, you need to keep the entire folder in order to run the website, not just index.html. Don't touch or move anything around in the folder. If you are storing a backup of the MyEtherWallet repo for the future, we recommend just storing the ZIP so you can be sure the folder contents stay intact.

As we are constantly updating MyEtherWallet.com, we recommend you periodically update your saved version of the repo.







### Developers

If you want to help contribute, here's what you need to know to get it up and running and compiling.

- Both the Chrome Extension and the MyEtherWallet.com are compiling from the same codebase. This code is found in the `app` folder. Don't touch the `dist` or `chrome-extension` folders.
- We use angular and bootstrap. We used to use jQuery and Bootstrap until it was converted in April 2016. If you wonder why some things are set up funky, that's why.
- The mercury branch is currently the active development branch. We then push the dist folder live to gh-pages, which then gets served to MyEtherWallet.com.
- We use npm / gulp for compiling. There is a lot of stuff happening in the compliation.
- Our node currently runs using the json relay found in `json_relay_node`. This is written in node.js.
- Our node used to run on the json relay found in `json_relay_php` which was written in php.

**Getting Started**

- Start by running `npm install`.
    * I currently have node v4.2.6 & npm v3.7.2 so check to see if you need to update those is something isn't working.
    * You may need to install `browserify` and `angular` globally?
- Run `gulp`. Gulp will then watch & compile everything and then watch for changes to the HTML, JS, or CSS.
- For distribution, run `gulp clean`.

**Folder Structure**
- `fonts` and `images` get moved into their respective folders. This isn't watched via gulp so if you add an image or font, you need to run `gulp` again.
- `includes` are the pieces of the pages / the pages themselves. These are pretty self explanatory and where you will make most frontend changes.
- `layouts` are the pages themselves. These basically take all the pieces of the pages and compile into one massive page. The navigation is also found here...sort of.
    * `index.html` is for MyEtherWallet.com.
    * `cx-wallet.html` is the main page for the Chrome Extension.
    * `embedded.html` is for https://www.myetherwallet.com/embedded.html.

- You can control what shows up on MyEtherWallet.com vs the Chrome Extension by using: `@@if (site === 'cx' )  {  ...  }` and `@@if (site === 'mew' ) { ... }`. Check out `sendTransaction.tpl` to see it in action. The former will only compile to the Chrome Extension. The latter only to MyEtherWallet.com.
- embedded.html is for embedding the wallet generation into third-party sites. [Read more about it and how to listen for the address generated here.](https://www.reddit.com/r/ethereum/comments/4gn37o/embeddable_myetherwallet_super_simple_wallet/)
- The wallet decrypt directives are at `scripts/directives/walletDecryptDrtv.js`. These show up on a lot of pages.
- The navigation is in `scripts/services/globalServices.js`. Again, we control which navigation items show up in which version of the site in this single file.
- As of September 2016, almost all the copy in the .tpl files are only there as placeholders. It all gets replaced via angular-translate. If you want to change some copy you need to do so in `scripts/translations/en.js` folder. You should also make a note about what you changed and move it to the top of the file so that we can make sure it gets translated if necessary.
- `styles` is all the less. It's a couple custom folders and bootstrap. I am in the process of re-factoring all the CSS, getting rid of Bootstrap, and really limiting the CSS to what we absolutely need.







### Use Your Own Server/Node Guide

*Old: https://github.com/kvhnuke/etherwallet/issues/226.*

**Guide by benjaminion for MEW + Ledger Nano S + Local Parity Node: https://github.com/benjaminion/eth-parity-qnap/wiki/Connecting-to-MyEtherWallet**

**[Announcing MyEtherWallet v3.4: The Node Switcher](https://www.reddit.com/r/ethereum/comments/5lqx90/announcing_myetherwallet_v34_the_node_switcher/)**

**That node must have an SSL certificate (aka be https://) or you must run MyEtherWallet locally. [Download the latest version of MyEtherWallet here](https://github.com/kvhnuke/etherwallet/releases/latest) and in order to connect to a non-SSL node. Or, you can get a free SSL certificate via [LetsEncrypt](https://letsencrypt.org/).**

- Enter a name for your node

- Enter the URL

- Enter the port

- Select whether it is a ETH / ETC / Ropsten / Custom chain.

    - **ETH**: Shows default ETH tokens, EIP-155=true, chainid=1, uses etherscan.io for links to addresses and txs.

    - **ETC**: Shows default ETC tokens (none...yet?), EIP-155=false, chainid=false, uses gastracker.io for links to addresses and txs.

    - **Ropsten**: Shows default ROP tokens (none...yet?), EIP-155=true, chainid=3, uses testnet.etherscan.io for links to addresses and txs.

    - **Custom**: Allows you to select whether EIP-155 is true or false, and provide a chainid if it's true.

**If you want to connect to your own local geth or parity...**

You must run MyEtherWallet locally. This is due to the fact that our SSL site won't connect to your non-SSL local node. [Download the latest version of MyEtherWallet here](https://github.com/kvhnuke/etherwallet/releases/latest) and use that to connect to your local node.

- Enter a name for your node

- URL: http://127.0.0.1

- Port: 8545

- Select whether it is a ETH / ETC / Ropsten or Custom chain. (see above)

- Run geth using `geth --rpc --rpccorsdomain "null" --keystore "dont_put_secret_files_here_ever"`

- or run parity using `parity --rpccorsdomain "*" --keys-path "dont_put_secret_files_here_ever"`





### How to Help Translate

**A couple of notes:**

- Everything on the entire site is broken down into lines and in this one file. It's kinda crazy. The uppermost items are the highest priority and the further you go down, the less of a priority it is.
- You can add comments anywhere by wrapping it in /* Your Comment Here */. If you want to leave a note for yourself or someone else, do so in this format. That way it doesn't screw up the code or show up somewhere on the site.
- Don't delete any lines. Just leave it in English if you don't know how to translate it.
- Always make sure each line ends with `',`. So the format is `NAME: ' your text here ',` You only need to change the `your text here` part - try not to touch anything else.

**If you are NOT a developer and have no idea how this works:**

Anyone can help out and it looks way more complicated than it is! If you would rather not deal with Github, please just email us a myetherwallet at gmail dot com and I'll email you the file and you can make changes and send it back to us and I'll make sure you don't screw anything up. If you feel like experiencing something new, read on!

1. Sign into your Github account or make a new Github account.
2. Go to https://github.com/kvhnuke/etherwallet/tree/mercury/app/scripts/translations
3. Click on the language file you want to update.
4. Look in the upper right. You will see "Raw" "Blame" and so on. Click the pencil icon. This will then tell you, *"You’re editing a file in a project you don’t have write access to. We’ve created a fork of this project for you to commit your proposed changes to. Submitting a change to this file will write it to a new branch in your fork, so you can send a pull request."* Ignore all this gibberish. [Screenshot](https://ipfs.pics/ipfs/QmejqvFu71QhQ5zfYMQyUYazWwnSpVHtQnE12pT2T9QEX5).
5. In your browser, start translating. Translate as little or as much as you want. [Screenshot](https://ipfs.pics/ipfs/QmUQd2w2ah1Bnfocuu7egamp44EqtcNCTx3TziWcmwfTme).
6. Scroll down to ~line 240 and enter your name/username, donation address, and any comments you would like to leave. [Screenshot](https://ipfs.pics/ipfs/QmdnhpdMZHRk1DyrFNyN7Rgm5G58NrkMJAvJNGg35oQ2UC).
7. When you are done, tell us what language you updated. You can also leave any notes about problems you had or things you'd like us to know.
8. Click the green "Propose File change" button. [Screenshot](https://ipfs.pics/ipfs/QmQoLPs6JkSfZsMvGCBCvudyJiWNFqcSHNMzAncjyrw1Sx)
9. This next page is a review of what you did.
10. Click the "Create Pull Request" button.....twice. [Screenshot](https://ipfs.pics/ipfs/QmZJJvPxXu7BFHDQ1zj1a73EATQETbsDuAJVEJnatTHrms).
11. That's it. You successfully made a new pull request! Tell all your friends.
12. We will now review it and pull it in and it will be made live on the site. We may also ask you questions if something is confusing for whatever reason.

**If you are a developer and familiar with GitHub, Pull Requests, and know how to save a JS file as a .js file rather than a Word Doc:**

1. Clone the [mercury branch](https://github.com/kvhnuke/etherwallet/tree/mercury).
2. Go to `/app/scripts/translations/`.
3. Open the language you want to translate.
4. Translate as much or as little as you wish.
5. Add your name/username, donation address, and any notes you would like on ~line 240 of the language.js file.
6. Open a PR and leave us a brief description of what you did and any issues you ran into or comments you have.

Read more @ [Help us translate MyEtherWallet.com into ALL THE LANGUAGES!](https://www.reddit.com/r/ethereum/comments/4z55s2/help_us_translate_myetherwalletcom_into_all_the/)







### Contact
If you can think of any other features or run into bugs, let us know. You can fork, open a PR, open an issue, [message kvhnuke on reddit](https://www.reddit.com/message/compose/?to=kvhnuke), [email tayvano](mailto:tayvano@gmail.com) or [in any of these ways](https://www.myetherwallet.com/#contact).






### Announcement History

- 08/12/15: [Launch Post: Ether Wallet Generator (for now)](https://www.reddit.com/r/ethereum/comments/3gkknd/ether_wallet_generator_for_now/). Never forget where you [came from](https://ipfs.pics/ipfs/QmXFK6NBy81ibvTEwnwwEUecXiRyQBriJUnKpaCaE4w7nF).
- 08/19/15: [ETHER WALLET- Ready for the second round?](https://www.reddit.com/r/ethereum/comments/3h6o38/ether_wallet_ready_for_the_second_round/). We the domain name & SSL.
- 08/24/15: [Lets purchase Augur rep, the easy way!](https://www.reddit.com/r/ethereum/comments/3i6eyd/lets_purchase_augur_rep_the_easy_way/)
- 02/08/16: [MyEtherWallet Chrome Extension: The Beta has Arrived](https://www.reddit.com/r/ethereum/comments/44vbef/myetherwallet_chrome_extension_the_beta_has/)
- 03/03/16: [We’ve heard you loud and clear so tonight…we've launch offline / advanced transactions for MyEtherWallet.com](https://www.reddit.com/r/ethereum/comments/48rf3d/weve_heard_you_loud_and_clear_so_tonightweve/)
- 03/05/16: [[Small Announcement] We updated the "Generate Wallet" Page & "Help" Page on MyEtherWallet.com to be more noob-friendly. Hit us with your feedback, please.](https://www.reddit.com/r/ethereum/comments/493t5u/small_announcement_we_updated_the_generate_wallet/)
- 04/18/16: [MyEtherWallet.com v2.0 (aka Mewtwo) has arrived!](https://www.reddit.com/r/ethereum/comments/4faooz/myetherwalletcom_v20_aka_mewtwo_has_arrived/)
- 04/28/16: [Embeddable MyEtherWallet: Super Simple Wallet Generation w/ ability to get the address generated](https://www.reddit.com/r/ethereum/comments/4gn37o/embeddable_myetherwallet_super_simple_wallet/)
- 04/30/16: [How to participate in “The DAO” creation via MyEtherWallet (yes...right NOW!)](https://www.reddit.com/r/ethtrader/comments/4h3xph/how_to_participate_in_the_dao_creation_via/)
- 05/30/16: [MyEtherWallet Update: Send DAO Tokens, Vote on Proposals, and the Chrome Extension finally gets updated!!](https://www.reddit.com/r/ethereum/comments/4lf71h/myetherwallet_update_send_dao_tokens_vote_on/)
- 06/07/16: [⚠ BEWARE: MYETHERWALLET >>.INFO<< IS A PHISHING SCAM AND WILL TAKE ALL YOUR FUNDS. myEtherWallet is MyEtherWallet.com](https://www.reddit.com/r/ethereum/comments/4rpurc/beware_myetherwallet_info_is_a_phishing_scam_and/)
- 07/28/16: [MyEtherWallet now Supports Sending Any Ethereum Token (ERC-20) — also learn about our future plans](https://www.reddit.com/r/ethereum/comments/4v0r32/myetherwallet_now_supports_sending_any_ethereum/)
- 07/28/16: [MyEtherWallet, Preventing Replays, and Ethereum Classic (ETC)](https://www.reddit.com/r/ethereum/comments/4v1y2t/myetherwallet_preventing_replays_and_ethereum/)
- 08/14/16: [⚠ Malicious Phisher is running Google Ads for MyEtherWallet.com ⚠ It does NOT go to MyEtherWallet.com. Always check the URL before accessing or creating a new wallet! Use your bookmarks bar!](https://www.reddit.com/r/ethereum/comments/4xpj0u/malicious_phisher_is_running_google_ads_for/)
- 08/22/16: [Help us translate MyEtherWallet.com into ALL THE LANGUAGES!](https://www.reddit.com/r/ethereum/comments/4z55s2/help_us_translate_myetherwalletcom_into_all_the/)
- 11/21/16: [Massive MyEtherWallet.com Update: Better URIs, The Hardfork, and looking back at the Golem Crowdfund.](https://www.reddit.com/r/ethereum/comments/5e3alw/massive_myetherwalletcom_update_better_uris_the/)
- 1/2/17: [Announcing MyEtherWallet v3.4: The Node Switcher](https://www.reddit.com/r/ethereum/comments/5lqx90/announcing_myetherwallet_v34_the_node_switcher/)
- 1/9/17: [Announcing MyEtherWallet v3.4.3: Interacting with Contracts](https://www.reddit.com/r/ethereum/comments/5n0dj0/announcing_myetherwallet_v343_interacting_with/?utm_content=title&utm_medium=user&utm_source=reddit&utm_name=frontpage)
- 2/3/17: [MyEtherWallet.com v3.4.7: You can use your TREZOR on MEW. Thanks to all who made this a reality 🤗](https://www.reddit.com/r/ethereum/comments/5rsfu9/myetherwalletcom_v347_you_can_use_your_trezor_on/?utm_content=comments&utm_medium=user&utm_source=reddit&utm_name=frontpage)
- 2/16/17: [MyEtherWallet v3.5.0: Swap ETH <-> BTC <-> REP via Bity, directly from MEW! (also: Parity backup phrase support + add'l contract features + our roadmap)](https://www.reddit.com/r/ethereum/comments/5ueysp/myetherwallet_v350_swap_eth_btc_rep_via_bity/?utm_content=comments&utm_medium=user&utm_source=reddit&utm_name=frontpage)


#### MyEtherWallet.com & MyEtherWallet CX are licensed under The MIT License (MIT).
