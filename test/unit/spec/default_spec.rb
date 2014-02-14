# Encoding: utf-8

require_relative 'spec_helper'

describe 'dtach::default' do
  before { stub_resources }
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'installs build dependency packages' do
    expect(chef_run).to install_package('gcc')
    expect(chef_run).to install_package('autoconf')
    expect(chef_run).to install_package('make')
  end

  it 'gets the remote tarball' do
    expect(chef_run).to create_remote_file("#{Chef::Config['file_cache_path']}/dtach-0.8.tar.gz") # rubocop:disable LineLength
  end

  it 'notifies install_dtach' do
    download = chef_run.remote_file('dtach')
    expect(download).to notify('bash[install_dtach]')
  end
end
