# Unicorn Tears Workstation Chef Cookbook

[![Cookbook Version](http://img.shields.io/cookbook/v/ut_workstation.svg)](https://supermarket.chef.io/cookbooks/ut_workstation)
[![Build Status](https://travis-ci.org/ut-cookbooks/ut_workstation.png?branch=master)](https://travis-ci.org/ut-cookbooks/ut_workstation)

* Website: http://ut-cookbooks.github.io/ut_workstation/
* Supermarket: https://supermarket.chef.io/cookbooks/ut_workstation
* Source Code: https://github.com/ut-cookbooks/ut_workstation

A Chef cookbook for a Unicorn Tears workstation.

This is a wrapper (or application) cookbook and is therefore good and
opinionated about application and configuration defaults. Feel free to try it,
fork and modify it, or just read and learn.

## Usage

Include `recipe[ut_workstation]` in your run-list and set up some data
bag items (namely under `workstation` and `users`) to drive the cookbook.

## Requirements

* Chef 12 or higher

## Platform Support

This cookbook is tested on the following platforms with [Test
Kitchen](http://kitchen.ci):

* CentOS 7.1 64-bit
* Debian 8.1 64-bit
* Mac OS X 10.9
* Mac OS X 10.10
* Ubuntu 12.04 64-bit
* Ubuntu 14.04 64-bit
* Ubuntu 15.04 64-bit

Unlisted platforms in the same family of similar or equivalent versions may
work without modification to this cookbook. Please [report][issues] any
additional platforms so they can be added.

## Cookbook Dependencies

This cookbook depends on the following external cookbooks:

* [apt](https://supermarket.chef.io/cookbooks/apt)
* [bashrc](https://supermarket.chef.io/cookbooks/bashrc)
* [chruby](https://supermarket.chef.io/cookbooks/chruby)
* [homebrew](https://supermarket.chef.io/cookbooks/homebrew)
* [homesick](https://supermarket.chef.io/cookbooks/homesick)
* [mac_os_x](https://supermarket.chef.io/cookbooks/mac_os_x)
* [user](https://supermarket.chef.io/cookbooks/user)
* [ut_base](https://supermarket.chef.io/cookbooks/ut_base)
* [python](https://supermarket.chef.io/cookbooks/python)
* [ruby_install](https://supermarket.chef.io/cookbooks/ruby_install)
* [xquartz](https://supermarket.chef.io/cookbooks/xquartz)
* [vagrant](https://supermarket.chef.io/cookbooks/vagrant)
* [virtualbox](https://supermarket.chef.io/cookbooks/virtualbox)

## Recipes

### default

Main recipe which includes all internal recipes.

## Attributes

| Key                                        | Description                                 | Type    | Default                     |
|--------------------------------------------|---------------------------------------------|---------|-----------------------------|
| `["ut_workstation"]["vagrant"]["version"]` | The version of Vagrant to install           | String  | (see attributes/vagrant.rb) |
| `["ut_workstation"]["install_virtualbox"]` | Whether or not to install VirtualBox        | Boolean | `true`                      |
| `["ut_workstation"]["install_vagrant"]`    | Whether or not to install Vagrant           | Boolean | `true`                      |

## Resources and Providers

There are **no external** resources and providers.

## Development

* Source hosted at [GitHub][repo]
* Report issues/Questions/Feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.
Ideally create a topic branch for every separate change you make.

## License and Author

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

[fnichol]:      https://github.com/fnichol
[repo]:         https://github.com/ut-cookbooks/ut_workstation
[issues]:       https://github.com/ut-cookbooks/ut_workstation/issues
