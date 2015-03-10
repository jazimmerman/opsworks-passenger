require 'spec_helper'

def siege(concurrency)
  describe command("siege -b -c #{concurrency} -t 10M localhost") do
    its(:exit_status) do
      should eq 0
      puts `\nvmstat -w`
      puts `\nmpstat`
      puts `\nnumastat`
      puts `\ncat /home/ec2-user/siege.log`
    end
  end
end

describe 'perf' do
  describe service('nginx') do
    it { should be_running }
  end

  describe port(80) do
    it { should be_listening }
  end

  [72].each do |concurrency|
    siege(concurrency)
  end
end
