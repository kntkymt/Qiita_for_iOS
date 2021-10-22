# Qiita app for iOS
## Requirements
- Xcode12.0
- iOS13.0

## Overview
- [Qiita](https://qiita.com/)の記事閲覧アプリ

|  |  |  |  |  |
| ------ | ------ | ------ | ------ | ------ |
| ![](Image/image1.png) | ![](Image/image2.png) | ![](Image/image3.png) | ![](Image/image4.png) | ![](Image/image5.png) |

## Setup

本アプリはQiitaアプリケーションのクライアントID, クライアントシークレットを利用します。

1. Qiitaウェブサイトの[アプリケーション設定ページ](https://qiita.com/settings/applications)からクライアントID, クライアントシークレットを取得してください。
    - リダイレクトURLは`qiita://qiitaios`を設定してください。 任意のリダイレクトURLを利用したい場合は`Info.plist`の`URL types`を変更してください。
1. `Qiita/Configuration/.env.sample`を参考に`Qiita/Configuration/.env`を作成し、1. で取得したクライアントID, クライアントシークレットを設定してください。

以上でセットアップは完了です。

## License
MIT 
