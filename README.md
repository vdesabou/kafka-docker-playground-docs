# kafka-docker-playground-docs

Documentation website for [kafka-docker-playground](https://github.com/vdesabou/kafka-docker-playground), published at https://kafka-docker-playground.io/#/ with [Docsify](https://docsify.js.org) ([docsify-themeable](https://jhildenbiddle.github.io/docsify-themeable/#/) theme).

## Generated vs hand-written pages

Some files under `docs/` are pushed by the CI of the main repository (`playground update-docs`, see `.github/workflows/ci.yml` and `update-docs.yml` there). Do not edit them here, they are overwritten on the next run:

| File(s) | Source |
|---|---|
| `playground *.md`, `index.md`, `cli.md`, `cli-pages.js` | `scripts/cli/src/bashly.yml` and `scripts/cli/docs-template/cli-template.md` |
| `content.md`, `content-template.md` | `docs/content-template.md`, plus CI results |
| `introduction.md`, `badges.md` | `docs/introduction-header.md`, `docs/badges-template.md`, `docs/introduction-footer.md` |
| `changelog.md` | `update-changelogs.yml` (closed milestones) |

Everything else (`how-to-use.md`, `how-it-works.md`, `reusables.md`, `academy.md`, `tips-and-tricks.md`, `legacy-java-producer.md`, `sidebar.md`, `_coverpage.md`, `index.html`, `assets/`, `images/`) is maintained in this repository.

## Preview locally

```bash
npm i -g docsify-cli
docsify serve ./docs
```

Then open http://localhost:3000
