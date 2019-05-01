REFERENCE.md: Gemfile manifests/* metadata.json types/*
	puppet strings generate --format markdown --out $@
