+++
title = "コミュニティプロジェクト"
template = "projects.html"
description = "東京Rustコミュニティメンバーが作成したプロジェクトをご覧ください！ツールやライブラリからアプリケーションや実験まで、私たちのメンバーはRustで素晴らしいものを作っています。"

[[extra.project]]
name = "Anodized"
url = "https://github.com/mkovaxx/anodized"
logo_url = "https://raw.githubusercontent.com/mkovaxx/anodized/main/assets/logo.svg"
description = "Specifications are a common ground across correctness tools in the Rust ecosystem. Anodized provides spec annotations that are checked for syntax and type errors at compile time, and have an ergonomic and expressive syntax. Specs are enforced at runtime by default. Integration with other tools like fuzzers and formal verifiers is also on the roadmap."

[[extra.project]]
name = "MFEM-rs"
url = "https://github.com/mkovaxx/mfem-rs"
logo_url = ""
description = "Rust wrapper for MFEM; a free, lightweight, scalable C++ library for finite element methods."

[[extra.project]]
name = "MORK"
url = "https://github.com/trueagi-io/MORK/"
logo_url = ""
description = "MORKは、数十億規模のエンティティを効率的に扱う必要があるアプリケーション向けに設計されたデータ変換エンジンです。もともとは象徴的AIアプリケーション、特に MeTTa言語 (https://metta-lang.dev) のバックエンドとなることを目的に設計されましたが、現在ではゲノミクスから金融パターン解析まで、さまざまな分野で利用するユーザーが増えています。MORKはS式の空間を保存し、その空間内のアトムに対する単一化を提供します。また、HyperベースのHTTPサーバー経由でアクセスできるほか、ライブラリとして直接リンクして利用することも可能です。"

[[extra.project]]
name = "pathmap"
url = "https://github.com/adam-Vandervorst/pathMap/"
logo_url = ""
description = "共有サブトライを備えた非常にコンパクトなラジックス256トライで、並行アクセスAPI、和・積・差などのパス代数演算、ファイルから直接マッピング可能な読み取り専用フォーマット、そして大量データを扱う際に有効となる多くの機能を備えています。"

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

[[extra.project]]
name = "Unifont-rs"
url = "https://github.com/mkovaxx/unifont-rs"
logo_url = ""
description = "Unifont provides a monochrome bitmap font that covers the entire Unicode Basic Multilingual Plane. Halfwidth glyphs are 8x16, fullwidth are 16x16 pixels. Supports #[no_std] builds."
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
