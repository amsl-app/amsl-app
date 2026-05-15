SHELL := /bin/bash

.PHONY: setup-local-minimal setup-local setup-local-force clean-local setup-git verify-git-filters

setup-local-minimal:
	@if [ ! -f .env ]; then cp .env.example .env; fi
	@python3 scripts/setup_local_config.py

setup-local: setup-local-minimal setup-git

setup-local-force:
	@cp .env.example .env
	@python3 scripts/setup_local_config.py

clean-local:
	@rm -f android/app/google-services.json ios/Runner/GoogleService-Info.plist

setup-git:
	@printf '%s\n' 'Setting up git clean filters'
	@git config --local filter.flavorsclean.clean "python3 scripts/git_flavors_clean_filter.py"
	@git config --local filter.firebasejsonclean.clean "python3 scripts/git_firebase_json_clean_filter.py"
	@git config --local filter.firebaseplistclean.clean "python3 scripts/git_firebase_plist_clean_filter.py"
	@git config --local filter.pbxprojclean.clean "python3 scripts/git_pbxproj_clean_filter.py"

verify-git-filters:
	@python3 -m py_compile scripts/git_env_clean_filter.py scripts/git_flavors_clean_filter.py scripts/git_firebase_json_clean_filter.py scripts/git_firebase_plist_clean_filter.py scripts/git_pbxproj_clean_filter.py
	@python3 scripts/git_flavors_clean_filter.py < lib/flavors.dart | rg -q 'k8s\.win|k8s\.iism|kit\.edu|f5f804' && (printf '%s\n' 'flavorsclean check failed'; exit 1) || true
	@python3 scripts/git_firebase_json_clean_filter.py < android/app/google-services.json | rg -q 'AIzaSy[A-Za-z0-9_-]{20,}' && (printf '%s\n' 'firebasejsonclean check failed'; exit 1) || true
	@python3 scripts/git_firebase_plist_clean_filter.py < ios/Runner/GoogleService-Info.plist | rg -q 'edu\.kit|wi-amsl|ASVKeKfu|cbb65afa' && (printf '%s\n' 'firebaseplistclean check failed'; exit 1) || true
	@python3 scripts/git_pbxproj_clean_filter.py < ios/Runner.xcodeproj/project.pbxproj | rg -q 'DEVELOPMENT_TEAM = "[^"]+";|"DEVELOPMENT_TEAM\[sdk=iphoneos\*\]" = "[^"]+";' && (printf '%s\n' 'pbxprojclean check failed'; exit 1) || true
	@printf '%s\n' 'All git clean filters look good.'
