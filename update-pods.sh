#!/bin/bash -e

bundle install
bundle exec pod update --repo-update
