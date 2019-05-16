all: REFERENCE.md pkg

REFERENCE.md: Gemfile manifests/* metadata.json types/*
	puppet strings generate --format markdown --out $@

pkg: CHANGELOG.md metadata.json
	pdk build
