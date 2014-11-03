name "fluentd"
default_version '5df1b12365403ac6cbe417e6694bb1a1e7fc4368'

dependency "ruby"
dependency "rubygems"
dependency "jemalloc"
dependency "nokogiri"
dependency "bundler"

source :git => 'https://github.com/fluent/fluentd.git'
relative_path "fluentd"

build do
  # Dir.glob(File.expand_path(File.join(Omnibus::Config.project_root, 'core_gems', '*.gem'))).sort.each { |gem_path|
  #   gem "install -n #{install_dir}/bin --no-ri --no-rdoc #{gem_path}"
  # }
  bundle "install"
  rake "build"
  gem "install -n #{install_dir}/embedded/bin --no-ri --no-rdoc pkg/fluentd-*.gem"

  # Dir.glob(File.expand_path(File.join(Omnibus::Config.project_root, 'plugin_gems', '*.gem'))).sort.each { |gem_path|
  #   args = ''
  #   if project.ohai['platform_family'] == 'mac_os_x' && gem_path.include?('-thrift-')
  #     # See: https://issues.apache.org/jira/browse/THRIFT-2219
  #     args << " -- --with-cppflags='-D_FORTIFY_SOURCE=0'"
  #   end
  #   gem "install -n #{install_dir}/bin --no-ri --no-rdoc #{gem_path} #{args}" # , :env => env
  # }

  plugins = %w[fluent-plugin-elasticsearch fluent-plugin-grep fluent-plugin-redis]

  plugins.each do |g|
    command "#{install_dir}/embedded/bin/fluent-gem install #{g} --no-rdoc --no-ri" #, :env => env
  end
end