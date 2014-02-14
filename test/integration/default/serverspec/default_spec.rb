# Encoding: utf-8

require_relative 'spec_helper'

describe 'compiles and installs dtach' do
  describe file('/usr/local/bin/dtach') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 755 }
  end

  describe command('/usr/local/bin/dtach --version') do
    it { should return_exit_status 0 }
    it { should return_stdout(/dtach - version \d+\.\d+, compiled on.*/) }
  end
end
