#! /bin/bash
bin/rails db:migrate
puma -C config/puma.rb
