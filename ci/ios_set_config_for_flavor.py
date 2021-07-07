#!/usr/bin/env python3
"""
XCode's command line tool only uses the default build
configuration set in the .pbxproj file.
For flavoring to work properly for iOS, we need to
set the default build configuration to the proper flavored version.
"""

import os
import pathlib

project_root_path = pathlib.Path(__file__).absolute().parent.parent
project_config_path =  project_root_path / 'ios' / 'Runner.xcodeproj' / 'project.pbxproj'
assert project_config_path.exists(), 'could not find iOS project configuration - project.pbxproj'

build_flavor = os.environ.get('FLAVOR')
assert build_flavor, 'build flavor environment variable (FLAVOR) not set'

default_build_config = 'Release-prod'
correct_build_config = f'Release-{build_flavor}'

with project_config_path.open() as f:
  project_config = f.read()

string_to_be_replaced = f'defaultConfigurationName = "{default_build_config}"'
string_to_replace_with = f'defaultConfigurationName = "{correct_build_config}"'

project_config = project_config.replace(string_to_be_replaced, string_to_replace_with)

with project_config_path.open('w') as f:
  f.write(project_config)
