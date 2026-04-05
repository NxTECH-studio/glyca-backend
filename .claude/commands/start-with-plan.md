---
description: 実装方針ドキュメントに沿って実装を開始
argument-hint: <docs/tasks内のファイルパス>
---

# 実装方針ドキュメントに沿って実装を開始

あなたは **implementer エージェント** として動作します。

## 入力
- **実装方針ドキュメントパス**: `{{arg1}}`
  - `docs/tasks/` で始まらない場合: 自動で `docs/tasks/` を追加

## 実行内容
`.claude/agents/implementer.md` の指示に従って実装を進めます。

### 主な流れ
1. ドキュメント読み込み
2. Todoリスト作成（TodoWrite必須）
3. 実装ループ（タスクごとに `in_progress` → 実装 → Linter → `completed`）
4. テスト実装（Model/Service/Job/Mailer/Request spec）
5. 最終チェック（Linter全実行、全テスト）
6. 完了報告

### Linter実行
```bash
bundle exec rubocop <対象ファイル>
```

### テスト実行
```bash
bundle exec rspec <対象specファイル>
```

### スキーマ変更がある場合
`db/Schemafile` を編集後、テスト用DBに適用:
```bash
bundle exec ridgepole -c config/database.yml -E test --apply -f db/Schemafile
```

### 完了報告フォーマット
```markdown
## 実装完了
### 実装したファイル
### テストファイル
### 最終チェック結果
✅ Linter: すべて通過
✅ テスト: XX examples, 0 failures
✅ コミット: すべての変更がコミット済み（未コミットファイルなし）
### 次のステップ
- `/pr-creation`
```

### コード品質チェック（/simplify）
実装・テスト・Linter がすべて完了し、コミット済みになった後、最終ステップとして `/simplify` スキルを実行する。

- `/simplify` は重複排除・コード品質・効率の3観点で並列レビュー＆自動修正を行う
- 修正が発生した場合は追加コミットする
- `/simplify` 完了後に完了報告を出力する

**完了前チェックリスト（すべて満たすこと）**:
- [ ] Linter がすべて通過
- [ ] テストがすべてパス
- [ ] すべての変更が `git commit` 済み（`git status` で未コミットファイルがないこと）
- [ ] `/simplify` による品質チェック＆修正が完了

## ワークフロー
```
実装方針をdocs/tasks/に作成
↓
/start-with-plan <xxx.md>        # 実装開始（このコマンド）
↓
/pr-creation                     # PR作成
```
