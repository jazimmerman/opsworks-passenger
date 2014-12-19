require 'spec_helper'

describe package('nginx') do
  it { should be_installed.with_version('1.2.9') }
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

describe command('nginx -V') do
  its(:stdout) { should match 'passenger'}
end

describe file('/etc/nginx/shared_server.conf.d/maintenance.conf') do
  it { should be_file }
  its(:content) { should match /set \$maintenance 0;/}
end

describe command('curl -i localhost/system/maintenance.html') do
  its(:stdout) { should_not match /503 Service Temporarily Unavailable/ }
  its(:stdout) { should_not match /<div id="maintenance">/ }
end

describe command('curl localhost/tacos.txt') do
  its(:stdout) { should_not match "yum" }
end