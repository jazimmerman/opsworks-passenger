require 'spec_helper'

def siege(concurrency)
  describe command("siege -c #{concurrency} -r 100 localhost &> /home/ec2-user/siege_#{concurrency}c100r.log") do
    its(:exit_status) do
      should eq 0
      puts `\nvmstat -w`
      puts `\nmpstat`
      puts `\nnumastat`
      # puts `grep -A 12 "Transactions:" /home/ec2-user/siege_#{concurrency}c100r.log`
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

  [175, 200].each do |concurrency|
    siege(concurrency)
  end
end
