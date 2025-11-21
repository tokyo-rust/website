+++
title = "コミュニティプロジェクト"
template = "projects.html"
description = "東京Rustコミュニティメンバーが作成したプロジェクトをご覧ください！ツールやライブラリからアプリケーションや実験まで、私たちのメンバーはRustで素晴らしいものを作っています。"

[[extra.project]]
name = "Shizen"
url = "https://github.com/brandonpollack23/shizen-again"
logo_url = "https://github.com/brandonpollack23.png?size=200"
description = "自然はタスク表管理のラブレリーとアプリです。P2P同期や依存関係の連鎖を通して現在実行できるアクションだけを見えるようにすることが機能です。"

[[extra.project]]
name = "Sarekt"
url = "https://github.com/brandonpollack23/sarekt"
logo_url = "https://raw.githubusercontent.com/brandonpollack23/sarekt/master/sarekt_screenshot.png"
description = "ラストで実行したよくないVulkan／Ash三次元レンダラー"
+++


## プロジェクトを追加する

あなたのRustプロジェクトを紹介しませんか？掲載をお待ちしています！プロジェクトは2つの方法で追加できます：

### 方法1：対話型スクリプトを使用（最も簡単）

1. [サイト](https://github.com/tokyo-rust/website)をフォークしてクローン
1. [mise](https://mise.jdx.dev)を有効にして必要な依存関係を取得（または単に[gum](https://github.com/charmbracelet/gum)をインストール）
1. スクリプトを実行：`./scripts/add-project.sh`
1. プロンプトに従ってプロジェクトの詳細を入力
1. 変更内容をプルリクエストで提出（`gh pr create`）

### 方法2：手動編集

1. [tokyo-rust websiteリポジトリ](https://github.com/tokyo-rust/website)をフォークしてクローン
2. `content/projects.md`と`content/projects.jp.md`を編集
3. プロジェクトの詳細を含む新しい`[[extra.project]]`エントリを追加：
   - `name`：プロジェクト名
   - `url`：プロジェクトリポジトリへのリンク
   - `logo_url`：（オプション）プロジェクトロゴまたはGitHubアバターのURL
   - `description`：プロジェクトの簡単な説明
4. プルリクエストを提出

東京Rustコミュニティメンバーによるすべてのプロジェクトを歓迎します！
