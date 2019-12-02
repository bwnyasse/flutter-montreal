cd /workspace/$1
HEAD_SHA=$(git rev-parse --verify HEAD)
VERSION_CODE=$(git rev-list --count master)
flutter build apk --build-name=$HEAD_SHA --build-number=$VERSION_CODE