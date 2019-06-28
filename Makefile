all: REFERENCE.md pkg

REFERENCE.md: manifests/* metadata.json types/*
	puppet strings generate --format markdown --out $@

pkg: CHANGELOG.md metadata.json
	pdk build
