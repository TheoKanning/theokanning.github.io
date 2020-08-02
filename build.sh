# build all files to docs directory
gulp
bundle exec jekyll build --destination docs
# remove default images added by theme
rm docs/assets/images/*
rm docs/assets/*.jpg
