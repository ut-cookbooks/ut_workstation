# <a name="title"></a> Unicorn Tears Workstation Chef Cookbook

[![Build Status](https://travis-ci.org/ut-cookbooks/ut_workstation.png?branch=master)](https://travis-ci.org/ut-workstation/ut_workstation)

## <a name="description"></a> Description

Chef cookbook for a Unicorn Tears workstation.

* Website: http://ut-cookbooks.github.io/ut_workstation/
* Opscode Community Site: http://community.opscode.com/cookbooks/ut_workstation
* Source Code: https://github.com/ut-cookbooks/ut_workstation

This is a wrapper (or application) cookbook and is therefore good and
opinionated about application and configuration defaults. Feel free to try it,
fork and modify it, or just read and learn.

## <a name="usage"></a> Usage

Simply include `recipe[ut_workstation]` in your run\_list and set up some bag
items (namely under `workstation` and `users`) to drive the cookbook.

## <a name="requirements"></a> Requirements

### <a name="requirements-chef"></a> Chef

Tested on 11.4.4 but newer and older version should work just fine.
File an [issue][issues] if this isn't the case.

### <a name="requirements-platform"></a> Platform

The following platforms have been tested with this cookbook, meaning that the
recipes run on these platforms without error:

* ubuntu
* debian
* mac\_os\_x

Please [report][issues] any additional platforms so they can be added.

### <a name="requirements-cookbooks"></a> Cookbooks

This cookbook depends on the following external cookbooks:

* [apt][apt_cb]
* [bashrc][bashrc_cb] (via Git)
* [chgems][chgems_cb]
* [chruby][chruby_cb] (currently forked)
* [dmg][dmg_cb]
* [homebrew][homebrew_cb] (currently forked)
* [homesick][homesick_cb]
* [mac_os_x][mac_os_x_cb] (currently forked)
* [mosh][mosh_cb]
* [user][user_cb]
* [ut_base][ut_base_cb]
* [python][python_cb]
* [ruby_build][ruby_build_cb]
* [xquartz][xquartz_cb]
* [vagrant][vagrant_cb]
* [virtualbox][virtualbox_cb] (currently forked)
* [zip_app][zip_app_cb]

## <a name="installation"></a> Installation

Depending on the situation and use case there are several ways to install
this cookbook. All the methods listed below assume a tagged version release
is the target, but omit the tags to get the head of development. A valid
Chef repository structure like the [Opscode repo][chef_repo] is also assumed.

### <a name="installation-site"></a> From the Opscode Community Site

To install this cookbook from the Community Site, use the *knife* command:

    knife cookbook site install ut_workstation

### <a name="installation-berkshelf"></a> Using Berkshelf

[Berkshelf][berkshelf] is a cookbook dependency manager and development
workflow assistant. To install Berkshelf:

    cd chef-repo
    gem install berkshelf
    berks init

To use the Community Site version:

    echo "cookbook 'ut_workstation'" >> Berksfile
    berks install

Or to reference the Git version:

    repo="ut-cookbooks/ut_workstation"
    latest_release=$(curl -s https://api.github.com/repos/$repo/git/refs/tags \
    | ruby -rjson -e '
      j = JSON.parse(STDIN.read);
      puts j.map { |t| t["ref"].split("/").last }.sort.last
    ')
    cat >> Berksfile <<END_OF_BERKSFILE
    cookbook 'chgems',
      :git => 'git://github.com/$repo.git', :branch => '$latest_release'
    END_OF_BERKSFILE
    berks install

### <a name="installation-librarian"></a> Using Librarian-Chef

[Librarian-Chef][librarian] is a bundler for your Chef cookbooks.
To install Librarian-Chef:

    cd chef-repo
    gem install librarian
    librarian-chef init

To use the Community Site version:

    echo "cookbook 'ut_workstation'" >> Cheffile
    librarian-chef install

Or to reference the Git version:

    repo="ut-cookbooks/ut_workstation"
    latest_release=$(curl -s https://api.github.com/repos/$repo/git/refs/tags \
    | ruby -rjson -e '
      j = JSON.parse(STDIN.read);
      puts j.map { |t| t["ref"].split("/").last }.sort.last
    ')
    cat >> Cheffile <<END_OF_CHEFFILE
    cookbook 'chgems',
      :git => 'git://github.com/$repo.git', :ref => '$latest_release'
    END_OF_CHEFFILE
    librarian-chef install

## <a name="recipes"></a> Recipes

### <a name="recipes-default"></a> default

coming soon...

## <a name="attributes"></a> Attributes

coming soon...

## <a name="lwrps"></a> Resources and Providers

There are **no** resources and providers.

## <a name="development"></a> Development

* Source hosted at [GitHub][repo]
* Report issues/Questions/Feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.
Ideally create a topic branch for every separate change you make.

## <a name="license"></a> License and Author

Author:: [Fletcher Nichol][fnichol] (<fnichol@nichol.ca>) [![endorse](http://api.coderwall.com/fnichol/endorsecount.png)](http://coderwall.com/fnichol)

Copyright 2013, Fletcher Nichol

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[apt_cb]:         http://community.opscode.com/cookbooks/apt
[bashrc_cb]:      https://github.com/fnichol/chef-bashrc
[chgems_cb]:      http://community.opscode.com/cookbooks/chgems
[chruby_cb]:      http://community.opscode.com/cookbooks/chruby
[dmg_cb]:         http://community.opscode.com/cookbooks/dmg
[homebrew_cb]:    http://community.opscode.com/cookbooks/homebrew
[homesick_cb]:    http://community.opscode.com/cookbooks/homesick
[mac_os_x_cb]:    http://community.opscode.com/cookbooks/mac_os_x
[mosh_cb]:        http://community.opscode.com/cookbooks/mosh
[user_cb]:        http://community.opscode.com/cookbooks/user
[ut_base_cb]:     http://community.opscode.com/cookbooks/ut_base
[python_cb]:      http://community.opscode.com/cookbooks/python
[ruby_build_cb]:  http://community.opscode.com/cookbooks/ruby_build
[xquartz_cb]:     http://community.opscode.com/cookbooks/xquartz
[vagrant_cb]:     http://community.opscode.com/cookbooks/vagrant
[virtualbox_cb]:  http://community.opscode.com/cookbooks/virtualbox
[zip_app_cb]:     http://community.opscode.com/cookbooks/zip_app

[berkshelf]:    http://berkshelf.com/
[chef_repo]:    https://github.com/opscode/chef-repo
[cheffile]:     https://github.com/applicationsonline/librarian/blob/master/lib/librarian/chef/templates/Cheffile
[librarian]:    https://github.com/applicationsonline/librarian#readme

[fnichol]:      https://github.com/fnichol
[repo]:         https://github.com/ut-cookbooks/ut_workstation
[issues]:       https://github.com/ut-cookbooks/ut_workstation/issues
