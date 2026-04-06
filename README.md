# Glyca Backend

Rails 8.1 API専用バックエンドアプリケーション。

## 技術スタック

| カテゴリ | 技術 |
|---|---|
| 言語 | Ruby 4.0.2 |
| フレームワーク | Rails 8.1 (API only) |
| DB | PostgreSQL |
| スキーマ管理 | Ridgepole |
| バックグラウンドジョブ | Solid Queue |
| キャッシュ | Solid Cache |
| デプロイ | Kamal (Docker) |
| テスト | RSpec, FactoryBot |
| Lint | RuboCop |

## セットアップ

```bash
# 依存関係のインストール
bundle install

# DB作成 & スキーマ適用
bin/rails db:create
bundle exec ridgepole -c config/database.yml -E development --apply -f db/Schemafile
bundle exec ridgepole -c config/database.yml -E test --apply -f db/Schemafile

# サーバー起動
bin/rails server
```

### 環境変数

| 変数名 | 説明 |
|---|---|
| `DB_HOST` | PostgreSQL ホスト |
| `DB_USERNAME` | PostgreSQL ユーザー名 |
| `DB_PASSWORD` | PostgreSQL パスワード |

## 開発コマンド

```bash
# テスト
bundle exec rspec

# Lint
bundle exec rubocop

# セキュリティ
bin/brakeman --no-pager
bin/bundler-audit

# スキーマ変更の適用（※ Rails マイグレーションは使わない）
bundle exec ridgepole -c config/database.yml -E development --apply -f db/Schemafile
```

## 開発フロー（Claude Code）

このプロジェクトでは Claude Code のカスタムコマンドを活用した開発フローを採用しています。

```
1. /start-with-plan <方針ファイル>
   → 実装方針に沿ってコードを実装。

2. /code-review
   → 並列エージェントによるセルフレビュー（セキュリティ・設計・テスト・可読性・Lint）。

3. /pr-creation
   → PR 作成。

4. 人間がレビュー / マージ / QA / リリース
```

カスタムコマンドの定義は `.claude/commands/` を参照してください。
