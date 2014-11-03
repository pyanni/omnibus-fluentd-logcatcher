
name 'fluentd-logcatcher'
maintainer 'Pierre Yanni'
homepage 'http://something.com'

install_dir     '/opt/fluentd-logcatcher'
build_version   Omnibus::BuildVersion.semver
build_iteration 1

# creates required build directories
dependency 'preparation'

# fluentd-logcatcher dependencies/components
dependency 'fluentd'

# version manifest file
dependency 'version-manifest'

exclude '\.git*'
exclude 'bundler\/git'
